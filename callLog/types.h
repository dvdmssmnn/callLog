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

#ifndef argTrace_types_h
#define argTrace_types_h

#import <unordered_map>
#import <string>
#import <vector>
#import <unordered_set>
#import <set>

struct cstring_cmp {
    bool operator()(const char *c1, const char *c2) const {
        return strcmp(c1, c2) < 0;
    }
};

typedef unsigned long long call_id_t;

typedef std::vector<bool> bool_stack_t;
typedef std::vector<register_t> register_stack_t;
typedef std::vector<const char*> cstring_stack_t;
//TODO: Change to unordered_set???
typedef std::set<const char*, cstring_cmp> cstring_set_t;
typedef std::vector<u_long> ulong_stack_t;
typedef std::vector<NSMethodSignature *> signature_stack_t;


typedef std::unordered_set<SEL> sel_set_t;

typedef std::vector<Class> class_stack_t;
typedef std::vector<SEL> sel_stack_t;

typedef std::vector<call_id_t> call_id_stack_t;

static const size_t MAX_TYPE_LENGTH = 64;
static const size_t MAX_VALUE_LENGTH = 256;

struct parameter_t {
    char type[MAX_TYPE_LENGTH];
    char value[MAX_VALUE_LENGTH];
    char *description;
};

typedef struct parameter_t parameter_t;

#endif
