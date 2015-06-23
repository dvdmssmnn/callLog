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

#ifndef HOOKHELPER_H
#define HOOKHELPER_H

#import <Foundation/Foundation.h>
#import "types.h"
#import <semaphore.h>

#ifdef __cplusplus
extern "C" {
#endif
    
    void initialize_hook_helper();
    
    extern call_id_t counter;
    extern pthread_mutex_t counter_mutex;
    extern dispatch_queue_t db_queue;
    
    void argTrace_preprocess(id self, Class _class, SEL _cmd, va_list args);
    void argTrace_postprocess(void *return_value);
    
    void argTrace_push_lr(register_t lr);
    register_t argTrace_pop_lr();
    
    void argTrace_push_sp(register_t sp);
    register_t argTrace_pop_sp();
    
    void argTrace_push_exception(register_t exception);
    register_t argTrace_pop_exception();
    
#ifdef __cplusplus
}
#endif

#endif