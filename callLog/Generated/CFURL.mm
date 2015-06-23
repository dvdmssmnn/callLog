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

#import "SQLiteStorage.h"
#import "ThreadStorage.h"
#import "callLogManager.h"
#import <vector>
#import <string>
#import <pthread.h>
#import <pthread.h>
#import "Config.h"
#import <CydiaSubstrate/CydiaSubstrate.h>
#import <semaphore.h>

using namespace std;
CFTypeID ____CFURLGetTypeID();

CFURLRef ____CFURLCreateWithBytes(CFAllocatorRef allocator, const UInt8 * URLBytes, CFIndex length, CFStringEncoding encoding, CFURLRef baseURL);

CFDataRef ____CFURLCreateData(CFAllocatorRef allocator, CFURLRef url, CFStringEncoding encoding, Boolean escapeWhitespace);

CFURLRef ____CFURLCreateWithString(CFAllocatorRef allocator, CFStringRef URLString, CFURLRef baseURL);

CFURLRef ____CFURLCreateAbsoluteURLWithBytes(CFAllocatorRef alloc, const UInt8 * relativeURLBytes, CFIndex length, CFStringEncoding encoding, CFURLRef baseURL, Boolean useCompatibilityMode);

CFURLRef ____CFURLCreateWithFileSystemPath(CFAllocatorRef allocator, CFStringRef filePath, CFURLPathStyle pathStyle, Boolean isDirectory);

CFURLRef ____CFURLCreateFromFileSystemRepresentation(CFAllocatorRef allocator, const UInt8 * buffer, CFIndex bufLen, Boolean isDirectory);

CFURLRef ____CFURLCreateWithFileSystemPathRelativeToBase(CFAllocatorRef allocator, CFStringRef filePath, CFURLPathStyle pathStyle, Boolean isDirectory, CFURLRef baseURL);

CFURLRef ____CFURLCreateFromFileSystemRepresentationRelativeToBase(CFAllocatorRef allocator, const UInt8 * buffer, CFIndex bufLen, Boolean isDirectory, CFURLRef baseURL);

Boolean ____CFURLGetFileSystemRepresentation(CFURLRef url, Boolean resolveAgainstBase, UInt8 * buffer, CFIndex maxBufLen);

CFStringRef ____CFURLGetString(CFURLRef anURL);

CFURLRef ____CFURLGetBaseURL(CFURLRef anURL);

Boolean ____CFURLCanBeDecomposed(CFURLRef anURL);

CFStringRef ____CFURLCopyScheme(CFURLRef anURL);

CFStringRef ____CFURLCopyNetLocation(CFURLRef anURL);

CFStringRef ____CFURLCopyPath(CFURLRef anURL);

CFStringRef ____CFURLCopyStrictPath(CFURLRef anURL, Boolean * isAbsolute);

CFStringRef ____CFURLCopyFileSystemPath(CFURLRef anURL, CFURLPathStyle pathStyle);

Boolean ____CFURLHasDirectoryPath(CFURLRef anURL);

CFStringRef ____CFURLCopyResourceSpecifier(CFURLRef anURL);

CFStringRef ____CFURLCopyHostName(CFURLRef anURL);

SInt32 ____CFURLGetPortNumber(CFURLRef anURL);

CFStringRef ____CFURLCopyUserName(CFURLRef anURL);

CFStringRef ____CFURLCopyPassword(CFURLRef anURL);

CFStringRef ____CFURLCopyParameterString(CFURLRef anURL, CFStringRef charactersToLeaveEscaped);

CFStringRef ____CFURLCopyQueryString(CFURLRef anURL, CFStringRef charactersToLeaveEscaped);

CFStringRef ____CFURLCopyFragment(CFURLRef anURL, CFStringRef charactersToLeaveEscaped);

CFStringRef ____CFURLCopyLastPathComponent(CFURLRef url);

CFStringRef ____CFURLCopyPathExtension(CFURLRef url);

CFURLRef ____CFURLCreateCopyAppendingPathComponent(CFAllocatorRef allocator, CFURLRef url, CFStringRef pathComponent, Boolean isDirectory);

CFURLRef ____CFURLCreateCopyDeletingLastPathComponent(CFAllocatorRef allocator, CFURLRef url);

CFURLRef ____CFURLCreateCopyAppendingPathExtension(CFAllocatorRef allocator, CFURLRef url, CFStringRef extension);

CFURLRef ____CFURLCreateCopyDeletingPathExtension(CFAllocatorRef allocator, CFURLRef url);

CFIndex ____CFURLGetBytes(CFURLRef url, UInt8 * buffer, CFIndex bufferLength);

CFRange ____CFURLGetByteRangeForComponent(CFURLRef url, CFURLComponentType component, CFRange * rangeIncludingSeparators);

CFStringRef ____CFURLCreateStringByReplacingPercentEscapes(CFAllocatorRef allocator, CFStringRef originalString, CFStringRef charactersToLeaveEscaped);

CFStringRef ____CFURLCreateStringByReplacingPercentEscapesUsingEncoding(CFAllocatorRef allocator, CFStringRef origString, CFStringRef charsToLeaveEscaped, CFStringEncoding encoding);

CFStringRef ____CFURLCreateStringByAddingPercentEscapes(CFAllocatorRef allocator, CFStringRef originalString, CFStringRef charactersToLeaveUnescaped, CFStringRef legalURLCharactersToBeEscaped, CFStringEncoding encoding);

Boolean ____CFURLIsFileReferenceURL(CFURLRef url);

CFURLRef ____CFURLCreateFileReferenceURL(CFAllocatorRef allocator, CFURLRef url, CFErrorRef * error);

CFURLRef ____CFURLCreateFilePathURL(CFAllocatorRef allocator, CFURLRef url, CFErrorRef * error);

Boolean ____CFURLCopyResourcePropertyForKey(CFURLRef url, CFStringRef key, void * propertyValueTypeRefPtr, CFErrorRef * error);

CFDictionaryRef ____CFURLCopyResourcePropertiesForKeys(CFURLRef url, CFArrayRef keys, CFErrorRef * error);

Boolean ____CFURLSetResourcePropertyForKey(CFURLRef url, CFStringRef key, CFTypeRef propertyValue, CFErrorRef * error);

Boolean ____CFURLSetResourcePropertiesForKeys(CFURLRef url, CFDictionaryRef keyedPropertyValues, CFErrorRef * error);

void ____CFURLClearResourcePropertyCacheForKey(CFURLRef url, CFStringRef key);

void ____CFURLClearResourcePropertyCache(CFURLRef url);

void ____CFURLSetTemporaryResourcePropertyForKey(CFURLRef url, CFStringRef key, CFTypeRef propertyValue);

Boolean ____CFURLResourceIsReachable(CFURLRef url, CFErrorRef * error);

CFDataRef ____CFURLCreateBookmarkData(CFAllocatorRef allocator, CFURLRef url, CFURLBookmarkCreationOptions options, CFArrayRef resourcePropertiesToInclude, CFURLRef relativeToURL, CFErrorRef * error);

CFURLRef ____CFURLCreateByResolvingBookmarkData(CFAllocatorRef allocator, CFDataRef bookmark, CFURLBookmarkResolutionOptions options, CFURLRef relativeToURL, CFArrayRef resourcePropertiesToInclude, Boolean * isStale, CFErrorRef * error);

CFDictionaryRef ____CFURLCreateResourcePropertiesForKeysFromBookmarkData(CFAllocatorRef allocator, CFArrayRef resourcePropertiesToReturn, CFDataRef bookmark);

CFTypeRef ____CFURLCreateResourcePropertyForKeyFromBookmarkData(CFAllocatorRef allocator, CFStringRef resourcePropertyKey, CFDataRef bookmark);

CFDataRef ____CFURLCreateBookmarkDataFromFile(CFAllocatorRef allocator, CFURLRef fileURL, CFErrorRef * errorRef);

Boolean ____CFURLWriteBookmarkDataToFile(CFDataRef bookmarkRef, CFURLRef fileURL, CFURLBookmarkFileCreationOptions options, CFErrorRef * errorRef);

Boolean ____CFURLStartAccessingSecurityScopedResource(CFURLRef url);

void ____CFURLStopAccessingSecurityScopedResource(CFURLRef url);

CFTypeID (*original_CFURLGetTypeID)();
CFURLRef (*original_CFURLCreateWithBytes)(CFAllocatorRef, const UInt8 *, CFIndex, CFStringEncoding, CFURLRef);
CFDataRef (*original_CFURLCreateData)(CFAllocatorRef, CFURLRef, CFStringEncoding, Boolean);
CFURLRef (*original_CFURLCreateWithString)(CFAllocatorRef, CFStringRef, CFURLRef);
CFURLRef (*original_CFURLCreateAbsoluteURLWithBytes)(CFAllocatorRef, const UInt8 *, CFIndex, CFStringEncoding, CFURLRef, Boolean);
CFURLRef (*original_CFURLCreateWithFileSystemPath)(CFAllocatorRef, CFStringRef, CFURLPathStyle, Boolean);
CFURLRef (*original_CFURLCreateFromFileSystemRepresentation)(CFAllocatorRef, const UInt8 *, CFIndex, Boolean);
CFURLRef (*original_CFURLCreateWithFileSystemPathRelativeToBase)(CFAllocatorRef, CFStringRef, CFURLPathStyle, Boolean, CFURLRef);
CFURLRef (*original_CFURLCreateFromFileSystemRepresentationRelativeToBase)(CFAllocatorRef, const UInt8 *, CFIndex, Boolean, CFURLRef);
Boolean (*original_CFURLGetFileSystemRepresentation)(CFURLRef, Boolean, UInt8 *, CFIndex);
CFStringRef (*original_CFURLGetString)(CFURLRef);
CFURLRef (*original_CFURLGetBaseURL)(CFURLRef);
Boolean (*original_CFURLCanBeDecomposed)(CFURLRef);
CFStringRef (*original_CFURLCopyScheme)(CFURLRef);
CFStringRef (*original_CFURLCopyNetLocation)(CFURLRef);
CFStringRef (*original_CFURLCopyPath)(CFURLRef);
CFStringRef (*original_CFURLCopyStrictPath)(CFURLRef, Boolean *);
CFStringRef (*original_CFURLCopyFileSystemPath)(CFURLRef, CFURLPathStyle);
Boolean (*original_CFURLHasDirectoryPath)(CFURLRef);
CFStringRef (*original_CFURLCopyResourceSpecifier)(CFURLRef);
CFStringRef (*original_CFURLCopyHostName)(CFURLRef);
SInt32 (*original_CFURLGetPortNumber)(CFURLRef);
CFStringRef (*original_CFURLCopyUserName)(CFURLRef);
CFStringRef (*original_CFURLCopyPassword)(CFURLRef);
CFStringRef (*original_CFURLCopyParameterString)(CFURLRef, CFStringRef);
CFStringRef (*original_CFURLCopyQueryString)(CFURLRef, CFStringRef);
CFStringRef (*original_CFURLCopyFragment)(CFURLRef, CFStringRef);
CFStringRef (*original_CFURLCopyLastPathComponent)(CFURLRef);
CFStringRef (*original_CFURLCopyPathExtension)(CFURLRef);
CFURLRef (*original_CFURLCreateCopyAppendingPathComponent)(CFAllocatorRef, CFURLRef, CFStringRef, Boolean);
CFURLRef (*original_CFURLCreateCopyDeletingLastPathComponent)(CFAllocatorRef, CFURLRef);
CFURLRef (*original_CFURLCreateCopyAppendingPathExtension)(CFAllocatorRef, CFURLRef, CFStringRef);
CFURLRef (*original_CFURLCreateCopyDeletingPathExtension)(CFAllocatorRef, CFURLRef);
CFIndex (*original_CFURLGetBytes)(CFURLRef, UInt8 *, CFIndex);
CFRange (*original_CFURLGetByteRangeForComponent)(CFURLRef, CFURLComponentType, CFRange *);
CFStringRef (*original_CFURLCreateStringByReplacingPercentEscapes)(CFAllocatorRef, CFStringRef, CFStringRef);
CFStringRef (*original_CFURLCreateStringByReplacingPercentEscapesUsingEncoding)(CFAllocatorRef, CFStringRef, CFStringRef, CFStringEncoding);
CFStringRef (*original_CFURLCreateStringByAddingPercentEscapes)(CFAllocatorRef, CFStringRef, CFStringRef, CFStringRef, CFStringEncoding);
Boolean (*original_CFURLIsFileReferenceURL)(CFURLRef);
CFURLRef (*original_CFURLCreateFileReferenceURL)(CFAllocatorRef, CFURLRef, CFErrorRef *);
CFURLRef (*original_CFURLCreateFilePathURL)(CFAllocatorRef, CFURLRef, CFErrorRef *);
Boolean (*original_CFURLCopyResourcePropertyForKey)(CFURLRef, CFStringRef, void *, CFErrorRef *);
CFDictionaryRef (*original_CFURLCopyResourcePropertiesForKeys)(CFURLRef, CFArrayRef, CFErrorRef *);
Boolean (*original_CFURLSetResourcePropertyForKey)(CFURLRef, CFStringRef, CFTypeRef, CFErrorRef *);
Boolean (*original_CFURLSetResourcePropertiesForKeys)(CFURLRef, CFDictionaryRef, CFErrorRef *);
void (*original_CFURLClearResourcePropertyCacheForKey)(CFURLRef, CFStringRef);
void (*original_CFURLClearResourcePropertyCache)(CFURLRef);
void (*original_CFURLSetTemporaryResourcePropertyForKey)(CFURLRef, CFStringRef, CFTypeRef);
Boolean (*original_CFURLResourceIsReachable)(CFURLRef, CFErrorRef *);
CFDataRef (*original_CFURLCreateBookmarkData)(CFAllocatorRef, CFURLRef, CFURLBookmarkCreationOptions, CFArrayRef, CFURLRef, CFErrorRef *);
CFURLRef (*original_CFURLCreateByResolvingBookmarkData)(CFAllocatorRef, CFDataRef, CFURLBookmarkResolutionOptions, CFURLRef, CFArrayRef, Boolean *, CFErrorRef *);
CFDictionaryRef (*original_CFURLCreateResourcePropertiesForKeysFromBookmarkData)(CFAllocatorRef, CFArrayRef, CFDataRef);
CFTypeRef (*original_CFURLCreateResourcePropertyForKeyFromBookmarkData)(CFAllocatorRef, CFStringRef, CFDataRef);
CFDataRef (*original_CFURLCreateBookmarkDataFromFile)(CFAllocatorRef, CFURLRef, CFErrorRef *);
Boolean (*original_CFURLWriteBookmarkDataToFile)(CFDataRef, CFURLRef, CFURLBookmarkFileCreationOptions, CFErrorRef *);
Boolean (*original_CFURLStartAccessingSecurityScopedResource)(CFURLRef);
void (*original_CFURLStopAccessingSecurityScopedResource)(CFURLRef);
__attribute__((constructor))
static void initialize() {
    dispatch_async(dispatch_get_main_queue(), ^ {
        MSHookFunction((void*)&CFURLGetTypeID, (void*)&____CFURLGetTypeID, (void**)&original_CFURLGetTypeID);
        MSHookFunction((void*)&CFURLCreateWithBytes, (void*)&____CFURLCreateWithBytes, (void**)&original_CFURLCreateWithBytes);
        MSHookFunction((void*)&CFURLCreateData, (void*)&____CFURLCreateData, (void**)&original_CFURLCreateData);
        MSHookFunction((void*)&CFURLCreateWithString, (void*)&____CFURLCreateWithString, (void**)&original_CFURLCreateWithString);
        MSHookFunction((void*)&CFURLCreateAbsoluteURLWithBytes, (void*)&____CFURLCreateAbsoluteURLWithBytes, (void**)&original_CFURLCreateAbsoluteURLWithBytes);
        MSHookFunction((void*)&CFURLCreateWithFileSystemPath, (void*)&____CFURLCreateWithFileSystemPath, (void**)&original_CFURLCreateWithFileSystemPath);
        MSHookFunction((void*)&CFURLCreateFromFileSystemRepresentation, (void*)&____CFURLCreateFromFileSystemRepresentation, (void**)&original_CFURLCreateFromFileSystemRepresentation);
        MSHookFunction((void*)&CFURLCreateWithFileSystemPathRelativeToBase, (void*)&____CFURLCreateWithFileSystemPathRelativeToBase, (void**)&original_CFURLCreateWithFileSystemPathRelativeToBase);
        MSHookFunction((void*)&CFURLCreateFromFileSystemRepresentationRelativeToBase, (void*)&____CFURLCreateFromFileSystemRepresentationRelativeToBase, (void**)&original_CFURLCreateFromFileSystemRepresentationRelativeToBase);
        MSHookFunction((void*)&CFURLGetFileSystemRepresentation, (void*)&____CFURLGetFileSystemRepresentation, (void**)&original_CFURLGetFileSystemRepresentation);
        MSHookFunction((void*)&CFURLGetString, (void*)&____CFURLGetString, (void**)&original_CFURLGetString);
        MSHookFunction((void*)&CFURLGetBaseURL, (void*)&____CFURLGetBaseURL, (void**)&original_CFURLGetBaseURL);
        MSHookFunction((void*)&CFURLCanBeDecomposed, (void*)&____CFURLCanBeDecomposed, (void**)&original_CFURLCanBeDecomposed);
        MSHookFunction((void*)&CFURLCopyScheme, (void*)&____CFURLCopyScheme, (void**)&original_CFURLCopyScheme);
        MSHookFunction((void*)&CFURLCopyNetLocation, (void*)&____CFURLCopyNetLocation, (void**)&original_CFURLCopyNetLocation);
        MSHookFunction((void*)&CFURLCopyPath, (void*)&____CFURLCopyPath, (void**)&original_CFURLCopyPath);
        MSHookFunction((void*)&CFURLCopyStrictPath, (void*)&____CFURLCopyStrictPath, (void**)&original_CFURLCopyStrictPath);
        MSHookFunction((void*)&CFURLCopyFileSystemPath, (void*)&____CFURLCopyFileSystemPath, (void**)&original_CFURLCopyFileSystemPath);
        MSHookFunction((void*)&CFURLHasDirectoryPath, (void*)&____CFURLHasDirectoryPath, (void**)&original_CFURLHasDirectoryPath);
        MSHookFunction((void*)&CFURLCopyResourceSpecifier, (void*)&____CFURLCopyResourceSpecifier, (void**)&original_CFURLCopyResourceSpecifier);
        MSHookFunction((void*)&CFURLCopyHostName, (void*)&____CFURLCopyHostName, (void**)&original_CFURLCopyHostName);
        MSHookFunction((void*)&CFURLGetPortNumber, (void*)&____CFURLGetPortNumber, (void**)&original_CFURLGetPortNumber);
        MSHookFunction((void*)&CFURLCopyUserName, (void*)&____CFURLCopyUserName, (void**)&original_CFURLCopyUserName);
        MSHookFunction((void*)&CFURLCopyPassword, (void*)&____CFURLCopyPassword, (void**)&original_CFURLCopyPassword);
        MSHookFunction((void*)&CFURLCopyParameterString, (void*)&____CFURLCopyParameterString, (void**)&original_CFURLCopyParameterString);
        MSHookFunction((void*)&CFURLCopyQueryString, (void*)&____CFURLCopyQueryString, (void**)&original_CFURLCopyQueryString);
        MSHookFunction((void*)&CFURLCopyFragment, (void*)&____CFURLCopyFragment, (void**)&original_CFURLCopyFragment);
        MSHookFunction((void*)&CFURLCopyLastPathComponent, (void*)&____CFURLCopyLastPathComponent, (void**)&original_CFURLCopyLastPathComponent);
        MSHookFunction((void*)&CFURLCopyPathExtension, (void*)&____CFURLCopyPathExtension, (void**)&original_CFURLCopyPathExtension);
        MSHookFunction((void*)&CFURLCreateCopyAppendingPathComponent, (void*)&____CFURLCreateCopyAppendingPathComponent, (void**)&original_CFURLCreateCopyAppendingPathComponent);
        MSHookFunction((void*)&CFURLCreateCopyDeletingLastPathComponent, (void*)&____CFURLCreateCopyDeletingLastPathComponent, (void**)&original_CFURLCreateCopyDeletingLastPathComponent);
        MSHookFunction((void*)&CFURLCreateCopyAppendingPathExtension, (void*)&____CFURLCreateCopyAppendingPathExtension, (void**)&original_CFURLCreateCopyAppendingPathExtension);
        MSHookFunction((void*)&CFURLCreateCopyDeletingPathExtension, (void*)&____CFURLCreateCopyDeletingPathExtension, (void**)&original_CFURLCreateCopyDeletingPathExtension);
        MSHookFunction((void*)&CFURLGetBytes, (void*)&____CFURLGetBytes, (void**)&original_CFURLGetBytes);
        MSHookFunction((void*)&CFURLGetByteRangeForComponent, (void*)&____CFURLGetByteRangeForComponent, (void**)&original_CFURLGetByteRangeForComponent);
        MSHookFunction((void*)&CFURLCreateStringByReplacingPercentEscapes, (void*)&____CFURLCreateStringByReplacingPercentEscapes, (void**)&original_CFURLCreateStringByReplacingPercentEscapes);
        MSHookFunction((void*)&CFURLCreateStringByReplacingPercentEscapesUsingEncoding, (void*)&____CFURLCreateStringByReplacingPercentEscapesUsingEncoding, (void**)&original_CFURLCreateStringByReplacingPercentEscapesUsingEncoding);
        MSHookFunction((void*)&CFURLCreateStringByAddingPercentEscapes, (void*)&____CFURLCreateStringByAddingPercentEscapes, (void**)&original_CFURLCreateStringByAddingPercentEscapes);
        MSHookFunction((void*)&CFURLIsFileReferenceURL, (void*)&____CFURLIsFileReferenceURL, (void**)&original_CFURLIsFileReferenceURL);
        MSHookFunction((void*)&CFURLCreateFileReferenceURL, (void*)&____CFURLCreateFileReferenceURL, (void**)&original_CFURLCreateFileReferenceURL);
        MSHookFunction((void*)&CFURLCreateFilePathURL, (void*)&____CFURLCreateFilePathURL, (void**)&original_CFURLCreateFilePathURL);
        MSHookFunction((void*)&CFURLCopyResourcePropertyForKey, (void*)&____CFURLCopyResourcePropertyForKey, (void**)&original_CFURLCopyResourcePropertyForKey);
        MSHookFunction((void*)&CFURLCopyResourcePropertiesForKeys, (void*)&____CFURLCopyResourcePropertiesForKeys, (void**)&original_CFURLCopyResourcePropertiesForKeys);
        MSHookFunction((void*)&CFURLSetResourcePropertyForKey, (void*)&____CFURLSetResourcePropertyForKey, (void**)&original_CFURLSetResourcePropertyForKey);
        MSHookFunction((void*)&CFURLSetResourcePropertiesForKeys, (void*)&____CFURLSetResourcePropertiesForKeys, (void**)&original_CFURLSetResourcePropertiesForKeys);
        MSHookFunction((void*)&CFURLClearResourcePropertyCacheForKey, (void*)&____CFURLClearResourcePropertyCacheForKey, (void**)&original_CFURLClearResourcePropertyCacheForKey);
        MSHookFunction((void*)&CFURLClearResourcePropertyCache, (void*)&____CFURLClearResourcePropertyCache, (void**)&original_CFURLClearResourcePropertyCache);
        MSHookFunction((void*)&CFURLSetTemporaryResourcePropertyForKey, (void*)&____CFURLSetTemporaryResourcePropertyForKey, (void**)&original_CFURLSetTemporaryResourcePropertyForKey);
        MSHookFunction((void*)&CFURLResourceIsReachable, (void*)&____CFURLResourceIsReachable, (void**)&original_CFURLResourceIsReachable);
        MSHookFunction((void*)&CFURLCreateBookmarkData, (void*)&____CFURLCreateBookmarkData, (void**)&original_CFURLCreateBookmarkData);
        MSHookFunction((void*)&CFURLCreateByResolvingBookmarkData, (void*)&____CFURLCreateByResolvingBookmarkData, (void**)&original_CFURLCreateByResolvingBookmarkData);
        MSHookFunction((void*)&CFURLCreateResourcePropertiesForKeysFromBookmarkData, (void*)&____CFURLCreateResourcePropertiesForKeysFromBookmarkData, (void**)&original_CFURLCreateResourcePropertiesForKeysFromBookmarkData);
        MSHookFunction((void*)&CFURLCreateResourcePropertyForKeyFromBookmarkData, (void*)&____CFURLCreateResourcePropertyForKeyFromBookmarkData, (void**)&original_CFURLCreateResourcePropertyForKeyFromBookmarkData);
        MSHookFunction((void*)&CFURLCreateBookmarkDataFromFile, (void*)&____CFURLCreateBookmarkDataFromFile, (void**)&original_CFURLCreateBookmarkDataFromFile);
        MSHookFunction((void*)&CFURLWriteBookmarkDataToFile, (void*)&____CFURLWriteBookmarkDataToFile, (void**)&original_CFURLWriteBookmarkDataToFile);
        MSHookFunction((void*)&CFURLStartAccessingSecurityScopedResource, (void*)&____CFURLStartAccessingSecurityScopedResource, (void**)&original_CFURLStartAccessingSecurityScopedResource);
        MSHookFunction((void*)&CFURLStopAccessingSecurityScopedResource, (void*)&____CFURLStopAccessingSecurityScopedResource, (void**)&original_CFURLStopAccessingSecurityScopedResource);
    });
}

__attribute__((constructor))
static void constructor() {
}
CFTypeID ____CFURLGetTypeID()
{
    if (!is_enabled() || !enabled_) {
        CFTypeID return_value = original_CFURLGetTypeID();
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLGetTypeID", "0x0", NULL, 0);
            for(unsigned int i = 0; i < 0; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 0; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    CFTypeID return_value = original_CFURLGetTypeID();
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFTypeID", MAX_TYPE_LENGTH);
    snprintf(return_param.value, MAX_VALUE_LENGTH, "%d", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


CFURLRef ____CFURLCreateWithBytes(CFAllocatorRef allocator, const UInt8 * URLBytes, CFIndex length, CFStringEncoding encoding, CFURLRef baseURL)
{
    if (!is_enabled() || !enabled_) {
        CFURLRef return_value = original_CFURLCreateWithBytes(allocator, URLBytes, length, encoding, baseURL);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(5, sizeof(parameter_t));
//Parse parameter allocator
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)allocator);
//Parse parameter URLBytes
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "^UInt8", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (register_t)URLBytes);
//Parse parameter length
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFIndex", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "%d", (int)length);
//Parse parameter encoding
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "CFStringEncoding", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "%d", (int)encoding);
//Parse parameter baseURL
    parameters[4].description = NULL;
    strncpy(parameters[4].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[4].value, MAX_VALUE_LENGTH, "0x%X", (int)baseURL);
    if(baseURL) {
        CFStringRef baseURL_description = CFCopyDescription(baseURL);
        parameters[4].description = (char*)calloc(CFStringGetLength(baseURL_description) + 1, sizeof(char));
        memcpy(parameters[4].description, CFStringGetCStringPtr(baseURL_description, kCFStringEncodingUTF8), CFStringGetLength(baseURL_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLCreateWithBytes", "0x0", parameters, 5);
            for(unsigned int i = 0; i < 5; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 5; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    CFURLRef return_value = original_CFURLCreateWithBytes(allocator, URLBytes, length, encoding, baseURL);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFURLRef", MAX_TYPE_LENGTH);
    if(return_value) {
        CFStringRef return_value_description = CFCopyDescription(return_value);
        return_param.description = (char*)calloc(CFStringGetLength(return_value_description) + 1, sizeof(char));
        memcpy(return_param.description, CFStringGetCStringPtr(return_value_description, kCFStringEncodingUTF8), CFStringGetLength(return_value_description));
    }
    snprintf(return_param.value, MAX_VALUE_LENGTH, "0x%X", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


CFDataRef ____CFURLCreateData(CFAllocatorRef allocator, CFURLRef url, CFStringEncoding encoding, Boolean escapeWhitespace)
{
    if (!is_enabled() || !enabled_) {
        CFDataRef return_value = original_CFURLCreateData(allocator, url, encoding, escapeWhitespace);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(4, sizeof(parameter_t));
//Parse parameter allocator
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)allocator);
//Parse parameter url
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)url);
    if(url) {
        CFStringRef url_description = CFCopyDescription(url);
        parameters[1].description = (char*)calloc(CFStringGetLength(url_description) + 1, sizeof(char));
        memcpy(parameters[1].description, CFStringGetCStringPtr(url_description, kCFStringEncodingUTF8), CFStringGetLength(url_description));
    }
//Parse parameter encoding
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFStringEncoding", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "%d", (int)encoding);
//Parse parameter escapeWhitespace
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "Boolean", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "%d", (int)escapeWhitespace);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLCreateData", "0x0", parameters, 4);
            for(unsigned int i = 0; i < 4; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 4; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    CFDataRef return_value = original_CFURLCreateData(allocator, url, encoding, escapeWhitespace);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFDataRef", MAX_TYPE_LENGTH);
    if(return_value) {
        CFStringRef return_value_description = CFCopyDescription(return_value);
        return_param.description = (char*)calloc(CFStringGetLength(return_value_description) + 1, sizeof(char));
        memcpy(return_param.description, CFStringGetCStringPtr(return_value_description, kCFStringEncodingUTF8), CFStringGetLength(return_value_description));
    }
    snprintf(return_param.value, MAX_VALUE_LENGTH, "0x%X", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


CFURLRef ____CFURLCreateWithString(CFAllocatorRef allocator, CFStringRef URLString, CFURLRef baseURL)
{
    if (!is_enabled() || !enabled_) {
        CFURLRef return_value = original_CFURLCreateWithString(allocator, URLString, baseURL);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(3, sizeof(parameter_t));
//Parse parameter allocator
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)allocator);
//Parse parameter URLString
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)URLString);
    if(URLString) {
        parameters[1].description = (char*)calloc(CFStringGetLength(URLString)+1, sizeof(char));
        CFStringGetCString(URLString, parameters[1].description, CFStringGetLength(URLString) + 1, kCFStringEncodingUTF8);
    }
//Parse parameter baseURL
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (int)baseURL);
    if(baseURL) {
        CFStringRef baseURL_description = CFCopyDescription(baseURL);
        parameters[2].description = (char*)calloc(CFStringGetLength(baseURL_description) + 1, sizeof(char));
        memcpy(parameters[2].description, CFStringGetCStringPtr(baseURL_description, kCFStringEncodingUTF8), CFStringGetLength(baseURL_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLCreateWithString", "0x0", parameters, 3);
            for(unsigned int i = 0; i < 3; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 3; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    CFURLRef return_value = original_CFURLCreateWithString(allocator, URLString, baseURL);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFURLRef", MAX_TYPE_LENGTH);
    if(return_value) {
        CFStringRef return_value_description = CFCopyDescription(return_value);
        return_param.description = (char*)calloc(CFStringGetLength(return_value_description) + 1, sizeof(char));
        memcpy(return_param.description, CFStringGetCStringPtr(return_value_description, kCFStringEncodingUTF8), CFStringGetLength(return_value_description));
    }
    snprintf(return_param.value, MAX_VALUE_LENGTH, "0x%X", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


CFURLRef ____CFURLCreateAbsoluteURLWithBytes(CFAllocatorRef alloc, const UInt8 * relativeURLBytes, CFIndex length, CFStringEncoding encoding, CFURLRef baseURL, Boolean useCompatibilityMode)
{
    if (!is_enabled() || !enabled_) {
        CFURLRef return_value = original_CFURLCreateAbsoluteURLWithBytes(alloc, relativeURLBytes, length, encoding, baseURL, useCompatibilityMode);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(6, sizeof(parameter_t));
//Parse parameter alloc
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)alloc);
//Parse parameter relativeURLBytes
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "^UInt8", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (register_t)relativeURLBytes);
//Parse parameter length
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFIndex", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "%d", (int)length);
//Parse parameter encoding
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "CFStringEncoding", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "%d", (int)encoding);
//Parse parameter baseURL
    parameters[4].description = NULL;
    strncpy(parameters[4].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[4].value, MAX_VALUE_LENGTH, "0x%X", (int)baseURL);
    if(baseURL) {
        CFStringRef baseURL_description = CFCopyDescription(baseURL);
        parameters[4].description = (char*)calloc(CFStringGetLength(baseURL_description) + 1, sizeof(char));
        memcpy(parameters[4].description, CFStringGetCStringPtr(baseURL_description, kCFStringEncodingUTF8), CFStringGetLength(baseURL_description));
    }
//Parse parameter useCompatibilityMode
    parameters[5].description = NULL;
    strncpy(parameters[5].type, "Boolean", MAX_TYPE_LENGTH);
    snprintf(parameters[5].value, MAX_VALUE_LENGTH, "%d", (int)useCompatibilityMode);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLCreateAbsoluteURLWithBytes", "0x0", parameters, 6);
            for(unsigned int i = 0; i < 6; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 6; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    CFURLRef return_value = original_CFURLCreateAbsoluteURLWithBytes(alloc, relativeURLBytes, length, encoding, baseURL, useCompatibilityMode);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFURLRef", MAX_TYPE_LENGTH);
    if(return_value) {
        CFStringRef return_value_description = CFCopyDescription(return_value);
        return_param.description = (char*)calloc(CFStringGetLength(return_value_description) + 1, sizeof(char));
        memcpy(return_param.description, CFStringGetCStringPtr(return_value_description, kCFStringEncodingUTF8), CFStringGetLength(return_value_description));
    }
    snprintf(return_param.value, MAX_VALUE_LENGTH, "0x%X", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


CFURLRef ____CFURLCreateWithFileSystemPath(CFAllocatorRef allocator, CFStringRef filePath, CFURLPathStyle pathStyle, Boolean isDirectory)
{
    if (!is_enabled() || !enabled_) {
        CFURLRef return_value = original_CFURLCreateWithFileSystemPath(allocator, filePath, pathStyle, isDirectory);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(4, sizeof(parameter_t));
//Parse parameter allocator
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)allocator);
//Parse parameter filePath
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)filePath);
    if(filePath) {
        parameters[1].description = (char*)calloc(CFStringGetLength(filePath)+1, sizeof(char));
        CFStringGetCString(filePath, parameters[1].description, CFStringGetLength(filePath) + 1, kCFStringEncodingUTF8);
    }
//Parse parameter pathStyle
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFURLPathStyle", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "%d", (int)pathStyle);
//Parse parameter isDirectory
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "Boolean", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "%d", (int)isDirectory);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLCreateWithFileSystemPath", "0x0", parameters, 4);
            for(unsigned int i = 0; i < 4; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 4; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    CFURLRef return_value = original_CFURLCreateWithFileSystemPath(allocator, filePath, pathStyle, isDirectory);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFURLRef", MAX_TYPE_LENGTH);
    if(return_value) {
        CFStringRef return_value_description = CFCopyDescription(return_value);
        return_param.description = (char*)calloc(CFStringGetLength(return_value_description) + 1, sizeof(char));
        memcpy(return_param.description, CFStringGetCStringPtr(return_value_description, kCFStringEncodingUTF8), CFStringGetLength(return_value_description));
    }
    snprintf(return_param.value, MAX_VALUE_LENGTH, "0x%X", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


CFURLRef ____CFURLCreateFromFileSystemRepresentation(CFAllocatorRef allocator, const UInt8 * buffer, CFIndex bufLen, Boolean isDirectory)
{
    if (!is_enabled() || !enabled_) {
        CFURLRef return_value = original_CFURLCreateFromFileSystemRepresentation(allocator, buffer, bufLen, isDirectory);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(4, sizeof(parameter_t));
//Parse parameter allocator
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)allocator);
//Parse parameter buffer
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "^UInt8", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (register_t)buffer);
//Parse parameter bufLen
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFIndex", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "%d", (int)bufLen);
//Parse parameter isDirectory
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "Boolean", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "%d", (int)isDirectory);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLCreateFromFileSystemRepresentation", "0x0", parameters, 4);
            for(unsigned int i = 0; i < 4; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 4; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    CFURLRef return_value = original_CFURLCreateFromFileSystemRepresentation(allocator, buffer, bufLen, isDirectory);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFURLRef", MAX_TYPE_LENGTH);
    if(return_value) {
        CFStringRef return_value_description = CFCopyDescription(return_value);
        return_param.description = (char*)calloc(CFStringGetLength(return_value_description) + 1, sizeof(char));
        memcpy(return_param.description, CFStringGetCStringPtr(return_value_description, kCFStringEncodingUTF8), CFStringGetLength(return_value_description));
    }
    snprintf(return_param.value, MAX_VALUE_LENGTH, "0x%X", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


CFURLRef ____CFURLCreateWithFileSystemPathRelativeToBase(CFAllocatorRef allocator, CFStringRef filePath, CFURLPathStyle pathStyle, Boolean isDirectory, CFURLRef baseURL)
{
    if (!is_enabled() || !enabled_) {
        CFURLRef return_value = original_CFURLCreateWithFileSystemPathRelativeToBase(allocator, filePath, pathStyle, isDirectory, baseURL);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(5, sizeof(parameter_t));
//Parse parameter allocator
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)allocator);
//Parse parameter filePath
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)filePath);
    if(filePath) {
        parameters[1].description = (char*)calloc(CFStringGetLength(filePath)+1, sizeof(char));
        CFStringGetCString(filePath, parameters[1].description, CFStringGetLength(filePath) + 1, kCFStringEncodingUTF8);
    }
//Parse parameter pathStyle
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFURLPathStyle", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "%d", (int)pathStyle);
//Parse parameter isDirectory
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "Boolean", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "%d", (int)isDirectory);
//Parse parameter baseURL
    parameters[4].description = NULL;
    strncpy(parameters[4].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[4].value, MAX_VALUE_LENGTH, "0x%X", (int)baseURL);
    if(baseURL) {
        CFStringRef baseURL_description = CFCopyDescription(baseURL);
        parameters[4].description = (char*)calloc(CFStringGetLength(baseURL_description) + 1, sizeof(char));
        memcpy(parameters[4].description, CFStringGetCStringPtr(baseURL_description, kCFStringEncodingUTF8), CFStringGetLength(baseURL_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLCreateWithFileSystemPathRelativeToBase", "0x0", parameters, 5);
            for(unsigned int i = 0; i < 5; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 5; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    CFURLRef return_value = original_CFURLCreateWithFileSystemPathRelativeToBase(allocator, filePath, pathStyle, isDirectory, baseURL);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFURLRef", MAX_TYPE_LENGTH);
    if(return_value) {
        CFStringRef return_value_description = CFCopyDescription(return_value);
        return_param.description = (char*)calloc(CFStringGetLength(return_value_description) + 1, sizeof(char));
        memcpy(return_param.description, CFStringGetCStringPtr(return_value_description, kCFStringEncodingUTF8), CFStringGetLength(return_value_description));
    }
    snprintf(return_param.value, MAX_VALUE_LENGTH, "0x%X", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


CFURLRef ____CFURLCreateFromFileSystemRepresentationRelativeToBase(CFAllocatorRef allocator, const UInt8 * buffer, CFIndex bufLen, Boolean isDirectory, CFURLRef baseURL)
{
    if (!is_enabled() || !enabled_) {
        CFURLRef return_value = original_CFURLCreateFromFileSystemRepresentationRelativeToBase(allocator, buffer, bufLen, isDirectory, baseURL);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(5, sizeof(parameter_t));
//Parse parameter allocator
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)allocator);
//Parse parameter buffer
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "^UInt8", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (register_t)buffer);
//Parse parameter bufLen
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFIndex", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "%d", (int)bufLen);
//Parse parameter isDirectory
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "Boolean", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "%d", (int)isDirectory);
//Parse parameter baseURL
    parameters[4].description = NULL;
    strncpy(parameters[4].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[4].value, MAX_VALUE_LENGTH, "0x%X", (int)baseURL);
    if(baseURL) {
        CFStringRef baseURL_description = CFCopyDescription(baseURL);
        parameters[4].description = (char*)calloc(CFStringGetLength(baseURL_description) + 1, sizeof(char));
        memcpy(parameters[4].description, CFStringGetCStringPtr(baseURL_description, kCFStringEncodingUTF8), CFStringGetLength(baseURL_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLCreateFromFileSystemRepresentationRelativeToBase", "0x0", parameters, 5);
            for(unsigned int i = 0; i < 5; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 5; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    CFURLRef return_value = original_CFURLCreateFromFileSystemRepresentationRelativeToBase(allocator, buffer, bufLen, isDirectory, baseURL);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFURLRef", MAX_TYPE_LENGTH);
    if(return_value) {
        CFStringRef return_value_description = CFCopyDescription(return_value);
        return_param.description = (char*)calloc(CFStringGetLength(return_value_description) + 1, sizeof(char));
        memcpy(return_param.description, CFStringGetCStringPtr(return_value_description, kCFStringEncodingUTF8), CFStringGetLength(return_value_description));
    }
    snprintf(return_param.value, MAX_VALUE_LENGTH, "0x%X", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


Boolean ____CFURLGetFileSystemRepresentation(CFURLRef url, Boolean resolveAgainstBase, UInt8 * buffer, CFIndex maxBufLen)
{
    if (!is_enabled() || !enabled_) {
        Boolean return_value = original_CFURLGetFileSystemRepresentation(url, resolveAgainstBase, buffer, maxBufLen);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(4, sizeof(parameter_t));
//Parse parameter url
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)url);
    if(url) {
        CFStringRef url_description = CFCopyDescription(url);
        parameters[0].description = (char*)calloc(CFStringGetLength(url_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(url_description, kCFStringEncodingUTF8), CFStringGetLength(url_description));
    }
//Parse parameter resolveAgainstBase
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "Boolean", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "%d", (int)resolveAgainstBase);
//Parse parameter buffer
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "^UInt8", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (register_t)buffer);
//Parse parameter maxBufLen
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "CFIndex", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "%d", (int)maxBufLen);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLGetFileSystemRepresentation", "0x0", parameters, 4);
            for(unsigned int i = 0; i < 4; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 4; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    Boolean return_value = original_CFURLGetFileSystemRepresentation(url, resolveAgainstBase, buffer, maxBufLen);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "Boolean", MAX_TYPE_LENGTH);
    snprintf(return_param.value, MAX_VALUE_LENGTH, "%d", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


CFStringRef ____CFURLGetString(CFURLRef anURL)
{
    if (!is_enabled() || !enabled_) {
        CFStringRef return_value = original_CFURLGetString(anURL);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(1, sizeof(parameter_t));
//Parse parameter anURL
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)anURL);
    if(anURL) {
        CFStringRef anURL_description = CFCopyDescription(anURL);
        parameters[0].description = (char*)calloc(CFStringGetLength(anURL_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(anURL_description, kCFStringEncodingUTF8), CFStringGetLength(anURL_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLGetString", "0x0", parameters, 1);
            for(unsigned int i = 0; i < 1; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 1; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    CFStringRef return_value = original_CFURLGetString(anURL);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFStringRef", MAX_TYPE_LENGTH);
    if(return_value) {
        return_param.description = (char*)calloc(CFStringGetLength(return_value)+1, sizeof(char));
        CFStringGetCString(return_value, return_param.description, CFStringGetLength(return_value) + 1, kCFStringEncodingUTF8);
    }
    snprintf(return_param.value, MAX_VALUE_LENGTH, "0x%X", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


CFURLRef ____CFURLGetBaseURL(CFURLRef anURL)
{
    if (!is_enabled() || !enabled_) {
        CFURLRef return_value = original_CFURLGetBaseURL(anURL);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(1, sizeof(parameter_t));
//Parse parameter anURL
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)anURL);
    if(anURL) {
        CFStringRef anURL_description = CFCopyDescription(anURL);
        parameters[0].description = (char*)calloc(CFStringGetLength(anURL_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(anURL_description, kCFStringEncodingUTF8), CFStringGetLength(anURL_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLGetBaseURL", "0x0", parameters, 1);
            for(unsigned int i = 0; i < 1; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 1; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    CFURLRef return_value = original_CFURLGetBaseURL(anURL);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFURLRef", MAX_TYPE_LENGTH);
    if(return_value) {
        CFStringRef return_value_description = CFCopyDescription(return_value);
        return_param.description = (char*)calloc(CFStringGetLength(return_value_description) + 1, sizeof(char));
        memcpy(return_param.description, CFStringGetCStringPtr(return_value_description, kCFStringEncodingUTF8), CFStringGetLength(return_value_description));
    }
    snprintf(return_param.value, MAX_VALUE_LENGTH, "0x%X", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


Boolean ____CFURLCanBeDecomposed(CFURLRef anURL)
{
    if (!is_enabled() || !enabled_) {
        Boolean return_value = original_CFURLCanBeDecomposed(anURL);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(1, sizeof(parameter_t));
//Parse parameter anURL
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)anURL);
    if(anURL) {
        CFStringRef anURL_description = CFCopyDescription(anURL);
        parameters[0].description = (char*)calloc(CFStringGetLength(anURL_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(anURL_description, kCFStringEncodingUTF8), CFStringGetLength(anURL_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLCanBeDecomposed", "0x0", parameters, 1);
            for(unsigned int i = 0; i < 1; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 1; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    Boolean return_value = original_CFURLCanBeDecomposed(anURL);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "Boolean", MAX_TYPE_LENGTH);
    snprintf(return_param.value, MAX_VALUE_LENGTH, "%d", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


CFStringRef ____CFURLCopyScheme(CFURLRef anURL)
{
    if (!is_enabled() || !enabled_) {
        CFStringRef return_value = original_CFURLCopyScheme(anURL);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(1, sizeof(parameter_t));
//Parse parameter anURL
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)anURL);
    if(anURL) {
        CFStringRef anURL_description = CFCopyDescription(anURL);
        parameters[0].description = (char*)calloc(CFStringGetLength(anURL_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(anURL_description, kCFStringEncodingUTF8), CFStringGetLength(anURL_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLCopyScheme", "0x0", parameters, 1);
            for(unsigned int i = 0; i < 1; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 1; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    CFStringRef return_value = original_CFURLCopyScheme(anURL);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFStringRef", MAX_TYPE_LENGTH);
    if(return_value) {
        return_param.description = (char*)calloc(CFStringGetLength(return_value)+1, sizeof(char));
        CFStringGetCString(return_value, return_param.description, CFStringGetLength(return_value) + 1, kCFStringEncodingUTF8);
    }
    snprintf(return_param.value, MAX_VALUE_LENGTH, "0x%X", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


CFStringRef ____CFURLCopyNetLocation(CFURLRef anURL)
{
    if (!is_enabled() || !enabled_) {
        CFStringRef return_value = original_CFURLCopyNetLocation(anURL);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(1, sizeof(parameter_t));
//Parse parameter anURL
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)anURL);
    if(anURL) {
        CFStringRef anURL_description = CFCopyDescription(anURL);
        parameters[0].description = (char*)calloc(CFStringGetLength(anURL_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(anURL_description, kCFStringEncodingUTF8), CFStringGetLength(anURL_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLCopyNetLocation", "0x0", parameters, 1);
            for(unsigned int i = 0; i < 1; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 1; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    CFStringRef return_value = original_CFURLCopyNetLocation(anURL);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFStringRef", MAX_TYPE_LENGTH);
    if(return_value) {
        return_param.description = (char*)calloc(CFStringGetLength(return_value)+1, sizeof(char));
        CFStringGetCString(return_value, return_param.description, CFStringGetLength(return_value) + 1, kCFStringEncodingUTF8);
    }
    snprintf(return_param.value, MAX_VALUE_LENGTH, "0x%X", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


CFStringRef ____CFURLCopyPath(CFURLRef anURL)
{
    if (!is_enabled() || !enabled_) {
        CFStringRef return_value = original_CFURLCopyPath(anURL);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(1, sizeof(parameter_t));
//Parse parameter anURL
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)anURL);
    if(anURL) {
        CFStringRef anURL_description = CFCopyDescription(anURL);
        parameters[0].description = (char*)calloc(CFStringGetLength(anURL_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(anURL_description, kCFStringEncodingUTF8), CFStringGetLength(anURL_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLCopyPath", "0x0", parameters, 1);
            for(unsigned int i = 0; i < 1; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 1; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    CFStringRef return_value = original_CFURLCopyPath(anURL);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFStringRef", MAX_TYPE_LENGTH);
    if(return_value) {
        return_param.description = (char*)calloc(CFStringGetLength(return_value)+1, sizeof(char));
        CFStringGetCString(return_value, return_param.description, CFStringGetLength(return_value) + 1, kCFStringEncodingUTF8);
    }
    snprintf(return_param.value, MAX_VALUE_LENGTH, "0x%X", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


CFStringRef ____CFURLCopyStrictPath(CFURLRef anURL, Boolean * isAbsolute)
{
    if (!is_enabled() || !enabled_) {
        CFStringRef return_value = original_CFURLCopyStrictPath(anURL, isAbsolute);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(2, sizeof(parameter_t));
//Parse parameter anURL
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)anURL);
    if(anURL) {
        CFStringRef anURL_description = CFCopyDescription(anURL);
        parameters[0].description = (char*)calloc(CFStringGetLength(anURL_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(anURL_description, kCFStringEncodingUTF8), CFStringGetLength(anURL_description));
    }
//Parse parameter isAbsolute
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "^Boolean", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (register_t)isAbsolute);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLCopyStrictPath", "0x0", parameters, 2);
            for(unsigned int i = 0; i < 2; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 2; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    CFStringRef return_value = original_CFURLCopyStrictPath(anURL, isAbsolute);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFStringRef", MAX_TYPE_LENGTH);
    if(return_value) {
        return_param.description = (char*)calloc(CFStringGetLength(return_value)+1, sizeof(char));
        CFStringGetCString(return_value, return_param.description, CFStringGetLength(return_value) + 1, kCFStringEncodingUTF8);
    }
    snprintf(return_param.value, MAX_VALUE_LENGTH, "0x%X", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


CFStringRef ____CFURLCopyFileSystemPath(CFURLRef anURL, CFURLPathStyle pathStyle)
{
    if (!is_enabled() || !enabled_) {
        CFStringRef return_value = original_CFURLCopyFileSystemPath(anURL, pathStyle);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(2, sizeof(parameter_t));
//Parse parameter anURL
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)anURL);
    if(anURL) {
        CFStringRef anURL_description = CFCopyDescription(anURL);
        parameters[0].description = (char*)calloc(CFStringGetLength(anURL_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(anURL_description, kCFStringEncodingUTF8), CFStringGetLength(anURL_description));
    }
//Parse parameter pathStyle
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFURLPathStyle", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "%d", (int)pathStyle);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLCopyFileSystemPath", "0x0", parameters, 2);
            for(unsigned int i = 0; i < 2; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 2; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    CFStringRef return_value = original_CFURLCopyFileSystemPath(anURL, pathStyle);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFStringRef", MAX_TYPE_LENGTH);
    if(return_value) {
        return_param.description = (char*)calloc(CFStringGetLength(return_value)+1, sizeof(char));
        CFStringGetCString(return_value, return_param.description, CFStringGetLength(return_value) + 1, kCFStringEncodingUTF8);
    }
    snprintf(return_param.value, MAX_VALUE_LENGTH, "0x%X", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


Boolean ____CFURLHasDirectoryPath(CFURLRef anURL)
{
    if (!is_enabled() || !enabled_) {
        Boolean return_value = original_CFURLHasDirectoryPath(anURL);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(1, sizeof(parameter_t));
//Parse parameter anURL
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)anURL);
    if(anURL) {
        CFStringRef anURL_description = CFCopyDescription(anURL);
        parameters[0].description = (char*)calloc(CFStringGetLength(anURL_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(anURL_description, kCFStringEncodingUTF8), CFStringGetLength(anURL_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLHasDirectoryPath", "0x0", parameters, 1);
            for(unsigned int i = 0; i < 1; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 1; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    Boolean return_value = original_CFURLHasDirectoryPath(anURL);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "Boolean", MAX_TYPE_LENGTH);
    snprintf(return_param.value, MAX_VALUE_LENGTH, "%d", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


CFStringRef ____CFURLCopyResourceSpecifier(CFURLRef anURL)
{
    if (!is_enabled() || !enabled_) {
        CFStringRef return_value = original_CFURLCopyResourceSpecifier(anURL);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(1, sizeof(parameter_t));
//Parse parameter anURL
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)anURL);
    if(anURL) {
        CFStringRef anURL_description = CFCopyDescription(anURL);
        parameters[0].description = (char*)calloc(CFStringGetLength(anURL_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(anURL_description, kCFStringEncodingUTF8), CFStringGetLength(anURL_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLCopyResourceSpecifier", "0x0", parameters, 1);
            for(unsigned int i = 0; i < 1; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 1; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    CFStringRef return_value = original_CFURLCopyResourceSpecifier(anURL);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFStringRef", MAX_TYPE_LENGTH);
    if(return_value) {
        return_param.description = (char*)calloc(CFStringGetLength(return_value)+1, sizeof(char));
        CFStringGetCString(return_value, return_param.description, CFStringGetLength(return_value) + 1, kCFStringEncodingUTF8);
    }
    snprintf(return_param.value, MAX_VALUE_LENGTH, "0x%X", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


CFStringRef ____CFURLCopyHostName(CFURLRef anURL)
{
    if (!is_enabled() || !enabled_) {
        CFStringRef return_value = original_CFURLCopyHostName(anURL);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(1, sizeof(parameter_t));
//Parse parameter anURL
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)anURL);
    if(anURL) {
        CFStringRef anURL_description = CFCopyDescription(anURL);
        parameters[0].description = (char*)calloc(CFStringGetLength(anURL_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(anURL_description, kCFStringEncodingUTF8), CFStringGetLength(anURL_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLCopyHostName", "0x0", parameters, 1);
            for(unsigned int i = 0; i < 1; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 1; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    CFStringRef return_value = original_CFURLCopyHostName(anURL);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFStringRef", MAX_TYPE_LENGTH);
    if(return_value) {
        return_param.description = (char*)calloc(CFStringGetLength(return_value)+1, sizeof(char));
        CFStringGetCString(return_value, return_param.description, CFStringGetLength(return_value) + 1, kCFStringEncodingUTF8);
    }
    snprintf(return_param.value, MAX_VALUE_LENGTH, "0x%X", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


SInt32 ____CFURLGetPortNumber(CFURLRef anURL)
{
    if (!is_enabled() || !enabled_) {
        SInt32 return_value = original_CFURLGetPortNumber(anURL);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(1, sizeof(parameter_t));
//Parse parameter anURL
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)anURL);
    if(anURL) {
        CFStringRef anURL_description = CFCopyDescription(anURL);
        parameters[0].description = (char*)calloc(CFStringGetLength(anURL_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(anURL_description, kCFStringEncodingUTF8), CFStringGetLength(anURL_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLGetPortNumber", "0x0", parameters, 1);
            for(unsigned int i = 0; i < 1; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 1; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    SInt32 return_value = original_CFURLGetPortNumber(anURL);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "SInt32", MAX_TYPE_LENGTH);
    snprintf(return_param.value, MAX_VALUE_LENGTH, "%d", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


CFStringRef ____CFURLCopyUserName(CFURLRef anURL)
{
    if (!is_enabled() || !enabled_) {
        CFStringRef return_value = original_CFURLCopyUserName(anURL);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(1, sizeof(parameter_t));
//Parse parameter anURL
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)anURL);
    if(anURL) {
        CFStringRef anURL_description = CFCopyDescription(anURL);
        parameters[0].description = (char*)calloc(CFStringGetLength(anURL_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(anURL_description, kCFStringEncodingUTF8), CFStringGetLength(anURL_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLCopyUserName", "0x0", parameters, 1);
            for(unsigned int i = 0; i < 1; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 1; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    CFStringRef return_value = original_CFURLCopyUserName(anURL);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFStringRef", MAX_TYPE_LENGTH);
    if(return_value) {
        return_param.description = (char*)calloc(CFStringGetLength(return_value)+1, sizeof(char));
        CFStringGetCString(return_value, return_param.description, CFStringGetLength(return_value) + 1, kCFStringEncodingUTF8);
    }
    snprintf(return_param.value, MAX_VALUE_LENGTH, "0x%X", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


CFStringRef ____CFURLCopyPassword(CFURLRef anURL)
{
    if (!is_enabled() || !enabled_) {
        CFStringRef return_value = original_CFURLCopyPassword(anURL);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(1, sizeof(parameter_t));
//Parse parameter anURL
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)anURL);
    if(anURL) {
        CFStringRef anURL_description = CFCopyDescription(anURL);
        parameters[0].description = (char*)calloc(CFStringGetLength(anURL_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(anURL_description, kCFStringEncodingUTF8), CFStringGetLength(anURL_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLCopyPassword", "0x0", parameters, 1);
            for(unsigned int i = 0; i < 1; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 1; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    CFStringRef return_value = original_CFURLCopyPassword(anURL);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFStringRef", MAX_TYPE_LENGTH);
    if(return_value) {
        return_param.description = (char*)calloc(CFStringGetLength(return_value)+1, sizeof(char));
        CFStringGetCString(return_value, return_param.description, CFStringGetLength(return_value) + 1, kCFStringEncodingUTF8);
    }
    snprintf(return_param.value, MAX_VALUE_LENGTH, "0x%X", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


CFStringRef ____CFURLCopyParameterString(CFURLRef anURL, CFStringRef charactersToLeaveEscaped)
{
    if (!is_enabled() || !enabled_) {
        CFStringRef return_value = original_CFURLCopyParameterString(anURL, charactersToLeaveEscaped);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(2, sizeof(parameter_t));
//Parse parameter anURL
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)anURL);
    if(anURL) {
        CFStringRef anURL_description = CFCopyDescription(anURL);
        parameters[0].description = (char*)calloc(CFStringGetLength(anURL_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(anURL_description, kCFStringEncodingUTF8), CFStringGetLength(anURL_description));
    }
//Parse parameter charactersToLeaveEscaped
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)charactersToLeaveEscaped);
    if(charactersToLeaveEscaped) {
        parameters[1].description = (char*)calloc(CFStringGetLength(charactersToLeaveEscaped)+1, sizeof(char));
        CFStringGetCString(charactersToLeaveEscaped, parameters[1].description, CFStringGetLength(charactersToLeaveEscaped) + 1, kCFStringEncodingUTF8);
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLCopyParameterString", "0x0", parameters, 2);
            for(unsigned int i = 0; i < 2; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 2; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    CFStringRef return_value = original_CFURLCopyParameterString(anURL, charactersToLeaveEscaped);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFStringRef", MAX_TYPE_LENGTH);
    if(return_value) {
        return_param.description = (char*)calloc(CFStringGetLength(return_value)+1, sizeof(char));
        CFStringGetCString(return_value, return_param.description, CFStringGetLength(return_value) + 1, kCFStringEncodingUTF8);
    }
    snprintf(return_param.value, MAX_VALUE_LENGTH, "0x%X", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


CFStringRef ____CFURLCopyQueryString(CFURLRef anURL, CFStringRef charactersToLeaveEscaped)
{
    if (!is_enabled() || !enabled_) {
        CFStringRef return_value = original_CFURLCopyQueryString(anURL, charactersToLeaveEscaped);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(2, sizeof(parameter_t));
//Parse parameter anURL
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)anURL);
    if(anURL) {
        CFStringRef anURL_description = CFCopyDescription(anURL);
        parameters[0].description = (char*)calloc(CFStringGetLength(anURL_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(anURL_description, kCFStringEncodingUTF8), CFStringGetLength(anURL_description));
    }
//Parse parameter charactersToLeaveEscaped
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)charactersToLeaveEscaped);
    if(charactersToLeaveEscaped) {
        parameters[1].description = (char*)calloc(CFStringGetLength(charactersToLeaveEscaped)+1, sizeof(char));
        CFStringGetCString(charactersToLeaveEscaped, parameters[1].description, CFStringGetLength(charactersToLeaveEscaped) + 1, kCFStringEncodingUTF8);
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLCopyQueryString", "0x0", parameters, 2);
            for(unsigned int i = 0; i < 2; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 2; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    CFStringRef return_value = original_CFURLCopyQueryString(anURL, charactersToLeaveEscaped);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFStringRef", MAX_TYPE_LENGTH);
    if(return_value) {
        return_param.description = (char*)calloc(CFStringGetLength(return_value)+1, sizeof(char));
        CFStringGetCString(return_value, return_param.description, CFStringGetLength(return_value) + 1, kCFStringEncodingUTF8);
    }
    snprintf(return_param.value, MAX_VALUE_LENGTH, "0x%X", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


CFStringRef ____CFURLCopyFragment(CFURLRef anURL, CFStringRef charactersToLeaveEscaped)
{
    if (!is_enabled() || !enabled_) {
        CFStringRef return_value = original_CFURLCopyFragment(anURL, charactersToLeaveEscaped);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(2, sizeof(parameter_t));
//Parse parameter anURL
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)anURL);
    if(anURL) {
        CFStringRef anURL_description = CFCopyDescription(anURL);
        parameters[0].description = (char*)calloc(CFStringGetLength(anURL_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(anURL_description, kCFStringEncodingUTF8), CFStringGetLength(anURL_description));
    }
//Parse parameter charactersToLeaveEscaped
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)charactersToLeaveEscaped);
    if(charactersToLeaveEscaped) {
        parameters[1].description = (char*)calloc(CFStringGetLength(charactersToLeaveEscaped)+1, sizeof(char));
        CFStringGetCString(charactersToLeaveEscaped, parameters[1].description, CFStringGetLength(charactersToLeaveEscaped) + 1, kCFStringEncodingUTF8);
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLCopyFragment", "0x0", parameters, 2);
            for(unsigned int i = 0; i < 2; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 2; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    CFStringRef return_value = original_CFURLCopyFragment(anURL, charactersToLeaveEscaped);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFStringRef", MAX_TYPE_LENGTH);
    if(return_value) {
        return_param.description = (char*)calloc(CFStringGetLength(return_value)+1, sizeof(char));
        CFStringGetCString(return_value, return_param.description, CFStringGetLength(return_value) + 1, kCFStringEncodingUTF8);
    }
    snprintf(return_param.value, MAX_VALUE_LENGTH, "0x%X", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


CFStringRef ____CFURLCopyLastPathComponent(CFURLRef url)
{
    if (!is_enabled() || !enabled_) {
        CFStringRef return_value = original_CFURLCopyLastPathComponent(url);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(1, sizeof(parameter_t));
//Parse parameter url
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)url);
    if(url) {
        CFStringRef url_description = CFCopyDescription(url);
        parameters[0].description = (char*)calloc(CFStringGetLength(url_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(url_description, kCFStringEncodingUTF8), CFStringGetLength(url_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLCopyLastPathComponent", "0x0", parameters, 1);
            for(unsigned int i = 0; i < 1; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 1; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    CFStringRef return_value = original_CFURLCopyLastPathComponent(url);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFStringRef", MAX_TYPE_LENGTH);
    if(return_value) {
        return_param.description = (char*)calloc(CFStringGetLength(return_value)+1, sizeof(char));
        CFStringGetCString(return_value, return_param.description, CFStringGetLength(return_value) + 1, kCFStringEncodingUTF8);
    }
    snprintf(return_param.value, MAX_VALUE_LENGTH, "0x%X", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


CFStringRef ____CFURLCopyPathExtension(CFURLRef url)
{
    if (!is_enabled() || !enabled_) {
        CFStringRef return_value = original_CFURLCopyPathExtension(url);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(1, sizeof(parameter_t));
//Parse parameter url
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)url);
    if(url) {
        CFStringRef url_description = CFCopyDescription(url);
        parameters[0].description = (char*)calloc(CFStringGetLength(url_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(url_description, kCFStringEncodingUTF8), CFStringGetLength(url_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLCopyPathExtension", "0x0", parameters, 1);
            for(unsigned int i = 0; i < 1; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 1; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    CFStringRef return_value = original_CFURLCopyPathExtension(url);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFStringRef", MAX_TYPE_LENGTH);
    if(return_value) {
        return_param.description = (char*)calloc(CFStringGetLength(return_value)+1, sizeof(char));
        CFStringGetCString(return_value, return_param.description, CFStringGetLength(return_value) + 1, kCFStringEncodingUTF8);
    }
    snprintf(return_param.value, MAX_VALUE_LENGTH, "0x%X", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


CFURLRef ____CFURLCreateCopyAppendingPathComponent(CFAllocatorRef allocator, CFURLRef url, CFStringRef pathComponent, Boolean isDirectory)
{
    if (!is_enabled() || !enabled_) {
        CFURLRef return_value = original_CFURLCreateCopyAppendingPathComponent(allocator, url, pathComponent, isDirectory);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(4, sizeof(parameter_t));
//Parse parameter allocator
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)allocator);
//Parse parameter url
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)url);
    if(url) {
        CFStringRef url_description = CFCopyDescription(url);
        parameters[1].description = (char*)calloc(CFStringGetLength(url_description) + 1, sizeof(char));
        memcpy(parameters[1].description, CFStringGetCStringPtr(url_description, kCFStringEncodingUTF8), CFStringGetLength(url_description));
    }
//Parse parameter pathComponent
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (int)pathComponent);
    if(pathComponent) {
        parameters[2].description = (char*)calloc(CFStringGetLength(pathComponent)+1, sizeof(char));
        CFStringGetCString(pathComponent, parameters[2].description, CFStringGetLength(pathComponent) + 1, kCFStringEncodingUTF8);
    }
//Parse parameter isDirectory
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "Boolean", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "%d", (int)isDirectory);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLCreateCopyAppendingPathComponent", "0x0", parameters, 4);
            for(unsigned int i = 0; i < 4; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 4; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    CFURLRef return_value = original_CFURLCreateCopyAppendingPathComponent(allocator, url, pathComponent, isDirectory);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFURLRef", MAX_TYPE_LENGTH);
    if(return_value) {
        CFStringRef return_value_description = CFCopyDescription(return_value);
        return_param.description = (char*)calloc(CFStringGetLength(return_value_description) + 1, sizeof(char));
        memcpy(return_param.description, CFStringGetCStringPtr(return_value_description, kCFStringEncodingUTF8), CFStringGetLength(return_value_description));
    }
    snprintf(return_param.value, MAX_VALUE_LENGTH, "0x%X", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


CFURLRef ____CFURLCreateCopyDeletingLastPathComponent(CFAllocatorRef allocator, CFURLRef url)
{
    if (!is_enabled() || !enabled_) {
        CFURLRef return_value = original_CFURLCreateCopyDeletingLastPathComponent(allocator, url);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(2, sizeof(parameter_t));
//Parse parameter allocator
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)allocator);
//Parse parameter url
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)url);
    if(url) {
        CFStringRef url_description = CFCopyDescription(url);
        parameters[1].description = (char*)calloc(CFStringGetLength(url_description) + 1, sizeof(char));
        memcpy(parameters[1].description, CFStringGetCStringPtr(url_description, kCFStringEncodingUTF8), CFStringGetLength(url_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLCreateCopyDeletingLastPathComponent", "0x0", parameters, 2);
            for(unsigned int i = 0; i < 2; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 2; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    CFURLRef return_value = original_CFURLCreateCopyDeletingLastPathComponent(allocator, url);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFURLRef", MAX_TYPE_LENGTH);
    if(return_value) {
        CFStringRef return_value_description = CFCopyDescription(return_value);
        return_param.description = (char*)calloc(CFStringGetLength(return_value_description) + 1, sizeof(char));
        memcpy(return_param.description, CFStringGetCStringPtr(return_value_description, kCFStringEncodingUTF8), CFStringGetLength(return_value_description));
    }
    snprintf(return_param.value, MAX_VALUE_LENGTH, "0x%X", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


CFURLRef ____CFURLCreateCopyAppendingPathExtension(CFAllocatorRef allocator, CFURLRef url, CFStringRef extension)
{
    if (!is_enabled() || !enabled_) {
        CFURLRef return_value = original_CFURLCreateCopyAppendingPathExtension(allocator, url, extension);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(3, sizeof(parameter_t));
//Parse parameter allocator
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)allocator);
//Parse parameter url
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)url);
    if(url) {
        CFStringRef url_description = CFCopyDescription(url);
        parameters[1].description = (char*)calloc(CFStringGetLength(url_description) + 1, sizeof(char));
        memcpy(parameters[1].description, CFStringGetCStringPtr(url_description, kCFStringEncodingUTF8), CFStringGetLength(url_description));
    }
//Parse parameter extension
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (int)extension);
    if(extension) {
        parameters[2].description = (char*)calloc(CFStringGetLength(extension)+1, sizeof(char));
        CFStringGetCString(extension, parameters[2].description, CFStringGetLength(extension) + 1, kCFStringEncodingUTF8);
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLCreateCopyAppendingPathExtension", "0x0", parameters, 3);
            for(unsigned int i = 0; i < 3; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 3; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    CFURLRef return_value = original_CFURLCreateCopyAppendingPathExtension(allocator, url, extension);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFURLRef", MAX_TYPE_LENGTH);
    if(return_value) {
        CFStringRef return_value_description = CFCopyDescription(return_value);
        return_param.description = (char*)calloc(CFStringGetLength(return_value_description) + 1, sizeof(char));
        memcpy(return_param.description, CFStringGetCStringPtr(return_value_description, kCFStringEncodingUTF8), CFStringGetLength(return_value_description));
    }
    snprintf(return_param.value, MAX_VALUE_LENGTH, "0x%X", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


CFURLRef ____CFURLCreateCopyDeletingPathExtension(CFAllocatorRef allocator, CFURLRef url)
{
    if (!is_enabled() || !enabled_) {
        CFURLRef return_value = original_CFURLCreateCopyDeletingPathExtension(allocator, url);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(2, sizeof(parameter_t));
//Parse parameter allocator
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)allocator);
//Parse parameter url
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)url);
    if(url) {
        CFStringRef url_description = CFCopyDescription(url);
        parameters[1].description = (char*)calloc(CFStringGetLength(url_description) + 1, sizeof(char));
        memcpy(parameters[1].description, CFStringGetCStringPtr(url_description, kCFStringEncodingUTF8), CFStringGetLength(url_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLCreateCopyDeletingPathExtension", "0x0", parameters, 2);
            for(unsigned int i = 0; i < 2; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 2; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    CFURLRef return_value = original_CFURLCreateCopyDeletingPathExtension(allocator, url);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFURLRef", MAX_TYPE_LENGTH);
    if(return_value) {
        CFStringRef return_value_description = CFCopyDescription(return_value);
        return_param.description = (char*)calloc(CFStringGetLength(return_value_description) + 1, sizeof(char));
        memcpy(return_param.description, CFStringGetCStringPtr(return_value_description, kCFStringEncodingUTF8), CFStringGetLength(return_value_description));
    }
    snprintf(return_param.value, MAX_VALUE_LENGTH, "0x%X", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


CFIndex ____CFURLGetBytes(CFURLRef url, UInt8 * buffer, CFIndex bufferLength)
{
    if (!is_enabled() || !enabled_) {
        CFIndex return_value = original_CFURLGetBytes(url, buffer, bufferLength);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(3, sizeof(parameter_t));
//Parse parameter url
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)url);
    if(url) {
        CFStringRef url_description = CFCopyDescription(url);
        parameters[0].description = (char*)calloc(CFStringGetLength(url_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(url_description, kCFStringEncodingUTF8), CFStringGetLength(url_description));
    }
//Parse parameter buffer
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "^UInt8", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (register_t)buffer);
//Parse parameter bufferLength
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFIndex", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "%d", (int)bufferLength);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLGetBytes", "0x0", parameters, 3);
            for(unsigned int i = 0; i < 3; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 3; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    CFIndex return_value = original_CFURLGetBytes(url, buffer, bufferLength);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFIndex", MAX_TYPE_LENGTH);
    snprintf(return_param.value, MAX_VALUE_LENGTH, "%d", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


CFRange ____CFURLGetByteRangeForComponent(CFURLRef url, CFURLComponentType component, CFRange * rangeIncludingSeparators)
{
    if (!is_enabled() || !enabled_) {
        CFRange return_value = original_CFURLGetByteRangeForComponent(url, component, rangeIncludingSeparators);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(3, sizeof(parameter_t));
//Parse parameter url
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)url);
    if(url) {
        CFStringRef url_description = CFCopyDescription(url);
        parameters[0].description = (char*)calloc(CFStringGetLength(url_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(url_description, kCFStringEncodingUTF8), CFStringGetLength(url_description));
    }
//Parse parameter component
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFURLComponentType", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "%d", (int)component);
//Parse parameter rangeIncludingSeparators
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "^CFRange", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (register_t)rangeIncludingSeparators);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLGetByteRangeForComponent", "0x0", parameters, 3);
            for(unsigned int i = 0; i < 3; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 3; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    CFRange return_value = original_CFURLGetByteRangeForComponent(url, component, rangeIncludingSeparators);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFRange", MAX_TYPE_LENGTH);
    snprintf(return_param.value, MAX_VALUE_LENGTH, "%d", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


CFStringRef ____CFURLCreateStringByReplacingPercentEscapes(CFAllocatorRef allocator, CFStringRef originalString, CFStringRef charactersToLeaveEscaped)
{
    if (!is_enabled() || !enabled_) {
        CFStringRef return_value = original_CFURLCreateStringByReplacingPercentEscapes(allocator, originalString, charactersToLeaveEscaped);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(3, sizeof(parameter_t));
//Parse parameter allocator
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)allocator);
//Parse parameter originalString
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)originalString);
    if(originalString) {
        parameters[1].description = (char*)calloc(CFStringGetLength(originalString)+1, sizeof(char));
        CFStringGetCString(originalString, parameters[1].description, CFStringGetLength(originalString) + 1, kCFStringEncodingUTF8);
    }
//Parse parameter charactersToLeaveEscaped
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (int)charactersToLeaveEscaped);
    if(charactersToLeaveEscaped) {
        parameters[2].description = (char*)calloc(CFStringGetLength(charactersToLeaveEscaped)+1, sizeof(char));
        CFStringGetCString(charactersToLeaveEscaped, parameters[2].description, CFStringGetLength(charactersToLeaveEscaped) + 1, kCFStringEncodingUTF8);
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLCreateStringByReplacingPercentEscapes", "0x0", parameters, 3);
            for(unsigned int i = 0; i < 3; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 3; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    CFStringRef return_value = original_CFURLCreateStringByReplacingPercentEscapes(allocator, originalString, charactersToLeaveEscaped);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFStringRef", MAX_TYPE_LENGTH);
    if(return_value) {
        return_param.description = (char*)calloc(CFStringGetLength(return_value)+1, sizeof(char));
        CFStringGetCString(return_value, return_param.description, CFStringGetLength(return_value) + 1, kCFStringEncodingUTF8);
    }
    snprintf(return_param.value, MAX_VALUE_LENGTH, "0x%X", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


CFStringRef ____CFURLCreateStringByReplacingPercentEscapesUsingEncoding(CFAllocatorRef allocator, CFStringRef origString, CFStringRef charsToLeaveEscaped, CFStringEncoding encoding)
{
    if (!is_enabled() || !enabled_) {
        CFStringRef return_value = original_CFURLCreateStringByReplacingPercentEscapesUsingEncoding(allocator, origString, charsToLeaveEscaped, encoding);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(4, sizeof(parameter_t));
//Parse parameter allocator
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)allocator);
//Parse parameter origString
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)origString);
    if(origString) {
        parameters[1].description = (char*)calloc(CFStringGetLength(origString)+1, sizeof(char));
        CFStringGetCString(origString, parameters[1].description, CFStringGetLength(origString) + 1, kCFStringEncodingUTF8);
    }
//Parse parameter charsToLeaveEscaped
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (int)charsToLeaveEscaped);
    if(charsToLeaveEscaped) {
        parameters[2].description = (char*)calloc(CFStringGetLength(charsToLeaveEscaped)+1, sizeof(char));
        CFStringGetCString(charsToLeaveEscaped, parameters[2].description, CFStringGetLength(charsToLeaveEscaped) + 1, kCFStringEncodingUTF8);
    }
//Parse parameter encoding
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "CFStringEncoding", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "%d", (int)encoding);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLCreateStringByReplacingPercentEscapesUsingEncoding", "0x0", parameters, 4);
            for(unsigned int i = 0; i < 4; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 4; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    CFStringRef return_value = original_CFURLCreateStringByReplacingPercentEscapesUsingEncoding(allocator, origString, charsToLeaveEscaped, encoding);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFStringRef", MAX_TYPE_LENGTH);
    if(return_value) {
        return_param.description = (char*)calloc(CFStringGetLength(return_value)+1, sizeof(char));
        CFStringGetCString(return_value, return_param.description, CFStringGetLength(return_value) + 1, kCFStringEncodingUTF8);
    }
    snprintf(return_param.value, MAX_VALUE_LENGTH, "0x%X", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


CFStringRef ____CFURLCreateStringByAddingPercentEscapes(CFAllocatorRef allocator, CFStringRef originalString, CFStringRef charactersToLeaveUnescaped, CFStringRef legalURLCharactersToBeEscaped, CFStringEncoding encoding)
{
    if (!is_enabled() || !enabled_) {
        CFStringRef return_value = original_CFURLCreateStringByAddingPercentEscapes(allocator, originalString, charactersToLeaveUnescaped, legalURLCharactersToBeEscaped, encoding);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(5, sizeof(parameter_t));
//Parse parameter allocator
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)allocator);
//Parse parameter originalString
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)originalString);
    if(originalString) {
        parameters[1].description = (char*)calloc(CFStringGetLength(originalString)+1, sizeof(char));
        CFStringGetCString(originalString, parameters[1].description, CFStringGetLength(originalString) + 1, kCFStringEncodingUTF8);
    }
//Parse parameter charactersToLeaveUnescaped
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (int)charactersToLeaveUnescaped);
    if(charactersToLeaveUnescaped) {
        parameters[2].description = (char*)calloc(CFStringGetLength(charactersToLeaveUnescaped)+1, sizeof(char));
        CFStringGetCString(charactersToLeaveUnescaped, parameters[2].description, CFStringGetLength(charactersToLeaveUnescaped) + 1, kCFStringEncodingUTF8);
    }
//Parse parameter legalURLCharactersToBeEscaped
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "0x%X", (int)legalURLCharactersToBeEscaped);
    if(legalURLCharactersToBeEscaped) {
        parameters[3].description = (char*)calloc(CFStringGetLength(legalURLCharactersToBeEscaped)+1, sizeof(char));
        CFStringGetCString(legalURLCharactersToBeEscaped, parameters[3].description, CFStringGetLength(legalURLCharactersToBeEscaped) + 1, kCFStringEncodingUTF8);
    }
//Parse parameter encoding
    parameters[4].description = NULL;
    strncpy(parameters[4].type, "CFStringEncoding", MAX_TYPE_LENGTH);
    snprintf(parameters[4].value, MAX_VALUE_LENGTH, "%d", (int)encoding);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLCreateStringByAddingPercentEscapes", "0x0", parameters, 5);
            for(unsigned int i = 0; i < 5; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 5; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    CFStringRef return_value = original_CFURLCreateStringByAddingPercentEscapes(allocator, originalString, charactersToLeaveUnescaped, legalURLCharactersToBeEscaped, encoding);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFStringRef", MAX_TYPE_LENGTH);
    if(return_value) {
        return_param.description = (char*)calloc(CFStringGetLength(return_value)+1, sizeof(char));
        CFStringGetCString(return_value, return_param.description, CFStringGetLength(return_value) + 1, kCFStringEncodingUTF8);
    }
    snprintf(return_param.value, MAX_VALUE_LENGTH, "0x%X", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


Boolean ____CFURLIsFileReferenceURL(CFURLRef url)
{
    if (!is_enabled() || !enabled_) {
        Boolean return_value = original_CFURLIsFileReferenceURL(url);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(1, sizeof(parameter_t));
//Parse parameter url
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)url);
    if(url) {
        CFStringRef url_description = CFCopyDescription(url);
        parameters[0].description = (char*)calloc(CFStringGetLength(url_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(url_description, kCFStringEncodingUTF8), CFStringGetLength(url_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLIsFileReferenceURL", "0x0", parameters, 1);
            for(unsigned int i = 0; i < 1; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 1; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    Boolean return_value = original_CFURLIsFileReferenceURL(url);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "Boolean", MAX_TYPE_LENGTH);
    snprintf(return_param.value, MAX_VALUE_LENGTH, "%d", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


CFURLRef ____CFURLCreateFileReferenceURL(CFAllocatorRef allocator, CFURLRef url, CFErrorRef * error)
{
    if (!is_enabled() || !enabled_) {
        CFURLRef return_value = original_CFURLCreateFileReferenceURL(allocator, url, error);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(3, sizeof(parameter_t));
//Parse parameter allocator
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)allocator);
//Parse parameter url
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)url);
    if(url) {
        CFStringRef url_description = CFCopyDescription(url);
        parameters[1].description = (char*)calloc(CFStringGetLength(url_description) + 1, sizeof(char));
        memcpy(parameters[1].description, CFStringGetCStringPtr(url_description, kCFStringEncodingUTF8), CFStringGetLength(url_description));
    }
//Parse parameter error
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "^CFErrorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (register_t)error);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLCreateFileReferenceURL", "0x0", parameters, 3);
            for(unsigned int i = 0; i < 3; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 3; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    CFURLRef return_value = original_CFURLCreateFileReferenceURL(allocator, url, error);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFURLRef", MAX_TYPE_LENGTH);
    if(return_value) {
        CFStringRef return_value_description = CFCopyDescription(return_value);
        return_param.description = (char*)calloc(CFStringGetLength(return_value_description) + 1, sizeof(char));
        memcpy(return_param.description, CFStringGetCStringPtr(return_value_description, kCFStringEncodingUTF8), CFStringGetLength(return_value_description));
    }
    snprintf(return_param.value, MAX_VALUE_LENGTH, "0x%X", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


CFURLRef ____CFURLCreateFilePathURL(CFAllocatorRef allocator, CFURLRef url, CFErrorRef * error)
{
    if (!is_enabled() || !enabled_) {
        CFURLRef return_value = original_CFURLCreateFilePathURL(allocator, url, error);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(3, sizeof(parameter_t));
//Parse parameter allocator
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)allocator);
//Parse parameter url
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)url);
    if(url) {
        CFStringRef url_description = CFCopyDescription(url);
        parameters[1].description = (char*)calloc(CFStringGetLength(url_description) + 1, sizeof(char));
        memcpy(parameters[1].description, CFStringGetCStringPtr(url_description, kCFStringEncodingUTF8), CFStringGetLength(url_description));
    }
//Parse parameter error
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "^CFErrorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (register_t)error);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLCreateFilePathURL", "0x0", parameters, 3);
            for(unsigned int i = 0; i < 3; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 3; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    CFURLRef return_value = original_CFURLCreateFilePathURL(allocator, url, error);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFURLRef", MAX_TYPE_LENGTH);
    if(return_value) {
        CFStringRef return_value_description = CFCopyDescription(return_value);
        return_param.description = (char*)calloc(CFStringGetLength(return_value_description) + 1, sizeof(char));
        memcpy(return_param.description, CFStringGetCStringPtr(return_value_description, kCFStringEncodingUTF8), CFStringGetLength(return_value_description));
    }
    snprintf(return_param.value, MAX_VALUE_LENGTH, "0x%X", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


Boolean ____CFURLCopyResourcePropertyForKey(CFURLRef url, CFStringRef key, void * propertyValueTypeRefPtr, CFErrorRef * error)
{
    if (!is_enabled() || !enabled_) {
        Boolean return_value = original_CFURLCopyResourcePropertyForKey(url, key, propertyValueTypeRefPtr, error);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(4, sizeof(parameter_t));
//Parse parameter url
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)url);
    if(url) {
        CFStringRef url_description = CFCopyDescription(url);
        parameters[0].description = (char*)calloc(CFStringGetLength(url_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(url_description, kCFStringEncodingUTF8), CFStringGetLength(url_description));
    }
//Parse parameter key
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)key);
    if(key) {
        parameters[1].description = (char*)calloc(CFStringGetLength(key)+1, sizeof(char));
        CFStringGetCString(key, parameters[1].description, CFStringGetLength(key) + 1, kCFStringEncodingUTF8);
    }
//Parse parameter propertyValueTypeRefPtr
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "^void", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (register_t)propertyValueTypeRefPtr);
//Parse parameter error
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "^CFErrorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "0x%X", (register_t)error);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLCopyResourcePropertyForKey", "0x0", parameters, 4);
            for(unsigned int i = 0; i < 4; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 4; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    Boolean return_value = original_CFURLCopyResourcePropertyForKey(url, key, propertyValueTypeRefPtr, error);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "Boolean", MAX_TYPE_LENGTH);
    snprintf(return_param.value, MAX_VALUE_LENGTH, "%d", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


CFDictionaryRef ____CFURLCopyResourcePropertiesForKeys(CFURLRef url, CFArrayRef keys, CFErrorRef * error)
{
    if (!is_enabled() || !enabled_) {
        CFDictionaryRef return_value = original_CFURLCopyResourcePropertiesForKeys(url, keys, error);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(3, sizeof(parameter_t));
//Parse parameter url
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)url);
    if(url) {
        CFStringRef url_description = CFCopyDescription(url);
        parameters[0].description = (char*)calloc(CFStringGetLength(url_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(url_description, kCFStringEncodingUTF8), CFStringGetLength(url_description));
    }
//Parse parameter keys
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFArrayRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)keys);
    if(keys) {
        CFStringRef keys_description = CFCopyDescription(keys);
        parameters[1].description = (char*)calloc(CFStringGetLength(keys_description) + 1, sizeof(char));
        memcpy(parameters[1].description, CFStringGetCStringPtr(keys_description, kCFStringEncodingUTF8), CFStringGetLength(keys_description));
    }
//Parse parameter error
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "^CFErrorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (register_t)error);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLCopyResourcePropertiesForKeys", "0x0", parameters, 3);
            for(unsigned int i = 0; i < 3; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 3; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    CFDictionaryRef return_value = original_CFURLCopyResourcePropertiesForKeys(url, keys, error);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFDictionaryRef", MAX_TYPE_LENGTH);
    if(return_value) {
        CFStringRef return_value_description = CFCopyDescription(return_value);
        return_param.description = (char*)calloc(CFStringGetLength(return_value_description) + 1, sizeof(char));
        memcpy(return_param.description, CFStringGetCStringPtr(return_value_description, kCFStringEncodingUTF8), CFStringGetLength(return_value_description));
    }
    snprintf(return_param.value, MAX_VALUE_LENGTH, "0x%X", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


Boolean ____CFURLSetResourcePropertyForKey(CFURLRef url, CFStringRef key, CFTypeRef propertyValue, CFErrorRef * error)
{
    if (!is_enabled() || !enabled_) {
        Boolean return_value = original_CFURLSetResourcePropertyForKey(url, key, propertyValue, error);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(4, sizeof(parameter_t));
//Parse parameter url
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)url);
    if(url) {
        CFStringRef url_description = CFCopyDescription(url);
        parameters[0].description = (char*)calloc(CFStringGetLength(url_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(url_description, kCFStringEncodingUTF8), CFStringGetLength(url_description));
    }
//Parse parameter key
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)key);
    if(key) {
        parameters[1].description = (char*)calloc(CFStringGetLength(key)+1, sizeof(char));
        CFStringGetCString(key, parameters[1].description, CFStringGetLength(key) + 1, kCFStringEncodingUTF8);
    }
//Parse parameter propertyValue
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFTypeRef", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (int)propertyValue);
    if(propertyValue) {
        CFStringRef propertyValue_description = CFCopyDescription(propertyValue);
        parameters[2].description = (char*)calloc(CFStringGetLength(propertyValue_description) + 1, sizeof(char));
        memcpy(parameters[2].description, CFStringGetCStringPtr(propertyValue_description, kCFStringEncodingUTF8), CFStringGetLength(propertyValue_description));
    }
//Parse parameter error
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "^CFErrorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "0x%X", (register_t)error);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLSetResourcePropertyForKey", "0x0", parameters, 4);
            for(unsigned int i = 0; i < 4; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 4; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    Boolean return_value = original_CFURLSetResourcePropertyForKey(url, key, propertyValue, error);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "Boolean", MAX_TYPE_LENGTH);
    snprintf(return_param.value, MAX_VALUE_LENGTH, "%d", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


Boolean ____CFURLSetResourcePropertiesForKeys(CFURLRef url, CFDictionaryRef keyedPropertyValues, CFErrorRef * error)
{
    if (!is_enabled() || !enabled_) {
        Boolean return_value = original_CFURLSetResourcePropertiesForKeys(url, keyedPropertyValues, error);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(3, sizeof(parameter_t));
//Parse parameter url
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)url);
    if(url) {
        CFStringRef url_description = CFCopyDescription(url);
        parameters[0].description = (char*)calloc(CFStringGetLength(url_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(url_description, kCFStringEncodingUTF8), CFStringGetLength(url_description));
    }
//Parse parameter keyedPropertyValues
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFDictionaryRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)keyedPropertyValues);
    if(keyedPropertyValues) {
        CFStringRef keyedPropertyValues_description = CFCopyDescription(keyedPropertyValues);
        parameters[1].description = (char*)calloc(CFStringGetLength(keyedPropertyValues_description) + 1, sizeof(char));
        memcpy(parameters[1].description, CFStringGetCStringPtr(keyedPropertyValues_description, kCFStringEncodingUTF8), CFStringGetLength(keyedPropertyValues_description));
    }
//Parse parameter error
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "^CFErrorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (register_t)error);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLSetResourcePropertiesForKeys", "0x0", parameters, 3);
            for(unsigned int i = 0; i < 3; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 3; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    Boolean return_value = original_CFURLSetResourcePropertiesForKeys(url, keyedPropertyValues, error);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "Boolean", MAX_TYPE_LENGTH);
    snprintf(return_param.value, MAX_VALUE_LENGTH, "%d", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


void ____CFURLClearResourcePropertyCacheForKey(CFURLRef url, CFStringRef key)
{
    if (!is_enabled() || !enabled_) {
        original_CFURLClearResourcePropertyCacheForKey(url, key);
        return;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(2, sizeof(parameter_t));
//Parse parameter url
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)url);
    if(url) {
        CFStringRef url_description = CFCopyDescription(url);
        parameters[0].description = (char*)calloc(CFStringGetLength(url_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(url_description, kCFStringEncodingUTF8), CFStringGetLength(url_description));
    }
//Parse parameter key
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)key);
    if(key) {
        parameters[1].description = (char*)calloc(CFStringGetLength(key)+1, sizeof(char));
        CFStringGetCString(key, parameters[1].description, CFStringGetLength(key) + 1, kCFStringEncodingUTF8);
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLClearResourcePropertyCacheForKey", "0x0", parameters, 2);
            for(unsigned int i = 0; i < 2; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 2; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    original_CFURLClearResourcePropertyCacheForKey(url, key);
    set_enabled(false);
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
}


void ____CFURLClearResourcePropertyCache(CFURLRef url)
{
    if (!is_enabled() || !enabled_) {
        original_CFURLClearResourcePropertyCache(url);
        return;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(1, sizeof(parameter_t));
//Parse parameter url
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)url);
    if(url) {
        CFStringRef url_description = CFCopyDescription(url);
        parameters[0].description = (char*)calloc(CFStringGetLength(url_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(url_description, kCFStringEncodingUTF8), CFStringGetLength(url_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLClearResourcePropertyCache", "0x0", parameters, 1);
            for(unsigned int i = 0; i < 1; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 1; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    original_CFURLClearResourcePropertyCache(url);
    set_enabled(false);
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
}


void ____CFURLSetTemporaryResourcePropertyForKey(CFURLRef url, CFStringRef key, CFTypeRef propertyValue)
{
    if (!is_enabled() || !enabled_) {
        original_CFURLSetTemporaryResourcePropertyForKey(url, key, propertyValue);
        return;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(3, sizeof(parameter_t));
//Parse parameter url
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)url);
    if(url) {
        CFStringRef url_description = CFCopyDescription(url);
        parameters[0].description = (char*)calloc(CFStringGetLength(url_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(url_description, kCFStringEncodingUTF8), CFStringGetLength(url_description));
    }
//Parse parameter key
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)key);
    if(key) {
        parameters[1].description = (char*)calloc(CFStringGetLength(key)+1, sizeof(char));
        CFStringGetCString(key, parameters[1].description, CFStringGetLength(key) + 1, kCFStringEncodingUTF8);
    }
//Parse parameter propertyValue
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFTypeRef", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (int)propertyValue);
    if(propertyValue) {
        CFStringRef propertyValue_description = CFCopyDescription(propertyValue);
        parameters[2].description = (char*)calloc(CFStringGetLength(propertyValue_description) + 1, sizeof(char));
        memcpy(parameters[2].description, CFStringGetCStringPtr(propertyValue_description, kCFStringEncodingUTF8), CFStringGetLength(propertyValue_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLSetTemporaryResourcePropertyForKey", "0x0", parameters, 3);
            for(unsigned int i = 0; i < 3; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 3; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    original_CFURLSetTemporaryResourcePropertyForKey(url, key, propertyValue);
    set_enabled(false);
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
}


Boolean ____CFURLResourceIsReachable(CFURLRef url, CFErrorRef * error)
{
    if (!is_enabled() || !enabled_) {
        Boolean return_value = original_CFURLResourceIsReachable(url, error);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(2, sizeof(parameter_t));
//Parse parameter url
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)url);
    if(url) {
        CFStringRef url_description = CFCopyDescription(url);
        parameters[0].description = (char*)calloc(CFStringGetLength(url_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(url_description, kCFStringEncodingUTF8), CFStringGetLength(url_description));
    }
//Parse parameter error
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "^CFErrorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (register_t)error);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLResourceIsReachable", "0x0", parameters, 2);
            for(unsigned int i = 0; i < 2; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 2; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    Boolean return_value = original_CFURLResourceIsReachable(url, error);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "Boolean", MAX_TYPE_LENGTH);
    snprintf(return_param.value, MAX_VALUE_LENGTH, "%d", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


CFDataRef ____CFURLCreateBookmarkData(CFAllocatorRef allocator, CFURLRef url, CFURLBookmarkCreationOptions options, CFArrayRef resourcePropertiesToInclude, CFURLRef relativeToURL, CFErrorRef * error)
{
    if (!is_enabled() || !enabled_) {
        CFDataRef return_value = original_CFURLCreateBookmarkData(allocator, url, options, resourcePropertiesToInclude, relativeToURL, error);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(6, sizeof(parameter_t));
//Parse parameter allocator
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)allocator);
//Parse parameter url
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)url);
    if(url) {
        CFStringRef url_description = CFCopyDescription(url);
        parameters[1].description = (char*)calloc(CFStringGetLength(url_description) + 1, sizeof(char));
        memcpy(parameters[1].description, CFStringGetCStringPtr(url_description, kCFStringEncodingUTF8), CFStringGetLength(url_description));
    }
//Parse parameter options
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFURLBookmarkCreationOptions", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "%d", (int)options);
//Parse parameter resourcePropertiesToInclude
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "CFArrayRef", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "0x%X", (int)resourcePropertiesToInclude);
    if(resourcePropertiesToInclude) {
        CFStringRef resourcePropertiesToInclude_description = CFCopyDescription(resourcePropertiesToInclude);
        parameters[3].description = (char*)calloc(CFStringGetLength(resourcePropertiesToInclude_description) + 1, sizeof(char));
        memcpy(parameters[3].description, CFStringGetCStringPtr(resourcePropertiesToInclude_description, kCFStringEncodingUTF8), CFStringGetLength(resourcePropertiesToInclude_description));
    }
//Parse parameter relativeToURL
    parameters[4].description = NULL;
    strncpy(parameters[4].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[4].value, MAX_VALUE_LENGTH, "0x%X", (int)relativeToURL);
    if(relativeToURL) {
        CFStringRef relativeToURL_description = CFCopyDescription(relativeToURL);
        parameters[4].description = (char*)calloc(CFStringGetLength(relativeToURL_description) + 1, sizeof(char));
        memcpy(parameters[4].description, CFStringGetCStringPtr(relativeToURL_description, kCFStringEncodingUTF8), CFStringGetLength(relativeToURL_description));
    }
//Parse parameter error
    parameters[5].description = NULL;
    strncpy(parameters[5].type, "^CFErrorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[5].value, MAX_VALUE_LENGTH, "0x%X", (register_t)error);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLCreateBookmarkData", "0x0", parameters, 6);
            for(unsigned int i = 0; i < 6; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 6; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    CFDataRef return_value = original_CFURLCreateBookmarkData(allocator, url, options, resourcePropertiesToInclude, relativeToURL, error);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFDataRef", MAX_TYPE_LENGTH);
    if(return_value) {
        CFStringRef return_value_description = CFCopyDescription(return_value);
        return_param.description = (char*)calloc(CFStringGetLength(return_value_description) + 1, sizeof(char));
        memcpy(return_param.description, CFStringGetCStringPtr(return_value_description, kCFStringEncodingUTF8), CFStringGetLength(return_value_description));
    }
    snprintf(return_param.value, MAX_VALUE_LENGTH, "0x%X", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


CFURLRef ____CFURLCreateByResolvingBookmarkData(CFAllocatorRef allocator, CFDataRef bookmark, CFURLBookmarkResolutionOptions options, CFURLRef relativeToURL, CFArrayRef resourcePropertiesToInclude, Boolean * isStale, CFErrorRef * error)
{
    if (!is_enabled() || !enabled_) {
        CFURLRef return_value = original_CFURLCreateByResolvingBookmarkData(allocator, bookmark, options, relativeToURL, resourcePropertiesToInclude, isStale, error);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(7, sizeof(parameter_t));
//Parse parameter allocator
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)allocator);
//Parse parameter bookmark
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFDataRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)bookmark);
    if(bookmark) {
        CFStringRef bookmark_description = CFCopyDescription(bookmark);
        parameters[1].description = (char*)calloc(CFStringGetLength(bookmark_description) + 1, sizeof(char));
        memcpy(parameters[1].description, CFStringGetCStringPtr(bookmark_description, kCFStringEncodingUTF8), CFStringGetLength(bookmark_description));
    }
//Parse parameter options
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFURLBookmarkResolutionOptions", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "%d", (int)options);
//Parse parameter relativeToURL
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "0x%X", (int)relativeToURL);
    if(relativeToURL) {
        CFStringRef relativeToURL_description = CFCopyDescription(relativeToURL);
        parameters[3].description = (char*)calloc(CFStringGetLength(relativeToURL_description) + 1, sizeof(char));
        memcpy(parameters[3].description, CFStringGetCStringPtr(relativeToURL_description, kCFStringEncodingUTF8), CFStringGetLength(relativeToURL_description));
    }
//Parse parameter resourcePropertiesToInclude
    parameters[4].description = NULL;
    strncpy(parameters[4].type, "CFArrayRef", MAX_TYPE_LENGTH);
    snprintf(parameters[4].value, MAX_VALUE_LENGTH, "0x%X", (int)resourcePropertiesToInclude);
    if(resourcePropertiesToInclude) {
        CFStringRef resourcePropertiesToInclude_description = CFCopyDescription(resourcePropertiesToInclude);
        parameters[4].description = (char*)calloc(CFStringGetLength(resourcePropertiesToInclude_description) + 1, sizeof(char));
        memcpy(parameters[4].description, CFStringGetCStringPtr(resourcePropertiesToInclude_description, kCFStringEncodingUTF8), CFStringGetLength(resourcePropertiesToInclude_description));
    }
//Parse parameter isStale
    parameters[5].description = NULL;
    strncpy(parameters[5].type, "^Boolean", MAX_TYPE_LENGTH);
    snprintf(parameters[5].value, MAX_VALUE_LENGTH, "0x%X", (register_t)isStale);
//Parse parameter error
    parameters[6].description = NULL;
    strncpy(parameters[6].type, "^CFErrorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[6].value, MAX_VALUE_LENGTH, "0x%X", (register_t)error);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLCreateByResolvingBookmarkData", "0x0", parameters, 7);
            for(unsigned int i = 0; i < 7; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 7; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    CFURLRef return_value = original_CFURLCreateByResolvingBookmarkData(allocator, bookmark, options, relativeToURL, resourcePropertiesToInclude, isStale, error);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFURLRef", MAX_TYPE_LENGTH);
    if(return_value) {
        CFStringRef return_value_description = CFCopyDescription(return_value);
        return_param.description = (char*)calloc(CFStringGetLength(return_value_description) + 1, sizeof(char));
        memcpy(return_param.description, CFStringGetCStringPtr(return_value_description, kCFStringEncodingUTF8), CFStringGetLength(return_value_description));
    }
    snprintf(return_param.value, MAX_VALUE_LENGTH, "0x%X", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


CFDictionaryRef ____CFURLCreateResourcePropertiesForKeysFromBookmarkData(CFAllocatorRef allocator, CFArrayRef resourcePropertiesToReturn, CFDataRef bookmark)
{
    if (!is_enabled() || !enabled_) {
        CFDictionaryRef return_value = original_CFURLCreateResourcePropertiesForKeysFromBookmarkData(allocator, resourcePropertiesToReturn, bookmark);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(3, sizeof(parameter_t));
//Parse parameter allocator
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)allocator);
//Parse parameter resourcePropertiesToReturn
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFArrayRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)resourcePropertiesToReturn);
    if(resourcePropertiesToReturn) {
        CFStringRef resourcePropertiesToReturn_description = CFCopyDescription(resourcePropertiesToReturn);
        parameters[1].description = (char*)calloc(CFStringGetLength(resourcePropertiesToReturn_description) + 1, sizeof(char));
        memcpy(parameters[1].description, CFStringGetCStringPtr(resourcePropertiesToReturn_description, kCFStringEncodingUTF8), CFStringGetLength(resourcePropertiesToReturn_description));
    }
//Parse parameter bookmark
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFDataRef", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (int)bookmark);
    if(bookmark) {
        CFStringRef bookmark_description = CFCopyDescription(bookmark);
        parameters[2].description = (char*)calloc(CFStringGetLength(bookmark_description) + 1, sizeof(char));
        memcpy(parameters[2].description, CFStringGetCStringPtr(bookmark_description, kCFStringEncodingUTF8), CFStringGetLength(bookmark_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLCreateResourcePropertiesForKeysFromBookmarkData", "0x0", parameters, 3);
            for(unsigned int i = 0; i < 3; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 3; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    CFDictionaryRef return_value = original_CFURLCreateResourcePropertiesForKeysFromBookmarkData(allocator, resourcePropertiesToReturn, bookmark);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFDictionaryRef", MAX_TYPE_LENGTH);
    if(return_value) {
        CFStringRef return_value_description = CFCopyDescription(return_value);
        return_param.description = (char*)calloc(CFStringGetLength(return_value_description) + 1, sizeof(char));
        memcpy(return_param.description, CFStringGetCStringPtr(return_value_description, kCFStringEncodingUTF8), CFStringGetLength(return_value_description));
    }
    snprintf(return_param.value, MAX_VALUE_LENGTH, "0x%X", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


CFTypeRef ____CFURLCreateResourcePropertyForKeyFromBookmarkData(CFAllocatorRef allocator, CFStringRef resourcePropertyKey, CFDataRef bookmark)
{
    if (!is_enabled() || !enabled_) {
        CFTypeRef return_value = original_CFURLCreateResourcePropertyForKeyFromBookmarkData(allocator, resourcePropertyKey, bookmark);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(3, sizeof(parameter_t));
//Parse parameter allocator
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)allocator);
//Parse parameter resourcePropertyKey
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)resourcePropertyKey);
    if(resourcePropertyKey) {
        parameters[1].description = (char*)calloc(CFStringGetLength(resourcePropertyKey)+1, sizeof(char));
        CFStringGetCString(resourcePropertyKey, parameters[1].description, CFStringGetLength(resourcePropertyKey) + 1, kCFStringEncodingUTF8);
    }
//Parse parameter bookmark
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFDataRef", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (int)bookmark);
    if(bookmark) {
        CFStringRef bookmark_description = CFCopyDescription(bookmark);
        parameters[2].description = (char*)calloc(CFStringGetLength(bookmark_description) + 1, sizeof(char));
        memcpy(parameters[2].description, CFStringGetCStringPtr(bookmark_description, kCFStringEncodingUTF8), CFStringGetLength(bookmark_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLCreateResourcePropertyForKeyFromBookmarkData", "0x0", parameters, 3);
            for(unsigned int i = 0; i < 3; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 3; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    CFTypeRef return_value = original_CFURLCreateResourcePropertyForKeyFromBookmarkData(allocator, resourcePropertyKey, bookmark);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFTypeRef", MAX_TYPE_LENGTH);
    if(return_value) {
        CFStringRef return_value_description = CFCopyDescription(return_value);
        return_param.description = (char*)calloc(CFStringGetLength(return_value_description) + 1, sizeof(char));
        memcpy(return_param.description, CFStringGetCStringPtr(return_value_description, kCFStringEncodingUTF8), CFStringGetLength(return_value_description));
    }
    snprintf(return_param.value, MAX_VALUE_LENGTH, "0x%X", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


CFDataRef ____CFURLCreateBookmarkDataFromFile(CFAllocatorRef allocator, CFURLRef fileURL, CFErrorRef * errorRef)
{
    if (!is_enabled() || !enabled_) {
        CFDataRef return_value = original_CFURLCreateBookmarkDataFromFile(allocator, fileURL, errorRef);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(3, sizeof(parameter_t));
//Parse parameter allocator
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)allocator);
//Parse parameter fileURL
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)fileURL);
    if(fileURL) {
        CFStringRef fileURL_description = CFCopyDescription(fileURL);
        parameters[1].description = (char*)calloc(CFStringGetLength(fileURL_description) + 1, sizeof(char));
        memcpy(parameters[1].description, CFStringGetCStringPtr(fileURL_description, kCFStringEncodingUTF8), CFStringGetLength(fileURL_description));
    }
//Parse parameter errorRef
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "^CFErrorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (register_t)errorRef);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLCreateBookmarkDataFromFile", "0x0", parameters, 3);
            for(unsigned int i = 0; i < 3; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 3; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    CFDataRef return_value = original_CFURLCreateBookmarkDataFromFile(allocator, fileURL, errorRef);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFDataRef", MAX_TYPE_LENGTH);
    if(return_value) {
        CFStringRef return_value_description = CFCopyDescription(return_value);
        return_param.description = (char*)calloc(CFStringGetLength(return_value_description) + 1, sizeof(char));
        memcpy(return_param.description, CFStringGetCStringPtr(return_value_description, kCFStringEncodingUTF8), CFStringGetLength(return_value_description));
    }
    snprintf(return_param.value, MAX_VALUE_LENGTH, "0x%X", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


Boolean ____CFURLWriteBookmarkDataToFile(CFDataRef bookmarkRef, CFURLRef fileURL, CFURLBookmarkFileCreationOptions options, CFErrorRef * errorRef)
{
    if (!is_enabled() || !enabled_) {
        Boolean return_value = original_CFURLWriteBookmarkDataToFile(bookmarkRef, fileURL, options, errorRef);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(4, sizeof(parameter_t));
//Parse parameter bookmarkRef
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFDataRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)bookmarkRef);
    if(bookmarkRef) {
        CFStringRef bookmarkRef_description = CFCopyDescription(bookmarkRef);
        parameters[0].description = (char*)calloc(CFStringGetLength(bookmarkRef_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(bookmarkRef_description, kCFStringEncodingUTF8), CFStringGetLength(bookmarkRef_description));
    }
//Parse parameter fileURL
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)fileURL);
    if(fileURL) {
        CFStringRef fileURL_description = CFCopyDescription(fileURL);
        parameters[1].description = (char*)calloc(CFStringGetLength(fileURL_description) + 1, sizeof(char));
        memcpy(parameters[1].description, CFStringGetCStringPtr(fileURL_description, kCFStringEncodingUTF8), CFStringGetLength(fileURL_description));
    }
//Parse parameter options
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFURLBookmarkFileCreationOptions", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "%d", (int)options);
//Parse parameter errorRef
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "^CFErrorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "0x%X", (register_t)errorRef);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLWriteBookmarkDataToFile", "0x0", parameters, 4);
            for(unsigned int i = 0; i < 4; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 4; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    Boolean return_value = original_CFURLWriteBookmarkDataToFile(bookmarkRef, fileURL, options, errorRef);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "Boolean", MAX_TYPE_LENGTH);
    snprintf(return_param.value, MAX_VALUE_LENGTH, "%d", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


Boolean ____CFURLStartAccessingSecurityScopedResource(CFURLRef url)
{
    if (!is_enabled() || !enabled_) {
        Boolean return_value = original_CFURLStartAccessingSecurityScopedResource(url);
        return return_value;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(1, sizeof(parameter_t));
//Parse parameter url
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)url);
    if(url) {
        CFStringRef url_description = CFCopyDescription(url);
        parameters[0].description = (char*)calloc(CFStringGetLength(url_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(url_description, kCFStringEncodingUTF8), CFStringGetLength(url_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLStartAccessingSecurityScopedResource", "0x0", parameters, 1);
            for(unsigned int i = 0; i < 1; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 1; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    Boolean return_value = original_CFURLStartAccessingSecurityScopedResource(url);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "Boolean", MAX_TYPE_LENGTH);
    snprintf(return_param.value, MAX_VALUE_LENGTH, "%d", (int)return_value);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_return(call_id, &return_param);
            set_enabled(true);
        });
    }
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
    return return_value;
}


void ____CFURLStopAccessingSecurityScopedResource(CFURLRef url)
{
    if (!is_enabled() || !enabled_) {
        original_CFURLStopAccessingSecurityScopedResource(url);
        return;
    }
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(1, sizeof(parameter_t));
//Parse parameter url
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)url);
    if(url) {
        CFStringRef url_description = CFCopyDescription(url);
        parameters[0].description = (char*)calloc(CFStringGetLength(url_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(url_description, kCFStringEncodingUTF8), CFStringGetLength(url_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFURL", "CFURLStopAccessingSecurityScopedResource", "0x0", parameters, 1);
            for(unsigned int i = 0; i < 1; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 1; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    original_CFURLStopAccessingSecurityScopedResource(url);
    set_enabled(false);
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
}


