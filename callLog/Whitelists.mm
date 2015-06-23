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

#import "Whitelists.h"
#import "Config.h"

using namespace std;

blacklist_t whitelisted;
cstring_set_t bundle_whitelist;

class_set_t class_whitelist;
sel_set_t method_whitelist;

blacklist_t class_method_blacklist;
class_set_t class_blacklist;
sel_set_t method_blacklist;

bool is_whitelisted(Class clazz, SEL method)
{
    class_set_t::iterator class_it = find(class_whitelist.begin(), class_whitelist.end(), clazz);
    if (class_it != class_whitelist.end()) {
        return true;
    }
    
    sel_set_t::iterator method_it = find(method_whitelist.begin(), method_whitelist.end(), method);
    if (method_it != method_whitelist.end()) {
        return true;
    }
    
    blacklist_t::iterator it = whitelisted.find(clazz);
    if (it != whitelisted.end()) {
        if (it->second.find(method) != it->second.end()) {
            return true;
        }
    }
    Class super_class = class_getSuperclass(clazz);
    if (super_class != Nil) {
        return is_whitelisted(super_class, method);
    }
    return false;
}

void add_whitelist_entry(const char *clazz,
                         const char *method)
{
    if (clazz && method) {
        Class c = NSClassFromString([NSString stringWithUTF8String:clazz]);
        SEL sel = NSSelectorFromString([NSString stringWithUTF8String:method]);
        whitelisted[c].insert(sel);
    } else if (clazz) {
        Class c = NSClassFromString([NSString stringWithUTF8String:clazz]);
        if (c != Nil) {
            class_whitelist.insert(c);
        }
    } else if (method) {
        SEL sel = NSSelectorFromString([NSString stringWithUTF8String:method]);
        method_whitelist.insert(sel);
    }
    save_config();
}

bool should_handle_call(const char *bundle)
{

    cstring_set_t::iterator it = bundle_whitelist.find(bundle);
    return it != bundle_whitelist.end();
}

void whitelist_bundle(const char *bundle)
{
    bundle_whitelist.insert(bundle);
    save_config();
}

blacklist_t get_class_method_whitelist()
{
    return whitelisted;
}

class_set_t get_class_whitelist()
{
    return class_whitelist;
}

sel_set_t get_method_whitelist()
{
    return method_whitelist;
}


void add_blacklist_entry(const char *clazz,
                         const char *method)
{
    if (clazz && method) {
        Class c = NSClassFromString([NSString stringWithUTF8String:clazz]);
        SEL sel = NSSelectorFromString([NSString stringWithUTF8String:method]);
        class_method_blacklist[c].insert(sel);
    } else if (clazz) {
        Class c = NSClassFromString([NSString stringWithUTF8String:clazz]);
        if (c != Nil) {
            class_blacklist.insert(c);
        }
    } else if (method) {
        SEL sel = NSSelectorFromString([NSString stringWithUTF8String:method]);
        method_blacklist.insert(sel);
    }
    save_config();
}

bool is_blacklisted(Class c, SEL sel)
{
    blacklist_t::iterator cm_it = class_method_blacklist.find(c);
    if (cm_it != class_method_blacklist.end()) {
        sel_set_t methods = cm_it->second;
        if (methods.find(sel) != methods.end()) {
            return true;
        }
    }
    class_set_t::iterator class_it = class_blacklist.find(c);
    if (class_it != class_blacklist.end()) {
        return true;
    }
    
    sel_set_t::iterator method_it = method_blacklist.find(sel);
    if (method_it != method_blacklist.end()) {
        //TODO: insert into class_method_blacklist for faster processing
        return true;
    }
    return false;
}

blacklist_t get_class_method_blacklist()
{
    return class_method_blacklist;
}

class_set_t get_class_blacklist()
{
    return class_blacklist;
}

sel_set_t get_method_blacklist()
{
    return method_blacklist;
}