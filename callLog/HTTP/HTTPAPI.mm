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

#import "HTTPAPI.h"

#import "GCDWebServer.h"
#import "GCDWebServerDataResponse.h"
#import "GCDWebServerFileResponse.h"

#import "SQLiteStorage.h"
#import "Whitelists.h"
#import "ThreadStorage.h"
#import "Config.h"
#import <json/json.h>
#import <sstream>
#import "HookHelper.h"
#import "callLogManager.h"
#import "CertificatePinning.h"

using namespace std;
using namespace Json;

GCDWebServer *_webServer = 0;

@implementation HTTPAPI

+ (void)load
{
    _webServer = [[GCDWebServer alloc] init];
    
//    NSString *indexPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"callgraph" ofType:@"html" inDirectory:@"BrowserClient"];
    
    NSString *indexPath = [[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingString:@"/BrowserClient/"];
    
    
    [_webServer addGETHandlerForBasePath:@"/"
                           directoryPath:indexPath
                           indexFilename:nil
                                cacheAge:3600
                      allowRangeRequests:YES];

    [_webServer addHandlerForMethod:@"GET" path:@"/cmd"
                       requestClass:[GCDWebServerRequest class]
                       processBlock:^GCDWebServerResponse *(GCDWebServerRequest *request) {
                           set_enabled(false);
                           GCDWebServerResponse *response = [self commandRequest:[request query]];
                           set_enabled(true);
                           return response;
                       }];
    
    [_webServer addHandlerForMethod:@"POST" path:@"/cmd"
                       requestClass:[GCDWebServerRequest class]
                       processBlock:^GCDWebServerResponse *(GCDWebServerRequest *request) {
                           set_enabled(false);
                           GCDWebServerResponse *response = [self commandRequest:[request query]];
                           set_enabled(true);
                           return response;
                       }];
    
    
    // Start server on port 8080
    [_webServer startWithPort:8080 bonjourName:@"iphone"];

}

+ (GCDWebServerResponse *)commandRequest:(NSDictionary *)query
{
    NSString *command = [query valueForKey:@"command"];
    if ([command isEqualToString:@"config"]) {
        return [GCDWebServerDataResponse responseWithText:[HTTPAPI handleConfigCommand:query]];
    } else if ([command isEqualToString:@"download"]) {
        __block GCDWebServerFileResponse *response = nil;
//        static dispatch_once_t onceToken;
//        dispatch_once(&onceToken, ^{
//            NSLog(@"Store classes in database");
//            store_classes();
//            NSLog(@"All classes stored");
//        });
        dispatch_sync(db_queue, ^{
            NSLog(@"Close db...");
            db_close();
            response = [GCDWebServerFileResponse responseWithFile:get_db_path()];
            db_open();
        });
        return response;
        
    } else if([command isEqualToString:@"trusted_certificates"]) {
        NSArray *trustedCertificates = get_trusted_certificates();
        return [GCDWebServerDataResponse responseWithJSONObject:trustedCertificates];
    }
    return [GCDWebServerDataResponse responseWithText:@""];
}

+ (NSString *)handleConfigCommand:(NSDictionary *)query
{
    NSString *option = [query valueForKey:@"option"];
    if (!option) {
        return @"error";
    }
    
    if ([option isEqualToString:@"handle_step_out"]) {
        NSString *value = [query valueForKey:@"value"];
        handle_step_out_bundle_ = [value boolValue];
        save_config();
    }  else if ([option isEqualToString:@"max_description_length"]) {
        NSString *value = [query valueForKey:@"value"];
        if (!value) {
            return @"error";
        }
        max_description_length_ = [value integerValue];
        save_config();
    } else if ([option isEqualToString:@"whitelist"]) {
        NSString *clazz = [query valueForKey:@"class"];
        NSString *method = [query valueForKey:@"method"];
        if (clazz == nil && method == nil) {
            return @"error";
        } else {
            NSString *bundle = [query valueForKey:@"bundle"];
            if (bundle == nil) {
                return @"error";
            }
            whitelist_bundle([bundle UTF8String]);
        }
        add_whitelist_entry(clazz ? [clazz UTF8String] : NULL, method ? [method UTF8String] : NULL);
    } else if ([option isEqualToString:@"blacklist"]) {
        NSString *clazz = [query valueForKey:@"class"];
        NSString *method = [query valueForKey:@"method"];
        if (clazz == nil && method == nil) {
            return @"error";
        }
        add_blacklist_entry(clazz ? [clazz UTF8String] : NULL, method ? [method UTF8String] : NULL);
    }
    
    return @"done";
}

@end
