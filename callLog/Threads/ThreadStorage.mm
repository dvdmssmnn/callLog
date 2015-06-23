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

#import "ThreadStorage.h"
#import "log.h"
#import <objc/runtime.h>

pthread_key_t __thread_infos__;
pthread_key_t __thread_enabled__;

void set_thread_value(pthread_key_t key, void *value)
{
    pthread_setspecific(key, value);
}

void *get_thread_value(pthread_key_t key)
{
    return pthread_getspecific(key);
}

void init_thread_infos()
{
    thread_storage_t *thread_infos = new thread_storage_t;
    
    thread_infos->lr_stack = new register_stack_t();
    thread_infos->sp_stack = new register_stack_t();
    thread_infos->exception_stack = new register_stack_t();
    thread_infos->helper_exception_stack = new register_stack_t();
    thread_infos->call_id_stack = new call_id_stack_t();
    thread_infos->bundle_stack = new cstring_stack_t();
    thread_infos->bundle_stack->reserve(100);
    thread_infos->signature_stack = new signature_stack_t();
    thread_infos->parse_enabled_stack = new bool_stack_t();
    thread_infos->thread_state = new NSUInteger;
    
#if DEBUG
    thread_infos->class_stack = new class_stack_t();
    thread_infos->selector_stack = new sel_stack_t();
#endif
    
    pthread_setspecific(__thread_infos__, thread_infos);
}

thread_storage_t *get_thread_infos() {
    thread_storage_t *thread_infos = (thread_storage_t*) pthread_getspecific(__thread_infos__);
    if (!thread_infos) {
        init_thread_infos();
    }
    thread_infos = (thread_storage_t*) pthread_getspecific(__thread_infos__);
    return thread_infos;
}

bool is_enabled()
{
    bool *enabled = (bool*) pthread_getspecific(__thread_enabled__);
    if (!enabled) {
        enabled = new bool;
        pthread_setspecific(__thread_enabled__, enabled);
        *enabled = true;
    }
    return *enabled;
}

void set_enabled(bool e)
{
    bool *enabled = (bool*) pthread_getspecific(__thread_enabled__);
    if (!enabled) {
        enabled = new bool;
        pthread_setspecific(__thread_enabled__, enabled);
        *enabled = true;
    }
    *enabled = e;
}

void print_thread_infos()
{
    logMsg(@"\n\nPrint thread infos");
    thread_storage_t *thread_infos = get_thread_infos();
    
    if (*(thread_infos->thread_state) & PARSE_PARAM) {
        logMsg(@"State: PARSE_PARAM");
    }
    if (*(thread_infos->thread_state) & GET_SIGNATURE) {
        logMsg(@"State: GET_SIGNATURE");
    }
    
#ifdef DEBUG
    
    logMsg([NSString stringWithFormat:@"Bundle:%zu ID:%zu Class:%zu Exc:%zu Help:%zu LR:%zu enable:%zu, sel:%zu sig:%zu",
          thread_infos->bundle_stack->size(),
          thread_infos->call_id_stack->size(),
          thread_infos->class_stack->size(),
          thread_infos->exception_stack->size(),
          thread_infos->helper_exception_stack->size(),
          thread_infos->lr_stack->size(),
          thread_infos->parse_enabled_stack->size(),
          thread_infos->selector_stack->size(),
          thread_infos->signature_stack->size()]);
    
#endif
    
    for (size_t i = 0; i < thread_infos->call_id_stack->size(); ++i) {
#if DEBUG
        logMsg([NSString stringWithFormat:@"%zu: %x\t[%s %s](%s): %s",
              i,
              thread_infos->helper_exception_stack->at(i),
              class_getName(thread_infos->class_stack->at(i)),
              sel_getName(thread_infos->selector_stack->at(i)),
              thread_infos->bundle_stack->at(i),
                thread_infos->parse_enabled_stack->at(i) ? "T" : "F"]);
#endif
    }
}

void print_call_stack()
{
#ifdef DEBUG
    logMsg(@"\n\nPrint callstack");
    thread_storage_t *thread_infos = get_thread_infos();
    for (size_t i = 0; i < thread_infos->class_stack->size(); ++i) {
        logMsg([NSString stringWithFormat:@"[%s %s]",
                class_getName(thread_infos->class_stack->at(i)),
                sel_getName(thread_infos->selector_stack->at(i))]);
    }
#endif
}


__attribute__((constructor))
static void initialize() {
    pthread_key_create(&__thread_infos__, 0);
    pthread_key_create(&__thread_enabled__, 0);
}