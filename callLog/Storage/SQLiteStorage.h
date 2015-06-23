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
#import <vector>
#import <string>
#import <json/json.h>

void initialize_database();
bool db_open();
void db_close();
NSString *get_db_path();

void insert_call(const call_id_t call_id,
                 const call_id_t caller_id,
                 const char *clazz,
                 const char *method,
                 const char *self,
                 const parameter_t *parameter,
                 const size_t num_parameters);

void insert_return(const call_id_t call_id,
                   const parameter_t *return_parameter);

void insert_class(int class_id, std::string clazz, std::string super_class, std::string bundle);
void insert_method(int class_id, std::string method);


Json::Value get_method_list();

Json::Value get_call_backtrace(std::string call_id, std::string arg_value);
Json::Value get_call(std::string call_id);
Json::Value find_in_return(std::string call_id, std::string arg_value);
Json::Value find_calls(std::string clazz,
                       std::string method,
                       std::string value,
                       std::string description);
Json::Value get_called(std::string call_id);