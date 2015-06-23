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
#import "types.h"

#import <string>
#import <objc/runtime.h>

typedef std::unordered_set<Method> method_set_t;
typedef std::unordered_set<Class> class_set_t;
typedef std::unordered_map<Class, sel_set_t> blacklist_t;

bool is_whitelisted(Class clazz,
                  SEL method);

bool should_handle_call(const char *bundle);

void add_whitelist_entry(const char *clazz,
                         const char *method);

void whitelist_bundle(const char *bundle);

void add_blacklist_entry(const char *clazz,
                         const char *method);
bool is_blacklisted(Class c, SEL sel);

blacklist_t get_class_method_whitelist();
class_set_t get_class_whitelist();
sel_set_t get_method_whitelist();

blacklist_t get_class_method_blacklist();
class_set_t get_class_blacklist();
sel_set_t get_method_blacklist();
