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

#import "ClassDictionary.h"
#import "types.h"
#import <objc/runtime.h>

typedef std::unordered_map<Class, char*> class_string_map_t;
class_string_map_t class_bundles;

typedef std::unordered_map<Class, std::unordered_set<SEL>> class_methods_t;
class_methods_t class_methods;


void set_bundle_for_class(Class clazz, const char *bundle)
{
    if (bundle == NULL) {
        class_bundles[clazz] = NULL;
    } else {
        //FIXME: strlen unsafe?
        size_t len = strlen(bundle);
        char *b = (char*)calloc(len+1, sizeof(char));
        memcpy(b, bundle, len);
        class_bundles[clazz] = b;
    }
    //    class_bundles.insert(std::make_pair(clazz, bundle));
}

const char *get_bundle_for_class(Class clazz)
{
    return class_bundles[clazz];;
}

void add_methods(Class c)
{
    unsigned int instance_methods_count = 0;
    Method *instance_methods = class_copyMethodList(c, &instance_methods_count);
    
    for (unsigned int i = 0; i < instance_methods_count; ++i) {
        class_methods[c].insert(method_getName(instance_methods[i]));
    }
    
    unsigned int class_methods_count = 0;
    Method *_class_methods = class_copyMethodList(object_getClass(c), &class_methods_count);
    for (unsigned int i = 0; i < class_methods_count; ++i) {
        class_methods[object_getClass(c)].insert(method_getName(_class_methods[i]));
    }
}

bool has_method(Class c, SEL _cmd)
{
    return class_methods[c].find(_cmd) != class_methods[c].end();
}

void class_dictionary_initialize()
{
    class_bundles = class_string_map_t();
}