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

using namespace std;
CFReadStreamRef ____CFReadStreamCreateWithBytesNoCopy(CFAllocatorRef alloc, const UInt8 * bytes, CFIndex length, CFAllocatorRef bytesDeallocator);

CFWriteStreamRef ____CFWriteStreamCreateWithBuffer(CFAllocatorRef alloc, UInt8 * buffer, CFIndex bufferCapacity);

CFWriteStreamRef ____CFWriteStreamCreateWithAllocatedBuffers(CFAllocatorRef alloc, CFAllocatorRef bufferAllocator);

CFReadStreamRef ____CFReadStreamCreateWithFile(CFAllocatorRef alloc, CFURLRef fileURL);

CFWriteStreamRef ____CFWriteStreamCreateWithFile(CFAllocatorRef alloc, CFURLRef fileURL);

void ____CFStreamCreatePairWithSocketToHost(CFAllocatorRef alloc, CFStringRef host, UInt32 port, CFReadStreamRef * readStream, CFWriteStreamRef * writeStream);

void ____CFStreamCreatePairWithPeerSocketSignature(CFAllocatorRef alloc, const CFSocketSignature * signature, CFReadStreamRef * readStream, CFWriteStreamRef * writeStream);

CFErrorRef ____CFReadStreamCopyError(CFReadStreamRef stream);

CFErrorRef ____CFWriteStreamCopyError(CFWriteStreamRef stream);

Boolean ____CFReadStreamOpen(CFReadStreamRef stream);

Boolean ____CFWriteStreamOpen(CFWriteStreamRef stream);

void ____CFReadStreamClose(CFReadStreamRef stream);

void ____CFWriteStreamClose(CFWriteStreamRef stream);

Boolean ____CFReadStreamHasBytesAvailable(CFReadStreamRef stream);

CFIndex ____CFReadStreamRead(CFReadStreamRef stream, UInt8 * buffer, CFIndex bufferLength);

const UInt8 * ____CFReadStreamGetBuffer(CFReadStreamRef stream, CFIndex maxBytesToRead, CFIndex * numBytesRead);

Boolean ____CFWriteStreamCanAcceptBytes(CFWriteStreamRef stream);

CFIndex ____CFWriteStreamWrite(CFWriteStreamRef stream, const UInt8 * buffer, CFIndex bufferLength);

void * ____CFReadStreamGetError(CFReadStreamRef stream);

void * ____CFWriteStreamGetError(CFWriteStreamRef stream);

CFReadStreamRef(*original_CFReadStreamCreateWithBytesNoCopy)(CFAllocatorRef, const UInt8 *, CFIndex, CFAllocatorRef);
CFWriteStreamRef(*original_CFWriteStreamCreateWithBuffer)(CFAllocatorRef, UInt8 *, CFIndex);
CFWriteStreamRef(*original_CFWriteStreamCreateWithAllocatedBuffers)(CFAllocatorRef, CFAllocatorRef);
CFReadStreamRef(*original_CFReadStreamCreateWithFile)(CFAllocatorRef, CFURLRef);
CFWriteStreamRef(*original_CFWriteStreamCreateWithFile)(CFAllocatorRef, CFURLRef);
void(*original_CFStreamCreatePairWithSocketToHost)(CFAllocatorRef, CFStringRef, UInt32, CFReadStreamRef *, CFWriteStreamRef *);
void(*original_CFStreamCreatePairWithPeerSocketSignature)(CFAllocatorRef, const CFSocketSignature *, CFReadStreamRef *, CFWriteStreamRef *);
CFErrorRef(*original_CFReadStreamCopyError)(CFReadStreamRef);
CFErrorRef(*original_CFWriteStreamCopyError)(CFWriteStreamRef);
Boolean(*original_CFReadStreamOpen)(CFReadStreamRef);
Boolean(*original_CFWriteStreamOpen)(CFWriteStreamRef);
void(*original_CFReadStreamClose)(CFReadStreamRef);
void(*original_CFWriteStreamClose)(CFWriteStreamRef);
Boolean(*original_CFReadStreamHasBytesAvailable)(CFReadStreamRef);
CFIndex(*original_CFReadStreamRead)(CFReadStreamRef, UInt8 *, CFIndex);
const UInt8 *(*original_CFReadStreamGetBuffer)(CFReadStreamRef, CFIndex, CFIndex *);
Boolean(*original_CFWriteStreamCanAcceptBytes)(CFWriteStreamRef);
CFIndex(*original_CFWriteStreamWrite)(CFWriteStreamRef, const UInt8 *, CFIndex);
void *(*original_CFReadStreamGetError)(CFReadStreamRef);
void *(*original_CFWriteStreamGetError)(CFWriteStreamRef);
__attribute__((constructor))
static void initialize() {
    dispatch_async(dispatch_get_main_queue(), ^ {
        struct rebinding rebinds[20];
        original_CFReadStreamCreateWithBytesNoCopy = (CFReadStreamRef(*)(CFAllocatorRef, const UInt8 *, CFIndex, CFAllocatorRef))CFReadStreamCreateWithBytesNoCopy;
        rebinds[0].name = (char*) "CFReadStreamCreateWithBytesNoCopy";
        rebinds[0].replacement = (void*) ____CFReadStreamCreateWithBytesNoCopy;
        original_CFWriteStreamCreateWithBuffer = (CFWriteStreamRef(*)(CFAllocatorRef, UInt8 *, CFIndex))CFWriteStreamCreateWithBuffer;
        rebinds[1].name = (char*) "CFWriteStreamCreateWithBuffer";
        rebinds[1].replacement = (void*) ____CFWriteStreamCreateWithBuffer;
        original_CFWriteStreamCreateWithAllocatedBuffers = (CFWriteStreamRef(*)(CFAllocatorRef, CFAllocatorRef))CFWriteStreamCreateWithAllocatedBuffers;
        rebinds[2].name = (char*) "CFWriteStreamCreateWithAllocatedBuffers";
        rebinds[2].replacement = (void*) ____CFWriteStreamCreateWithAllocatedBuffers;
        original_CFReadStreamCreateWithFile = (CFReadStreamRef(*)(CFAllocatorRef, CFURLRef))CFReadStreamCreateWithFile;
        rebinds[3].name = (char*) "CFReadStreamCreateWithFile";
        rebinds[3].replacement = (void*) ____CFReadStreamCreateWithFile;
        original_CFWriteStreamCreateWithFile = (CFWriteStreamRef(*)(CFAllocatorRef, CFURLRef))CFWriteStreamCreateWithFile;
        rebinds[4].name = (char*) "CFWriteStreamCreateWithFile";
        rebinds[4].replacement = (void*) ____CFWriteStreamCreateWithFile;
        original_CFStreamCreatePairWithSocketToHost = (void(*)(CFAllocatorRef, CFStringRef, UInt32, CFReadStreamRef *, CFWriteStreamRef *))CFStreamCreatePairWithSocketToHost;
        rebinds[5].name = (char*) "CFStreamCreatePairWithSocketToHost";
        rebinds[5].replacement = (void*) ____CFStreamCreatePairWithSocketToHost;
        original_CFStreamCreatePairWithPeerSocketSignature = (void(*)(CFAllocatorRef, const CFSocketSignature *, CFReadStreamRef *, CFWriteStreamRef *))CFStreamCreatePairWithPeerSocketSignature;
        rebinds[6].name = (char*) "CFStreamCreatePairWithPeerSocketSignature";
        rebinds[6].replacement = (void*) ____CFStreamCreatePairWithPeerSocketSignature;
        original_CFReadStreamCopyError = (CFErrorRef(*)(CFReadStreamRef))CFReadStreamCopyError;
        rebinds[7].name = (char*) "CFReadStreamCopyError";
        rebinds[7].replacement = (void*) ____CFReadStreamCopyError;
        original_CFWriteStreamCopyError = (CFErrorRef(*)(CFWriteStreamRef))CFWriteStreamCopyError;
        rebinds[8].name = (char*) "CFWriteStreamCopyError";
        rebinds[8].replacement = (void*) ____CFWriteStreamCopyError;
        original_CFReadStreamOpen = (Boolean(*)(CFReadStreamRef))CFReadStreamOpen;
        rebinds[9].name = (char*) "CFReadStreamOpen";
        rebinds[9].replacement = (void*) ____CFReadStreamOpen;
        original_CFWriteStreamOpen = (Boolean(*)(CFWriteStreamRef))CFWriteStreamOpen;
        rebinds[10].name = (char*) "CFWriteStreamOpen";
        rebinds[10].replacement = (void*) ____CFWriteStreamOpen;
        original_CFReadStreamClose = (void(*)(CFReadStreamRef))CFReadStreamClose;
        rebinds[11].name = (char*) "CFReadStreamClose";
        rebinds[11].replacement = (void*) ____CFReadStreamClose;
        original_CFWriteStreamClose = (void(*)(CFWriteStreamRef))CFWriteStreamClose;
        rebinds[12].name = (char*) "CFWriteStreamClose";
        rebinds[12].replacement = (void*) ____CFWriteStreamClose;
        original_CFReadStreamHasBytesAvailable = (Boolean(*)(CFReadStreamRef))CFReadStreamHasBytesAvailable;
        rebinds[13].name = (char*) "CFReadStreamHasBytesAvailable";
        rebinds[13].replacement = (void*) ____CFReadStreamHasBytesAvailable;
        original_CFReadStreamRead = (CFIndex(*)(CFReadStreamRef, UInt8 *, CFIndex))CFReadStreamRead;
        rebinds[14].name = (char*) "CFReadStreamRead";
        rebinds[14].replacement = (void*) ____CFReadStreamRead;
        original_CFReadStreamGetBuffer = (const UInt8 *(*)(CFReadStreamRef, CFIndex, CFIndex *))CFReadStreamGetBuffer;
        rebinds[15].name = (char*) "CFReadStreamGetBuffer";
        rebinds[15].replacement = (void*) ____CFReadStreamGetBuffer;
        original_CFWriteStreamCanAcceptBytes = (Boolean(*)(CFWriteStreamRef))CFWriteStreamCanAcceptBytes;
        rebinds[16].name = (char*) "CFWriteStreamCanAcceptBytes";
        rebinds[16].replacement = (void*) ____CFWriteStreamCanAcceptBytes;
        original_CFWriteStreamWrite = (CFIndex(*)(CFWriteStreamRef, const UInt8 *, CFIndex))CFWriteStreamWrite;
        rebinds[17].name = (char*) "CFWriteStreamWrite";
        rebinds[17].replacement = (void*) ____CFWriteStreamWrite;
        original_CFReadStreamGetError = (void *(*)(CFReadStreamRef))CFReadStreamGetError;
        rebinds[18].name = (char*) "CFReadStreamGetError";
        rebinds[18].replacement = (void*) ____CFReadStreamGetError;
        original_CFWriteStreamGetError = (void *(*)(CFWriteStreamRef))CFWriteStreamGetError;
        rebinds[19].name = (char*) "CFWriteStreamGetError";
        rebinds[19].replacement = (void*) ____CFWriteStreamGetError;
    });
}

CFReadStreamRef ____CFReadStreamCreateWithBytesNoCopy(CFAllocatorRef alloc, const UInt8 * bytes, CFIndex length, CFAllocatorRef bytesDeallocator)
{
    if (!is_enabled() || !enabled_) {
        CFReadStreamRef return_value = original_CFReadStreamCreateWithBytesNoCopy(alloc, bytes, length, bytesDeallocator);
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
//Parse parameter alloc
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)alloc);
//Parse parameter bytes
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "^UInt8", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (register_t)bytes);
    parameters[1].description = (char*)calloc(2*length+1, sizeof(char));
    NSData *bytes_data = [NSData dataWithBytes:bytes length:length];
    strncpy(parameters[1].description, [[[[[bytes_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*length);
//Parse parameter length
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFIndex", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "%d", (int)length);
//Parse parameter bytesDeallocator
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "%d", (int)bytesDeallocator);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFStream", "CFReadStreamCreateWithBytesNoCopy", "0x0", parameters, 4);
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
    set_enabled(true);
    CFReadStreamRef return_value = original_CFReadStreamCreateWithBytesNoCopy(alloc, bytes, length, bytesDeallocator);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFReadStreamRef", MAX_TYPE_LENGTH);
    if(return_value) {
        CFStringRef return_value_description = CFCopyDescription(return_value);
        return_param.description = (char*)calloc(CFStringGetLength(return_value_description) + 1, sizeof(char));
        memcpy(return_param.description, CFStringGetCStringPtr(return_value_description, kCFStringEncodingUTF8), CFStringGetLength(return_value_description));
    }
    snprintf(return_param.value, MAX_VALUE_LENGTH, "0x%X", (int)return_value);
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


CFWriteStreamRef ____CFWriteStreamCreateWithBuffer(CFAllocatorRef alloc, UInt8 * buffer, CFIndex bufferCapacity)
{
    if (!is_enabled() || !enabled_) {
        CFWriteStreamRef return_value = original_CFWriteStreamCreateWithBuffer(alloc, buffer, bufferCapacity);
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
//Parse parameter alloc
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)alloc);
//Parse parameter buffer
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "^UInt8", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (register_t)buffer);
//Parse parameter bufferCapacity
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFIndex", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "%d", (int)bufferCapacity);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFStream", "CFWriteStreamCreateWithBuffer", "0x0", parameters, 3);
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
    CFWriteStreamRef return_value = original_CFWriteStreamCreateWithBuffer(alloc, buffer, bufferCapacity);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFWriteStreamRef", MAX_TYPE_LENGTH);
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


CFWriteStreamRef ____CFWriteStreamCreateWithAllocatedBuffers(CFAllocatorRef alloc, CFAllocatorRef bufferAllocator)
{
    if (!is_enabled() || !enabled_) {
        CFWriteStreamRef return_value = original_CFWriteStreamCreateWithAllocatedBuffers(alloc, bufferAllocator);
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
//Parse parameter alloc
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)alloc);
//Parse parameter bufferAllocator
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "%d", (int)bufferAllocator);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFStream", "CFWriteStreamCreateWithAllocatedBuffers", "0x0", parameters, 2);
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
    CFWriteStreamRef return_value = original_CFWriteStreamCreateWithAllocatedBuffers(alloc, bufferAllocator);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFWriteStreamRef", MAX_TYPE_LENGTH);
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


CFReadStreamRef ____CFReadStreamCreateWithFile(CFAllocatorRef alloc, CFURLRef fileURL)
{
    if (!is_enabled() || !enabled_) {
        CFReadStreamRef return_value = original_CFReadStreamCreateWithFile(alloc, fileURL);
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
//Parse parameter alloc
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)alloc);
//Parse parameter fileURL
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)fileURL);
    if(fileURL) {
        CFStringRef fileURL_description = CFCopyDescription(fileURL);
        parameters[1].description = (char*)calloc(CFStringGetLength(fileURL_description) + 1, sizeof(char));
        memcpy(parameters[1].description, CFStringGetCStringPtr(fileURL_description, kCFStringEncodingUTF8), CFStringGetLength(fileURL_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFStream", "CFReadStreamCreateWithFile", "0x0", parameters, 2);
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
    CFReadStreamRef return_value = original_CFReadStreamCreateWithFile(alloc, fileURL);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFReadStreamRef", MAX_TYPE_LENGTH);
    if(return_value) {
        CFStringRef return_value_description = CFCopyDescription(return_value);
        return_param.description = (char*)calloc(CFStringGetLength(return_value_description) + 1, sizeof(char));
        memcpy(return_param.description, CFStringGetCStringPtr(return_value_description, kCFStringEncodingUTF8), CFStringGetLength(return_value_description));
    }
    snprintf(return_param.value, MAX_VALUE_LENGTH, "0x%X", (int)return_value);
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


CFWriteStreamRef ____CFWriteStreamCreateWithFile(CFAllocatorRef alloc, CFURLRef fileURL)
{
    if (!is_enabled() || !enabled_) {
        CFWriteStreamRef return_value = original_CFWriteStreamCreateWithFile(alloc, fileURL);
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
//Parse parameter alloc
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)alloc);
//Parse parameter fileURL
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)fileURL);
    if(fileURL) {
        CFStringRef fileURL_description = CFCopyDescription(fileURL);
        parameters[1].description = (char*)calloc(CFStringGetLength(fileURL_description) + 1, sizeof(char));
        memcpy(parameters[1].description, CFStringGetCStringPtr(fileURL_description, kCFStringEncodingUTF8), CFStringGetLength(fileURL_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFStream", "CFWriteStreamCreateWithFile", "0x0", parameters, 2);
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
    CFWriteStreamRef return_value = original_CFWriteStreamCreateWithFile(alloc, fileURL);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFWriteStreamRef", MAX_TYPE_LENGTH);
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


void ____CFStreamCreatePairWithSocketToHost(CFAllocatorRef alloc, CFStringRef host, UInt32 port, CFReadStreamRef * readStream, CFWriteStreamRef * writeStream)
{
    if (!is_enabled() || !enabled_) {
        original_CFStreamCreatePairWithSocketToHost(alloc, host, port, readStream, writeStream);
        return;
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
    parameters = (parameter_t*)calloc(5, sizeof(parameter_t));
//Parse parameter alloc
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)alloc);
//Parse parameter host
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)host);
    if(host) {
        parameters[1].description = (char*)calloc(CFStringGetLength(host)+1, sizeof(char));
        CFStringGetCString(host, parameters[1].description, CFStringGetLength(host) + 1, kCFStringEncodingUTF8);
    }
//Parse parameter port
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "UInt32", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "%d", (int)port);
//Parse parameter readStream
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "^CFReadStreamRef", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "0x%X", (register_t)readStream);
//Parse parameter writeStream
    parameters[4].description = NULL;
    strncpy(parameters[4].type, "^CFWriteStreamRef", MAX_TYPE_LENGTH);
    snprintf(parameters[4].value, MAX_VALUE_LENGTH, "0x%X", (register_t)writeStream);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFStream", "CFStreamCreatePairWithSocketToHost", "0x0", parameters, 5);
            for(unsigned int i = 0; i < 5; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 5; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    original_CFStreamCreatePairWithSocketToHost(alloc, host, port, readStream, writeStream);
    set_enabled(false);
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
}


void ____CFStreamCreatePairWithPeerSocketSignature(CFAllocatorRef alloc, const CFSocketSignature * signature, CFReadStreamRef * readStream, CFWriteStreamRef * writeStream)
{
    if (!is_enabled() || !enabled_) {
        original_CFStreamCreatePairWithPeerSocketSignature(alloc, signature, readStream, writeStream);
        return;
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
//Parse parameter alloc
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)alloc);
//Parse parameter signature
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "^CFSocketSignature", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (register_t)signature);
//Parse parameter readStream
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "^CFReadStreamRef", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (register_t)readStream);
//Parse parameter writeStream
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "^CFWriteStreamRef", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "0x%X", (register_t)writeStream);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFStream", "CFStreamCreatePairWithPeerSocketSignature", "0x0", parameters, 4);
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
    set_enabled(true);
    original_CFStreamCreatePairWithPeerSocketSignature(alloc, signature, readStream, writeStream);
    set_enabled(false);
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
}


CFErrorRef ____CFReadStreamCopyError(CFReadStreamRef stream)
{
    if (!is_enabled() || !enabled_) {
        CFErrorRef return_value = original_CFReadStreamCopyError(stream);
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
//Parse parameter stream
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFReadStreamRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)stream);
    if(stream) {
        CFStringRef stream_description = CFCopyDescription(stream);
        parameters[0].description = (char*)calloc(CFStringGetLength(stream_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(stream_description, kCFStringEncodingUTF8), CFStringGetLength(stream_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFStream", "CFReadStreamCopyError", "0x0", parameters, 1);
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
    CFErrorRef return_value = original_CFReadStreamCopyError(stream);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFErrorRef", MAX_TYPE_LENGTH);
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


CFErrorRef ____CFWriteStreamCopyError(CFWriteStreamRef stream)
{
    if (!is_enabled() || !enabled_) {
        CFErrorRef return_value = original_CFWriteStreamCopyError(stream);
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
//Parse parameter stream
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFWriteStreamRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)stream);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFStream", "CFWriteStreamCopyError", "0x0", parameters, 1);
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
    CFErrorRef return_value = original_CFWriteStreamCopyError(stream);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFErrorRef", MAX_TYPE_LENGTH);
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


Boolean ____CFReadStreamOpen(CFReadStreamRef stream)
{
    if (!is_enabled() || !enabled_) {
        Boolean return_value = original_CFReadStreamOpen(stream);
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
//Parse parameter stream
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFReadStreamRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)stream);
    if(stream) {
        CFStringRef stream_description = CFCopyDescription(stream);
        parameters[0].description = (char*)calloc(CFStringGetLength(stream_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(stream_description, kCFStringEncodingUTF8), CFStringGetLength(stream_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFStream", "CFReadStreamOpen", "0x0", parameters, 1);
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
    Boolean return_value = original_CFReadStreamOpen(stream);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "Boolean", MAX_TYPE_LENGTH);
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


Boolean ____CFWriteStreamOpen(CFWriteStreamRef stream)
{
    if (!is_enabled() || !enabled_) {
        Boolean return_value = original_CFWriteStreamOpen(stream);
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
//Parse parameter stream
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFWriteStreamRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)stream);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFStream", "CFWriteStreamOpen", "0x0", parameters, 1);
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
    Boolean return_value = original_CFWriteStreamOpen(stream);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "Boolean", MAX_TYPE_LENGTH);
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


void ____CFReadStreamClose(CFReadStreamRef stream)
{
    if (!is_enabled() || !enabled_) {
        original_CFReadStreamClose(stream);
        return;
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
//Parse parameter stream
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFReadStreamRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)stream);
    if(stream) {
        CFStringRef stream_description = CFCopyDescription(stream);
        parameters[0].description = (char*)calloc(CFStringGetLength(stream_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(stream_description, kCFStringEncodingUTF8), CFStringGetLength(stream_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFStream", "CFReadStreamClose", "0x0", parameters, 1);
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
    original_CFReadStreamClose(stream);
    set_enabled(false);
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
}


void ____CFWriteStreamClose(CFWriteStreamRef stream)
{
    if (!is_enabled() || !enabled_) {
        original_CFWriteStreamClose(stream);
        return;
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
//Parse parameter stream
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFWriteStreamRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)stream);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFStream", "CFWriteStreamClose", "0x0", parameters, 1);
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
    original_CFWriteStreamClose(stream);
    set_enabled(false);
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
}


Boolean ____CFReadStreamHasBytesAvailable(CFReadStreamRef stream)
{
    if (!is_enabled() || !enabled_) {
        Boolean return_value = original_CFReadStreamHasBytesAvailable(stream);
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
//Parse parameter stream
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFReadStreamRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)stream);
    if(stream) {
        CFStringRef stream_description = CFCopyDescription(stream);
        parameters[0].description = (char*)calloc(CFStringGetLength(stream_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(stream_description, kCFStringEncodingUTF8), CFStringGetLength(stream_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFStream", "CFReadStreamHasBytesAvailable", "0x0", parameters, 1);
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
    Boolean return_value = original_CFReadStreamHasBytesAvailable(stream);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "Boolean", MAX_TYPE_LENGTH);
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


CFIndex ____CFReadStreamRead(CFReadStreamRef stream, UInt8 * buffer, CFIndex bufferLength)
{
    if (!is_enabled() || !enabled_) {
        CFIndex return_value = original_CFReadStreamRead(stream, buffer, bufferLength);
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
//Parse parameter stream
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFReadStreamRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)stream);
    if(stream) {
        CFStringRef stream_description = CFCopyDescription(stream);
        parameters[0].description = (char*)calloc(CFStringGetLength(stream_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(stream_description, kCFStringEncodingUTF8), CFStringGetLength(stream_description));
    }
//Parse parameter bufferLength
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFIndex", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "%d", (int)bufferLength);
    set_enabled(true);
    CFIndex return_value = original_CFReadStreamRead(stream, buffer, bufferLength);
    set_enabled(false);
//Parse parameter buffer
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "^UInt8", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (register_t)buffer);
    parameters[1].description = (char*)calloc(2*return_value+1, sizeof(char));
    NSData *buffer_data = [NSData dataWithBytes:buffer length:return_value];
    strncpy(parameters[1].description, [[[[[buffer_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFStream", "CFReadStreamRead", "0x0", parameters, 3);
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
    strncpy(return_param.type, "CFIndex", MAX_TYPE_LENGTH);
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


const UInt8 * ____CFReadStreamGetBuffer(CFReadStreamRef stream, CFIndex maxBytesToRead, CFIndex * numBytesRead)
{
    if (!is_enabled() || !enabled_) {
        const UInt8 * return_value = original_CFReadStreamGetBuffer(stream, maxBytesToRead, numBytesRead);
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
//Parse parameter stream
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFReadStreamRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)stream);
    if(stream) {
        CFStringRef stream_description = CFCopyDescription(stream);
        parameters[0].description = (char*)calloc(CFStringGetLength(stream_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(stream_description, kCFStringEncodingUTF8), CFStringGetLength(stream_description));
    }
//Parse parameter maxBytesToRead
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFIndex", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "%d", (int)maxBytesToRead);
//Parse parameter numBytesRead
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "^CFIndex", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (register_t)numBytesRead);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFStream", "CFReadStreamGetBuffer", "0x0", parameters, 3);
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
    const UInt8 * return_value = original_CFReadStreamGetBuffer(stream, maxBytesToRead, numBytesRead);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "const UInt8 *", MAX_TYPE_LENGTH);
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


Boolean ____CFWriteStreamCanAcceptBytes(CFWriteStreamRef stream)
{
    if (!is_enabled() || !enabled_) {
        Boolean return_value = original_CFWriteStreamCanAcceptBytes(stream);
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
//Parse parameter stream
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFWriteStreamRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)stream);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFStream", "CFWriteStreamCanAcceptBytes", "0x0", parameters, 1);
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
    Boolean return_value = original_CFWriteStreamCanAcceptBytes(stream);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "Boolean", MAX_TYPE_LENGTH);
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


CFIndex ____CFWriteStreamWrite(CFWriteStreamRef stream, const UInt8 * buffer, CFIndex bufferLength)
{
    if (!is_enabled() || !enabled_) {
        CFIndex return_value = original_CFWriteStreamWrite(stream, buffer, bufferLength);
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
//Parse parameter stream
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFWriteStreamRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)stream);
//Parse parameter buffer
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "^UInt8", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (register_t)buffer);
    parameters[1].description = (char*)calloc(2*bufferLength+1, sizeof(char));
    NSData *buffer_data = [NSData dataWithBytes:buffer length:bufferLength];
    strncpy(parameters[1].description, [[[[[buffer_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*bufferLength);
//Parse parameter bufferLength
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFIndex", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "%d", (int)bufferLength);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFStream", "CFWriteStreamWrite", "0x0", parameters, 3);
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
    CFIndex return_value = original_CFWriteStreamWrite(stream, buffer, bufferLength);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFIndex", MAX_TYPE_LENGTH);
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


void * ____CFReadStreamGetError(CFReadStreamRef stream)
{
    if (!is_enabled() || !enabled_) {
        void * return_value = original_CFReadStreamGetError(stream);
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
//Parse parameter stream
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFReadStreamRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)stream);
    if(stream) {
        CFStringRef stream_description = CFCopyDescription(stream);
        parameters[0].description = (char*)calloc(CFStringGetLength(stream_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(stream_description, kCFStringEncodingUTF8), CFStringGetLength(stream_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFStream", "CFReadStreamGetError", "0x0", parameters, 1);
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
    void * return_value = original_CFReadStreamGetError(stream);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "void *", MAX_TYPE_LENGTH);
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


void * ____CFWriteStreamGetError(CFWriteStreamRef stream)
{
    if (!is_enabled() || !enabled_) {
        void * return_value = original_CFWriteStreamGetError(stream);
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
//Parse parameter stream
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFWriteStreamRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)stream);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFStream", "CFWriteStreamGetError", "0x0", parameters, 1);
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
    void * return_value = original_CFWriteStreamGetError(stream);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "void *", MAX_TYPE_LENGTH);
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


