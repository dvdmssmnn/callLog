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

#import <pthread.h>
#import "types.h"

extern pthread_key_t __thread_infos__;
extern pthread_key_t __thread_enabled__;

typedef enum : NSUInteger {
    NORMAL = 0x0,
    GET_SIGNATURE = 0x1 << 1,
    PARSE_PARAM = 0x1 << 2
} thread_state_t;


struct thread_storage_t {
    register_stack_t *lr_stack;
    register_stack_t *sp_stack;
    register_stack_t *exception_stack;
    //this stack is used to keep track of those calls
    //where the 'enabled' flag was true
    register_stack_t *helper_exception_stack;
    call_id_stack_t *call_id_stack;
    cstring_stack_t *bundle_stack;
    signature_stack_t *signature_stack;
    bool_stack_t *parse_enabled_stack;
    Class current_class;
    SEL current_sel;
#if DEBUG
    class_stack_t *class_stack;
    sel_stack_t *selector_stack;
#endif
    NSUInteger *thread_state;
};

typedef struct thread_storage_t thread_storage_t;


void set_thread_value(pthread_key_t key, void *value);
void *get_thread_value(pthread_key_t key);
void init_thread_infos();
thread_storage_t *get_thread_infos();

bool is_enabled();
void set_enabled(bool enabled);

void print_thread_infos();
void print_call_stack();