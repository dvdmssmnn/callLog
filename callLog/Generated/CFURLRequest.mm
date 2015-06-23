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

using namespace std;
void _____NSURLConnectionDidReceiveData(CFTypeRef connection, CFDataRef data, long a, void * b);

void (*original__NSURLConnectionDidReceiveData)(CFTypeRef, CFDataRef, long, void *);
__attribute__((constructor))
static void initialize() {
    dispatch_async(dispatch_get_main_queue(), ^ {
        void *_NSURLConnectionDidReceiveData_symbol = 0;
        MSHookSymbol(_NSURLConnectionDidReceiveData_symbol, "__NSURLConnectionDidReceiveData");
        MSHookFunction(_NSURLConnectionDidReceiveData_symbol, (void*)&_____NSURLConnectionDidReceiveData, (void**)&original__NSURLConnectionDidReceiveData);
    });
}

__attribute__((constructor))
static void constructor() {
}
void _____NSURLConnectionDidReceiveData(CFTypeRef connection, CFDataRef data, long a, void * b)
{
    if (!is_enabled() || !enabled_) {
        original__NSURLConnectionDidReceiveData(connection, data, a, b);
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
//Parse parameter connection
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFTypeRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)connection);
    if(connection) {
        CFStringRef connection_description = CFCopyDescription(connection);
        parameters[0].description = (char*)calloc(CFStringGetLength(connection_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(connection_description, kCFStringEncodingUTF8), CFStringGetLength(connection_description));
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
//Parse parameter a
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "long", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "%d", (int)a);
//Parse parameter b
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "^void", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "0x%X", (register_t)b);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURLRequest", "_NSURLConnectionDidReceiveData", "0x0", parameters, 4);
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
    original__NSURLConnectionDidReceiveData(connection, data, a, b);
    set_enabled(false);
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
}


