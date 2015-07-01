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
#include <unistd.h>

using namespace std;
void ____CFURLRequestSetHTTPRequestBody(CFTypeRef request, CFDataRef body);

void ____CFURLRequestSetHTTPRequestBodyStream(CFTypeRef request, CFReadStreamRef bodyStream);

CFTypeRef ____CFURLConnectionCreate(CFAllocatorRef alloc, CFTypeRef request, CFTypeRef * client);

CFTypeRef ____CFURLConnectionCreateWithProperties(CFAllocatorRef alloc, CFTypeRef request, CFTypeRef * client, CFDictionaryRef properties);

void ____CFURLRequestSetHTTPHeaderFieldValue(CFTypeRef mutableHTTPRequest, CFStringRef httpHeaderField, CFStringRef httpHeaderFieldValue);

void ____CFURLRequestSetMultipleHTTPHeaderFields(CFTypeRef mutableHTTPRequest, CFDictionaryRef headerFields);

void ____CFURLRequestAppendHTTPHeaderFieldValue(CFTypeRef mutableHTTPRequest, CFStringRef httpHeaderField, CFStringRef additionalHttpHeaderFieldValue);

CFTypeRef ____CFURLRequestCreateMutable(CFAllocatorRef alloc, CFURLRef URL, int cachePolicy, CFTimeInterval timeout, CFURLRef mainDocumentURL);

CFTypeRef ____CFURLRequestCreateMutableCopy(CFAllocatorRef alloc, CFTypeRef origRequest);

CFTypeRef ____CFURLRequestCreateMutableHTTPRequest(CFAllocatorRef alloc, CFTypeRef httpRequest, CFArrayRef bodyParts, int cachePolicy, CFTimeInterval timeout, CFURLRef mainDocumentURL);

CFTypeRef ____CFURLRequestCreateHTTPRequest(CFAllocatorRef alloc, CFTypeRef httpRequest, CFArrayRef bodyParts, int cachePolicy, CFTimeInterval timeout, CFURLRef mainDocumentURL);

CFTypeRef ____CFURLRequestCreateCopy(CFAllocatorRef alloc, CFTypeRef originalRequest);

void ____CFURLRequestSetURL(CFTypeRef request, CFTypeRef url);

void ____CFURLConnectionUseCredential(CFTypeRef conn, CFTypeRef creds, CFTypeRef challenge);

CFTypeRef ____CFURLCredentialCreate(CFAllocatorRef allocator, CFStringRef username, CFStringRef password, CFStringRef accountDomain, int persistence);

void _____NSWriteDataToFileWithExtendedAttributes(CFStringRef filePath, CFDataRef data, void * unknown, CFDictionaryRef a);

ssize_t ____write(int fildes, const void * buf, size_t nbyte);

int ____open(char * filename, int access, int permission);

int ____close(int fd);

void * ____SSLHandshake(void * a, void * b);

void(*original_CFURLRequestSetHTTPRequestBody)(CFTypeRef, CFDataRef);
void(*original_CFURLRequestSetHTTPRequestBodyStream)(CFTypeRef, CFReadStreamRef);
CFTypeRef(*original_CFURLConnectionCreate)(CFAllocatorRef, CFTypeRef, CFTypeRef *);
CFTypeRef(*original_CFURLConnectionCreateWithProperties)(CFAllocatorRef, CFTypeRef, CFTypeRef *, CFDictionaryRef);
void(*original_CFURLRequestSetHTTPHeaderFieldValue)(CFTypeRef, CFStringRef, CFStringRef);
void(*original_CFURLRequestSetMultipleHTTPHeaderFields)(CFTypeRef, CFDictionaryRef);
void(*original_CFURLRequestAppendHTTPHeaderFieldValue)(CFTypeRef, CFStringRef, CFStringRef);
CFTypeRef(*original_CFURLRequestCreateMutable)(CFAllocatorRef, CFURLRef, int, CFTimeInterval, CFURLRef);
CFTypeRef(*original_CFURLRequestCreateMutableCopy)(CFAllocatorRef, CFTypeRef);
CFTypeRef(*original_CFURLRequestCreateMutableHTTPRequest)(CFAllocatorRef, CFTypeRef, CFArrayRef, int, CFTimeInterval, CFURLRef);
CFTypeRef(*original_CFURLRequestCreateHTTPRequest)(CFAllocatorRef, CFTypeRef, CFArrayRef, int, CFTimeInterval, CFURLRef);
CFTypeRef(*original_CFURLRequestCreateCopy)(CFAllocatorRef, CFTypeRef);
void(*original_CFURLRequestSetURL)(CFTypeRef, CFTypeRef);
void(*original_CFURLConnectionUseCredential)(CFTypeRef, CFTypeRef, CFTypeRef);
CFTypeRef(*original_CFURLCredentialCreate)(CFAllocatorRef, CFStringRef, CFStringRef, CFStringRef, int);
void(*original__NSWriteDataToFileWithExtendedAttributes)(CFStringRef, CFDataRef, void *, CFDictionaryRef);
ssize_t(*original_write)(int, const void *, size_t);
int(*original_open)(char *, int, int);
int(*original_close)(int);
void *(*original_SSLHandshake)(void *, void *);
__attribute__((constructor))
static void initialize() {
    dispatch_async(dispatch_get_main_queue(), ^ {
        struct rebinding rebinds[20];
        original_CFURLRequestSetHTTPRequestBody = (void(*)(CFTypeRef, CFDataRef))dlsym(RTLD_DEFAULT, "CFURLRequestSetHTTPRequestBody");
        rebinds[0].name = (char*) "CFURLRequestSetHTTPRequestBody";
        rebinds[0].replacement = (void*) ____CFURLRequestSetHTTPRequestBody;
        original_CFURLRequestSetHTTPRequestBodyStream = (void(*)(CFTypeRef, CFReadStreamRef))dlsym(RTLD_DEFAULT, "CFURLRequestSetHTTPRequestBodyStream");
        rebinds[1].name = (char*) "CFURLRequestSetHTTPRequestBodyStream";
        rebinds[1].replacement = (void*) ____CFURLRequestSetHTTPRequestBodyStream;
        original_CFURLConnectionCreate = (CFTypeRef(*)(CFAllocatorRef, CFTypeRef, CFTypeRef *))dlsym(RTLD_DEFAULT, "CFURLConnectionCreate");
        rebinds[2].name = (char*) "CFURLConnectionCreate";
        rebinds[2].replacement = (void*) ____CFURLConnectionCreate;
        original_CFURLConnectionCreateWithProperties = (CFTypeRef(*)(CFAllocatorRef, CFTypeRef, CFTypeRef *, CFDictionaryRef))dlsym(RTLD_DEFAULT, "CFURLConnectionCreateWithProperties");
        rebinds[3].name = (char*) "CFURLConnectionCreateWithProperties";
        rebinds[3].replacement = (void*) ____CFURLConnectionCreateWithProperties;
        original_CFURLRequestSetHTTPHeaderFieldValue = (void(*)(CFTypeRef, CFStringRef, CFStringRef))dlsym(RTLD_DEFAULT, "CFURLRequestSetHTTPHeaderFieldValue");
        rebinds[4].name = (char*) "CFURLRequestSetHTTPHeaderFieldValue";
        rebinds[4].replacement = (void*) ____CFURLRequestSetHTTPHeaderFieldValue;
        original_CFURLRequestSetMultipleHTTPHeaderFields = (void(*)(CFTypeRef, CFDictionaryRef))dlsym(RTLD_DEFAULT, "CFURLRequestSetMultipleHTTPHeaderFields");
        rebinds[5].name = (char*) "CFURLRequestSetMultipleHTTPHeaderFields";
        rebinds[5].replacement = (void*) ____CFURLRequestSetMultipleHTTPHeaderFields;
        original_CFURLRequestAppendHTTPHeaderFieldValue = (void(*)(CFTypeRef, CFStringRef, CFStringRef))dlsym(RTLD_DEFAULT, "CFURLRequestAppendHTTPHeaderFieldValue");
        rebinds[6].name = (char*) "CFURLRequestAppendHTTPHeaderFieldValue";
        rebinds[6].replacement = (void*) ____CFURLRequestAppendHTTPHeaderFieldValue;
        original_CFURLRequestCreateMutable = (CFTypeRef(*)(CFAllocatorRef, CFURLRef, int, CFTimeInterval, CFURLRef))dlsym(RTLD_DEFAULT, "CFURLRequestCreateMutable");
        rebinds[7].name = (char*) "CFURLRequestCreateMutable";
        rebinds[7].replacement = (void*) ____CFURLRequestCreateMutable;
        original_CFURLRequestCreateMutableCopy = (CFTypeRef(*)(CFAllocatorRef, CFTypeRef))dlsym(RTLD_DEFAULT, "CFURLRequestCreateMutableCopy");
        rebinds[8].name = (char*) "CFURLRequestCreateMutableCopy";
        rebinds[8].replacement = (void*) ____CFURLRequestCreateMutableCopy;
        original_CFURLRequestCreateMutableHTTPRequest = (CFTypeRef(*)(CFAllocatorRef, CFTypeRef, CFArrayRef, int, CFTimeInterval, CFURLRef))dlsym(RTLD_DEFAULT, "CFURLRequestCreateMutableHTTPRequest");
        rebinds[9].name = (char*) "CFURLRequestCreateMutableHTTPRequest";
        rebinds[9].replacement = (void*) ____CFURLRequestCreateMutableHTTPRequest;
        original_CFURLRequestCreateHTTPRequest = (CFTypeRef(*)(CFAllocatorRef, CFTypeRef, CFArrayRef, int, CFTimeInterval, CFURLRef))dlsym(RTLD_DEFAULT, "CFURLRequestCreateHTTPRequest");
        rebinds[10].name = (char*) "CFURLRequestCreateHTTPRequest";
        rebinds[10].replacement = (void*) ____CFURLRequestCreateHTTPRequest;
        original_CFURLRequestCreateCopy = (CFTypeRef(*)(CFAllocatorRef, CFTypeRef))dlsym(RTLD_DEFAULT, "CFURLRequestCreateCopy");
        rebinds[11].name = (char*) "CFURLRequestCreateCopy";
        rebinds[11].replacement = (void*) ____CFURLRequestCreateCopy;
        original_CFURLRequestSetURL = (void(*)(CFTypeRef, CFTypeRef))dlsym(RTLD_DEFAULT, "CFURLRequestSetURL");
        rebinds[12].name = (char*) "CFURLRequestSetURL";
        rebinds[12].replacement = (void*) ____CFURLRequestSetURL;
        original_CFURLConnectionUseCredential = (void(*)(CFTypeRef, CFTypeRef, CFTypeRef))dlsym(RTLD_DEFAULT, "CFURLConnectionUseCredential");
        rebinds[13].name = (char*) "CFURLConnectionUseCredential";
        rebinds[13].replacement = (void*) ____CFURLConnectionUseCredential;
        original_CFURLCredentialCreate = (CFTypeRef(*)(CFAllocatorRef, CFStringRef, CFStringRef, CFStringRef, int))dlsym(RTLD_DEFAULT, "CFURLCredentialCreate");
        rebinds[14].name = (char*) "CFURLCredentialCreate";
        rebinds[14].replacement = (void*) ____CFURLCredentialCreate;
        original__NSWriteDataToFileWithExtendedAttributes = (void(*)(CFStringRef, CFDataRef, void *, CFDictionaryRef))dlsym(RTLD_DEFAULT, "_NSWriteDataToFileWithExtendedAttributes");
        rebinds[15].name = (char*) "_NSWriteDataToFileWithExtendedAttributes";
        rebinds[15].replacement = (void*) _____NSWriteDataToFileWithExtendedAttributes;
        original_write = (ssize_t(*)(int, const void *, size_t))write;
        rebinds[16].name = (char*) "write";
        rebinds[16].replacement = (void*) ____write;
        original_open = (int(*)(char *, int, int))open;
        rebinds[17].name = (char*) "open";
        rebinds[17].replacement = (void*) ____open;
        original_close = (int(*)(int))close;
        rebinds[18].name = (char*) "close";
        rebinds[18].replacement = (void*) ____close;
        original_SSLHandshake = (void *(*)(void *, void *))dlsym(RTLD_DEFAULT, "SSLHandshake");
        rebinds[19].name = (char*) "SSLHandshake";
        rebinds[19].replacement = (void*) ____SSLHandshake;
        rebind_symbols(rebinds, 20);
    });
}

void ____CFURLRequestSetHTTPRequestBody(CFTypeRef request, CFDataRef body)
{
    if (!is_enabled() || !enabled_) {
        original_CFURLRequestSetHTTPRequestBody(request, body);
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
    parameters = (parameter_t*)calloc(2, sizeof(parameter_t));
//Parse parameter request
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFTypeRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)request);
    if(request) {
        CFStringRef request_description = CFCopyDescription(request);
        parameters[0].description = (char*)calloc(CFStringGetLength(request_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(request_description, kCFStringEncodingUTF8), CFStringGetLength(request_description));
    }
//Parse parameter body
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFDataRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)body);
    if(body) {
        CFStringRef body_description = CFCopyDescription(body);
        parameters[1].description = (char*)calloc(CFStringGetLength(body_description) + 1, sizeof(char));
        memcpy(parameters[1].description, CFStringGetCStringPtr(body_description, kCFStringEncodingUTF8), CFStringGetLength(body_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "Dev", "CFURLRequestSetHTTPRequestBody", "0x0", parameters, 2);
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
    original_CFURLRequestSetHTTPRequestBody(request, body);
    set_enabled(false);
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
}


void ____CFURLRequestSetHTTPRequestBodyStream(CFTypeRef request, CFReadStreamRef bodyStream)
{
    if (!is_enabled() || !enabled_) {
        original_CFURLRequestSetHTTPRequestBodyStream(request, bodyStream);
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
    parameters = (parameter_t*)calloc(2, sizeof(parameter_t));
//Parse parameter request
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFTypeRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)request);
    if(request) {
        CFStringRef request_description = CFCopyDescription(request);
        parameters[0].description = (char*)calloc(CFStringGetLength(request_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(request_description, kCFStringEncodingUTF8), CFStringGetLength(request_description));
    }
//Parse parameter bodyStream
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFReadStreamRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)bodyStream);
    if(bodyStream) {
        CFStringRef bodyStream_description = CFCopyDescription(bodyStream);
        parameters[1].description = (char*)calloc(CFStringGetLength(bodyStream_description) + 1, sizeof(char));
        memcpy(parameters[1].description, CFStringGetCStringPtr(bodyStream_description, kCFStringEncodingUTF8), CFStringGetLength(bodyStream_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "Dev", "CFURLRequestSetHTTPRequestBodyStream", "0x0", parameters, 2);
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
    original_CFURLRequestSetHTTPRequestBodyStream(request, bodyStream);
    set_enabled(false);
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
}


CFTypeRef ____CFURLConnectionCreate(CFAllocatorRef alloc, CFTypeRef request, CFTypeRef * client)
{
    if (!is_enabled() || !enabled_) {
        CFTypeRef return_value = original_CFURLConnectionCreate(alloc, request, client);
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
//Parse parameter request
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFTypeRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)request);
    if(request) {
        CFStringRef request_description = CFCopyDescription(request);
        parameters[1].description = (char*)calloc(CFStringGetLength(request_description) + 1, sizeof(char));
        memcpy(parameters[1].description, CFStringGetCStringPtr(request_description, kCFStringEncodingUTF8), CFStringGetLength(request_description));
    }
//Parse parameter client
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "^CFTypeRef", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (register_t)client);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "Dev", "CFURLConnectionCreate", "0x0", parameters, 3);
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
    CFTypeRef return_value = original_CFURLConnectionCreate(alloc, request, client);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFTypeRef", MAX_TYPE_LENGTH);
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


CFTypeRef ____CFURLConnectionCreateWithProperties(CFAllocatorRef alloc, CFTypeRef request, CFTypeRef * client, CFDictionaryRef properties)
{
    if (!is_enabled() || !enabled_) {
        CFTypeRef return_value = original_CFURLConnectionCreateWithProperties(alloc, request, client, properties);
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
//Parse parameter request
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFTypeRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)request);
    if(request) {
        CFStringRef request_description = CFCopyDescription(request);
        parameters[1].description = (char*)calloc(CFStringGetLength(request_description) + 1, sizeof(char));
        memcpy(parameters[1].description, CFStringGetCStringPtr(request_description, kCFStringEncodingUTF8), CFStringGetLength(request_description));
    }
//Parse parameter client
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "^CFTypeRef", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (register_t)client);
//Parse parameter properties
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "CFDictionaryRef", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "0x%X", (int)properties);
    if(properties) {
        CFStringRef properties_description = CFCopyDescription(properties);
        parameters[3].description = (char*)calloc(CFStringGetLength(properties_description) + 1, sizeof(char));
        memcpy(parameters[3].description, CFStringGetCStringPtr(properties_description, kCFStringEncodingUTF8), CFStringGetLength(properties_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "Dev", "CFURLConnectionCreateWithProperties", "0x0", parameters, 4);
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
    CFTypeRef return_value = original_CFURLConnectionCreateWithProperties(alloc, request, client, properties);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFTypeRef", MAX_TYPE_LENGTH);
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


void ____CFURLRequestSetHTTPHeaderFieldValue(CFTypeRef mutableHTTPRequest, CFStringRef httpHeaderField, CFStringRef httpHeaderFieldValue)
{
    if (!is_enabled() || !enabled_) {
        original_CFURLRequestSetHTTPHeaderFieldValue(mutableHTTPRequest, httpHeaderField, httpHeaderFieldValue);
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
    parameters = (parameter_t*)calloc(3, sizeof(parameter_t));
//Parse parameter mutableHTTPRequest
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFTypeRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)mutableHTTPRequest);
    if(mutableHTTPRequest) {
        CFStringRef mutableHTTPRequest_description = CFCopyDescription(mutableHTTPRequest);
        parameters[0].description = (char*)calloc(CFStringGetLength(mutableHTTPRequest_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(mutableHTTPRequest_description, kCFStringEncodingUTF8), CFStringGetLength(mutableHTTPRequest_description));
    }
//Parse parameter httpHeaderField
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)httpHeaderField);
    if(httpHeaderField) {
        parameters[1].description = (char*)calloc(CFStringGetLength(httpHeaderField)+1, sizeof(char));
        CFStringGetCString(httpHeaderField, parameters[1].description, CFStringGetLength(httpHeaderField) + 1, kCFStringEncodingUTF8);
    }
//Parse parameter httpHeaderFieldValue
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (int)httpHeaderFieldValue);
    if(httpHeaderFieldValue) {
        parameters[2].description = (char*)calloc(CFStringGetLength(httpHeaderFieldValue)+1, sizeof(char));
        CFStringGetCString(httpHeaderFieldValue, parameters[2].description, CFStringGetLength(httpHeaderFieldValue) + 1, kCFStringEncodingUTF8);
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "Dev", "CFURLRequestSetHTTPHeaderFieldValue", "0x0", parameters, 3);
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
    original_CFURLRequestSetHTTPHeaderFieldValue(mutableHTTPRequest, httpHeaderField, httpHeaderFieldValue);
    set_enabled(false);
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
}


void ____CFURLRequestSetMultipleHTTPHeaderFields(CFTypeRef mutableHTTPRequest, CFDictionaryRef headerFields)
{
    if (!is_enabled() || !enabled_) {
        original_CFURLRequestSetMultipleHTTPHeaderFields(mutableHTTPRequest, headerFields);
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
    parameters = (parameter_t*)calloc(2, sizeof(parameter_t));
//Parse parameter mutableHTTPRequest
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFTypeRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)mutableHTTPRequest);
    if(mutableHTTPRequest) {
        CFStringRef mutableHTTPRequest_description = CFCopyDescription(mutableHTTPRequest);
        parameters[0].description = (char*)calloc(CFStringGetLength(mutableHTTPRequest_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(mutableHTTPRequest_description, kCFStringEncodingUTF8), CFStringGetLength(mutableHTTPRequest_description));
    }
//Parse parameter headerFields
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFDictionaryRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)headerFields);
    if(headerFields) {
        CFStringRef headerFields_description = CFCopyDescription(headerFields);
        parameters[1].description = (char*)calloc(CFStringGetLength(headerFields_description) + 1, sizeof(char));
        memcpy(parameters[1].description, CFStringGetCStringPtr(headerFields_description, kCFStringEncodingUTF8), CFStringGetLength(headerFields_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "Dev", "CFURLRequestSetMultipleHTTPHeaderFields", "0x0", parameters, 2);
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
    original_CFURLRequestSetMultipleHTTPHeaderFields(mutableHTTPRequest, headerFields);
    set_enabled(false);
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
}


void ____CFURLRequestAppendHTTPHeaderFieldValue(CFTypeRef mutableHTTPRequest, CFStringRef httpHeaderField, CFStringRef additionalHttpHeaderFieldValue)
{
    if (!is_enabled() || !enabled_) {
        original_CFURLRequestAppendHTTPHeaderFieldValue(mutableHTTPRequest, httpHeaderField, additionalHttpHeaderFieldValue);
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
    parameters = (parameter_t*)calloc(3, sizeof(parameter_t));
//Parse parameter mutableHTTPRequest
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFTypeRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)mutableHTTPRequest);
    if(mutableHTTPRequest) {
        CFStringRef mutableHTTPRequest_description = CFCopyDescription(mutableHTTPRequest);
        parameters[0].description = (char*)calloc(CFStringGetLength(mutableHTTPRequest_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(mutableHTTPRequest_description, kCFStringEncodingUTF8), CFStringGetLength(mutableHTTPRequest_description));
    }
//Parse parameter httpHeaderField
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)httpHeaderField);
    if(httpHeaderField) {
        parameters[1].description = (char*)calloc(CFStringGetLength(httpHeaderField)+1, sizeof(char));
        CFStringGetCString(httpHeaderField, parameters[1].description, CFStringGetLength(httpHeaderField) + 1, kCFStringEncodingUTF8);
    }
//Parse parameter additionalHttpHeaderFieldValue
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (int)additionalHttpHeaderFieldValue);
    if(additionalHttpHeaderFieldValue) {
        parameters[2].description = (char*)calloc(CFStringGetLength(additionalHttpHeaderFieldValue)+1, sizeof(char));
        CFStringGetCString(additionalHttpHeaderFieldValue, parameters[2].description, CFStringGetLength(additionalHttpHeaderFieldValue) + 1, kCFStringEncodingUTF8);
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "Dev", "CFURLRequestAppendHTTPHeaderFieldValue", "0x0", parameters, 3);
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
    original_CFURLRequestAppendHTTPHeaderFieldValue(mutableHTTPRequest, httpHeaderField, additionalHttpHeaderFieldValue);
    set_enabled(false);
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
}


CFTypeRef ____CFURLRequestCreateMutable(CFAllocatorRef alloc, CFURLRef URL, int cachePolicy, CFTimeInterval timeout, CFURLRef mainDocumentURL)
{
    if (!is_enabled() || !enabled_) {
        CFTypeRef return_value = original_CFURLRequestCreateMutable(alloc, URL, cachePolicy, timeout, mainDocumentURL);
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
    parameters = (parameter_t*)calloc(5, sizeof(parameter_t));
//Parse parameter alloc
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)alloc);
//Parse parameter URL
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)URL);
    if(URL) {
        CFStringRef URL_description = CFCopyDescription(URL);
        parameters[1].description = (char*)calloc(CFStringGetLength(URL_description) + 1, sizeof(char));
        memcpy(parameters[1].description, CFStringGetCStringPtr(URL_description, kCFStringEncodingUTF8), CFStringGetLength(URL_description));
    }
//Parse parameter cachePolicy
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "i", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "%d", (int)cachePolicy);
//Parse parameter timeout
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "CFTimeInterval", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "%d", (int)timeout);
//Parse parameter mainDocumentURL
    parameters[4].description = NULL;
    strncpy(parameters[4].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[4].value, MAX_VALUE_LENGTH, "0x%X", (int)mainDocumentURL);
    if(mainDocumentURL) {
        CFStringRef mainDocumentURL_description = CFCopyDescription(mainDocumentURL);
        parameters[4].description = (char*)calloc(CFStringGetLength(mainDocumentURL_description) + 1, sizeof(char));
        memcpy(parameters[4].description, CFStringGetCStringPtr(mainDocumentURL_description, kCFStringEncodingUTF8), CFStringGetLength(mainDocumentURL_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "Dev", "CFURLRequestCreateMutable", "0x0", parameters, 5);
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
    CFTypeRef return_value = original_CFURLRequestCreateMutable(alloc, URL, cachePolicy, timeout, mainDocumentURL);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFTypeRef", MAX_TYPE_LENGTH);
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


CFTypeRef ____CFURLRequestCreateMutableCopy(CFAllocatorRef alloc, CFTypeRef origRequest)
{
    if (!is_enabled() || !enabled_) {
        CFTypeRef return_value = original_CFURLRequestCreateMutableCopy(alloc, origRequest);
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
//Parse parameter origRequest
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFTypeRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)origRequest);
    if(origRequest) {
        CFStringRef origRequest_description = CFCopyDescription(origRequest);
        parameters[1].description = (char*)calloc(CFStringGetLength(origRequest_description) + 1, sizeof(char));
        memcpy(parameters[1].description, CFStringGetCStringPtr(origRequest_description, kCFStringEncodingUTF8), CFStringGetLength(origRequest_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "Dev", "CFURLRequestCreateMutableCopy", "0x0", parameters, 2);
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
    CFTypeRef return_value = original_CFURLRequestCreateMutableCopy(alloc, origRequest);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFTypeRef", MAX_TYPE_LENGTH);
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


CFTypeRef ____CFURLRequestCreateMutableHTTPRequest(CFAllocatorRef alloc, CFTypeRef httpRequest, CFArrayRef bodyParts, int cachePolicy, CFTimeInterval timeout, CFURLRef mainDocumentURL)
{
    if (!is_enabled() || !enabled_) {
        CFTypeRef return_value = original_CFURLRequestCreateMutableHTTPRequest(alloc, httpRequest, bodyParts, cachePolicy, timeout, mainDocumentURL);
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
//Parse parameter alloc
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)alloc);
//Parse parameter httpRequest
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFTypeRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)httpRequest);
    if(httpRequest) {
        CFStringRef httpRequest_description = CFCopyDescription(httpRequest);
        parameters[1].description = (char*)calloc(CFStringGetLength(httpRequest_description) + 1, sizeof(char));
        memcpy(parameters[1].description, CFStringGetCStringPtr(httpRequest_description, kCFStringEncodingUTF8), CFStringGetLength(httpRequest_description));
    }
//Parse parameter bodyParts
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFArrayRef", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (int)bodyParts);
    if(bodyParts) {
        CFStringRef bodyParts_description = CFCopyDescription(bodyParts);
        parameters[2].description = (char*)calloc(CFStringGetLength(bodyParts_description) + 1, sizeof(char));
        memcpy(parameters[2].description, CFStringGetCStringPtr(bodyParts_description, kCFStringEncodingUTF8), CFStringGetLength(bodyParts_description));
    }
//Parse parameter cachePolicy
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "i", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "%d", (int)cachePolicy);
//Parse parameter timeout
    parameters[4].description = NULL;
    strncpy(parameters[4].type, "CFTimeInterval", MAX_TYPE_LENGTH);
    snprintf(parameters[4].value, MAX_VALUE_LENGTH, "%d", (int)timeout);
//Parse parameter mainDocumentURL
    parameters[5].description = NULL;
    strncpy(parameters[5].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[5].value, MAX_VALUE_LENGTH, "0x%X", (int)mainDocumentURL);
    if(mainDocumentURL) {
        CFStringRef mainDocumentURL_description = CFCopyDescription(mainDocumentURL);
        parameters[5].description = (char*)calloc(CFStringGetLength(mainDocumentURL_description) + 1, sizeof(char));
        memcpy(parameters[5].description, CFStringGetCStringPtr(mainDocumentURL_description, kCFStringEncodingUTF8), CFStringGetLength(mainDocumentURL_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "Dev", "CFURLRequestCreateMutableHTTPRequest", "0x0", parameters, 6);
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
    CFTypeRef return_value = original_CFURLRequestCreateMutableHTTPRequest(alloc, httpRequest, bodyParts, cachePolicy, timeout, mainDocumentURL);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFTypeRef", MAX_TYPE_LENGTH);
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


CFTypeRef ____CFURLRequestCreateHTTPRequest(CFAllocatorRef alloc, CFTypeRef httpRequest, CFArrayRef bodyParts, int cachePolicy, CFTimeInterval timeout, CFURLRef mainDocumentURL)
{
    if (!is_enabled() || !enabled_) {
        CFTypeRef return_value = original_CFURLRequestCreateHTTPRequest(alloc, httpRequest, bodyParts, cachePolicy, timeout, mainDocumentURL);
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
//Parse parameter alloc
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)alloc);
//Parse parameter httpRequest
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFTypeRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)httpRequest);
    if(httpRequest) {
        CFStringRef httpRequest_description = CFCopyDescription(httpRequest);
        parameters[1].description = (char*)calloc(CFStringGetLength(httpRequest_description) + 1, sizeof(char));
        memcpy(parameters[1].description, CFStringGetCStringPtr(httpRequest_description, kCFStringEncodingUTF8), CFStringGetLength(httpRequest_description));
    }
//Parse parameter bodyParts
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFArrayRef", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (int)bodyParts);
    if(bodyParts) {
        CFStringRef bodyParts_description = CFCopyDescription(bodyParts);
        parameters[2].description = (char*)calloc(CFStringGetLength(bodyParts_description) + 1, sizeof(char));
        memcpy(parameters[2].description, CFStringGetCStringPtr(bodyParts_description, kCFStringEncodingUTF8), CFStringGetLength(bodyParts_description));
    }
//Parse parameter cachePolicy
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "i", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "%d", (int)cachePolicy);
//Parse parameter timeout
    parameters[4].description = NULL;
    strncpy(parameters[4].type, "CFTimeInterval", MAX_TYPE_LENGTH);
    snprintf(parameters[4].value, MAX_VALUE_LENGTH, "%d", (int)timeout);
//Parse parameter mainDocumentURL
    parameters[5].description = NULL;
    strncpy(parameters[5].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[5].value, MAX_VALUE_LENGTH, "0x%X", (int)mainDocumentURL);
    if(mainDocumentURL) {
        CFStringRef mainDocumentURL_description = CFCopyDescription(mainDocumentURL);
        parameters[5].description = (char*)calloc(CFStringGetLength(mainDocumentURL_description) + 1, sizeof(char));
        memcpy(parameters[5].description, CFStringGetCStringPtr(mainDocumentURL_description, kCFStringEncodingUTF8), CFStringGetLength(mainDocumentURL_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "Dev", "CFURLRequestCreateHTTPRequest", "0x0", parameters, 6);
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
    CFTypeRef return_value = original_CFURLRequestCreateHTTPRequest(alloc, httpRequest, bodyParts, cachePolicy, timeout, mainDocumentURL);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFTypeRef", MAX_TYPE_LENGTH);
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


CFTypeRef ____CFURLRequestCreateCopy(CFAllocatorRef alloc, CFTypeRef originalRequest)
{
    if (!is_enabled() || !enabled_) {
        CFTypeRef return_value = original_CFURLRequestCreateCopy(alloc, originalRequest);
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
//Parse parameter originalRequest
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFTypeRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)originalRequest);
    if(originalRequest) {
        CFStringRef originalRequest_description = CFCopyDescription(originalRequest);
        parameters[1].description = (char*)calloc(CFStringGetLength(originalRequest_description) + 1, sizeof(char));
        memcpy(parameters[1].description, CFStringGetCStringPtr(originalRequest_description, kCFStringEncodingUTF8), CFStringGetLength(originalRequest_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "Dev", "CFURLRequestCreateCopy", "0x0", parameters, 2);
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
    CFTypeRef return_value = original_CFURLRequestCreateCopy(alloc, originalRequest);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFTypeRef", MAX_TYPE_LENGTH);
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


void ____CFURLRequestSetURL(CFTypeRef request, CFTypeRef url)
{
    if (!is_enabled() || !enabled_) {
        original_CFURLRequestSetURL(request, url);
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
    parameters = (parameter_t*)calloc(2, sizeof(parameter_t));
//Parse parameter request
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFTypeRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)request);
    if(request) {
        CFStringRef request_description = CFCopyDescription(request);
        parameters[0].description = (char*)calloc(CFStringGetLength(request_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(request_description, kCFStringEncodingUTF8), CFStringGetLength(request_description));
    }
//Parse parameter url
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFTypeRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)url);
    if(url) {
        CFStringRef url_description = CFCopyDescription(url);
        parameters[1].description = (char*)calloc(CFStringGetLength(url_description) + 1, sizeof(char));
        memcpy(parameters[1].description, CFStringGetCStringPtr(url_description, kCFStringEncodingUTF8), CFStringGetLength(url_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "Dev", "CFURLRequestSetURL", "0x0", parameters, 2);
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
    original_CFURLRequestSetURL(request, url);
    set_enabled(false);
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
}


void ____CFURLConnectionUseCredential(CFTypeRef conn, CFTypeRef creds, CFTypeRef challenge)
{
    if (!is_enabled() || !enabled_) {
        original_CFURLConnectionUseCredential(conn, creds, challenge);
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
    parameters = (parameter_t*)calloc(3, sizeof(parameter_t));
//Parse parameter conn
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFTypeRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)conn);
    if(conn) {
        CFStringRef conn_description = CFCopyDescription(conn);
        parameters[0].description = (char*)calloc(CFStringGetLength(conn_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(conn_description, kCFStringEncodingUTF8), CFStringGetLength(conn_description));
    }
//Parse parameter creds
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFTypeRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)creds);
    if(creds) {
        CFStringRef creds_description = CFCopyDescription(creds);
        parameters[1].description = (char*)calloc(CFStringGetLength(creds_description) + 1, sizeof(char));
        memcpy(parameters[1].description, CFStringGetCStringPtr(creds_description, kCFStringEncodingUTF8), CFStringGetLength(creds_description));
    }
//Parse parameter challenge
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFTypeRef", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (int)challenge);
    if(challenge) {
        CFStringRef challenge_description = CFCopyDescription(challenge);
        parameters[2].description = (char*)calloc(CFStringGetLength(challenge_description) + 1, sizeof(char));
        memcpy(parameters[2].description, CFStringGetCStringPtr(challenge_description, kCFStringEncodingUTF8), CFStringGetLength(challenge_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "Dev", "CFURLConnectionUseCredential", "0x0", parameters, 3);
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
    original_CFURLConnectionUseCredential(conn, creds, challenge);
    set_enabled(false);
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
}


CFTypeRef ____CFURLCredentialCreate(CFAllocatorRef allocator, CFStringRef username, CFStringRef password, CFStringRef accountDomain, int persistence)
{
    if (!is_enabled() || !enabled_) {
        CFTypeRef return_value = original_CFURLCredentialCreate(allocator, username, password, accountDomain, persistence);
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
    parameters = (parameter_t*)calloc(5, sizeof(parameter_t));
//Parse parameter allocator
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)allocator);
//Parse parameter username
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)username);
    if(username) {
        parameters[1].description = (char*)calloc(CFStringGetLength(username)+1, sizeof(char));
        CFStringGetCString(username, parameters[1].description, CFStringGetLength(username) + 1, kCFStringEncodingUTF8);
    }
//Parse parameter password
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (int)password);
    if(password) {
        parameters[2].description = (char*)calloc(CFStringGetLength(password)+1, sizeof(char));
        CFStringGetCString(password, parameters[2].description, CFStringGetLength(password) + 1, kCFStringEncodingUTF8);
    }
//Parse parameter accountDomain
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "0x%X", (int)accountDomain);
    if(accountDomain) {
        parameters[3].description = (char*)calloc(CFStringGetLength(accountDomain)+1, sizeof(char));
        CFStringGetCString(accountDomain, parameters[3].description, CFStringGetLength(accountDomain) + 1, kCFStringEncodingUTF8);
    }
//Parse parameter persistence
    parameters[4].description = NULL;
    strncpy(parameters[4].type, "i", MAX_TYPE_LENGTH);
    snprintf(parameters[4].value, MAX_VALUE_LENGTH, "%d", (int)persistence);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "Dev", "CFURLCredentialCreate", "0x0", parameters, 5);
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
    CFTypeRef return_value = original_CFURLCredentialCreate(allocator, username, password, accountDomain, persistence);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFTypeRef", MAX_TYPE_LENGTH);
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


void _____NSWriteDataToFileWithExtendedAttributes(CFStringRef filePath, CFDataRef data, void * unknown, CFDictionaryRef a)
{
    if (!is_enabled() || !enabled_) {
        original__NSWriteDataToFileWithExtendedAttributes(filePath, data, unknown, a);
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
//Parse parameter filePath
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)filePath);
    if(filePath) {
        parameters[0].description = (char*)calloc(CFStringGetLength(filePath)+1, sizeof(char));
        CFStringGetCString(filePath, parameters[0].description, CFStringGetLength(filePath) + 1, kCFStringEncodingUTF8);
    }
//Parse parameter data
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFDataRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)data);
    if(data) {
        CFStringRef data_description = CFCopyDescription(data);
        parameters[1].description = (char*)calloc(CFStringGetLength(data_description) + 1, sizeof(char));
        memcpy(parameters[1].description, CFStringGetCStringPtr(data_description, kCFStringEncodingUTF8), CFStringGetLength(data_description));
    }
//Parse parameter unknown
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "^void", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (register_t)unknown);
//Parse parameter a
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "CFDictionaryRef", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "0x%X", (int)a);
    if(a) {
        CFStringRef a_description = CFCopyDescription(a);
        parameters[3].description = (char*)calloc(CFStringGetLength(a_description) + 1, sizeof(char));
        memcpy(parameters[3].description, CFStringGetCStringPtr(a_description, kCFStringEncodingUTF8), CFStringGetLength(a_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "Dev", "_NSWriteDataToFileWithExtendedAttributes", "0x0", parameters, 4);
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
    original__NSWriteDataToFileWithExtendedAttributes(filePath, data, unknown, a);
    set_enabled(false);
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
}


ssize_t ____write(int fildes, const void * buf, size_t nbyte)
{
    if (!is_enabled() || !enabled_) {
        ssize_t return_value = original_write(fildes, buf, nbyte);
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
//Parse parameter fildes
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "i", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)fildes);
//Parse parameter buf
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "^void", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (register_t)buf);
    parameters[1].description = (char*)calloc(2*nbyte+1, sizeof(char));
    NSData *buf_data = [NSData dataWithBytes:buf length:nbyte];
    strncpy(parameters[1].description, [[[[[buf_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*nbyte);
//Parse parameter nbyte
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "size_t", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "%d", (int)nbyte);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "Dev", "write", "0x0", parameters, 3);
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
    ssize_t return_value = original_write(fildes, buf, nbyte);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "ssize_t", MAX_TYPE_LENGTH);
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


int ____open(char * filename, int access, int permission)
{
    if (!is_enabled() || !enabled_) {
        int return_value = original_open(filename, access, permission);
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
//Parse parameter filename
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "*", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (register_t)filename);
    parameters[0].description = (char*)calloc(strlen(filename)+1, sizeof(char));
    memcpy(parameters[0].description, filename, strlen(filename));
//Parse parameter access
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "i", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "%d", (int)access);
//Parse parameter permission
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "i", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "%d", (int)permission);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "Dev", "open", "0x0", parameters, 3);
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
    int return_value = original_open(filename, access, permission);
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


int ____close(int fd)
{
    if (!is_enabled() || !enabled_) {
        int return_value = original_close(fd);
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
//Parse parameter fd
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "i", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)fd);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "Dev", "close", "0x0", parameters, 1);
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
    int return_value = original_close(fd);
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


void * ____SSLHandshake(void * a, void * b)
{
    if (!is_enabled() || !enabled_) {
        void * return_value = original_SSLHandshake(a, b);
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
//Parse parameter a
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "^void", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (register_t)a);
//Parse parameter b
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "^void", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (register_t)b);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "Dev", "SSLHandshake", "0x0", parameters, 2);
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
    void * return_value = original_SSLHandshake(a, b);
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


