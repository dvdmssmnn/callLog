//Copyright (c) 2015, David Missmann
//All rights reserved.
//
//Redistribution and use in source and binary forms, with or without modification,
//are permitted provided that the following conditions are met:
//
//1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following
//disclaimer.
//
//2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following
//disclaimer in the documentation and/or other materials provided with the distribution.
//
//THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
//INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
//SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
//SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
//WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
//OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>
#import <sstream>
#import "CertificatePinning.h"
#import <dlfcn.h>
#import "fishhook.h"
#import <objc/runtime.h>

id (*original_initWithTrust)(id, SEL, SecTrustRef);
id __initWithTrustHook(id self, SEL _cmd, SecTrustRef trust);


__attribute__((constructor))
static void initialize() {
    original_initWithTrust = (id(*)(id, SEL, SecTrustRef)) method_setImplementation(class_getInstanceMethod([NSURLCredential class], @selector(initWithTrust:)), (IMP)__initWithTrustHook);
}

static dispatch_once_t onceToken;
dispatch_queue_t store_cert_queue;
NSMutableDictionary *stored_certificates = nil;

void store_certificate(SecCertificateRef certificate) {
    dispatch_once(&onceToken, ^{
        store_cert_queue = dispatch_queue_create("store_cert", 0);
        stored_certificates = [NSMutableDictionary dictionary];
    });
    
    dispatch_sync(store_cert_queue, ^{
        CFStringRef certificateSummary = SecCertificateCopySubjectSummary(certificate);
        const char *sum = CFStringGetCStringPtr(certificateSummary, kCFStringEncodingUTF8);
        unsigned char digest[CC_SHA1_DIGEST_LENGTH];
        CC_SHA1((void*)sum, strlen(sum), digest);
        NSData *d = [NSData dataWithBytes:digest length:CC_SHA1_DIGEST_LENGTH];
        NSString *certSumHashHex = [[[[d description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""];
        
        if ([stored_certificates valueForKey:certSumHashHex]) {
            return;
        }
        CFDataRef derDataRef = SecCertificateCopyData(certificate);
        NSData *derData = [NSData dataWithBytes:CFDataGetBytePtr(derDataRef) length:CFDataGetLength(derDataRef)];
        
        [stored_certificates setValue:[derData copy] forKey:certSumHashHex];
        
        NSString *filePath = [NSString stringWithFormat:@"%@%@.der", NSTemporaryDirectory(), certSumHashHex];
        [derData writeToFile:filePath atomically:YES];
    });
}

id __initWithTrustHook(id self, SEL _cmd, SecTrustRef trust)
{
    CFIndex certCount = SecTrustGetCertificateCount(trust);
    for (CFIndex i = 0; i < certCount; ++i) {
        SecCertificateRef certificate = SecTrustGetCertificateAtIndex(trust, i);
        store_certificate(certificate);
        store_certificate(certificate);
    }
    return original_initWithTrust(self, _cmd, trust);
}

NSArray *get_trusted_certificates()
{
    dispatch_once(&onceToken, ^{
        store_cert_queue = dispatch_queue_create("store_cert", 0);
        stored_certificates = [NSMutableDictionary dictionary];
    });
    NSMutableArray *certificates = [NSMutableArray array];
    dispatch_sync(store_cert_queue, ^{
        [stored_certificates enumerateKeysAndObjectsUsingBlock:^(id key, NSData *obj, BOOL *stop) {
            [certificates addObject:[obj base64EncodedStringWithOptions:0]];
        }];
    });
    return certificates;
}