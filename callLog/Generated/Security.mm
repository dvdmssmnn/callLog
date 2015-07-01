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
#import "fishhook.h"
#import <semaphore.h>
#import <dlfcn.h>
#import <Security/Security.h>

using namespace std;
int ____SecRandomCopyBytes(SecRandomRef rnd, size_t count, uint8_t * bytes);

OSStatus ____SecKeyGeneratePair(CFDictionaryRef parameters_, SecKeyRef * publicKey, SecKeyRef * privateKey);

OSStatus ____SecKeyRawSign(SecKeyRef key, SecPadding padding, const uint8_t * dataToSign, size_t dataToSignLen, uint8_t * sig, size_t * sigLen);

OSStatus ____SecKeyRawVerify(SecKeyRef key, SecPadding padding, const uint8_t * signedData, size_t signedDataLen, const uint8_t * sig, size_t sigLen);

OSStatus ____SecKeyEncrypt(SecKeyRef key, SecPadding padding, const uint8_t * plainText, size_t plainTextLen, uint8_t * cipherText, size_t * cipherTextLen);

OSStatus ____SecKeyDecrypt(SecKeyRef key, SecPadding padding, const uint8_t * cipherText, size_t cipherTextLen, uint8_t * plainText, size_t * plainTextLen);

size_t ____SecKeyGetBlockSize(SecKeyRef key);

OSStatus ____SecItemCopyMatching(CFDictionaryRef query, CFTypeRef * result);

OSStatus ____SecItemAdd(CFDictionaryRef attributes, CFTypeRef * result);

OSStatus ____SecItemUpdate(CFDictionaryRef query, CFDictionaryRef attributesToUpdate);

OSStatus ____SecItemDelete(CFDictionaryRef query);

int(*original_SecRandomCopyBytes)(SecRandomRef, size_t, uint8_t *);
OSStatus(*original_SecKeyGeneratePair)(CFDictionaryRef, SecKeyRef *, SecKeyRef *);
OSStatus(*original_SecKeyRawSign)(SecKeyRef, SecPadding, const uint8_t *, size_t, uint8_t *, size_t *);
OSStatus(*original_SecKeyRawVerify)(SecKeyRef, SecPadding, const uint8_t *, size_t, const uint8_t *, size_t);
OSStatus(*original_SecKeyEncrypt)(SecKeyRef, SecPadding, const uint8_t *, size_t, uint8_t *, size_t *);
OSStatus(*original_SecKeyDecrypt)(SecKeyRef, SecPadding, const uint8_t *, size_t, uint8_t *, size_t *);
size_t(*original_SecKeyGetBlockSize)(SecKeyRef);
OSStatus(*original_SecItemCopyMatching)(CFDictionaryRef, CFTypeRef *);
OSStatus(*original_SecItemAdd)(CFDictionaryRef, CFTypeRef *);
OSStatus(*original_SecItemUpdate)(CFDictionaryRef, CFDictionaryRef);
OSStatus(*original_SecItemDelete)(CFDictionaryRef);
__attribute__((constructor))
static void initialize() {
    dispatch_async(dispatch_get_main_queue(), ^ {
        struct rebinding rebinds[11];
        original_SecRandomCopyBytes = (int(*)(SecRandomRef, size_t, uint8_t *))SecRandomCopyBytes;
        rebinds[0].name = (char*) "SecRandomCopyBytes";
        rebinds[0].replacement = (void*) ____SecRandomCopyBytes;
        original_SecKeyGeneratePair = (OSStatus(*)(CFDictionaryRef, SecKeyRef *, SecKeyRef *))SecKeyGeneratePair;
        rebinds[1].name = (char*) "SecKeyGeneratePair";
        rebinds[1].replacement = (void*) ____SecKeyGeneratePair;
        original_SecKeyRawSign = (OSStatus(*)(SecKeyRef, SecPadding, const uint8_t *, size_t, uint8_t *, size_t *))SecKeyRawSign;
        rebinds[2].name = (char*) "SecKeyRawSign";
        rebinds[2].replacement = (void*) ____SecKeyRawSign;
        original_SecKeyRawVerify = (OSStatus(*)(SecKeyRef, SecPadding, const uint8_t *, size_t, const uint8_t *, size_t))SecKeyRawVerify;
        rebinds[3].name = (char*) "SecKeyRawVerify";
        rebinds[3].replacement = (void*) ____SecKeyRawVerify;
        original_SecKeyEncrypt = (OSStatus(*)(SecKeyRef, SecPadding, const uint8_t *, size_t, uint8_t *, size_t *))SecKeyEncrypt;
        rebinds[4].name = (char*) "SecKeyEncrypt";
        rebinds[4].replacement = (void*) ____SecKeyEncrypt;
        original_SecKeyDecrypt = (OSStatus(*)(SecKeyRef, SecPadding, const uint8_t *, size_t, uint8_t *, size_t *))SecKeyDecrypt;
        rebinds[5].name = (char*) "SecKeyDecrypt";
        rebinds[5].replacement = (void*) ____SecKeyDecrypt;
        original_SecKeyGetBlockSize = (size_t(*)(SecKeyRef))SecKeyGetBlockSize;
        rebinds[6].name = (char*) "SecKeyGetBlockSize";
        rebinds[6].replacement = (void*) ____SecKeyGetBlockSize;
        original_SecItemCopyMatching = (OSStatus(*)(CFDictionaryRef, CFTypeRef *))SecItemCopyMatching;
        rebinds[7].name = (char*) "SecItemCopyMatching";
        rebinds[7].replacement = (void*) ____SecItemCopyMatching;
        original_SecItemAdd = (OSStatus(*)(CFDictionaryRef, CFTypeRef *))SecItemAdd;
        rebinds[8].name = (char*) "SecItemAdd";
        rebinds[8].replacement = (void*) ____SecItemAdd;
        original_SecItemUpdate = (OSStatus(*)(CFDictionaryRef, CFDictionaryRef))SecItemUpdate;
        rebinds[9].name = (char*) "SecItemUpdate";
        rebinds[9].replacement = (void*) ____SecItemUpdate;
        original_SecItemDelete = (OSStatus(*)(CFDictionaryRef))SecItemDelete;
        rebinds[10].name = (char*) "SecItemDelete";
        rebinds[10].replacement = (void*) ____SecItemDelete;
        rebind_symbols(rebinds, 11);
    });
}

int ____SecRandomCopyBytes(SecRandomRef rnd, size_t count, uint8_t * bytes)
{
    if (!is_enabled() || !enabled_) {
        int return_value = original_SecRandomCopyBytes(rnd, count, bytes);
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
//Parse parameter rnd
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "SecRandomRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)rnd);
//Parse parameter count
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "size_t", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "%d", (int)count);
    set_enabled(true);
    int return_value = original_SecRandomCopyBytes(rnd, count, bytes);
    set_enabled(false);
//Parse parameter bytes
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "^uint8_t", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (register_t)bytes);
    parameters[2].description = (char*)calloc(2*count+1, sizeof(char));
    NSData *bytes_data = [NSData dataWithBytes:bytes length:count];
    strncpy(parameters[2].description, [[[[[bytes_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*count);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "Security", "SecRandomCopyBytes", "0x0", parameters, 3);
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


OSStatus ____SecKeyGeneratePair(CFDictionaryRef parameters_, SecKeyRef * publicKey, SecKeyRef * privateKey)
{
    if (!is_enabled() || !enabled_) {
        OSStatus return_value = original_SecKeyGeneratePair(parameters_, publicKey, privateKey);
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
//Parse parameter parameters_
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFDictionaryRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)parameters_);
    if(parameters_) {
        CFStringRef parameters__description = CFCopyDescription(parameters_);
        parameters[0].description = (char*)calloc(CFStringGetLength(parameters__description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(parameters__description, kCFStringEncodingUTF8), CFStringGetLength(parameters__description));
    }
//Parse parameter publicKey
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "^SecKeyRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (register_t)publicKey);
//Parse parameter privateKey
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "^SecKeyRef", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (register_t)privateKey);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "Security", "SecKeyGeneratePair", "0x0", parameters, 3);
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
    OSStatus return_value = original_SecKeyGeneratePair(parameters_, publicKey, privateKey);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "OSStatus", MAX_TYPE_LENGTH);
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


OSStatus ____SecKeyRawSign(SecKeyRef key, SecPadding padding, const uint8_t * dataToSign, size_t dataToSignLen, uint8_t * sig, size_t * sigLen)
{
    if (!is_enabled() || !enabled_) {
        OSStatus return_value = original_SecKeyRawSign(key, padding, dataToSign, dataToSignLen, sig, sigLen);
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
//Parse parameter key
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "SecKeyRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)key);
//Parse parameter padding
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "SecPadding", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "%d", (int)padding);
//Parse parameter dataToSign
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "^uint8_t", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (register_t)dataToSign);
    parameters[2].description = (char*)calloc(2*dataToSignLen+1, sizeof(char));
    NSData *dataToSign_data = [NSData dataWithBytes:dataToSign length:dataToSignLen];
    strncpy(parameters[2].description, [[[[[dataToSign_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*dataToSignLen);
//Parse parameter dataToSignLen
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "size_t", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "%d", (int)dataToSignLen);
//Parse parameter sigLen
    parameters[5].description = NULL;
    strncpy(parameters[5].type, "^size_t", MAX_TYPE_LENGTH);
    snprintf(parameters[5].value, MAX_VALUE_LENGTH, "0x%X", (register_t)sigLen);
    set_enabled(true);
    OSStatus return_value = original_SecKeyRawSign(key, padding, dataToSign, dataToSignLen, sig, sigLen);
    set_enabled(false);
//Parse parameter sig
    parameters[4].description = NULL;
    strncpy(parameters[4].type, "^uint8_t", MAX_TYPE_LENGTH);
    snprintf(parameters[4].value, MAX_VALUE_LENGTH, "0x%X", (register_t)sig);
    parameters[4].description = (char*)calloc(2*(sigLen ? (*sigLen) : 0)+1, sizeof(char));
    NSData *sig_data = [NSData dataWithBytes:sig length:(sigLen ? (*sigLen) : 0)];
    strncpy(parameters[4].description, [[[[[sig_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*(sigLen ? (*sigLen) : 0));
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "Security", "SecKeyRawSign", "0x0", parameters, 6);
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
    strncpy(return_param.type, "OSStatus", MAX_TYPE_LENGTH);
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


OSStatus ____SecKeyRawVerify(SecKeyRef key, SecPadding padding, const uint8_t * signedData, size_t signedDataLen, const uint8_t * sig, size_t sigLen)
{
    if (!is_enabled() || !enabled_) {
        OSStatus return_value = original_SecKeyRawVerify(key, padding, signedData, signedDataLen, sig, sigLen);
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
//Parse parameter key
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "SecKeyRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)key);
//Parse parameter padding
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "SecPadding", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "%d", (int)padding);
//Parse parameter signedData
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "^uint8_t", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (register_t)signedData);
    parameters[2].description = (char*)calloc(2*signedDataLen+1, sizeof(char));
    NSData *signedData_data = [NSData dataWithBytes:signedData length:signedDataLen];
    strncpy(parameters[2].description, [[[[[signedData_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*signedDataLen);
//Parse parameter signedDataLen
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "size_t", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "%d", (int)signedDataLen);
//Parse parameter sig
    parameters[4].description = NULL;
    strncpy(parameters[4].type, "^uint8_t", MAX_TYPE_LENGTH);
    snprintf(parameters[4].value, MAX_VALUE_LENGTH, "0x%X", (register_t)sig);
    parameters[4].description = (char*)calloc(2*sigLen+1, sizeof(char));
    NSData *sig_data = [NSData dataWithBytes:sig length:sigLen];
    strncpy(parameters[4].description, [[[[[sig_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*sigLen);
//Parse parameter sigLen
    parameters[5].description = NULL;
    strncpy(parameters[5].type, "size_t", MAX_TYPE_LENGTH);
    snprintf(parameters[5].value, MAX_VALUE_LENGTH, "%d", (int)sigLen);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "Security", "SecKeyRawVerify", "0x0", parameters, 6);
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
    OSStatus return_value = original_SecKeyRawVerify(key, padding, signedData, signedDataLen, sig, sigLen);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "OSStatus", MAX_TYPE_LENGTH);
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


OSStatus ____SecKeyEncrypt(SecKeyRef key, SecPadding padding, const uint8_t * plainText, size_t plainTextLen, uint8_t * cipherText, size_t * cipherTextLen)
{
    if (!is_enabled() || !enabled_) {
        OSStatus return_value = original_SecKeyEncrypt(key, padding, plainText, plainTextLen, cipherText, cipherTextLen);
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
//Parse parameter key
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "SecKeyRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)key);
//Parse parameter padding
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "SecPadding", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "%d", (int)padding);
//Parse parameter plainText
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "^uint8_t", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (register_t)plainText);
    parameters[2].description = (char*)calloc(2*plainTextLen+1, sizeof(char));
    NSData *plainText_data = [NSData dataWithBytes:plainText length:plainTextLen];
    strncpy(parameters[2].description, [[[[[plainText_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*plainTextLen);
//Parse parameter plainTextLen
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "size_t", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "%d", (int)plainTextLen);
//Parse parameter cipherTextLen
    parameters[5].description = NULL;
    strncpy(parameters[5].type, "^size_t", MAX_TYPE_LENGTH);
    snprintf(parameters[5].value, MAX_VALUE_LENGTH, "0x%X", (register_t)cipherTextLen);
    set_enabled(true);
    OSStatus return_value = original_SecKeyEncrypt(key, padding, plainText, plainTextLen, cipherText, cipherTextLen);
    set_enabled(false);
//Parse parameter cipherText
    parameters[4].description = NULL;
    strncpy(parameters[4].type, "^uint8_t", MAX_TYPE_LENGTH);
    snprintf(parameters[4].value, MAX_VALUE_LENGTH, "0x%X", (register_t)cipherText);
    parameters[4].description = (char*)calloc(2*(cipherTextLen ? (*cipherTextLen) : 0)+1, sizeof(char));
    NSData *cipherText_data = [NSData dataWithBytes:cipherText length:(cipherTextLen ? (*cipherTextLen) : 0)];
    strncpy(parameters[4].description, [[[[[cipherText_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*(cipherTextLen ? (*cipherTextLen) : 0));
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "Security", "SecKeyEncrypt", "0x0", parameters, 6);
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
    strncpy(return_param.type, "OSStatus", MAX_TYPE_LENGTH);
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


OSStatus ____SecKeyDecrypt(SecKeyRef key, SecPadding padding, const uint8_t * cipherText, size_t cipherTextLen, uint8_t * plainText, size_t * plainTextLen)
{
    if (!is_enabled() || !enabled_) {
        OSStatus return_value = original_SecKeyDecrypt(key, padding, cipherText, cipherTextLen, plainText, plainTextLen);
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
//Parse parameter key
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "SecKeyRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)key);
//Parse parameter padding
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "SecPadding", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "%d", (int)padding);
//Parse parameter cipherText
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "^uint8_t", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (register_t)cipherText);
    parameters[2].description = (char*)calloc(2*cipherTextLen+1, sizeof(char));
    NSData *cipherText_data = [NSData dataWithBytes:cipherText length:cipherTextLen];
    strncpy(parameters[2].description, [[[[[cipherText_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*cipherTextLen);
//Parse parameter cipherTextLen
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "size_t", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "%d", (int)cipherTextLen);
//Parse parameter plainTextLen
    parameters[5].description = NULL;
    strncpy(parameters[5].type, "^size_t", MAX_TYPE_LENGTH);
    snprintf(parameters[5].value, MAX_VALUE_LENGTH, "0x%X", (register_t)plainTextLen);
    set_enabled(true);
    OSStatus return_value = original_SecKeyDecrypt(key, padding, cipherText, cipherTextLen, plainText, plainTextLen);
    set_enabled(false);
//Parse parameter plainText
    parameters[4].description = NULL;
    strncpy(parameters[4].type, "^uint8_t", MAX_TYPE_LENGTH);
    snprintf(parameters[4].value, MAX_VALUE_LENGTH, "0x%X", (register_t)plainText);
    parameters[4].description = (char*)calloc(2*(plainTextLen ? (*plainTextLen) : 0)+1, sizeof(char));
    NSData *plainText_data = [NSData dataWithBytes:plainText length:(plainTextLen ? (*plainTextLen) : 0)];
    strncpy(parameters[4].description, [[[[[plainText_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*(plainTextLen ? (*plainTextLen) : 0));
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "Security", "SecKeyDecrypt", "0x0", parameters, 6);
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
    strncpy(return_param.type, "OSStatus", MAX_TYPE_LENGTH);
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


size_t ____SecKeyGetBlockSize(SecKeyRef key)
{
    if (!is_enabled() || !enabled_) {
        size_t return_value = original_SecKeyGetBlockSize(key);
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
//Parse parameter key
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "SecKeyRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)key);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "Security", "SecKeyGetBlockSize", "0x0", parameters, 1);
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
    size_t return_value = original_SecKeyGetBlockSize(key);
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


OSStatus ____SecItemCopyMatching(CFDictionaryRef query, CFTypeRef * result)
{
    if (!is_enabled() || !enabled_) {
        OSStatus return_value = original_SecItemCopyMatching(query, result);
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
//Parse parameter query
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFDictionaryRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)query);
    if(query) {
        CFStringRef query_description = CFCopyDescription(query);
        parameters[0].description = (char*)calloc(CFStringGetLength(query_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(query_description, kCFStringEncodingUTF8), CFStringGetLength(query_description));
    }
//Parse parameter result
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "^CFTypeRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (register_t)result);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "Security", "SecItemCopyMatching", "0x0", parameters, 2);
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
    OSStatus return_value = original_SecItemCopyMatching(query, result);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "OSStatus", MAX_TYPE_LENGTH);
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


OSStatus ____SecItemAdd(CFDictionaryRef attributes, CFTypeRef * result)
{
    if (!is_enabled() || !enabled_) {
        OSStatus return_value = original_SecItemAdd(attributes, result);
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
//Parse parameter attributes
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFDictionaryRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)attributes);
    if(attributes) {
        CFStringRef attributes_description = CFCopyDescription(attributes);
        parameters[0].description = (char*)calloc(CFStringGetLength(attributes_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(attributes_description, kCFStringEncodingUTF8), CFStringGetLength(attributes_description));
    }
//Parse parameter result
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "^CFTypeRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (register_t)result);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "Security", "SecItemAdd", "0x0", parameters, 2);
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
    OSStatus return_value = original_SecItemAdd(attributes, result);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "OSStatus", MAX_TYPE_LENGTH);
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


OSStatus ____SecItemUpdate(CFDictionaryRef query, CFDictionaryRef attributesToUpdate)
{
    if (!is_enabled() || !enabled_) {
        OSStatus return_value = original_SecItemUpdate(query, attributesToUpdate);
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
//Parse parameter query
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFDictionaryRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)query);
    if(query) {
        CFStringRef query_description = CFCopyDescription(query);
        parameters[0].description = (char*)calloc(CFStringGetLength(query_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(query_description, kCFStringEncodingUTF8), CFStringGetLength(query_description));
    }
//Parse parameter attributesToUpdate
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFDictionaryRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)attributesToUpdate);
    if(attributesToUpdate) {
        CFStringRef attributesToUpdate_description = CFCopyDescription(attributesToUpdate);
        parameters[1].description = (char*)calloc(CFStringGetLength(attributesToUpdate_description) + 1, sizeof(char));
        memcpy(parameters[1].description, CFStringGetCStringPtr(attributesToUpdate_description, kCFStringEncodingUTF8), CFStringGetLength(attributesToUpdate_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "Security", "SecItemUpdate", "0x0", parameters, 2);
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
    OSStatus return_value = original_SecItemUpdate(query, attributesToUpdate);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "OSStatus", MAX_TYPE_LENGTH);
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


OSStatus ____SecItemDelete(CFDictionaryRef query)
{
    if (!is_enabled() || !enabled_) {
        OSStatus return_value = original_SecItemDelete(query);
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
//Parse parameter query
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFDictionaryRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)query);
    if(query) {
        CFStringRef query_description = CFCopyDescription(query);
        parameters[0].description = (char*)calloc(CFStringGetLength(query_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(query_description, kCFStringEncodingUTF8), CFStringGetLength(query_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "Security", "SecItemDelete", "0x0", parameters, 1);
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
    OSStatus return_value = original_SecItemDelete(query);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "OSStatus", MAX_TYPE_LENGTH);
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


