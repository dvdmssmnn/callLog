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

#import "HookHelper.h"

#import "SQLiteStorage.h"
#import "ThreadStorage.h"
#import "callLogManager.h"
#import <vector>
#import <string>
#import <pthread.h>
#import <pthread.h>
#import "Config.h"
#import <CydiaSubstrate/CydiaSubstrate.h>
#import <semaphore.h>
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonCrypto.h>
#import <CommonCrypto/CommonRandom.h>

using namespace std;
CCCryptorStatus ____CCCryptorCreate(CCOperation op, CCAlgorithm alg, CCOptions options, const void * key, size_t keyLength, const void * iv, CCCryptorRef * cryptorRef);

CCCryptorStatus ____CCCryptorCreateFromData(CCOperation op, CCAlgorithm alg, CCOptions options, const void * key, size_t keyLength, const void * iv, const void * data, size_t dataLength, CCCryptorRef * cryptorRef, size_t * dataUsed);

CCCryptorStatus ____CCCryptorRelease(CCCryptorRef cryptorRef);

CCCryptorStatus ____CCCryptorUpdate(CCCryptorRef cryptorRef, const void * dataIn, size_t dataInLength, void * dataOut, size_t dataOutAvailable, size_t * dataOutMoved);

CCCryptorStatus ____CCCryptorFinal(CCCryptorRef cryptorRef, void * dataOut, size_t dataOutAvailable, size_t * dataOutMoved);

size_t ____CCCryptorGetOutputLength(CCCryptorRef cryptorRef, size_t inputLength, bool final);

CCCryptorStatus ____CCCryptorReset(CCCryptorRef cryptorRef, const void * iv);

CCCryptorStatus ____CCCrypt(CCOperation op, CCAlgorithm alg, CCOptions options, const void * key, size_t keyLength, const void * iv, const void * dataIn, size_t dataInLength, void * dataOut, size_t dataOutAvailable, size_t * dataOutMoved);

CCCryptorStatus ____CCCryptorCreateWithMode(CCOperation op, CCMode mode, CCAlgorithm alg, CCPadding padding, const void * iv, const void * key, size_t keyLength, const void * tweak, size_t tweakLength, int numRounds, CCModeOptions options, CCCryptorRef * cryptorRef);

int ____CCKeyDerivationPBKDF(CCPBKDFAlgorithm algorithm, const char * password, size_t passwordLen, const uint8_t * salt, size_t saltLen, CCPseudoRandomAlgorithm prf, uint rounds, uint8_t * derivedKey, size_t derivedKeyLen);

uint ____CCCalibratePBKDF(CCPBKDFAlgorithm algorithm, size_t passwordLen, size_t saltLen, CCPseudoRandomAlgorithm prf, size_t derivedKeyLen, uint32_t msec);

CCRNGStatus ____CCRandomGenerateBytes(void * bytes, size_t count);

int ____CC_MD2_Init(CC_MD2_CTX * c);

int ____CC_MD2_Update(CC_MD2_CTX * c, const void * data, CC_LONG len);

int ____CC_MD2_Final(unsigned char * md, CC_MD2_CTX * c);

unsigned char * ____CC_MD2(const void * data, CC_LONG len, unsigned char * md);

int ____CC_MD4_Init(CC_MD4_CTX * c);

int ____CC_MD4_Update(CC_MD4_CTX * c, const void * data, CC_LONG len);

int ____CC_MD4_Final(unsigned char * md, CC_MD4_CTX * c);

unsigned char * ____CC_MD4(const void * data, CC_LONG len, unsigned char * md);

int ____CC_MD5_Init(CC_MD5_CTX * c);

int ____CC_MD5_Update(CC_MD5_CTX * c, const void * data, CC_LONG len);

int ____CC_MD5_Final(unsigned char * md, CC_MD5_CTX * c);

unsigned char * ____CC_MD5(const void * data, CC_LONG len, unsigned char * md);

int ____CC_SHA1_Init(CC_SHA1_CTX * c);

int ____CC_SHA1_Update(CC_SHA1_CTX * c, const void * data, CC_LONG len);

int ____CC_SHA1_Final(unsigned char * md, CC_SHA1_CTX * c);

unsigned char * ____CC_SHA1(const void * data, CC_LONG len, unsigned char * md);

int ____CC_SHA224_Init(CC_SHA256_CTX * c);

int ____CC_SHA224_Update(CC_SHA256_CTX * c, const void * data, CC_LONG len);

int ____CC_SHA224_Final(unsigned char * md, CC_SHA256_CTX * c);

unsigned char * ____CC_SHA224(const void * data, CC_LONG len, unsigned char * md);

int ____CC_SHA256_Init(CC_SHA256_CTX * c);

int ____CC_SHA256_Update(CC_SHA256_CTX * c, const void * data, CC_LONG len);

int ____CC_SHA256_Final(unsigned char * md, CC_SHA256_CTX * c);

unsigned char * ____CC_SHA256(const void * data, CC_LONG len, unsigned char * md);

int ____CC_SHA384_Init(CC_SHA512_CTX * c);

int ____CC_SHA384_Update(CC_SHA512_CTX * c, const void * data, CC_LONG len);

int ____CC_SHA384_Final(unsigned char * md, CC_SHA512_CTX * c);

unsigned char * ____CC_SHA384(const void * data, CC_LONG len, unsigned char * md);

int ____CC_SHA512_Init(CC_SHA512_CTX * c);

int ____CC_SHA512_Update(CC_SHA512_CTX * c, const void * data, CC_LONG len);

int ____CC_SHA512_Final(unsigned char * md, CC_SHA512_CTX * c);

unsigned char * ____CC_SHA512(const void * data, CC_LONG len, unsigned char * md);

CCCryptorStatus (*original_CCCryptorCreate)(CCOperation, CCAlgorithm, CCOptions, const void *, size_t, const void *, CCCryptorRef *);
CCCryptorStatus (*original_CCCryptorCreateFromData)(CCOperation, CCAlgorithm, CCOptions, const void *, size_t, const void *, const void *, size_t, CCCryptorRef *, size_t *);
CCCryptorStatus (*original_CCCryptorRelease)(CCCryptorRef);
CCCryptorStatus (*original_CCCryptorUpdate)(CCCryptorRef, const void *, size_t, void *, size_t, size_t *);
CCCryptorStatus (*original_CCCryptorFinal)(CCCryptorRef, void *, size_t, size_t *);
size_t (*original_CCCryptorGetOutputLength)(CCCryptorRef, size_t, bool);
CCCryptorStatus (*original_CCCryptorReset)(CCCryptorRef, const void *);
CCCryptorStatus (*original_CCCrypt)(CCOperation, CCAlgorithm, CCOptions, const void *, size_t, const void *, const void *, size_t, void *, size_t, size_t *);
CCCryptorStatus (*original_CCCryptorCreateWithMode)(CCOperation, CCMode, CCAlgorithm, CCPadding, const void *, const void *, size_t, const void *, size_t, int, CCModeOptions, CCCryptorRef *);
int (*original_CCKeyDerivationPBKDF)(CCPBKDFAlgorithm, const char *, size_t, const uint8_t *, size_t, CCPseudoRandomAlgorithm, uint, uint8_t *, size_t);
uint (*original_CCCalibratePBKDF)(CCPBKDFAlgorithm, size_t, size_t, CCPseudoRandomAlgorithm, size_t, uint32_t);
CCRNGStatus (*original_CCRandomGenerateBytes)(void *, size_t);
int (*original_CC_MD2_Init)(CC_MD2_CTX *);
int (*original_CC_MD2_Update)(CC_MD2_CTX *, const void *, CC_LONG);
int (*original_CC_MD2_Final)(unsigned char *, CC_MD2_CTX *);
unsigned char * (*original_CC_MD2)(const void *, CC_LONG, unsigned char *);
int (*original_CC_MD4_Init)(CC_MD4_CTX *);
int (*original_CC_MD4_Update)(CC_MD4_CTX *, const void *, CC_LONG);
int (*original_CC_MD4_Final)(unsigned char *, CC_MD4_CTX *);
unsigned char * (*original_CC_MD4)(const void *, CC_LONG, unsigned char *);
int (*original_CC_MD5_Init)(CC_MD5_CTX *);
int (*original_CC_MD5_Update)(CC_MD5_CTX *, const void *, CC_LONG);
int (*original_CC_MD5_Final)(unsigned char *, CC_MD5_CTX *);
unsigned char * (*original_CC_MD5)(const void *, CC_LONG, unsigned char *);
int (*original_CC_SHA1_Init)(CC_SHA1_CTX *);
int (*original_CC_SHA1_Update)(CC_SHA1_CTX *, const void *, CC_LONG);
int (*original_CC_SHA1_Final)(unsigned char *, CC_SHA1_CTX *);
unsigned char * (*original_CC_SHA1)(const void *, CC_LONG, unsigned char *);
int (*original_CC_SHA224_Init)(CC_SHA256_CTX *);
int (*original_CC_SHA224_Update)(CC_SHA256_CTX *, const void *, CC_LONG);
int (*original_CC_SHA224_Final)(unsigned char *, CC_SHA256_CTX *);
unsigned char * (*original_CC_SHA224)(const void *, CC_LONG, unsigned char *);
int (*original_CC_SHA256_Init)(CC_SHA256_CTX *);
int (*original_CC_SHA256_Update)(CC_SHA256_CTX *, const void *, CC_LONG);
int (*original_CC_SHA256_Final)(unsigned char *, CC_SHA256_CTX *);
unsigned char * (*original_CC_SHA256)(const void *, CC_LONG, unsigned char *);
int (*original_CC_SHA384_Init)(CC_SHA512_CTX *);
int (*original_CC_SHA384_Update)(CC_SHA512_CTX *, const void *, CC_LONG);
int (*original_CC_SHA384_Final)(unsigned char *, CC_SHA512_CTX *);
unsigned char * (*original_CC_SHA384)(const void *, CC_LONG, unsigned char *);
int (*original_CC_SHA512_Init)(CC_SHA512_CTX *);
int (*original_CC_SHA512_Update)(CC_SHA512_CTX *, const void *, CC_LONG);
int (*original_CC_SHA512_Final)(unsigned char *, CC_SHA512_CTX *);
unsigned char * (*original_CC_SHA512)(const void *, CC_LONG, unsigned char *);
__attribute__((constructor))
static void initialize() {
    dispatch_async(dispatch_get_main_queue(), ^ {
        MSHookFunction((void*)&CCCryptorCreate, (void*)&____CCCryptorCreate, (void**)&original_CCCryptorCreate);
        MSHookFunction((void*)&CCCryptorCreateFromData, (void*)&____CCCryptorCreateFromData, (void**)&original_CCCryptorCreateFromData);
        MSHookFunction((void*)&CCCryptorRelease, (void*)&____CCCryptorRelease, (void**)&original_CCCryptorRelease);
        MSHookFunction((void*)&CCCryptorUpdate, (void*)&____CCCryptorUpdate, (void**)&original_CCCryptorUpdate);
        MSHookFunction((void*)&CCCryptorFinal, (void*)&____CCCryptorFinal, (void**)&original_CCCryptorFinal);
        MSHookFunction((void*)&CCCryptorGetOutputLength, (void*)&____CCCryptorGetOutputLength, (void**)&original_CCCryptorGetOutputLength);
        MSHookFunction((void*)&CCCryptorReset, (void*)&____CCCryptorReset, (void**)&original_CCCryptorReset);
        MSHookFunction((void*)&CCCrypt, (void*)&____CCCrypt, (void**)&original_CCCrypt);
        MSHookFunction((void*)&CCCryptorCreateWithMode, (void*)&____CCCryptorCreateWithMode, (void**)&original_CCCryptorCreateWithMode);
        MSHookFunction((void*)&CCKeyDerivationPBKDF, (void*)&____CCKeyDerivationPBKDF, (void**)&original_CCKeyDerivationPBKDF);
        MSHookFunction((void*)&CCCalibratePBKDF, (void*)&____CCCalibratePBKDF, (void**)&original_CCCalibratePBKDF);
        MSHookFunction((void*)&CCRandomGenerateBytes, (void*)&____CCRandomGenerateBytes, (void**)&original_CCRandomGenerateBytes);
        MSHookFunction((void*)&CC_MD2_Init, (void*)&____CC_MD2_Init, (void**)&original_CC_MD2_Init);
        MSHookFunction((void*)&CC_MD2_Update, (void*)&____CC_MD2_Update, (void**)&original_CC_MD2_Update);
        MSHookFunction((void*)&CC_MD2_Final, (void*)&____CC_MD2_Final, (void**)&original_CC_MD2_Final);
        MSHookFunction((void*)&CC_MD2, (void*)&____CC_MD2, (void**)&original_CC_MD2);
        MSHookFunction((void*)&CC_MD4_Init, (void*)&____CC_MD4_Init, (void**)&original_CC_MD4_Init);
        MSHookFunction((void*)&CC_MD4_Update, (void*)&____CC_MD4_Update, (void**)&original_CC_MD4_Update);
        MSHookFunction((void*)&CC_MD4_Final, (void*)&____CC_MD4_Final, (void**)&original_CC_MD4_Final);
        MSHookFunction((void*)&CC_MD4, (void*)&____CC_MD4, (void**)&original_CC_MD4);
        MSHookFunction((void*)&CC_MD5_Init, (void*)&____CC_MD5_Init, (void**)&original_CC_MD5_Init);
        MSHookFunction((void*)&CC_MD5_Update, (void*)&____CC_MD5_Update, (void**)&original_CC_MD5_Update);
        MSHookFunction((void*)&CC_MD5_Final, (void*)&____CC_MD5_Final, (void**)&original_CC_MD5_Final);
        MSHookFunction((void*)&CC_MD5, (void*)&____CC_MD5, (void**)&original_CC_MD5);
        MSHookFunction((void*)&CC_SHA1_Init, (void*)&____CC_SHA1_Init, (void**)&original_CC_SHA1_Init);
        MSHookFunction((void*)&CC_SHA1_Update, (void*)&____CC_SHA1_Update, (void**)&original_CC_SHA1_Update);
        MSHookFunction((void*)&CC_SHA1_Final, (void*)&____CC_SHA1_Final, (void**)&original_CC_SHA1_Final);
        MSHookFunction((void*)&CC_SHA1, (void*)&____CC_SHA1, (void**)&original_CC_SHA1);
        MSHookFunction((void*)&CC_SHA224_Init, (void*)&____CC_SHA224_Init, (void**)&original_CC_SHA224_Init);
        MSHookFunction((void*)&CC_SHA224_Update, (void*)&____CC_SHA224_Update, (void**)&original_CC_SHA224_Update);
        MSHookFunction((void*)&CC_SHA224_Final, (void*)&____CC_SHA224_Final, (void**)&original_CC_SHA224_Final);
        MSHookFunction((void*)&CC_SHA224, (void*)&____CC_SHA224, (void**)&original_CC_SHA224);
        MSHookFunction((void*)&CC_SHA256_Init, (void*)&____CC_SHA256_Init, (void**)&original_CC_SHA256_Init);
        MSHookFunction((void*)&CC_SHA256_Update, (void*)&____CC_SHA256_Update, (void**)&original_CC_SHA256_Update);
        MSHookFunction((void*)&CC_SHA256_Final, (void*)&____CC_SHA256_Final, (void**)&original_CC_SHA256_Final);
        MSHookFunction((void*)&CC_SHA256, (void*)&____CC_SHA256, (void**)&original_CC_SHA256);
        MSHookFunction((void*)&CC_SHA384_Init, (void*)&____CC_SHA384_Init, (void**)&original_CC_SHA384_Init);
        MSHookFunction((void*)&CC_SHA384_Update, (void*)&____CC_SHA384_Update, (void**)&original_CC_SHA384_Update);
        MSHookFunction((void*)&CC_SHA384_Final, (void*)&____CC_SHA384_Final, (void**)&original_CC_SHA384_Final);
        MSHookFunction((void*)&CC_SHA384, (void*)&____CC_SHA384, (void**)&original_CC_SHA384);
        MSHookFunction((void*)&CC_SHA512_Init, (void*)&____CC_SHA512_Init, (void**)&original_CC_SHA512_Init);
        MSHookFunction((void*)&CC_SHA512_Update, (void*)&____CC_SHA512_Update, (void**)&original_CC_SHA512_Update);
        MSHookFunction((void*)&CC_SHA512_Final, (void*)&____CC_SHA512_Final, (void**)&original_CC_SHA512_Final);
        MSHookFunction((void*)&CC_SHA512, (void*)&____CC_SHA512, (void**)&original_CC_SHA512);
    });
}

__attribute__((constructor))
static void constructor() {
}
CCCryptorStatus ____CCCryptorCreate(CCOperation op, CCAlgorithm alg, CCOptions options, const void * key, size_t keyLength, const void * iv, CCCryptorRef * cryptorRef)
{
    if (!is_enabled() || !enabled_) {
        CCCryptorStatus return_value = original_CCCryptorCreate(op, alg, options, key, keyLength, iv, cryptorRef);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(7, sizeof(parameter_t));
//Parse parameter op
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CCOperation", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)op);
    switch (op) {
    case 0:
        parameters[0].description = (char*)calloc(11, sizeof(char));
        strncpy(parameters[0].description, "kCCEncrypt", 10);
        break;
    case 1:
        parameters[0].description = (char*)calloc(11, sizeof(char));
        strncpy(parameters[0].description, "kCCDecrypt", 10);
        break;
    }//Parse parameter alg
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CCAlgorithm", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "%d", (int)alg);
    switch (alg) {
    case 0:
        parameters[1].description = (char*)calloc(19, sizeof(char));
        strncpy(parameters[1].description, "kCCAlgorithmAES128", 18);
        break;
    case 1:
        parameters[1].description = (char*)calloc(16, sizeof(char));
        strncpy(parameters[1].description, "kCCAlgorithmDES", 15);
        break;
    case 2:
        parameters[1].description = (char*)calloc(17, sizeof(char));
        strncpy(parameters[1].description, "kCCAlgorithm3DES", 16);
        break;
    case 3:
        parameters[1].description = (char*)calloc(17, sizeof(char));
        strncpy(parameters[1].description, "kCCAlgorithmCAST", 16);
        break;
    case 4:
        parameters[1].description = (char*)calloc(16, sizeof(char));
        strncpy(parameters[1].description, "kCCAlgorithmRC4", 15);
        break;
    case 5:
        parameters[1].description = (char*)calloc(16, sizeof(char));
        strncpy(parameters[1].description, "kCCAlgorithmRC2", 15);
        break;
    case 6:
        parameters[1].description = (char*)calloc(21, sizeof(char));
        strncpy(parameters[1].description, "kCCAlgorithmBlowfish", 20);
        break;
    }//Parse parameter options
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CCOptions", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "%d", (int)options);
//Parse parameter key
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "^void", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "0x%X", (register_t)key);
    parameters[3].description = (char*)calloc(2*keyLength+1, sizeof(char));
    NSData *key_data = [NSData dataWithBytes:key length:keyLength];
    strncpy(parameters[3].description, [[[[[key_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*keyLength);
//Parse parameter keyLength
    parameters[4].description = NULL;
    strncpy(parameters[4].type, "size_t", MAX_TYPE_LENGTH);
    snprintf(parameters[4].value, MAX_VALUE_LENGTH, "%d", (int)keyLength);
//Parse parameter iv
    parameters[5].description = NULL;
    strncpy(parameters[5].type, "^void", MAX_TYPE_LENGTH);
    snprintf(parameters[5].value, MAX_VALUE_LENGTH, "0x%X", (register_t)iv);
    if(iv&&alg==kCCAlgorithmAES) {
        parameters[5].description = (char*)calloc(2*16+1, sizeof(char));
        NSData *iv_data = [NSData dataWithBytes:iv length:16];
        strncpy(parameters[5].description, [[[[[iv_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*16);

    }
    if(iv&&alg!=kCCAlgorithmAES) {
        parameters[5].description = (char*)calloc(2*8+1, sizeof(char));
        NSData *iv_data = [NSData dataWithBytes:iv length:8];
        strncpy(parameters[5].description, [[[[[iv_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*8);

    }
    set_enabled(true);
    CCCryptorStatus return_value = original_CCCryptorCreate(op, alg, options, key, keyLength, iv, cryptorRef);
    set_enabled(false);
//Parse parameter cryptorRef
    parameters[6].description = NULL;
    strncpy(parameters[6].type, "^CCCryptorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[6].value, MAX_VALUE_LENGTH, "0x%X", (int)*cryptorRef);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CommonCrypto", "CCCryptorCreate", "0x0", parameters, 7);
            for(unsigned int i = 0; i < 7; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 7; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CCCryptorStatus", MAX_TYPE_LENGTH);
    switch (return_value) {
    case 0:
        return_param.description = (char*)calloc(11, sizeof(char));
        strncpy(return_param.description, "kCCSuccess", 10);
        break;
    case -4300:
        return_param.description = (char*)calloc(14, sizeof(char));
        strncpy(return_param.description, "kCCParamError", 13);
        break;
    case -4301:
        return_param.description = (char*)calloc(18, sizeof(char));
        strncpy(return_param.description, "kCCBufferTooSmall", 17);
        break;
    case -4302:
        return_param.description = (char*)calloc(17, sizeof(char));
        strncpy(return_param.description, "kCCMemoryFailure", 16);
        break;
    case -4303:
        return_param.description = (char*)calloc(18, sizeof(char));
        strncpy(return_param.description, "kCCAlignmentError", 17);
        break;
    case -4304:
        return_param.description = (char*)calloc(15, sizeof(char));
        strncpy(return_param.description, "kCCDecodeError", 14);
        break;
    case -4305:
        return_param.description = (char*)calloc(17, sizeof(char));
        strncpy(return_param.description, "kCCUnimplemented", 16);
        break;
    case -4306:
        return_param.description = (char*)calloc(12, sizeof(char));
        strncpy(return_param.description, "kCCOverflow", 11);
        break;
    case -4307:
        return_param.description = (char*)calloc(14, sizeof(char));
        strncpy(return_param.description, "kCCRNGFailure", 13);
        break;
    }
    snprintf(return_param.value, MAX_VALUE_LENGTH, "%d", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


CCCryptorStatus ____CCCryptorCreateFromData(CCOperation op, CCAlgorithm alg, CCOptions options, const void * key, size_t keyLength, const void * iv, const void * data, size_t dataLength, CCCryptorRef * cryptorRef, size_t * dataUsed)
{
    if (!is_enabled() || !enabled_) {
        CCCryptorStatus return_value = original_CCCryptorCreateFromData(op, alg, options, key, keyLength, iv, data, dataLength, cryptorRef, dataUsed);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(10, sizeof(parameter_t));
//Parse parameter op
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CCOperation", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)op);
    switch (op) {
    case 0:
        parameters[0].description = (char*)calloc(11, sizeof(char));
        strncpy(parameters[0].description, "kCCEncrypt", 10);
        break;
    case 1:
        parameters[0].description = (char*)calloc(11, sizeof(char));
        strncpy(parameters[0].description, "kCCDecrypt", 10);
        break;
    }//Parse parameter alg
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CCAlgorithm", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "%d", (int)alg);
    switch (alg) {
    case 0:
        parameters[1].description = (char*)calloc(19, sizeof(char));
        strncpy(parameters[1].description, "kCCAlgorithmAES128", 18);
        break;
    case 1:
        parameters[1].description = (char*)calloc(16, sizeof(char));
        strncpy(parameters[1].description, "kCCAlgorithmDES", 15);
        break;
    case 2:
        parameters[1].description = (char*)calloc(17, sizeof(char));
        strncpy(parameters[1].description, "kCCAlgorithm3DES", 16);
        break;
    case 3:
        parameters[1].description = (char*)calloc(17, sizeof(char));
        strncpy(parameters[1].description, "kCCAlgorithmCAST", 16);
        break;
    case 4:
        parameters[1].description = (char*)calloc(16, sizeof(char));
        strncpy(parameters[1].description, "kCCAlgorithmRC4", 15);
        break;
    case 5:
        parameters[1].description = (char*)calloc(16, sizeof(char));
        strncpy(parameters[1].description, "kCCAlgorithmRC2", 15);
        break;
    case 6:
        parameters[1].description = (char*)calloc(21, sizeof(char));
        strncpy(parameters[1].description, "kCCAlgorithmBlowfish", 20);
        break;
    }//Parse parameter options
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CCOptions", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "%d", (int)options);
//Parse parameter key
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "^void", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "0x%X", (register_t)key);
    parameters[3].description = (char*)calloc(2*keyLength+1, sizeof(char));
    NSData *key_data = [NSData dataWithBytes:key length:keyLength];
    strncpy(parameters[3].description, [[[[[key_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*keyLength);
//Parse parameter keyLength
    parameters[4].description = NULL;
    strncpy(parameters[4].type, "size_t", MAX_TYPE_LENGTH);
    snprintf(parameters[4].value, MAX_VALUE_LENGTH, "%d", (int)keyLength);
//Parse parameter iv
    parameters[5].description = NULL;
    strncpy(parameters[5].type, "^void", MAX_TYPE_LENGTH);
    snprintf(parameters[5].value, MAX_VALUE_LENGTH, "0x%X", (register_t)iv);
    if(iv&&alg==kCCAlgorithmAES) {
        parameters[5].description = (char*)calloc(2*16+1, sizeof(char));
        NSData *iv_data = [NSData dataWithBytes:iv length:16];
        strncpy(parameters[5].description, [[[[[iv_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*16);

    }
    if(iv&&alg!=kCCAlgorithmAES) {
        parameters[5].description = (char*)calloc(2*8+1, sizeof(char));
        NSData *iv_data = [NSData dataWithBytes:iv length:8];
        strncpy(parameters[5].description, [[[[[iv_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*8);

    }
//Parse parameter data
    parameters[6].description = NULL;
    strncpy(parameters[6].type, "^void", MAX_TYPE_LENGTH);
    snprintf(parameters[6].value, MAX_VALUE_LENGTH, "0x%X", (register_t)data);
    parameters[6].description = (char*)calloc(2*dataLength+1, sizeof(char));
    NSData *data_data = [NSData dataWithBytes:data length:dataLength];
    strncpy(parameters[6].description, [[[[[data_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*dataLength);
//Parse parameter dataLength
    parameters[7].description = NULL;
    strncpy(parameters[7].type, "size_t", MAX_TYPE_LENGTH);
    snprintf(parameters[7].value, MAX_VALUE_LENGTH, "%d", (int)dataLength);
//Parse parameter dataUsed
    parameters[9].description = NULL;
    strncpy(parameters[9].type, "^size_t", MAX_TYPE_LENGTH);
    snprintf(parameters[9].value, MAX_VALUE_LENGTH, "0x%X", (register_t)dataUsed);
    set_enabled(true);
    CCCryptorStatus return_value = original_CCCryptorCreateFromData(op, alg, options, key, keyLength, iv, data, dataLength, cryptorRef, dataUsed);
    set_enabled(false);
//Parse parameter cryptorRef
    parameters[8].description = NULL;
    strncpy(parameters[8].type, "^CCCryptorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[8].value, MAX_VALUE_LENGTH, "0x%X", (int)*cryptorRef);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CommonCrypto", "CCCryptorCreateFromData", "0x0", parameters, 10);
            for(unsigned int i = 0; i < 10; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 10; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CCCryptorStatus", MAX_TYPE_LENGTH);
    switch (return_value) {
    case 0:
        return_param.description = (char*)calloc(11, sizeof(char));
        strncpy(return_param.description, "kCCSuccess", 10);
        break;
    case -4300:
        return_param.description = (char*)calloc(14, sizeof(char));
        strncpy(return_param.description, "kCCParamError", 13);
        break;
    case -4301:
        return_param.description = (char*)calloc(18, sizeof(char));
        strncpy(return_param.description, "kCCBufferTooSmall", 17);
        break;
    case -4302:
        return_param.description = (char*)calloc(17, sizeof(char));
        strncpy(return_param.description, "kCCMemoryFailure", 16);
        break;
    case -4303:
        return_param.description = (char*)calloc(18, sizeof(char));
        strncpy(return_param.description, "kCCAlignmentError", 17);
        break;
    case -4304:
        return_param.description = (char*)calloc(15, sizeof(char));
        strncpy(return_param.description, "kCCDecodeError", 14);
        break;
    case -4305:
        return_param.description = (char*)calloc(17, sizeof(char));
        strncpy(return_param.description, "kCCUnimplemented", 16);
        break;
    case -4306:
        return_param.description = (char*)calloc(12, sizeof(char));
        strncpy(return_param.description, "kCCOverflow", 11);
        break;
    case -4307:
        return_param.description = (char*)calloc(14, sizeof(char));
        strncpy(return_param.description, "kCCRNGFailure", 13);
        break;
    }
    snprintf(return_param.value, MAX_VALUE_LENGTH, "%d", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


CCCryptorStatus ____CCCryptorRelease(CCCryptorRef cryptorRef)
{
    if (!is_enabled() || !enabled_) {
        CCCryptorStatus return_value = original_CCCryptorRelease(cryptorRef);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(1, sizeof(parameter_t));
//Parse parameter cryptorRef
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CCCryptorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)cryptorRef);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CommonCrypto", "CCCryptorRelease", "0x0", parameters, 1);
            for(unsigned int i = 0; i < 1; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 1; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    CCCryptorStatus return_value = original_CCCryptorRelease(cryptorRef);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CCCryptorStatus", MAX_TYPE_LENGTH);
    switch (return_value) {
    case 0:
        return_param.description = (char*)calloc(11, sizeof(char));
        strncpy(return_param.description, "kCCSuccess", 10);
        break;
    case -4300:
        return_param.description = (char*)calloc(14, sizeof(char));
        strncpy(return_param.description, "kCCParamError", 13);
        break;
    case -4301:
        return_param.description = (char*)calloc(18, sizeof(char));
        strncpy(return_param.description, "kCCBufferTooSmall", 17);
        break;
    case -4302:
        return_param.description = (char*)calloc(17, sizeof(char));
        strncpy(return_param.description, "kCCMemoryFailure", 16);
        break;
    case -4303:
        return_param.description = (char*)calloc(18, sizeof(char));
        strncpy(return_param.description, "kCCAlignmentError", 17);
        break;
    case -4304:
        return_param.description = (char*)calloc(15, sizeof(char));
        strncpy(return_param.description, "kCCDecodeError", 14);
        break;
    case -4305:
        return_param.description = (char*)calloc(17, sizeof(char));
        strncpy(return_param.description, "kCCUnimplemented", 16);
        break;
    case -4306:
        return_param.description = (char*)calloc(12, sizeof(char));
        strncpy(return_param.description, "kCCOverflow", 11);
        break;
    case -4307:
        return_param.description = (char*)calloc(14, sizeof(char));
        strncpy(return_param.description, "kCCRNGFailure", 13);
        break;
    }
    snprintf(return_param.value, MAX_VALUE_LENGTH, "%d", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


CCCryptorStatus ____CCCryptorUpdate(CCCryptorRef cryptorRef, const void * dataIn, size_t dataInLength, void * dataOut, size_t dataOutAvailable, size_t * dataOutMoved)
{
    if (!is_enabled() || !enabled_) {
        CCCryptorStatus return_value = original_CCCryptorUpdate(cryptorRef, dataIn, dataInLength, dataOut, dataOutAvailable, dataOutMoved);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(6, sizeof(parameter_t));
//Parse parameter cryptorRef
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CCCryptorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)cryptorRef);
//Parse parameter dataIn
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "^void", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (register_t)dataIn);
    parameters[1].description = (char*)calloc(2*dataInLength+1, sizeof(char));
    NSData *dataIn_data = [NSData dataWithBytes:dataIn length:dataInLength];
    strncpy(parameters[1].description, [[[[[dataIn_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*dataInLength);
//Parse parameter dataInLength
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "size_t", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "%d", (int)dataInLength);
//Parse parameter dataOutAvailable
    parameters[4].description = NULL;
    strncpy(parameters[4].type, "size_t", MAX_TYPE_LENGTH);
    snprintf(parameters[4].value, MAX_VALUE_LENGTH, "%d", (int)dataOutAvailable);
//Parse parameter dataOutMoved
    parameters[5].description = NULL;
    strncpy(parameters[5].type, "^size_t", MAX_TYPE_LENGTH);
    snprintf(parameters[5].value, MAX_VALUE_LENGTH, "0x%X", (register_t)dataOutMoved);
    set_enabled(true);
    CCCryptorStatus return_value = original_CCCryptorUpdate(cryptorRef, dataIn, dataInLength, dataOut, dataOutAvailable, dataOutMoved);
    set_enabled(false);
//Parse parameter dataOut
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "^void", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "0x%X", (register_t)dataOut);
    parameters[3].description = (char*)calloc(2*(dataOutMoved ? (*dataOutMoved) : 0)+1, sizeof(char));
    NSData *dataOut_data = [NSData dataWithBytes:dataOut length:(dataOutMoved ? (*dataOutMoved) : 0)];
    strncpy(parameters[3].description, [[[[[dataOut_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*(dataOutMoved ? (*dataOutMoved) : 0));
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CommonCrypto", "CCCryptorUpdate", "0x0", parameters, 6);
            for(unsigned int i = 0; i < 6; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 6; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CCCryptorStatus", MAX_TYPE_LENGTH);
    switch (return_value) {
    case 0:
        return_param.description = (char*)calloc(11, sizeof(char));
        strncpy(return_param.description, "kCCSuccess", 10);
        break;
    case -4300:
        return_param.description = (char*)calloc(14, sizeof(char));
        strncpy(return_param.description, "kCCParamError", 13);
        break;
    case -4301:
        return_param.description = (char*)calloc(18, sizeof(char));
        strncpy(return_param.description, "kCCBufferTooSmall", 17);
        break;
    case -4302:
        return_param.description = (char*)calloc(17, sizeof(char));
        strncpy(return_param.description, "kCCMemoryFailure", 16);
        break;
    case -4303:
        return_param.description = (char*)calloc(18, sizeof(char));
        strncpy(return_param.description, "kCCAlignmentError", 17);
        break;
    case -4304:
        return_param.description = (char*)calloc(15, sizeof(char));
        strncpy(return_param.description, "kCCDecodeError", 14);
        break;
    case -4305:
        return_param.description = (char*)calloc(17, sizeof(char));
        strncpy(return_param.description, "kCCUnimplemented", 16);
        break;
    case -4306:
        return_param.description = (char*)calloc(12, sizeof(char));
        strncpy(return_param.description, "kCCOverflow", 11);
        break;
    case -4307:
        return_param.description = (char*)calloc(14, sizeof(char));
        strncpy(return_param.description, "kCCRNGFailure", 13);
        break;
    }
    snprintf(return_param.value, MAX_VALUE_LENGTH, "%d", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


CCCryptorStatus ____CCCryptorFinal(CCCryptorRef cryptorRef, void * dataOut, size_t dataOutAvailable, size_t * dataOutMoved)
{
    if (!is_enabled() || !enabled_) {
        CCCryptorStatus return_value = original_CCCryptorFinal(cryptorRef, dataOut, dataOutAvailable, dataOutMoved);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(4, sizeof(parameter_t));
//Parse parameter cryptorRef
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CCCryptorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)cryptorRef);
//Parse parameter dataOutAvailable
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "size_t", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "%d", (int)dataOutAvailable);
//Parse parameter dataOutMoved
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "^size_t", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "0x%X", (register_t)dataOutMoved);
    set_enabled(true);
    CCCryptorStatus return_value = original_CCCryptorFinal(cryptorRef, dataOut, dataOutAvailable, dataOutMoved);
    set_enabled(false);
//Parse parameter dataOut
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "^void", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (register_t)dataOut);
    parameters[1].description = (char*)calloc(2*(dataOutMoved ? (*dataOutMoved) : 0)+1, sizeof(char));
    NSData *dataOut_data = [NSData dataWithBytes:dataOut length:(dataOutMoved ? (*dataOutMoved) : 0)];
    strncpy(parameters[1].description, [[[[[dataOut_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*(dataOutMoved ? (*dataOutMoved) : 0));
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CommonCrypto", "CCCryptorFinal", "0x0", parameters, 4);
            for(unsigned int i = 0; i < 4; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 4; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CCCryptorStatus", MAX_TYPE_LENGTH);
    switch (return_value) {
    case 0:
        return_param.description = (char*)calloc(11, sizeof(char));
        strncpy(return_param.description, "kCCSuccess", 10);
        break;
    case -4300:
        return_param.description = (char*)calloc(14, sizeof(char));
        strncpy(return_param.description, "kCCParamError", 13);
        break;
    case -4301:
        return_param.description = (char*)calloc(18, sizeof(char));
        strncpy(return_param.description, "kCCBufferTooSmall", 17);
        break;
    case -4302:
        return_param.description = (char*)calloc(17, sizeof(char));
        strncpy(return_param.description, "kCCMemoryFailure", 16);
        break;
    case -4303:
        return_param.description = (char*)calloc(18, sizeof(char));
        strncpy(return_param.description, "kCCAlignmentError", 17);
        break;
    case -4304:
        return_param.description = (char*)calloc(15, sizeof(char));
        strncpy(return_param.description, "kCCDecodeError", 14);
        break;
    case -4305:
        return_param.description = (char*)calloc(17, sizeof(char));
        strncpy(return_param.description, "kCCUnimplemented", 16);
        break;
    case -4306:
        return_param.description = (char*)calloc(12, sizeof(char));
        strncpy(return_param.description, "kCCOverflow", 11);
        break;
    case -4307:
        return_param.description = (char*)calloc(14, sizeof(char));
        strncpy(return_param.description, "kCCRNGFailure", 13);
        break;
    }
    snprintf(return_param.value, MAX_VALUE_LENGTH, "%d", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


size_t ____CCCryptorGetOutputLength(CCCryptorRef cryptorRef, size_t inputLength, bool final)
{
    if (!is_enabled() || !enabled_) {
        size_t return_value = original_CCCryptorGetOutputLength(cryptorRef, inputLength, final);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(3, sizeof(parameter_t));
//Parse parameter cryptorRef
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CCCryptorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)cryptorRef);
//Parse parameter inputLength
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "size_t", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "%d", (int)inputLength);
//Parse parameter final
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "bool", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "%d", (int)final);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CommonCrypto", "CCCryptorGetOutputLength", "0x0", parameters, 3);
            for(unsigned int i = 0; i < 3; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 3; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    size_t return_value = original_CCCryptorGetOutputLength(cryptorRef, inputLength, final);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "size_t", MAX_TYPE_LENGTH);
    snprintf(return_param.value, MAX_VALUE_LENGTH, "%d", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


CCCryptorStatus ____CCCryptorReset(CCCryptorRef cryptorRef, const void * iv)
{
    if (!is_enabled() || !enabled_) {
        CCCryptorStatus return_value = original_CCCryptorReset(cryptorRef, iv);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(2, sizeof(parameter_t));
//Parse parameter cryptorRef
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CCCryptorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)cryptorRef);
//Parse parameter iv
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "^void", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (register_t)iv);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CommonCrypto", "CCCryptorReset", "0x0", parameters, 2);
            for(unsigned int i = 0; i < 2; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 2; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    CCCryptorStatus return_value = original_CCCryptorReset(cryptorRef, iv);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CCCryptorStatus", MAX_TYPE_LENGTH);
    switch (return_value) {
    case 0:
        return_param.description = (char*)calloc(11, sizeof(char));
        strncpy(return_param.description, "kCCSuccess", 10);
        break;
    case -4300:
        return_param.description = (char*)calloc(14, sizeof(char));
        strncpy(return_param.description, "kCCParamError", 13);
        break;
    case -4301:
        return_param.description = (char*)calloc(18, sizeof(char));
        strncpy(return_param.description, "kCCBufferTooSmall", 17);
        break;
    case -4302:
        return_param.description = (char*)calloc(17, sizeof(char));
        strncpy(return_param.description, "kCCMemoryFailure", 16);
        break;
    case -4303:
        return_param.description = (char*)calloc(18, sizeof(char));
        strncpy(return_param.description, "kCCAlignmentError", 17);
        break;
    case -4304:
        return_param.description = (char*)calloc(15, sizeof(char));
        strncpy(return_param.description, "kCCDecodeError", 14);
        break;
    case -4305:
        return_param.description = (char*)calloc(17, sizeof(char));
        strncpy(return_param.description, "kCCUnimplemented", 16);
        break;
    case -4306:
        return_param.description = (char*)calloc(12, sizeof(char));
        strncpy(return_param.description, "kCCOverflow", 11);
        break;
    case -4307:
        return_param.description = (char*)calloc(14, sizeof(char));
        strncpy(return_param.description, "kCCRNGFailure", 13);
        break;
    }
    snprintf(return_param.value, MAX_VALUE_LENGTH, "%d", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


CCCryptorStatus ____CCCrypt(CCOperation op, CCAlgorithm alg, CCOptions options, const void * key, size_t keyLength, const void * iv, const void * dataIn, size_t dataInLength, void * dataOut, size_t dataOutAvailable, size_t * dataOutMoved)
{
    if (!is_enabled() || !enabled_) {
        CCCryptorStatus return_value = original_CCCrypt(op, alg, options, key, keyLength, iv, dataIn, dataInLength, dataOut, dataOutAvailable, dataOutMoved);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(11, sizeof(parameter_t));
//Parse parameter op
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CCOperation", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)op);
    switch (op) {
    case 0:
        parameters[0].description = (char*)calloc(11, sizeof(char));
        strncpy(parameters[0].description, "kCCEncrypt", 10);
        break;
    case 1:
        parameters[0].description = (char*)calloc(11, sizeof(char));
        strncpy(parameters[0].description, "kCCDecrypt", 10);
        break;
    }//Parse parameter alg
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CCAlgorithm", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "%d", (int)alg);
    switch (alg) {
    case 0:
        parameters[1].description = (char*)calloc(19, sizeof(char));
        strncpy(parameters[1].description, "kCCAlgorithmAES128", 18);
        break;
    case 1:
        parameters[1].description = (char*)calloc(16, sizeof(char));
        strncpy(parameters[1].description, "kCCAlgorithmDES", 15);
        break;
    case 2:
        parameters[1].description = (char*)calloc(17, sizeof(char));
        strncpy(parameters[1].description, "kCCAlgorithm3DES", 16);
        break;
    case 3:
        parameters[1].description = (char*)calloc(17, sizeof(char));
        strncpy(parameters[1].description, "kCCAlgorithmCAST", 16);
        break;
    case 4:
        parameters[1].description = (char*)calloc(16, sizeof(char));
        strncpy(parameters[1].description, "kCCAlgorithmRC4", 15);
        break;
    case 5:
        parameters[1].description = (char*)calloc(16, sizeof(char));
        strncpy(parameters[1].description, "kCCAlgorithmRC2", 15);
        break;
    case 6:
        parameters[1].description = (char*)calloc(21, sizeof(char));
        strncpy(parameters[1].description, "kCCAlgorithmBlowfish", 20);
        break;
    }//Parse parameter options
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CCOptions", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "%d", (int)options);
//Parse parameter key
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "^void", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "0x%X", (register_t)key);
//Parse parameter keyLength
    parameters[4].description = NULL;
    strncpy(parameters[4].type, "size_t", MAX_TYPE_LENGTH);
    snprintf(parameters[4].value, MAX_VALUE_LENGTH, "%d", (int)keyLength);
//Parse parameter iv
    parameters[5].description = NULL;
    strncpy(parameters[5].type, "^void", MAX_TYPE_LENGTH);
    snprintf(parameters[5].value, MAX_VALUE_LENGTH, "0x%X", (register_t)iv);
//Parse parameter dataIn
    parameters[6].description = NULL;
    strncpy(parameters[6].type, "^void", MAX_TYPE_LENGTH);
    snprintf(parameters[6].value, MAX_VALUE_LENGTH, "0x%X", (register_t)dataIn);
//Parse parameter dataInLength
    parameters[7].description = NULL;
    strncpy(parameters[7].type, "size_t", MAX_TYPE_LENGTH);
    snprintf(parameters[7].value, MAX_VALUE_LENGTH, "%d", (int)dataInLength);
//Parse parameter dataOut
    parameters[8].description = NULL;
    strncpy(parameters[8].type, "^void", MAX_TYPE_LENGTH);
    snprintf(parameters[8].value, MAX_VALUE_LENGTH, "0x%X", (register_t)dataOut);
//Parse parameter dataOutAvailable
    parameters[9].description = NULL;
    strncpy(parameters[9].type, "size_t", MAX_TYPE_LENGTH);
    snprintf(parameters[9].value, MAX_VALUE_LENGTH, "%d", (int)dataOutAvailable);
//Parse parameter dataOutMoved
    parameters[10].description = NULL;
    strncpy(parameters[10].type, "^size_t", MAX_TYPE_LENGTH);
    snprintf(parameters[10].value, MAX_VALUE_LENGTH, "0x%X", (register_t)dataOutMoved);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CommonCrypto", "CCCrypt", "0x0", parameters, 11);
            for(unsigned int i = 0; i < 11; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 11; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    CCCryptorStatus return_value = original_CCCrypt(op, alg, options, key, keyLength, iv, dataIn, dataInLength, dataOut, dataOutAvailable, dataOutMoved);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CCCryptorStatus", MAX_TYPE_LENGTH);
    switch (return_value) {
    case 0:
        return_param.description = (char*)calloc(11, sizeof(char));
        strncpy(return_param.description, "kCCSuccess", 10);
        break;
    case -4300:
        return_param.description = (char*)calloc(14, sizeof(char));
        strncpy(return_param.description, "kCCParamError", 13);
        break;
    case -4301:
        return_param.description = (char*)calloc(18, sizeof(char));
        strncpy(return_param.description, "kCCBufferTooSmall", 17);
        break;
    case -4302:
        return_param.description = (char*)calloc(17, sizeof(char));
        strncpy(return_param.description, "kCCMemoryFailure", 16);
        break;
    case -4303:
        return_param.description = (char*)calloc(18, sizeof(char));
        strncpy(return_param.description, "kCCAlignmentError", 17);
        break;
    case -4304:
        return_param.description = (char*)calloc(15, sizeof(char));
        strncpy(return_param.description, "kCCDecodeError", 14);
        break;
    case -4305:
        return_param.description = (char*)calloc(17, sizeof(char));
        strncpy(return_param.description, "kCCUnimplemented", 16);
        break;
    case -4306:
        return_param.description = (char*)calloc(12, sizeof(char));
        strncpy(return_param.description, "kCCOverflow", 11);
        break;
    case -4307:
        return_param.description = (char*)calloc(14, sizeof(char));
        strncpy(return_param.description, "kCCRNGFailure", 13);
        break;
    }
    snprintf(return_param.value, MAX_VALUE_LENGTH, "%d", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


CCCryptorStatus ____CCCryptorCreateWithMode(CCOperation op, CCMode mode, CCAlgorithm alg, CCPadding padding, const void * iv, const void * key, size_t keyLength, const void * tweak, size_t tweakLength, int numRounds, CCModeOptions options, CCCryptorRef * cryptorRef)
{
    if (!is_enabled() || !enabled_) {
        CCCryptorStatus return_value = original_CCCryptorCreateWithMode(op, mode, alg, padding, iv, key, keyLength, tweak, tweakLength, numRounds, options, cryptorRef);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(12, sizeof(parameter_t));
//Parse parameter op
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CCOperation", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)op);
    switch (op) {
    case 0:
        parameters[0].description = (char*)calloc(11, sizeof(char));
        strncpy(parameters[0].description, "kCCEncrypt", 10);
        break;
    case 1:
        parameters[0].description = (char*)calloc(11, sizeof(char));
        strncpy(parameters[0].description, "kCCDecrypt", 10);
        break;
    }//Parse parameter mode
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CCMode", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "%d", (int)mode);
//Parse parameter alg
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CCAlgorithm", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "%d", (int)alg);
    switch (alg) {
    case 0:
        parameters[2].description = (char*)calloc(19, sizeof(char));
        strncpy(parameters[2].description, "kCCAlgorithmAES128", 18);
        break;
    case 1:
        parameters[2].description = (char*)calloc(16, sizeof(char));
        strncpy(parameters[2].description, "kCCAlgorithmDES", 15);
        break;
    case 2:
        parameters[2].description = (char*)calloc(17, sizeof(char));
        strncpy(parameters[2].description, "kCCAlgorithm3DES", 16);
        break;
    case 3:
        parameters[2].description = (char*)calloc(17, sizeof(char));
        strncpy(parameters[2].description, "kCCAlgorithmCAST", 16);
        break;
    case 4:
        parameters[2].description = (char*)calloc(16, sizeof(char));
        strncpy(parameters[2].description, "kCCAlgorithmRC4", 15);
        break;
    case 5:
        parameters[2].description = (char*)calloc(16, sizeof(char));
        strncpy(parameters[2].description, "kCCAlgorithmRC2", 15);
        break;
    case 6:
        parameters[2].description = (char*)calloc(21, sizeof(char));
        strncpy(parameters[2].description, "kCCAlgorithmBlowfish", 20);
        break;
    }//Parse parameter padding
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "CCPadding", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "%d", (int)padding);
//Parse parameter iv
    parameters[4].description = NULL;
    strncpy(parameters[4].type, "^void", MAX_TYPE_LENGTH);
    snprintf(parameters[4].value, MAX_VALUE_LENGTH, "0x%X", (register_t)iv);
    if(iv&&alg==kCCAlgorithmAES) {
        parameters[4].description = (char*)calloc(2*16+1, sizeof(char));
        NSData *iv_data = [NSData dataWithBytes:iv length:16];
        strncpy(parameters[4].description, [[[[[iv_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*16);

    }
    if(iv&&alg!=kCCAlgorithmAES) {
        parameters[4].description = (char*)calloc(2*8+1, sizeof(char));
        NSData *iv_data = [NSData dataWithBytes:iv length:8];
        strncpy(parameters[4].description, [[[[[iv_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*8);

    }
//Parse parameter key
    parameters[5].description = NULL;
    strncpy(parameters[5].type, "^void", MAX_TYPE_LENGTH);
    snprintf(parameters[5].value, MAX_VALUE_LENGTH, "0x%X", (register_t)key);
    parameters[5].description = (char*)calloc(2*keyLength+1, sizeof(char));
    NSData *key_data = [NSData dataWithBytes:key length:keyLength];
    strncpy(parameters[5].description, [[[[[key_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*keyLength);
//Parse parameter keyLength
    parameters[6].description = NULL;
    strncpy(parameters[6].type, "size_t", MAX_TYPE_LENGTH);
    snprintf(parameters[6].value, MAX_VALUE_LENGTH, "%d", (int)keyLength);
//Parse parameter tweak
    parameters[7].description = NULL;
    strncpy(parameters[7].type, "^void", MAX_TYPE_LENGTH);
    snprintf(parameters[7].value, MAX_VALUE_LENGTH, "0x%X", (register_t)tweak);
    if(tweak!=NULL) {
        parameters[7].description = (char*)calloc(2*tweakLength+1, sizeof(char));
        NSData *tweak_data = [NSData dataWithBytes:tweak length:tweakLength];
        strncpy(parameters[7].description, [[[[[tweak_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*tweakLength);

    }
//Parse parameter tweakLength
    parameters[8].description = NULL;
    strncpy(parameters[8].type, "size_t", MAX_TYPE_LENGTH);
    snprintf(parameters[8].value, MAX_VALUE_LENGTH, "%d", (int)tweakLength);
//Parse parameter numRounds
    parameters[9].description = NULL;
    strncpy(parameters[9].type, "i", MAX_TYPE_LENGTH);
    snprintf(parameters[9].value, MAX_VALUE_LENGTH, "%d", (int)numRounds);
//Parse parameter options
    parameters[10].description = NULL;
    strncpy(parameters[10].type, "CCModeOptions", MAX_TYPE_LENGTH);
    snprintf(parameters[10].value, MAX_VALUE_LENGTH, "%d", (int)options);
    switch (options) {
    case 1:
        parameters[10].description = (char*)calloc(20, sizeof(char));
        strncpy(parameters[10].description, "kCCModeOptionCTR_LE", 19);
        break;
    case 2:
        parameters[10].description = (char*)calloc(20, sizeof(char));
        strncpy(parameters[10].description, "kCCModeOptionCTR_BE", 19);
        break;
    }
    set_enabled(true);
    CCCryptorStatus return_value = original_CCCryptorCreateWithMode(op, mode, alg, padding, iv, key, keyLength, tweak, tweakLength, numRounds, options, cryptorRef);
    set_enabled(false);
//Parse parameter cryptorRef
    parameters[11].description = NULL;
    strncpy(parameters[11].type, "^CCCryptorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[11].value, MAX_VALUE_LENGTH, "0x%X", (int)*cryptorRef);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CommonCrypto", "CCCryptorCreateWithMode", "0x0", parameters, 12);
            for(unsigned int i = 0; i < 12; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 12; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CCCryptorStatus", MAX_TYPE_LENGTH);
    switch (return_value) {
    case 0:
        return_param.description = (char*)calloc(11, sizeof(char));
        strncpy(return_param.description, "kCCSuccess", 10);
        break;
    case -4300:
        return_param.description = (char*)calloc(14, sizeof(char));
        strncpy(return_param.description, "kCCParamError", 13);
        break;
    case -4301:
        return_param.description = (char*)calloc(18, sizeof(char));
        strncpy(return_param.description, "kCCBufferTooSmall", 17);
        break;
    case -4302:
        return_param.description = (char*)calloc(17, sizeof(char));
        strncpy(return_param.description, "kCCMemoryFailure", 16);
        break;
    case -4303:
        return_param.description = (char*)calloc(18, sizeof(char));
        strncpy(return_param.description, "kCCAlignmentError", 17);
        break;
    case -4304:
        return_param.description = (char*)calloc(15, sizeof(char));
        strncpy(return_param.description, "kCCDecodeError", 14);
        break;
    case -4305:
        return_param.description = (char*)calloc(17, sizeof(char));
        strncpy(return_param.description, "kCCUnimplemented", 16);
        break;
    case -4306:
        return_param.description = (char*)calloc(12, sizeof(char));
        strncpy(return_param.description, "kCCOverflow", 11);
        break;
    case -4307:
        return_param.description = (char*)calloc(14, sizeof(char));
        strncpy(return_param.description, "kCCRNGFailure", 13);
        break;
    }
    snprintf(return_param.value, MAX_VALUE_LENGTH, "%d", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


int ____CCKeyDerivationPBKDF(CCPBKDFAlgorithm algorithm, const char * password, size_t passwordLen, const uint8_t * salt, size_t saltLen, CCPseudoRandomAlgorithm prf, uint rounds, uint8_t * derivedKey, size_t derivedKeyLen)
{
    if (!is_enabled() || !enabled_) {
        int return_value = original_CCKeyDerivationPBKDF(algorithm, password, passwordLen, salt, saltLen, prf, rounds, derivedKey, derivedKeyLen);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(9, sizeof(parameter_t));
//Parse parameter algorithm
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CCPBKDFAlgorithm", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)algorithm);
    switch (algorithm) {
    case 2:
        parameters[0].description = (char*)calloc(10, sizeof(char));
        strncpy(parameters[0].description, "kCCPBKDF2", 9);
        break;
    }//Parse parameter password
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "^char", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (register_t)password);
    parameters[1].description = (char*)calloc(2*passwordLen+1, sizeof(char));
    NSData *password_data = [NSData dataWithBytes:password length:passwordLen];
    strncpy(parameters[1].description, [[[[[password_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*passwordLen);
//Parse parameter passwordLen
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "size_t", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "%d", (int)passwordLen);
//Parse parameter salt
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "^uint8_t", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "0x%X", (register_t)salt);
    parameters[3].description = (char*)calloc(2*saltLen+1, sizeof(char));
    NSData *salt_data = [NSData dataWithBytes:salt length:saltLen];
    strncpy(parameters[3].description, [[[[[salt_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*saltLen);
//Parse parameter saltLen
    parameters[4].description = NULL;
    strncpy(parameters[4].type, "size_t", MAX_TYPE_LENGTH);
    snprintf(parameters[4].value, MAX_VALUE_LENGTH, "%d", (int)saltLen);
//Parse parameter prf
    parameters[5].description = NULL;
    strncpy(parameters[5].type, "CCPseudoRandomAlgorithm", MAX_TYPE_LENGTH);
    snprintf(parameters[5].value, MAX_VALUE_LENGTH, "%d", (int)prf);
    switch (prf) {
    case 1:
        parameters[5].description = (char*)calloc(18, sizeof(char));
        strncpy(parameters[5].description, "kCCPRFHmacAlgSHA1", 17);
        break;
    case 2:
        parameters[5].description = (char*)calloc(20, sizeof(char));
        strncpy(parameters[5].description, "kCCPRFHmacAlgSHA224", 19);
        break;
    case 3:
        parameters[5].description = (char*)calloc(20, sizeof(char));
        strncpy(parameters[5].description, "kCCPRFHmacAlgSHA256", 19);
        break;
    case 4:
        parameters[5].description = (char*)calloc(20, sizeof(char));
        strncpy(parameters[5].description, "kCCPRFHmacAlgSHA384", 19);
        break;
    case 5:
        parameters[5].description = (char*)calloc(20, sizeof(char));
        strncpy(parameters[5].description, "kCCPRFHmacAlgSHA512", 19);
        break;
    }//Parse parameter rounds
    parameters[6].description = NULL;
    strncpy(parameters[6].type, "uint", MAX_TYPE_LENGTH);
    snprintf(parameters[6].value, MAX_VALUE_LENGTH, "%d", (int)rounds);
//Parse parameter derivedKeyLen
    parameters[8].description = NULL;
    strncpy(parameters[8].type, "size_t", MAX_TYPE_LENGTH);
    snprintf(parameters[8].value, MAX_VALUE_LENGTH, "%d", (int)derivedKeyLen);
    set_enabled(true);
    int return_value = original_CCKeyDerivationPBKDF(algorithm, password, passwordLen, salt, saltLen, prf, rounds, derivedKey, derivedKeyLen);
    set_enabled(false);
//Parse parameter derivedKey
    parameters[7].description = NULL;
    strncpy(parameters[7].type, "^uint8_t", MAX_TYPE_LENGTH);
    snprintf(parameters[7].value, MAX_VALUE_LENGTH, "0x%X", (register_t)derivedKey);
    parameters[7].description = (char*)calloc(2*derivedKeyLen+1, sizeof(char));
    NSData *derivedKey_data = [NSData dataWithBytes:derivedKey length:derivedKeyLen];
    strncpy(parameters[7].description, [[[[[derivedKey_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*derivedKeyLen);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CommonCrypto", "CCKeyDerivationPBKDF", "0x0", parameters, 9);
            for(unsigned int i = 0; i < 9; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 9; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "int", MAX_TYPE_LENGTH);
    snprintf(return_param.value, MAX_VALUE_LENGTH, "%d", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


uint ____CCCalibratePBKDF(CCPBKDFAlgorithm algorithm, size_t passwordLen, size_t saltLen, CCPseudoRandomAlgorithm prf, size_t derivedKeyLen, uint32_t msec)
{
    if (!is_enabled() || !enabled_) {
        uint return_value = original_CCCalibratePBKDF(algorithm, passwordLen, saltLen, prf, derivedKeyLen, msec);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(6, sizeof(parameter_t));
//Parse parameter algorithm
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CCPBKDFAlgorithm", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)algorithm);
    switch (algorithm) {
    case 2:
        parameters[0].description = (char*)calloc(10, sizeof(char));
        strncpy(parameters[0].description, "kCCPBKDF2", 9);
        break;
    }//Parse parameter passwordLen
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "size_t", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "%d", (int)passwordLen);
//Parse parameter saltLen
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "size_t", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "%d", (int)saltLen);
//Parse parameter prf
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "CCPseudoRandomAlgorithm", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "%d", (int)prf);
    switch (prf) {
    case 1:
        parameters[3].description = (char*)calloc(18, sizeof(char));
        strncpy(parameters[3].description, "kCCPRFHmacAlgSHA1", 17);
        break;
    case 2:
        parameters[3].description = (char*)calloc(20, sizeof(char));
        strncpy(parameters[3].description, "kCCPRFHmacAlgSHA224", 19);
        break;
    case 3:
        parameters[3].description = (char*)calloc(20, sizeof(char));
        strncpy(parameters[3].description, "kCCPRFHmacAlgSHA256", 19);
        break;
    case 4:
        parameters[3].description = (char*)calloc(20, sizeof(char));
        strncpy(parameters[3].description, "kCCPRFHmacAlgSHA384", 19);
        break;
    case 5:
        parameters[3].description = (char*)calloc(20, sizeof(char));
        strncpy(parameters[3].description, "kCCPRFHmacAlgSHA512", 19);
        break;
    }//Parse parameter derivedKeyLen
    parameters[4].description = NULL;
    strncpy(parameters[4].type, "size_t", MAX_TYPE_LENGTH);
    snprintf(parameters[4].value, MAX_VALUE_LENGTH, "%d", (int)derivedKeyLen);
//Parse parameter msec
    parameters[5].description = NULL;
    strncpy(parameters[5].type, "uint32_t", MAX_TYPE_LENGTH);
    snprintf(parameters[5].value, MAX_VALUE_LENGTH, "%d", (int)msec);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CommonCrypto", "CCCalibratePBKDF", "0x0", parameters, 6);
            for(unsigned int i = 0; i < 6; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 6; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    uint return_value = original_CCCalibratePBKDF(algorithm, passwordLen, saltLen, prf, derivedKeyLen, msec);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "uint", MAX_TYPE_LENGTH);
    snprintf(return_param.value, MAX_VALUE_LENGTH, "%d", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


CCRNGStatus ____CCRandomGenerateBytes(void * bytes, size_t count)
{
    if (!is_enabled() || !enabled_) {
        CCRNGStatus return_value = original_CCRandomGenerateBytes(bytes, count);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(2, sizeof(parameter_t));
//Parse parameter count
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "size_t", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "%d", (int)count);
    set_enabled(true);
    CCRNGStatus return_value = original_CCRandomGenerateBytes(bytes, count);
    set_enabled(false);
//Parse parameter bytes
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "^void", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (register_t)bytes);
    parameters[0].description = (char*)calloc(2*count+1, sizeof(char));
    NSData *bytes_data = [NSData dataWithBytes:bytes length:count];
    strncpy(parameters[0].description, [[[[[bytes_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*count);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CommonCrypto", "CCRandomGenerateBytes", "0x0", parameters, 2);
            for(unsigned int i = 0; i < 2; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 2; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CCRNGStatus", MAX_TYPE_LENGTH);
    switch (return_value) {
    case 0:
        return_param.description = (char*)calloc(11, sizeof(char));
        strncpy(return_param.description, "kCCSuccess", 10);
        break;
    case -4300:
        return_param.description = (char*)calloc(14, sizeof(char));
        strncpy(return_param.description, "kCCParamError", 13);
        break;
    case -4301:
        return_param.description = (char*)calloc(18, sizeof(char));
        strncpy(return_param.description, "kCCBufferTooSmall", 17);
        break;
    case -4302:
        return_param.description = (char*)calloc(17, sizeof(char));
        strncpy(return_param.description, "kCCMemoryFailure", 16);
        break;
    case -4303:
        return_param.description = (char*)calloc(18, sizeof(char));
        strncpy(return_param.description, "kCCAlignmentError", 17);
        break;
    case -4304:
        return_param.description = (char*)calloc(15, sizeof(char));
        strncpy(return_param.description, "kCCDecodeError", 14);
        break;
    case -4305:
        return_param.description = (char*)calloc(17, sizeof(char));
        strncpy(return_param.description, "kCCUnimplemented", 16);
        break;
    case -4306:
        return_param.description = (char*)calloc(12, sizeof(char));
        strncpy(return_param.description, "kCCOverflow", 11);
        break;
    case -4307:
        return_param.description = (char*)calloc(14, sizeof(char));
        strncpy(return_param.description, "kCCRNGFailure", 13);
        break;
    }
    snprintf(return_param.value, MAX_VALUE_LENGTH, "%d", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


int ____CC_MD2_Init(CC_MD2_CTX * c)
{
    if (!is_enabled() || !enabled_) {
        int return_value = original_CC_MD2_Init(c);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(1, sizeof(parameter_t));
    set_enabled(true);
    int return_value = original_CC_MD2_Init(c);
    set_enabled(false);
//Parse parameter c
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "^CC_MD2_CTX", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (register_t)c);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CommonCrypto", "CC_MD2_Init", "0x0", parameters, 1);
            for(unsigned int i = 0; i < 1; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 1; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "int", MAX_TYPE_LENGTH);
    snprintf(return_param.value, MAX_VALUE_LENGTH, "%d", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


int ____CC_MD2_Update(CC_MD2_CTX * c, const void * data, CC_LONG len)
{
    if (!is_enabled() || !enabled_) {
        int return_value = original_CC_MD2_Update(c, data, len);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(3, sizeof(parameter_t));
//Parse parameter c
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "^CC_MD2_CTX", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (register_t)c);
//Parse parameter data
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "^void", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (register_t)data);
    parameters[1].description = (char*)calloc(2*len+1, sizeof(char));
    NSData *data_data = [NSData dataWithBytes:data length:len];
    strncpy(parameters[1].description, [[[[[data_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*len);
//Parse parameter len
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CC_LONG", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "%d", (int)len);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CommonCrypto", "CC_MD2_Update", "0x0", parameters, 3);
            for(unsigned int i = 0; i < 3; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 3; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    int return_value = original_CC_MD2_Update(c, data, len);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "int", MAX_TYPE_LENGTH);
    snprintf(return_param.value, MAX_VALUE_LENGTH, "%d", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


int ____CC_MD2_Final(unsigned char * md, CC_MD2_CTX * c)
{
    if (!is_enabled() || !enabled_) {
        int return_value = original_CC_MD2_Final(md, c);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(2, sizeof(parameter_t));
//Parse parameter c
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "^CC_MD2_CTX", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (register_t)c);
    set_enabled(true);
    int return_value = original_CC_MD2_Final(md, c);
    set_enabled(false);
//Parse parameter md
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "*", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (register_t)md);
    parameters[0].description = (char*)calloc(2*CC_MD2_DIGEST_LENGTH+1, sizeof(char));
    NSData *md_data = [NSData dataWithBytes:md length:CC_MD2_DIGEST_LENGTH];
    strncpy(parameters[0].description, [[[[[md_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*CC_MD2_DIGEST_LENGTH);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CommonCrypto", "CC_MD2_Final", "0x0", parameters, 2);
            for(unsigned int i = 0; i < 2; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 2; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "int", MAX_TYPE_LENGTH);
    snprintf(return_param.value, MAX_VALUE_LENGTH, "%d", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


unsigned char * ____CC_MD2(const void * data, CC_LONG len, unsigned char * md)
{
    if (!is_enabled() || !enabled_) {
        unsigned char * return_value = original_CC_MD2(data, len, md);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(3, sizeof(parameter_t));
//Parse parameter data
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "^void", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (register_t)data);
    parameters[0].description = (char*)calloc(2*len+1, sizeof(char));
    NSData *data_data = [NSData dataWithBytes:data length:len];
    strncpy(parameters[0].description, [[[[[data_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*len);
//Parse parameter len
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CC_LONG", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "%d", (int)len);
    set_enabled(true);
    unsigned char * return_value = original_CC_MD2(data, len, md);
    set_enabled(false);
//Parse parameter md
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "*", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (register_t)md);
    parameters[2].description = (char*)calloc(2*CC_MD2_DIGEST_LENGTH+1, sizeof(char));
    NSData *md_data = [NSData dataWithBytes:md length:CC_MD2_DIGEST_LENGTH];
    strncpy(parameters[2].description, [[[[[md_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*CC_MD2_DIGEST_LENGTH);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CommonCrypto", "CC_MD2", "0x0", parameters, 3);
            for(unsigned int i = 0; i < 3; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 3; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "unsigned char *", MAX_TYPE_LENGTH);
    snprintf(return_param.value, MAX_VALUE_LENGTH, "0x%X", (register_t)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


int ____CC_MD4_Init(CC_MD4_CTX * c)
{
    if (!is_enabled() || !enabled_) {
        int return_value = original_CC_MD4_Init(c);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(1, sizeof(parameter_t));
    set_enabled(true);
    int return_value = original_CC_MD4_Init(c);
    set_enabled(false);
//Parse parameter c
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "^CC_MD4_CTX", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (register_t)c);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CommonCrypto", "CC_MD4_Init", "0x0", parameters, 1);
            for(unsigned int i = 0; i < 1; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 1; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "int", MAX_TYPE_LENGTH);
    snprintf(return_param.value, MAX_VALUE_LENGTH, "%d", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


int ____CC_MD4_Update(CC_MD4_CTX * c, const void * data, CC_LONG len)
{
    if (!is_enabled() || !enabled_) {
        int return_value = original_CC_MD4_Update(c, data, len);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(3, sizeof(parameter_t));
//Parse parameter c
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "^CC_MD4_CTX", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (register_t)c);
//Parse parameter data
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "^void", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (register_t)data);
    parameters[1].description = (char*)calloc(2*len+1, sizeof(char));
    NSData *data_data = [NSData dataWithBytes:data length:len];
    strncpy(parameters[1].description, [[[[[data_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*len);
//Parse parameter len
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CC_LONG", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "%d", (int)len);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CommonCrypto", "CC_MD4_Update", "0x0", parameters, 3);
            for(unsigned int i = 0; i < 3; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 3; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    int return_value = original_CC_MD4_Update(c, data, len);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "int", MAX_TYPE_LENGTH);
    snprintf(return_param.value, MAX_VALUE_LENGTH, "%d", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


int ____CC_MD4_Final(unsigned char * md, CC_MD4_CTX * c)
{
    if (!is_enabled() || !enabled_) {
        int return_value = original_CC_MD4_Final(md, c);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(2, sizeof(parameter_t));
//Parse parameter c
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "^CC_MD4_CTX", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (register_t)c);
    set_enabled(true);
    int return_value = original_CC_MD4_Final(md, c);
    set_enabled(false);
//Parse parameter md
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "*", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (register_t)md);
    parameters[0].description = (char*)calloc(2*CC_MD4_DIGEST_LENGTH+1, sizeof(char));
    NSData *md_data = [NSData dataWithBytes:md length:CC_MD4_DIGEST_LENGTH];
    strncpy(parameters[0].description, [[[[[md_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*CC_MD4_DIGEST_LENGTH);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CommonCrypto", "CC_MD4_Final", "0x0", parameters, 2);
            for(unsigned int i = 0; i < 2; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 2; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "int", MAX_TYPE_LENGTH);
    snprintf(return_param.value, MAX_VALUE_LENGTH, "%d", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


unsigned char * ____CC_MD4(const void * data, CC_LONG len, unsigned char * md)
{
    if (!is_enabled() || !enabled_) {
        unsigned char * return_value = original_CC_MD4(data, len, md);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(3, sizeof(parameter_t));
//Parse parameter data
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "^void", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (register_t)data);
    parameters[0].description = (char*)calloc(2*len+1, sizeof(char));
    NSData *data_data = [NSData dataWithBytes:data length:len];
    strncpy(parameters[0].description, [[[[[data_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*len);
//Parse parameter len
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CC_LONG", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "%d", (int)len);
    set_enabled(true);
    unsigned char * return_value = original_CC_MD4(data, len, md);
    set_enabled(false);
//Parse parameter md
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "*", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (register_t)md);
    parameters[2].description = (char*)calloc(2*CC_MD4_DIGEST_LENGTH+1, sizeof(char));
    NSData *md_data = [NSData dataWithBytes:md length:CC_MD4_DIGEST_LENGTH];
    strncpy(parameters[2].description, [[[[[md_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*CC_MD4_DIGEST_LENGTH);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CommonCrypto", "CC_MD4", "0x0", parameters, 3);
            for(unsigned int i = 0; i < 3; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 3; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "unsigned char *", MAX_TYPE_LENGTH);
    snprintf(return_param.value, MAX_VALUE_LENGTH, "0x%X", (register_t)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


int ____CC_MD5_Init(CC_MD5_CTX * c)
{
    if (!is_enabled() || !enabled_) {
        int return_value = original_CC_MD5_Init(c);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(1, sizeof(parameter_t));
    set_enabled(true);
    int return_value = original_CC_MD5_Init(c);
    set_enabled(false);
//Parse parameter c
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "^CC_MD5_CTX", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (register_t)c);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CommonCrypto", "CC_MD5_Init", "0x0", parameters, 1);
            for(unsigned int i = 0; i < 1; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 1; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "int", MAX_TYPE_LENGTH);
    snprintf(return_param.value, MAX_VALUE_LENGTH, "%d", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


int ____CC_MD5_Update(CC_MD5_CTX * c, const void * data, CC_LONG len)
{
    if (!is_enabled() || !enabled_) {
        int return_value = original_CC_MD5_Update(c, data, len);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(3, sizeof(parameter_t));
//Parse parameter c
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "^CC_MD5_CTX", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (register_t)c);
//Parse parameter data
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "^void", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (register_t)data);
    parameters[1].description = (char*)calloc(2*len+1, sizeof(char));
    NSData *data_data = [NSData dataWithBytes:data length:len];
    strncpy(parameters[1].description, [[[[[data_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*len);
//Parse parameter len
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CC_LONG", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "%d", (int)len);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CommonCrypto", "CC_MD5_Update", "0x0", parameters, 3);
            for(unsigned int i = 0; i < 3; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 3; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    int return_value = original_CC_MD5_Update(c, data, len);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "int", MAX_TYPE_LENGTH);
    snprintf(return_param.value, MAX_VALUE_LENGTH, "%d", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


int ____CC_MD5_Final(unsigned char * md, CC_MD5_CTX * c)
{
    if (!is_enabled() || !enabled_) {
        int return_value = original_CC_MD5_Final(md, c);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(2, sizeof(parameter_t));
//Parse parameter c
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "^CC_MD5_CTX", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (register_t)c);
    set_enabled(true);
    int return_value = original_CC_MD5_Final(md, c);
    set_enabled(false);
//Parse parameter md
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "*", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (register_t)md);
    parameters[0].description = (char*)calloc(2*CC_MD5_DIGEST_LENGTH+1, sizeof(char));
    NSData *md_data = [NSData dataWithBytes:md length:CC_MD5_DIGEST_LENGTH];
    strncpy(parameters[0].description, [[[[[md_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*CC_MD5_DIGEST_LENGTH);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CommonCrypto", "CC_MD5_Final", "0x0", parameters, 2);
            for(unsigned int i = 0; i < 2; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 2; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "int", MAX_TYPE_LENGTH);
    snprintf(return_param.value, MAX_VALUE_LENGTH, "%d", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


unsigned char * ____CC_MD5(const void * data, CC_LONG len, unsigned char * md)
{
    if (!is_enabled() || !enabled_) {
        unsigned char * return_value = original_CC_MD5(data, len, md);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(3, sizeof(parameter_t));
//Parse parameter data
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "^void", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (register_t)data);
//Parse parameter len
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CC_LONG", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "%d", (int)len);
    set_enabled(true);
    unsigned char * return_value = original_CC_MD5(data, len, md);
    set_enabled(false);
//Parse parameter md
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "*", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (register_t)md);
    parameters[2].description = (char*)calloc(2*CC_MD5_DIGEST_LENGTH+1, sizeof(char));
    NSData *md_data = [NSData dataWithBytes:md length:CC_MD5_DIGEST_LENGTH];
    strncpy(parameters[2].description, [[[[[md_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*CC_MD5_DIGEST_LENGTH);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CommonCrypto", "CC_MD5", "0x0", parameters, 3);
            for(unsigned int i = 0; i < 3; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 3; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "unsigned char *", MAX_TYPE_LENGTH);
    snprintf(return_param.value, MAX_VALUE_LENGTH, "0x%X", (register_t)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


int ____CC_SHA1_Init(CC_SHA1_CTX * c)
{
    if (!is_enabled() || !enabled_) {
        int return_value = original_CC_SHA1_Init(c);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(1, sizeof(parameter_t));
    set_enabled(true);
    int return_value = original_CC_SHA1_Init(c);
    set_enabled(false);
//Parse parameter c
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "^CC_SHA1_CTX", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (register_t)c);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CommonCrypto", "CC_SHA1_Init", "0x0", parameters, 1);
            for(unsigned int i = 0; i < 1; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 1; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "int", MAX_TYPE_LENGTH);
    snprintf(return_param.value, MAX_VALUE_LENGTH, "%d", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


int ____CC_SHA1_Update(CC_SHA1_CTX * c, const void * data, CC_LONG len)
{
    if (!is_enabled() || !enabled_) {
        int return_value = original_CC_SHA1_Update(c, data, len);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(3, sizeof(parameter_t));
//Parse parameter c
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "^CC_SHA1_CTX", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (register_t)c);
//Parse parameter data
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "^void", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (register_t)data);
    parameters[1].description = (char*)calloc(2*len+1, sizeof(char));
    NSData *data_data = [NSData dataWithBytes:data length:len];
    strncpy(parameters[1].description, [[[[[data_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*len);
//Parse parameter len
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CC_LONG", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "%d", (int)len);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CommonCrypto", "CC_SHA1_Update", "0x0", parameters, 3);
            for(unsigned int i = 0; i < 3; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 3; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    int return_value = original_CC_SHA1_Update(c, data, len);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "int", MAX_TYPE_LENGTH);
    snprintf(return_param.value, MAX_VALUE_LENGTH, "%d", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


int ____CC_SHA1_Final(unsigned char * md, CC_SHA1_CTX * c)
{
    if (!is_enabled() || !enabled_) {
        int return_value = original_CC_SHA1_Final(md, c);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(2, sizeof(parameter_t));
//Parse parameter c
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "^CC_SHA1_CTX", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (register_t)c);
    set_enabled(true);
    int return_value = original_CC_SHA1_Final(md, c);
    set_enabled(false);
//Parse parameter md
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "*", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (register_t)md);
    parameters[0].description = (char*)calloc(2*CC_SHA1_DIGEST_LENGTH+1, sizeof(char));
    NSData *md_data = [NSData dataWithBytes:md length:CC_SHA1_DIGEST_LENGTH];
    strncpy(parameters[0].description, [[[[[md_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*CC_SHA1_DIGEST_LENGTH);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CommonCrypto", "CC_SHA1_Final", "0x0", parameters, 2);
            for(unsigned int i = 0; i < 2; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 2; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "int", MAX_TYPE_LENGTH);
    snprintf(return_param.value, MAX_VALUE_LENGTH, "%d", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


unsigned char * ____CC_SHA1(const void * data, CC_LONG len, unsigned char * md)
{
    if (!is_enabled() || !enabled_) {
        unsigned char * return_value = original_CC_SHA1(data, len, md);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(3, sizeof(parameter_t));
//Parse parameter data
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "^void", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (register_t)data);
    parameters[0].description = (char*)calloc(2*len+1, sizeof(char));
    NSData *data_data = [NSData dataWithBytes:data length:len];
    strncpy(parameters[0].description, [[[[[data_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*len);
//Parse parameter len
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CC_LONG", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "%d", (int)len);
    set_enabled(true);
    unsigned char * return_value = original_CC_SHA1(data, len, md);
    set_enabled(false);
//Parse parameter md
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "*", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (register_t)md);
    parameters[2].description = (char*)calloc(2*CC_SHA1_DIGEST_LENGTH+1, sizeof(char));
    NSData *md_data = [NSData dataWithBytes:md length:CC_SHA1_DIGEST_LENGTH];
    strncpy(parameters[2].description, [[[[[md_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*CC_SHA1_DIGEST_LENGTH);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CommonCrypto", "CC_SHA1", "0x0", parameters, 3);
            for(unsigned int i = 0; i < 3; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 3; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "unsigned char *", MAX_TYPE_LENGTH);
    snprintf(return_param.value, MAX_VALUE_LENGTH, "0x%X", (register_t)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


int ____CC_SHA224_Init(CC_SHA256_CTX * c)
{
    if (!is_enabled() || !enabled_) {
        int return_value = original_CC_SHA224_Init(c);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(1, sizeof(parameter_t));
    set_enabled(true);
    int return_value = original_CC_SHA224_Init(c);
    set_enabled(false);
//Parse parameter c
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "^CC_SHA256_CTX", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (register_t)c);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CommonCrypto", "CC_SHA224_Init", "0x0", parameters, 1);
            for(unsigned int i = 0; i < 1; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 1; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "int", MAX_TYPE_LENGTH);
    snprintf(return_param.value, MAX_VALUE_LENGTH, "%d", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


int ____CC_SHA224_Update(CC_SHA256_CTX * c, const void * data, CC_LONG len)
{
    if (!is_enabled() || !enabled_) {
        int return_value = original_CC_SHA224_Update(c, data, len);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(3, sizeof(parameter_t));
//Parse parameter c
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "^CC_SHA256_CTX", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (register_t)c);
//Parse parameter data
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "^void", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (register_t)data);
    parameters[1].description = (char*)calloc(2*len+1, sizeof(char));
    NSData *data_data = [NSData dataWithBytes:data length:len];
    strncpy(parameters[1].description, [[[[[data_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*len);
//Parse parameter len
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CC_LONG", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "%d", (int)len);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CommonCrypto", "CC_SHA224_Update", "0x0", parameters, 3);
            for(unsigned int i = 0; i < 3; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 3; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    int return_value = original_CC_SHA224_Update(c, data, len);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "int", MAX_TYPE_LENGTH);
    snprintf(return_param.value, MAX_VALUE_LENGTH, "%d", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


int ____CC_SHA224_Final(unsigned char * md, CC_SHA256_CTX * c)
{
    if (!is_enabled() || !enabled_) {
        int return_value = original_CC_SHA224_Final(md, c);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(2, sizeof(parameter_t));
//Parse parameter c
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "^CC_SHA256_CTX", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (register_t)c);
    set_enabled(true);
    int return_value = original_CC_SHA224_Final(md, c);
    set_enabled(false);
//Parse parameter md
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "*", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (register_t)md);
    parameters[0].description = (char*)calloc(2*CC_SHA224_DIGEST_LENGTH+1, sizeof(char));
    NSData *md_data = [NSData dataWithBytes:md length:CC_SHA224_DIGEST_LENGTH];
    strncpy(parameters[0].description, [[[[[md_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*CC_SHA224_DIGEST_LENGTH);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CommonCrypto", "CC_SHA224_Final", "0x0", parameters, 2);
            for(unsigned int i = 0; i < 2; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 2; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "int", MAX_TYPE_LENGTH);
    snprintf(return_param.value, MAX_VALUE_LENGTH, "%d", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


unsigned char * ____CC_SHA224(const void * data, CC_LONG len, unsigned char * md)
{
    if (!is_enabled() || !enabled_) {
        unsigned char * return_value = original_CC_SHA224(data, len, md);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(3, sizeof(parameter_t));
//Parse parameter data
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "^void", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (register_t)data);
    parameters[0].description = (char*)calloc(2*len+1, sizeof(char));
    NSData *data_data = [NSData dataWithBytes:data length:len];
    strncpy(parameters[0].description, [[[[[data_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*len);
//Parse parameter len
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CC_LONG", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "%d", (int)len);
    set_enabled(true);
    unsigned char * return_value = original_CC_SHA224(data, len, md);
    set_enabled(false);
//Parse parameter md
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "*", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (register_t)md);
    parameters[2].description = (char*)calloc(2*CC_SHA224_DIGEST_LENGTH+1, sizeof(char));
    NSData *md_data = [NSData dataWithBytes:md length:CC_SHA224_DIGEST_LENGTH];
    strncpy(parameters[2].description, [[[[[md_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*CC_SHA224_DIGEST_LENGTH);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CommonCrypto", "CC_SHA224", "0x0", parameters, 3);
            for(unsigned int i = 0; i < 3; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 3; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "unsigned char *", MAX_TYPE_LENGTH);
    snprintf(return_param.value, MAX_VALUE_LENGTH, "0x%X", (register_t)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


int ____CC_SHA256_Init(CC_SHA256_CTX * c)
{
    if (!is_enabled() || !enabled_) {
        int return_value = original_CC_SHA256_Init(c);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(1, sizeof(parameter_t));
    set_enabled(true);
    int return_value = original_CC_SHA256_Init(c);
    set_enabled(false);
//Parse parameter c
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "^CC_SHA256_CTX", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (register_t)c);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CommonCrypto", "CC_SHA256_Init", "0x0", parameters, 1);
            for(unsigned int i = 0; i < 1; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 1; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "int", MAX_TYPE_LENGTH);
    snprintf(return_param.value, MAX_VALUE_LENGTH, "%d", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


int ____CC_SHA256_Update(CC_SHA256_CTX * c, const void * data, CC_LONG len)
{
    if (!is_enabled() || !enabled_) {
        int return_value = original_CC_SHA256_Update(c, data, len);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(3, sizeof(parameter_t));
//Parse parameter c
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "^CC_SHA256_CTX", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (register_t)c);
//Parse parameter data
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "^void", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (register_t)data);
    parameters[1].description = (char*)calloc(2*len+1, sizeof(char));
    NSData *data_data = [NSData dataWithBytes:data length:len];
    strncpy(parameters[1].description, [[[[[data_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*len);
//Parse parameter len
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CC_LONG", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "%d", (int)len);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CommonCrypto", "CC_SHA256_Update", "0x0", parameters, 3);
            for(unsigned int i = 0; i < 3; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 3; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    int return_value = original_CC_SHA256_Update(c, data, len);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "int", MAX_TYPE_LENGTH);
    snprintf(return_param.value, MAX_VALUE_LENGTH, "%d", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


int ____CC_SHA256_Final(unsigned char * md, CC_SHA256_CTX * c)
{
    if (!is_enabled() || !enabled_) {
        int return_value = original_CC_SHA256_Final(md, c);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(2, sizeof(parameter_t));
//Parse parameter c
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "^CC_SHA256_CTX", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (register_t)c);
    set_enabled(true);
    int return_value = original_CC_SHA256_Final(md, c);
    set_enabled(false);
//Parse parameter md
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "*", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (register_t)md);
    parameters[0].description = (char*)calloc(2*CC_SHA256_DIGEST_LENGTH+1, sizeof(char));
    NSData *md_data = [NSData dataWithBytes:md length:CC_SHA256_DIGEST_LENGTH];
    strncpy(parameters[0].description, [[[[[md_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*CC_SHA256_DIGEST_LENGTH);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CommonCrypto", "CC_SHA256_Final", "0x0", parameters, 2);
            for(unsigned int i = 0; i < 2; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 2; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "int", MAX_TYPE_LENGTH);
    snprintf(return_param.value, MAX_VALUE_LENGTH, "%d", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


unsigned char * ____CC_SHA256(const void * data, CC_LONG len, unsigned char * md)
{
    if (!is_enabled() || !enabled_) {
        unsigned char * return_value = original_CC_SHA256(data, len, md);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(3, sizeof(parameter_t));
//Parse parameter data
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "^void", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (register_t)data);
    parameters[0].description = (char*)calloc(2*len+1, sizeof(char));
    NSData *data_data = [NSData dataWithBytes:data length:len];
    strncpy(parameters[0].description, [[[[[data_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*len);
//Parse parameter len
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CC_LONG", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "%d", (int)len);
    set_enabled(true);
    unsigned char * return_value = original_CC_SHA256(data, len, md);
    set_enabled(false);
//Parse parameter md
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "*", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (register_t)md);
    parameters[2].description = (char*)calloc(2*CC_SHA256_DIGEST_LENGTH+1, sizeof(char));
    NSData *md_data = [NSData dataWithBytes:md length:CC_SHA256_DIGEST_LENGTH];
    strncpy(parameters[2].description, [[[[[md_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*CC_SHA256_DIGEST_LENGTH);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CommonCrypto", "CC_SHA256", "0x0", parameters, 3);
            for(unsigned int i = 0; i < 3; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 3; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "unsigned char *", MAX_TYPE_LENGTH);
    snprintf(return_param.value, MAX_VALUE_LENGTH, "0x%X", (register_t)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


int ____CC_SHA384_Init(CC_SHA512_CTX * c)
{
    if (!is_enabled() || !enabled_) {
        int return_value = original_CC_SHA384_Init(c);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(1, sizeof(parameter_t));
    set_enabled(true);
    int return_value = original_CC_SHA384_Init(c);
    set_enabled(false);
//Parse parameter c
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "^CC_SHA512_CTX", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (register_t)c);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CommonCrypto", "CC_SHA384_Init", "0x0", parameters, 1);
            for(unsigned int i = 0; i < 1; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 1; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "int", MAX_TYPE_LENGTH);
    snprintf(return_param.value, MAX_VALUE_LENGTH, "%d", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


int ____CC_SHA384_Update(CC_SHA512_CTX * c, const void * data, CC_LONG len)
{
    if (!is_enabled() || !enabled_) {
        int return_value = original_CC_SHA384_Update(c, data, len);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(3, sizeof(parameter_t));
//Parse parameter c
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "^CC_SHA512_CTX", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (register_t)c);
//Parse parameter data
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "^void", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (register_t)data);
    parameters[1].description = (char*)calloc(2*len+1, sizeof(char));
    NSData *data_data = [NSData dataWithBytes:data length:len];
    strncpy(parameters[1].description, [[[[[data_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*len);
//Parse parameter len
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CC_LONG", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "%d", (int)len);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CommonCrypto", "CC_SHA384_Update", "0x0", parameters, 3);
            for(unsigned int i = 0; i < 3; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 3; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    int return_value = original_CC_SHA384_Update(c, data, len);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "int", MAX_TYPE_LENGTH);
    snprintf(return_param.value, MAX_VALUE_LENGTH, "%d", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


int ____CC_SHA384_Final(unsigned char * md, CC_SHA512_CTX * c)
{
    if (!is_enabled() || !enabled_) {
        int return_value = original_CC_SHA384_Final(md, c);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(2, sizeof(parameter_t));
//Parse parameter c
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "^CC_SHA512_CTX", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (register_t)c);
    set_enabled(true);
    int return_value = original_CC_SHA384_Final(md, c);
    set_enabled(false);
//Parse parameter md
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "*", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (register_t)md);
    parameters[0].description = (char*)calloc(2*CC_SHA384_DIGEST_LENGTH+1, sizeof(char));
    NSData *md_data = [NSData dataWithBytes:md length:CC_SHA384_DIGEST_LENGTH];
    strncpy(parameters[0].description, [[[[[md_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*CC_SHA384_DIGEST_LENGTH);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CommonCrypto", "CC_SHA384_Final", "0x0", parameters, 2);
            for(unsigned int i = 0; i < 2; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 2; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "int", MAX_TYPE_LENGTH);
    snprintf(return_param.value, MAX_VALUE_LENGTH, "%d", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


unsigned char * ____CC_SHA384(const void * data, CC_LONG len, unsigned char * md)
{
    if (!is_enabled() || !enabled_) {
        unsigned char * return_value = original_CC_SHA384(data, len, md);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(3, sizeof(parameter_t));
//Parse parameter data
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "^void", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (register_t)data);
    parameters[0].description = (char*)calloc(2*len+1, sizeof(char));
    NSData *data_data = [NSData dataWithBytes:data length:len];
    strncpy(parameters[0].description, [[[[[data_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*len);
//Parse parameter len
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CC_LONG", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "%d", (int)len);
    set_enabled(true);
    unsigned char * return_value = original_CC_SHA384(data, len, md);
    set_enabled(false);
//Parse parameter md
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "*", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (register_t)md);
    parameters[2].description = (char*)calloc(2*CC_SHA384_DIGEST_LENGTH+1, sizeof(char));
    NSData *md_data = [NSData dataWithBytes:md length:CC_SHA384_DIGEST_LENGTH];
    strncpy(parameters[2].description, [[[[[md_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*CC_SHA384_DIGEST_LENGTH);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CommonCrypto", "CC_SHA384", "0x0", parameters, 3);
            for(unsigned int i = 0; i < 3; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 3; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "unsigned char *", MAX_TYPE_LENGTH);
    snprintf(return_param.value, MAX_VALUE_LENGTH, "0x%X", (register_t)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


int ____CC_SHA512_Init(CC_SHA512_CTX * c)
{
    if (!is_enabled() || !enabled_) {
        int return_value = original_CC_SHA512_Init(c);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(1, sizeof(parameter_t));
    set_enabled(true);
    int return_value = original_CC_SHA512_Init(c);
    set_enabled(false);
//Parse parameter c
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "^CC_SHA512_CTX", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (register_t)c);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CommonCrypto", "CC_SHA512_Init", "0x0", parameters, 1);
            for(unsigned int i = 0; i < 1; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 1; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "int", MAX_TYPE_LENGTH);
    snprintf(return_param.value, MAX_VALUE_LENGTH, "%d", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


int ____CC_SHA512_Update(CC_SHA512_CTX * c, const void * data, CC_LONG len)
{
    if (!is_enabled() || !enabled_) {
        int return_value = original_CC_SHA512_Update(c, data, len);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(3, sizeof(parameter_t));
//Parse parameter c
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "^CC_SHA512_CTX", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (register_t)c);
//Parse parameter data
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "^void", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (register_t)data);
    parameters[1].description = (char*)calloc(2*len+1, sizeof(char));
    NSData *data_data = [NSData dataWithBytes:data length:len];
    strncpy(parameters[1].description, [[[[[data_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*len);
//Parse parameter len
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CC_LONG", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "%d", (int)len);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CommonCrypto", "CC_SHA512_Update", "0x0", parameters, 3);
            for(unsigned int i = 0; i < 3; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 3; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    int return_value = original_CC_SHA512_Update(c, data, len);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "int", MAX_TYPE_LENGTH);
    snprintf(return_param.value, MAX_VALUE_LENGTH, "%d", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


int ____CC_SHA512_Final(unsigned char * md, CC_SHA512_CTX * c)
{
    if (!is_enabled() || !enabled_) {
        int return_value = original_CC_SHA512_Final(md, c);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(2, sizeof(parameter_t));
//Parse parameter c
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "^CC_SHA512_CTX", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (register_t)c);
    set_enabled(true);
    int return_value = original_CC_SHA512_Final(md, c);
    set_enabled(false);
//Parse parameter md
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "*", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (register_t)md);
    parameters[0].description = (char*)calloc(2*CC_SHA512_DIGEST_LENGTH+1, sizeof(char));
    NSData *md_data = [NSData dataWithBytes:md length:CC_SHA512_DIGEST_LENGTH];
    strncpy(parameters[0].description, [[[[[md_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*CC_SHA512_DIGEST_LENGTH);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CommonCrypto", "CC_SHA512_Final", "0x0", parameters, 2);
            for(unsigned int i = 0; i < 2; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 2; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "int", MAX_TYPE_LENGTH);
    snprintf(return_param.value, MAX_VALUE_LENGTH, "%d", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


unsigned char * ____CC_SHA512(const void * data, CC_LONG len, unsigned char * md)
{
    if (!is_enabled() || !enabled_) {
        unsigned char * return_value = original_CC_SHA512(data, len, md);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(3, sizeof(parameter_t));
//Parse parameter data
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "^void", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (register_t)data);
    parameters[0].description = (char*)calloc(2*len+1, sizeof(char));
    NSData *data_data = [NSData dataWithBytes:data length:len];
    strncpy(parameters[0].description, [[[[[data_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*len);
//Parse parameter len
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CC_LONG", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "%d", (int)len);
    set_enabled(true);
    unsigned char * return_value = original_CC_SHA512(data, len, md);
    set_enabled(false);
//Parse parameter md
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "*", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (register_t)md);
    parameters[2].description = (char*)calloc(2*CC_SHA512_DIGEST_LENGTH+1, sizeof(char));
    NSData *md_data = [NSData dataWithBytes:md length:CC_SHA512_DIGEST_LENGTH];
    strncpy(parameters[2].description, [[[[[md_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*CC_SHA512_DIGEST_LENGTH);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CommonCrypto", "CC_SHA512", "0x0", parameters, 3);
            for(unsigned int i = 0; i < 3; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 3; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "unsigned char *", MAX_TYPE_LENGTH);
    snprintf(return_param.value, MAX_VALUE_LENGTH, "0x%X", (register_t)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


