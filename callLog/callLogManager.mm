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

#import "callLogManager.h"

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CydiaSubstrate/CydiaSubstrate.h>

#import "Hook.h"
#import <objc/runtime.h>
#import "HookHelper.h"
#import "ClassDictionary.h"
#import "MethodSignatures.h"
#import "SQLiteStorage.h"
#import "Config.h"
#import "Whitelists.h"
#import "Exception.h"

#define START_ASYNC

__attribute__((constructor))
static void initialize() {
#ifdef START_ASYNC
    dispatch_async(dispatch_get_main_queue(), ^{
#endif
//        initialize_db();
        
        initialize_database();
        initialize_hook_helper();
        class_dictionary_initialize();
        
        int numClasses = objc_getClassList(0, 0);
        
        Class *classes = (Class*)malloc(numClasses * sizeof(Class));
        objc_getClassList(classes, numClasses);
        
        while (--numClasses) {
            NSBundle *bundle = [NSBundle bundleForClass:classes[numClasses]];
            if ([bundle bundleIdentifier]) {
                set_bundle_for_class(classes[numClasses], [[bundle bundleIdentifier] cStringUsingEncoding:NSUTF8StringEncoding]);
            } else {
                set_bundle_for_class(classes[numClasses], [[bundle bundlePath] cStringUsingEncoding:NSUTF8StringEncoding]);
            }
            add_methods(classes[numClasses]);
        }
        
        method_signatures_initialize();
        
        load_config();
        
        
        whitelist_bundle([[[NSBundle mainBundle] bundleIdentifier] UTF8String]);
        add_whitelist_entry("NSUserDefaults", NULL);
        
        if (enabled_objc_hooks_) {
            hook_throw_exception();
            objc_msgSendHook_enable();
        }
        
        [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
        enabled_ = true;
#ifdef START_ASYNC
    });
#endif
}

void store_classes()
{
    dispatch_sync(db_queue, ^{
        int numClasses = objc_getClassList(0, 0);
        Class *classes = (Class*)malloc(numClasses * sizeof(Class));
        objc_getClassList(classes, numClasses);
        
        while (--numClasses) {
            Class superclass = class_getSuperclass(classes[numClasses]);
            const char *superclass_name = 0;
            if (superclass != Nil) {
                superclass_name = class_getName(superclass);
            }
            const char *class_name = class_getName(classes[numClasses]);
            insert_class(numClasses, class_name, superclass_name ?: "", get_bundle_for_class(classes[numClasses])?: "");
            
            
            
            unsigned int num_instance_methods = 0;
            unsigned int num_class_methods = 0;
            
            Method *instance_methods = class_copyMethodList(classes[numClasses], &num_instance_methods);
            Method *class_methods = class_copyMethodList(object_getClass(classes[numClasses]), &num_class_methods);
            if (num_instance_methods) {
                while (--num_instance_methods) {
                    insert_method(numClasses, sel_getName(method_getName(instance_methods[num_instance_methods])));
                    
                    
                }
            }
            
            if (num_class_methods) {
                while (--num_class_methods) {
                    insert_method(numClasses, sel_getName(method_getName(class_methods[num_class_methods])));
                    
                    
                }
            }
            
        }
    });

    
}