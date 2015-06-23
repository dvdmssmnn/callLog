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

#include "Config.h"
#import "Whitelists.h"
#import <Foundation/Foundation.h>
#import <string>
#import <json/json.h>
#import <json/reader.h>
#import <sstream>

using namespace std;
using namespace Json;

const string CONFIG_FILENAME = "config.json";

const string HANDLE_STEP_OUT_BUNDLE = "handle_step_out_bundle";
const string METHOD_WHITELIST = "method_whitelist";
const string MAX_DESCRIPTION_LENGTH = "max_description_length";
const string ENABLE_OBJC_HOOKS = "enable_objc_hooks";

const string BLACKLIST = "blacklist";

bool enabled_ = false;
bool handle_step_out_bundle_ = true;
int max_description_length_ = 100;
bool enabled_objc_hooks_ = true;

NSString *path_to_config();

void load_config()
{
    NSString *config_file = path_to_config();

    
    NSData *configData = [NSData dataWithContentsOfFile:config_file];
    NSString *config = [[NSString alloc] initWithData:configData encoding:NSUTF8StringEncoding];
    
    Value root;
    Reader reader;
    reader.parse([config UTF8String], root);
    
    if (root.isMember(HANDLE_STEP_OUT_BUNDLE)) {
        handle_step_out_bundle_ = root[HANDLE_STEP_OUT_BUNDLE].asBool();
    }
    
    if (root.isMember(MAX_DESCRIPTION_LENGTH)) {
        max_description_length_ = root[MAX_DESCRIPTION_LENGTH].asInt();
    }
    
    if (root.isMember(ENABLE_OBJC_HOOKS)) {
        enabled_objc_hooks_ = root[ENABLE_OBJC_HOOKS].asBool();
    }
    
    if (root.isMember(METHOD_WHITELIST)) {
        Value whitelist = root[METHOD_WHITELIST];
        for (int i = 0; i < whitelist.size(); ++i) {
            if (whitelist[i].isMember("class") && whitelist[i].isMember("method")) {
                add_whitelist_entry(whitelist[i]["class"].asCString(), whitelist[i]["method"].asCString());
            } else if (whitelist[i].isMember("class")) {
                add_whitelist_entry(whitelist[i]["class"].asCString(), NULL);
            } else if (whitelist[i].isMember("method")) {
                add_whitelist_entry(NULL, whitelist[i]["method"].asCString());
            }
        }
    }
    
    if (root.isMember(BLACKLIST)) {
        Value blacklist = root[BLACKLIST];
        for (int i = 0; i < blacklist.size(); ++i) {
            if (blacklist[i].isMember("class") && blacklist[i].isMember("method")) {
                add_blacklist_entry(blacklist[i]["class"].asCString(), blacklist[i]["method"].asCString());
            } else if (blacklist[i].isMember("class")) {
                add_blacklist_entry(blacklist[i]["class"].asCString(), NULL);
            } else if (blacklist[i].isMember("method")) {
                add_blacklist_entry(NULL, blacklist[i]["method"].asCString());
            }
        }
    }
}

void save_config()
{
    Value config_json;
    
    blacklist_t class_method_whitelist = get_class_method_whitelist();
    blacklist_t::iterator class_method_it = class_method_whitelist.begin();
    
    Value method_whitelist_json;
    
    for(; class_method_it != class_method_whitelist.end(); ++class_method_it) {
        sel_set_t::iterator method_it = class_method_it->second.begin();
        for (; method_it != class_method_it->second.end(); ++method_it) {
            Value whitelist_entry;
            whitelist_entry["class"] = class_getName(class_method_it->first);
            whitelist_entry["method"] = sel_getName(*method_it);
            method_whitelist_json.append(whitelist_entry);
        }
    }
    
    class_set_t class_whitelist = get_class_whitelist();
    class_set_t::iterator class_it = class_whitelist.begin();
    
    for (; class_it != class_whitelist.end(); ++class_it) {
        Value whitelist_entry;
        whitelist_entry["class"] = class_getName(*class_it);
        method_whitelist_json.append(whitelist_entry);
    }
    
    sel_set_t method_whitelist = get_method_whitelist();
    sel_set_t::iterator method_it = method_whitelist.begin();
    
    for (; method_it != method_whitelist.end(); ++method_it) {
        Value whitelist_entry;
        whitelist_entry["method"] = sel_getName(*method_it);
        method_whitelist_json.append(whitelist_entry);
    }
    
    
    //BLACKLIST
    Value blacklist_json;
    
    blacklist_t class_method_blacklist = get_class_method_blacklist();
    for (blacklist_t::iterator class_it = class_method_blacklist.begin();
         class_it != class_method_blacklist.end();
         ++class_it) {
        for (sel_set_t::iterator method_it = class_it->second.begin();
             method_it != class_it->second.end();
             ++method_it) {
            Value blacklist_entry;
            blacklist_entry["class"] = class_getName(class_it->first);
            blacklist_entry["method"] = sel_getName(*method_it);
            
            blacklist_json.append(blacklist_entry);
        }
    }
    
    class_set_t class_blacklist = get_class_blacklist();
    for (class_set_t::iterator class_it = class_blacklist.begin();
         class_it != class_blacklist.end();
         ++class_it) {
        Value blacklist_entry;
        blacklist_entry["class"] = class_getName(*class_it);
        blacklist_json.append(blacklist_entry);
    }
    
    sel_set_t method_blacklist = get_method_blacklist();
    for (sel_set_t::iterator method_it = method_blacklist.begin();
         method_it != method_blacklist.end();
         ++method_it) {
        Value blacklist_entry;
        blacklist_entry["method"] = sel_getName(*method_it);
        blacklist_json.append(blacklist_entry);
    }
    
    config_json[BLACKLIST] = blacklist_json;
    
    
    config_json[METHOD_WHITELIST] = method_whitelist_json;
    
    config_json[HANDLE_STEP_OUT_BUNDLE] = handle_step_out_bundle_;
    
    config_json[MAX_DESCRIPTION_LENGTH] = max_description_length_;
    
    config_json[ENABLE_OBJC_HOOKS] = enabled_objc_hooks_;
    
    NSString *config_file = path_to_config();
    
    stringstream ss;
    ss << config_json;
    
    NSString *configString = [NSString stringWithUTF8String:ss.str().c_str()];
    [configString writeToFile:config_file
                   atomically:YES
                     encoding:NSUTF8StringEncoding error:nil];
}

#pragma mark - Local

NSString *path_to_config()
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *config_file = [NSString stringWithFormat:@"%@/%s",
                             documentsDirectory, CONFIG_FILENAME.c_str()];
    return config_file;
}