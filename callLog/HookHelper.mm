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

#import <string>
#import <objc/runtime.h>
#import <cstdarg>
#import <semaphore.h>

#import "ThreadStorage.h"
#import "types.h"
#import "ClassDictionary.h"
#import "MethodSignatures.h"
#import "SQLiteStorage.h"
#import "Whitelists.h"
#import "Config.h"
#import "log.h"

#define ARG_LENGTH 256

dispatch_queue_t db_queue;

call_id_t counter = 0;
pthread_mutex_t counter_mutex;

SEL number_of_arguments_sel;
NSUInteger (*number_of_arguments)(id, SEL);

SEL signature_with_objc_types_sel;
NSMethodSignature *(*signature_with_objc_tyes)(id, SEL, const char *);

using namespace std;

bool arg_parse(va_list *args,
               const char *type,
               size_t max_size,
               string &value,
               string &description,
               const bool should_parse_description,
               string &parsed_type);

void parse_paremeter(va_list *args,
                     const char *type,
                     size_t max_size,
                     bool parse_description,
                     parameter_t *parameter);

void argTrace_preprocess(id self, Class _class, SEL _cmd, va_list args)
{
    thread_storage_t *thread_infos = get_thread_infos();
    
#ifdef DEBUG
    Class clazz = object_getClass(self);
    thread_infos->class_stack->push_back(clazz);
    thread_infos->selector_stack->push_back(_cmd);
#endif
    
    if (!(is_enabled() && enabled_)) {
        return;
    }

    set_enabled(false);
    
    call_id_t callID;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    callID = counter;
    pthread_mutex_unlock(&counter_mutex);
    
    thread_infos->helper_exception_stack->push_back(thread_infos->exception_stack->back());
    
    __block call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(callID);
    
    
#ifndef DEBUG
    Class clazz = object_getClass(self);
#endif
    thread_infos->current_class = clazz;
    thread_infos->current_sel = _cmd;
    
    const char *bundleID = get_bundle_for_class(clazz) ?: "";
    
    const char *callee_bundle_id = NULL;
    if (thread_infos->bundle_stack->size()) {
        callee_bundle_id = thread_infos->bundle_stack->back();
    }
    thread_infos->bundle_stack->push_back(bundleID);
    
#ifndef ALL_CALLS
    if (handle_step_out_bundle_ && callee_bundle_id &&  strlen(callee_bundle_id)) {
        if (!should_handle_call(bundleID) && !(thread_infos->parse_enabled_stack->size() && thread_infos->parse_enabled_stack->back())) {
            if (!should_handle_call(callee_bundle_id)) {
                thread_infos->signature_stack->push_back(0);
                thread_infos->parse_enabled_stack->push_back(false);
                thread_infos->call_id_stack->pop_back();
                thread_infos->call_id_stack->push_back(caller_id);
                set_enabled(true);
                return;
            }
        }
    } else {
        if (!should_handle_call(bundleID) && !(thread_infos->parse_enabled_stack->size() && thread_infos->parse_enabled_stack->back())) {
            thread_infos->signature_stack->push_back(0);
            thread_infos->parse_enabled_stack->push_back(false);
            thread_infos->call_id_stack->pop_back();
            thread_infos->call_id_stack->push_back(caller_id);
            set_enabled(true);
            return;
        }
    }
#endif
    
    if (!self) {
        thread_infos->signature_stack->push_back(0);
        thread_infos->parse_enabled_stack->push_back(false);
        thread_infos->call_id_stack->pop_back();
        thread_infos->call_id_stack->push_back(caller_id);
        set_enabled(true);
        return;
    }
    
    //TODO: speed up somehow......
    bool blacklisted = is_blacklisted(clazz, _cmd);
    bool should_parse = !blacklisted;

    if (!blacklisted) {
        Class _imp_class = Nil;
        _imp_class = [self class];
        bool is_class_method = false;
        if (_imp_class == self) {
            is_class_method = true;
            _imp_class = self;
        }
        
        while (_imp_class != Nil) {
            if (has_method(is_class_method ? object_getClass(_imp_class) : _imp_class, _cmd)) {
                break;
            }
            _imp_class = class_getSuperclass(_imp_class);
        }
        const char *alpha = 0;
        if (_imp_class && (alpha = class_getName(_imp_class))) {
            while (*alpha == '_') {
                ++alpha;
            }
            if (strncmp(alpha, "NS", 2) == 0) {
                if (strncmp(alpha, "NSConst", 7) &&
                    strncmp(alpha, "NSCFConst", 9)) {
                    should_parse = false;
                }
            } else if (strncmp(alpha, "UI", 2) == 0 ||
                strncmp(alpha, "CA", 2) == 0 ||
                strncmp(alpha, "CF", 2) == 0) {
                should_parse = false;
            }
        }
        
        //TODO: only check '_imp_class'???
        if (!should_parse) {
            should_parse = is_whitelisted(_imp_class, _cmd);
        }
    }
    thread_infos->parse_enabled_stack->push_back(should_parse);

    __block NSMethodSignature *signature = getSignature(clazz, _cmd);
    if (!signature && !blacklisted) {
        *(thread_infos->thread_state) ^= GET_SIGNATURE;
        thread_infos->signature_stack->push_back(nil);
        bool is_class_method = false;
        if ([self class] == self) {
            is_class_method = true;
        }
        Method m = Nil;
        if (is_class_method) {
            m = class_getClassMethod(self, _cmd);
        } else {
            m = class_getInstanceMethod([self class], _cmd);
        }
        
        @try {
//            signature = [self methodSignatureForSelector:_cmd];
            const char *type_encoding = method_getTypeEncoding(m);
            signature = signature_with_objc_tyes([NSMethodSignature class], signature_with_objc_types_sel, type_encoding);

        }
        @catch (NSException *exception) {
            
        }
        insertSignature(clazz, _cmd, signature);
        thread_infos->signature_stack->pop_back();
        *(thread_infos->thread_state) ^= GET_SIGNATURE;
    }
    
    thread_infos->signature_stack->push_back(signature);

    NSUInteger num_args = 2;
    if (signature) {
        num_args = [signature numberOfArguments];
    }
    
    parameter_t *parameters = NULL;
    
    if (num_args > 2) {
        parameters = (parameter_t*)calloc(num_args - 2, sizeof(parameter_t));
        
        for (int i = 2; i < num_args; ++i) {
            
            parse_paremeter(&args, [signature getArgumentTypeAtIndex:i], 0, should_parse, &parameters[i-2]);
            
//            string parsed, description, parsed_type;
//            arg_parse(&args, [signature getArgumentTypeAtIndex:i], 0, parsed, description,should_parse, parsed_type);
//            
//            argument_t arg;
//            if (should_parse) {
//                arg.type = parsed_type;
//            } else {
//                arg.type = [signature getArgumentTypeAtIndex:i];
//            }
//        
//            arg.value = parsed;
//            arg.description = description;
//            args_.push_back(arg);
        }
    }
    
#ifndef SKIP_DB
    register_t self_ptr = (register_t)self;
#ifdef SQL_SYNC
    dispatch_sync(db_queue, ^{
#else
    dispatch_async(db_queue, ^{
#endif
        set_enabled(false);
        char self_str[30];
        snprintf(self_str, 30, "0x%X", self_ptr);
        insert_call(callID,
                    caller_id,
                    object_getClassName(clazz),
                    sel_getName(_cmd), self_str,
                    parameters,
                    num_args - 2);
        for (int i = 0; i < num_args -2; ++i) {
            if (parameters[i].description) {
                free(parameters[i].description);
            }
        }
        free(parameters);
        set_enabled(true);
    });
#endif
    set_enabled(true);
}

void argTrace_postprocess(void *return_value)
{
    thread_storage_t *thread_infos = get_thread_infos();
    
#ifdef DEBUG
    thread_infos->selector_stack->pop_back();
    thread_infos->class_stack->pop_back();
#endif
    
    if (!(is_enabled() && enabled_)) {
        return;
    }
    
    set_enabled(false);
    
    thread_infos->helper_exception_stack->pop_back();
    thread_infos->bundle_stack->pop_back();
    
    call_id_t call_id = thread_infos->call_id_stack->back();
    thread_infos->call_id_stack->pop_back();
    
    NSMethodSignature *signature = thread_infos->signature_stack->back();
    thread_infos->signature_stack->pop_back();
    
    bool should_parse = thread_infos->parse_enabled_stack->back();
    thread_infos->parse_enabled_stack->pop_back();
    
    if (signature) {
        va_list ret = (va_list)&return_value;
        parameter_t return_param;
        return_param.value[0] = '\0';
        return_param.type[0] = '\0';
        return_param.description = NULL;
        parse_paremeter(&ret, [signature methodReturnType], 4, should_parse, &return_param);
//        insert_return_valud(to_string(call_id), return_type, ret_value);
        
#ifndef SKIP_DB
#ifdef SQL_SYNC
        dispatch_sync(db_queue, ^{
#else
            dispatch_async(db_queue, ^{
#endif
                set_enabled(false);
                insert_return(call_id, &return_param);
                set_enabled(true);
        });
#endif
    }
    
    set_enabled(true);
}

void argTrace_push_lr(register_t lr)
{
    thread_storage_t *thread_storage = get_thread_infos();
    thread_storage->lr_stack->push_back(lr);
}

register_t argTrace_pop_lr()
{
    thread_storage_t *thread_storage = get_thread_infos();
    register_t lr = thread_storage->lr_stack->back();
    thread_storage->lr_stack->pop_back();
    return lr;
}

void argTrace_push_sp(register_t sp)
{
    thread_storage_t *thread_storage = get_thread_infos();
    thread_storage->sp_stack->push_back(sp);

}

register_t argTrace_pop_sp()
{
    thread_storage_t *thread_storage = get_thread_infos();
    register_t sp = thread_storage->sp_stack->back();
    thread_storage->sp_stack->pop_back();
    return sp;
}

void argTrace_push_exception(register_t exception)
{
    thread_storage_t *thread_storage = get_thread_infos();
    thread_storage->exception_stack->push_back(exception);
}

register_t argTrace_pop_exception()
{
    thread_storage_t *thread_storage = get_thread_infos();
    register_t ex = thread_storage->exception_stack->back();
    thread_storage->exception_stack->pop_back();
    return ex;
}

#pragma mark - Local
     
void parse_paremeter(va_list *args,
                     const char *type,
                     size_t max_size,
                     bool parse_description,
                     parameter_t *parameter)
{
    NSUInteger size;
    NSGetSizeAndAlignment(type, &size, 0);
    if (max_size && size > max_size) {
        stpncpy(parameter->value, "unable to parse", 16);
        return;
    }
    
    const char *type_it = type;
    
    while (1) {
        switch (*type_it) {
            case '@':
            {
                id arg = va_arg(*args, id);
                snprintf(parameter->value, MAX_VALUE_LENGTH, "0x%X", (register_t)arg);
                if (parse_description) {
                    if (arg) {
                        @try {
                            class_getName(object_getClass(arg));
                            
                            NSString *d = [arg description];
                            if ([arg isKindOfClass:[NSData class]]) {
                                d = [[[d stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""];
                            }
                            if (max_description_length_ && [d length] > max_description_length_) {
                                d = [d substringToIndex:max_description_length_];
                            }
                            char *descripton = (char*) calloc([d length] + 1, sizeof(char));
                            strncpy(descripton, [d UTF8String], [d length]);
                            parameter->description = descripton;
                            strncpy(parameter->type, class_getName([arg class]), MAX_TYPE_LENGTH);
                        }
                        @catch (NSException *exception) {
                            
                        }
                    }
                }
            }
                break;
            case '^':
            {
                void *arg = va_arg(*args, void*);
                snprintf(parameter->value, MAX_VALUE_LENGTH, "0x%X", (register_t)arg);
            }
                break;
            case 'i':
            case 'c':
            {
                int arg = va_arg(*args, int);
                snprintf(parameter->value, MAX_VALUE_LENGTH, "%d", arg);
            }
                break;
            case 'I':
            {
                unsigned int arg = va_arg(*args, unsigned int);
                snprintf(parameter->value, MAX_VALUE_LENGTH, "%u", arg);
            }
                break;
            case 'r':
            case 'R':
            case 'V':
            case 'n':
            case 'N':
            case 'o':
            case 'O':
                ++type_it;
                continue;
                break;
            default:
                stpncpy(parameter->value, "unable to parse", 16);
                strncpy(parameter->type, type, MAX_TYPE_LENGTH);
                for (int i = 0; i < size; i+=4) {
                    va_arg(*args, int);
                }
                break;
        }
        break;
    }
    
    if (!parse_description) {
        strncpy(parameter->type, type, MAX_TYPE_LENGTH);
    }
}

bool arg_parse(va_list *args,
               const char *type,
               size_t max_size,
               string &value,
               string &description,
               const bool should_parse_description,
               string &parsed_type)
{
    string t = type;
    NSUInteger size;
    NSGetSizeAndAlignment(type, &size, 0);
    if (max_size && size > max_size) {
        value = "unable_to parse";
        return false;
    }
    
    while (1) {
        switch (*type) {
            case '@':
            {
                id arg = va_arg(*args, id);
                char helper[100];
                snprintf(helper, 100, "0x%X", (register_t)arg);
                value = helper;
                if (should_parse_description) {
                    if (arg) {
                        NSString *d = [arg description];
                        if ([d length] > max_description_length_) {
                            d = [d substringToIndex:max_description_length_];
                        }
                        parsed_type = class_getName([arg class]);
                        if ([arg isKindOfClass:[NSData class]]) {
                            description = [[[[d stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] UTF8String];
                        } else {
                            description = [d UTF8String];
                        }
                    } else {
                        parsed_type = type;
                        description = "nil";
                    }
                }
            }
                break;
            case '^':
            {
                void *arg = va_arg(*args, void*);
                char helper[100];
                snprintf(helper, 100, "0x%X", (register_t)arg);
                value = helper;
            }
                break;
            case 'i':
            {
                int arg = va_arg(*args, int);
                value = to_string(arg);
            }
                break;
            case 'v':
                value = "";
                break;
            case 'r':
            case 'R':
            case 'V':
            case 'n':
            case 'N':
            case 'o':
            case 'O':
                ++type;
                continue;
                break;
            default:
                value = "unable_to_parse";
                for (int i = 0; i < size; i+=4) {
                    va_arg(*args, int);
                }
                break;
        }
        break;
    }
    
//    while (1) {
//        
//    
//        if (*type == '@') {
//            id arg = va_arg(*args, id);
//            char helper[100];
//            snprintf(helper, 100, "0x%X", (register_t)arg);
//            value = helper;
//            if (should_parse_description) {
//                if (arg) {
//                    NSString *d = [arg description];
//                    if ([d length] > max_description_length_) {
//                        d = [d substringToIndex:max_description_length_];
//                    }
//                    description = [d UTF8String];
//                    parsed_type = class_getName([arg class]);
//                } else {
//                    parsed_type = type;
//                    description = "nil";
//                }
//            }
//        } else if (t == "i") {
//            int arg = va_arg(*args, int);
//            value = to_string(arg);
//        } else if (t == "I") {
//            unsigned int arg = va_arg(*args, unsigned int);
//            value = to_string(arg);
//        } else if (t == "c") {
//            char arg = va_arg(*args, char);
//            value = to_string(arg);
//        } else if (t == "C") {
//            unsigned char arg = va_arg(*args, unsigned char);
//            value = to_string(arg);
//        } else if (t == "s") {
//            short arg = va_arg(*args, short);
//            value = to_string(arg);
//        } else if (t == "S") {
//            unsigned short arg = va_arg(*args, unsigned short);
//            value = to_string(arg);
//        } else if (t == "q") {
//            long long arg = va_arg(*args, long long);
//            value = to_string(arg);
//        } else if (t == "Q") {
//            unsigned long long arg = va_arg(*args, unsigned long long);
//            value = to_string(arg);
//        } else if (t == "l") {
//            long arg = va_arg(*args, long);
//            value = to_string(arg);
//        } else if (t == "L") {
//            unsigned long arg = va_arg(*args, unsigned long);
//            value = to_string(arg);
//        } else if (t == "f") {
//            float arg = va_arg(*args, float);
//            value = to_string(arg);
//        } else if (t == "d") {
//            double arg = va_arg(*args, double);
//            value = to_string(arg);
//        } else if (t == "B") {
//            bool arg = va_arg(*args, bool);
//            value = to_string(arg);
//        } else if (*type == '*') {
//            char *arg = va_arg(*args, char*);
//            value = to_string((register_t)arg);
//        } else if (t == "r*") {
//            //TODO should be handled by the previous case
//            char *arg = va_arg(*args, char*);
//            value = to_string((register_t)arg);
//        } else if (t == "#") {
//            Class arg = va_arg(*args, Class);
//            value = class_getName(arg) ?: "";
//        } else if (t == ":") {
//            SEL arg(va_arg(*args, SEL));
//            value = sel_getName(arg) ?: "";
//        } else if (*type == '^') {
//            void *arg = va_arg(*args, void*);
//            char helper[100];
//            snprintf(helper, 100, "0x%X", (register_t)arg);
//            value = helper;
//        } else if (t == "?") {
//            return false;
//        } else if (*type == 'r') {
//            type++;
//            continue;
//        } else if (*type =='v') {
//            value = "";
//        } else {
//            value = "unable_to_parse";
//            for (int i = 0; i < size; i+=4) {
//                va_arg(*args, int);
//            }
//        }
//        break;
//    }
    return true;
}

void initialize_hook_helper() {
    pthread_mutex_init(&counter_mutex, 0);
    
    db_queue = dispatch_queue_create("db_queue", DISPATCH_QUEUE_CONCURRENT);
//    db_queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    
    number_of_arguments_sel = NSSelectorFromString(@"numberOfArguments");
    IMP numberOfArguments_imp = method_getImplementation(class_getInstanceMethod([NSMethodSignature class], number_of_arguments_sel));
    number_of_arguments = (NSUInteger(*)(id, SEL)) numberOfArguments_imp;
    
    signature_with_objc_types_sel = @selector(signatureWithObjCTypes:);
    IMP signature_with_objc_types_imp = method_getImplementation(class_getClassMethod([NSMethodSignature class], signature_with_objc_types_sel));
    signature_with_objc_tyes = (NSMethodSignature*(*)(id, SEL, const char*))signature_with_objc_types_imp;
}
