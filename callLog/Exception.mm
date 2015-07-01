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

#import "Exception.h"
#import <dlfcn.h>
#import "ThreadStorage.h"
#import "log.h"
#import "Whitelists.h"
#import "ASM.h"
#import "fishhook.h"

IMP original_raise_exception = 0;
void *original_rethrow_exception = 0;

void *original_throw = 0;


#define POP_HOOK() \
thread_infos->exception_stack->pop_back();\
thread_infos->lr_stack->pop_back();

#ifdef DEBUG

#define POP_HELPER() \
thread_infos->helper_exception_stack->pop_back();\
thread_infos->bundle_stack->pop_back();\
thread_infos->call_id_stack->pop_back();\
thread_infos->parse_enabled_stack->pop_back();\
thread_infos->signature_stack->pop_back();\
thread_infos->selector_stack->pop_back();\
thread_infos->class_stack->pop_back();

#else

#define POP_HELPER() \
thread_infos->helper_exception_stack->pop_back();\
thread_infos->bundle_stack->pop_back();\
thread_infos->call_id_stack->pop_back();\
thread_infos->parse_enabled_stack->pop_back();\
thread_infos->signature_stack->pop_back();

#endif

void raise_exception(id self, SEL _cmd)
{
    ((void (*)(id, SEL))original_raise_exception)(self, _cmd);
}

register_t get_exception_handler() {
    register_t r = 0;
    __asm("mrc    p15, #0x0, r1, c13, c0, #0x3\n");
    __asm("bic    r1, r1, #0x3\n");
    __asm("ldr    %0, [r1, #0x48]\n" : "=r"(r));
    return r;
}

void handle_rethrow_exception() {
    
    //TODO: check if 'signatureWithObjCTypes:' was called?
    if (*(get_thread_infos()->thread_state) & GET_SIGNATURE) {
        return;
    }
    
    logMsg(@"rethrow");
    
    thread_storage_t *thread_infos = get_thread_infos();
    
    register_t ex = get_exception_handler();
    
    while (thread_infos->exception_stack->back() == ex
           && thread_infos->exception_stack->size() > 1) {
        //        NSLog(@"pop %d", ex);
        POP_HOOK()
    }
    
    while (thread_infos->helper_exception_stack->back() == ex
           && thread_infos->helper_exception_stack->size() > 1) {
        POP_HELPER()
    }
}

void handle_raise_exception(id exception) {
    logMsg(@"-----------------------------------");
    thread_storage_t *thread_infos = get_thread_infos();
    //TODO: check if 'signatureWithObjCTypes:' was called?
    if (*(get_thread_infos()->thread_state) & GET_SIGNATURE) {
        logMsg(@"get signature");
        add_blacklist_entry(class_getName(thread_infos->current_class), sel_getName(thread_infos->current_sel));
        print_call_stack();
        return;
    }
    
    logMsg([exception description]);

    print_thread_infos();
    print_call_stack();
    
    //FIXME: Remove this?
    while (thread_infos->exception_stack->back() == 0) {
        POP_HOOK()
    }
    while (thread_infos->helper_exception_stack->back() == 0) {
        POP_HELPER()
    }
    
//    register_t ex = foobar();
    register_t ex = thread_infos->exception_stack->back();
    
    logMsg([NSString stringWithFormat:@"Unwind %d", ex]);
    while (thread_infos->exception_stack->back() == ex
           && thread_infos->exception_stack->size() > 1) {
        logMsg([NSString stringWithFormat:@"pop %d", ex]);
        POP_HOOK()
    }
    
    while (thread_infos->helper_exception_stack->back() == ex
           && thread_infos->helper_exception_stack->size() > 1) {
        POP_HELPER()
    }
}


__attribute__((__naked__))
static void rethrow_exception()
{
    save()
    call(blx, handle_rethrow_exception)
    load()
    call(bx, original_rethrow_exception);
}


__attribute__((__naked__))
static void throw_exception()
{
    save()
    call(blx, handle_raise_exception)
    load()
    call(bx, original_throw)
}

    void hook_throw_exception()
{
    original_throw = dlsym(RTLD_DEFAULT, "objc_exception_throw");
    original_rethrow_exception = dlsym(RTLD_DEFAULT, "objc_exception_rethrow");
    
    struct rebinding rebind[2];
    
    rebind[0].name = (char*)"objc_exception_throw";
    rebind[0].replacement = (void*)throw_exception;
    
    rebind[1].name = (char*)"_objc_exception_rethrow";
    rebind[1].replacement = (void*)rethrow_exception;
    
    rebind_symbols(rebind, 2);
}
