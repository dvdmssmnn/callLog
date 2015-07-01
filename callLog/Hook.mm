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

#import "Hook.h"

#import <dlfcn.h>
#import <objc/message.h>

#import "HookHelper.h"
#import "ThreadStorage.h"

#import "ASM.h"
#import "fishhook.h"

void *original_msgSend = 0;


__attribute__((__naked__))
static id msgSend_hook()
{
    save()
    __asm volatile ("mov r0, lr\n");
    link(blx, argTrace_push_lr);
    restore_save()
    
    __asm("mrc    p15, #0x0, r1, c13, c0, #0x3\n");
    __asm("bic    r1, r1, #0x3\n");
    __asm("ldr    r0, [r1, #0x48]\n");
    link(blx, argTrace_push_exception)
    
    restore_save()
    __asm volatile ("mov r2, r1\n");
    __asm volatile ("mov r1, #0\n");
    __asm volatile ("add r3, sp, #8\n");
    link(blx, argTrace_preprocess)
//    call(blx, preprocess_)
    load()
    call(blx, original_msgSend)
//    call(bx, original_msgSend)
    save()
    restore_save()
    link(blx, argTrace_postprocess);
    restore_save()
    link(blx, argTrace_pop_exception);
    link(blx, argTrace_pop_lr);
    __asm volatile("mov r12, r0\n");
    load()
    __asm volatile("bx r12\n");
}


void objc_msgSendHook_enable()
{
    original_msgSend = (void*)objc_msgSend;
    struct rebinding rebind_objc_msgSend[1];
    rebind_objc_msgSend[0].name = (char*)"objc_msgSend";
    rebind_objc_msgSend[0].replacement = (void*)msgSend_hook;
    
    rebind_symbols(rebind_objc_msgSend, 1);
}