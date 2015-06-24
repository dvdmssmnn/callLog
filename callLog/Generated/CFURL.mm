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
#import "fishhook.h"
#import <semaphore.h>
#import <dlfcn.h>

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

CFTypeID(*original_CFURLGetTypeID)();
CFURLRef(*original_CFURLCreateWithBytes)(CFAllocatorRef, const UInt8 *, CFIndex, CFStringEncoding, CFURLRef);
CFDataRef(*original_CFURLCreateData)(CFAllocatorRef, CFURLRef, CFStringEncoding, Boolean);
CFURLRef(*original_CFURLCreateWithString)(CFAllocatorRef, CFStringRef, CFURLRef);
CFURLRef(*original_CFURLCreateAbsoluteURLWithBytes)(CFAllocatorRef, const UInt8 *, CFIndex, CFStringEncoding, CFURLRef, Boolean);
CFURLRef(*original_CFURLCreateWithFileSystemPath)(CFAllocatorRef, CFStringRef, CFURLPathStyle, Boolean);
CFURLRef(*original_CFURLCreateFromFileSystemRepresentation)(CFAllocatorRef, const UInt8 *, CFIndex, Boolean);
CFURLRef(*original_CFURLCreateWithFileSystemPathRelativeToBase)(CFAllocatorRef, CFStringRef, CFURLPathStyle, Boolean, CFURLRef);
CFURLRef(*original_CFURLCreateFromFileSystemRepresentationRelativeToBase)(CFAllocatorRef, const UInt8 *, CFIndex, Boolean, CFURLRef);
Boolean(*original_CFURLGetFileSystemRepresentation)(CFURLRef, Boolean, UInt8 *, CFIndex);
CFStringRef(*original_CFURLGetString)(CFURLRef);
CFURLRef(*original_CFURLGetBaseURL)(CFURLRef);
Boolean(*original_CFURLCanBeDecomposed)(CFURLRef);
CFStringRef(*original_CFURLCopyScheme)(CFURLRef);
CFStringRef(*original_CFURLCopyNetLocation)(CFURLRef);
CFStringRef(*original_CFURLCopyPath)(CFURLRef);
CFStringRef(*original_CFURLCopyStrictPath)(CFURLRef, Boolean *);
CFStringRef(*original_CFURLCopyFileSystemPath)(CFURLRef, CFURLPathStyle);
Boolean(*original_CFURLHasDirectoryPath)(CFURLRef);
CFStringRef(*original_CFURLCopyResourceSpecifier)(CFURLRef);
CFStringRef(*original_CFURLCopyHostName)(CFURLRef);
SInt32(*original_CFURLGetPortNumber)(CFURLRef);
CFStringRef(*original_CFURLCopyUserName)(CFURLRef);
CFStringRef(*original_CFURLCopyPassword)(CFURLRef);
CFStringRef(*original_CFURLCopyParameterString)(CFURLRef, CFStringRef);
CFStringRef(*original_CFURLCopyQueryString)(CFURLRef, CFStringRef);
CFStringRef(*original_CFURLCopyFragment)(CFURLRef, CFStringRef);
CFStringRef(*original_CFURLCopyLastPathComponent)(CFURLRef);
CFStringRef(*original_CFURLCopyPathExtension)(CFURLRef);
CFURLRef(*original_CFURLCreateCopyAppendingPathComponent)(CFAllocatorRef, CFURLRef, CFStringRef, Boolean);
CFURLRef(*original_CFURLCreateCopyDeletingLastPathComponent)(CFAllocatorRef, CFURLRef);
CFURLRef(*original_CFURLCreateCopyAppendingPathExtension)(CFAllocatorRef, CFURLRef, CFStringRef);
CFURLRef(*original_CFURLCreateCopyDeletingPathExtension)(CFAllocatorRef, CFURLRef);
CFIndex(*original_CFURLGetBytes)(CFURLRef, UInt8 *, CFIndex);
CFRange(*original_CFURLGetByteRangeForComponent)(CFURLRef, CFURLComponentType, CFRange *);
CFStringRef(*original_CFURLCreateStringByReplacingPercentEscapes)(CFAllocatorRef, CFStringRef, CFStringRef);
CFStringRef(*original_CFURLCreateStringByReplacingPercentEscapesUsingEncoding)(CFAllocatorRef, CFStringRef, CFStringRef, CFStringEncoding);
CFStringRef(*original_CFURLCreateStringByAddingPercentEscapes)(CFAllocatorRef, CFStringRef, CFStringRef, CFStringRef, CFStringEncoding);
Boolean(*original_CFURLIsFileReferenceURL)(CFURLRef);
CFURLRef(*original_CFURLCreateFileReferenceURL)(CFAllocatorRef, CFURLRef, CFErrorRef *);
CFURLRef(*original_CFURLCreateFilePathURL)(CFAllocatorRef, CFURLRef, CFErrorRef *);
Boolean(*original_CFURLCopyResourcePropertyForKey)(CFURLRef, CFStringRef, void *, CFErrorRef *);
CFDictionaryRef(*original_CFURLCopyResourcePropertiesForKeys)(CFURLRef, CFArrayRef, CFErrorRef *);
Boolean(*original_CFURLSetResourcePropertyForKey)(CFURLRef, CFStringRef, CFTypeRef, CFErrorRef *);
Boolean(*original_CFURLSetResourcePropertiesForKeys)(CFURLRef, CFDictionaryRef, CFErrorRef *);
void(*original_CFURLClearResourcePropertyCacheForKey)(CFURLRef, CFStringRef);
void(*original_CFURLClearResourcePropertyCache)(CFURLRef);
void(*original_CFURLSetTemporaryResourcePropertyForKey)(CFURLRef, CFStringRef, CFTypeRef);
Boolean(*original_CFURLResourceIsReachable)(CFURLRef, CFErrorRef *);
CFDataRef(*original_CFURLCreateBookmarkData)(CFAllocatorRef, CFURLRef, CFURLBookmarkCreationOptions, CFArrayRef, CFURLRef, CFErrorRef *);
CFURLRef(*original_CFURLCreateByResolvingBookmarkData)(CFAllocatorRef, CFDataRef, CFURLBookmarkResolutionOptions, CFURLRef, CFArrayRef, Boolean *, CFErrorRef *);
CFDictionaryRef(*original_CFURLCreateResourcePropertiesForKeysFromBookmarkData)(CFAllocatorRef, CFArrayRef, CFDataRef);
CFTypeRef(*original_CFURLCreateResourcePropertyForKeyFromBookmarkData)(CFAllocatorRef, CFStringRef, CFDataRef);
CFDataRef(*original_CFURLCreateBookmarkDataFromFile)(CFAllocatorRef, CFURLRef, CFErrorRef *);
Boolean(*original_CFURLWriteBookmarkDataToFile)(CFDataRef, CFURLRef, CFURLBookmarkFileCreationOptions, CFErrorRef *);
Boolean(*original_CFURLStartAccessingSecurityScopedResource)(CFURLRef);
void(*original_CFURLStopAccessingSecurityScopedResource)(CFURLRef);
__attribute__((constructor))
static void initialize() {
    dispatch_async(dispatch_get_main_queue(), ^ {
        struct rebinding rebinds[57];
        original_CFURLGetTypeID = (CFTypeID(*)())CFURLGetTypeID;
        rebinds[0].name = (char*) "CFURLGetTypeID";
        rebinds[0].replacement = (void*) ____CFURLGetTypeID;
        original_CFURLCreateWithBytes = (CFURLRef(*)(CFAllocatorRef, const UInt8 *, CFIndex, CFStringEncoding, CFURLRef))CFURLCreateWithBytes;
        rebinds[1].name = (char*) "CFURLCreateWithBytes";
        rebinds[1].replacement = (void*) ____CFURLCreateWithBytes;
        original_CFURLCreateData = (CFDataRef(*)(CFAllocatorRef, CFURLRef, CFStringEncoding, Boolean))CFURLCreateData;
        rebinds[2].name = (char*) "CFURLCreateData";
        rebinds[2].replacement = (void*) ____CFURLCreateData;
        original_CFURLCreateWithString = (CFURLRef(*)(CFAllocatorRef, CFStringRef, CFURLRef))CFURLCreateWithString;
        rebinds[3].name = (char*) "CFURLCreateWithString";
        rebinds[3].replacement = (void*) ____CFURLCreateWithString;
        original_CFURLCreateAbsoluteURLWithBytes = (CFURLRef(*)(CFAllocatorRef, const UInt8 *, CFIndex, CFStringEncoding, CFURLRef, Boolean))CFURLCreateAbsoluteURLWithBytes;
        rebinds[4].name = (char*) "CFURLCreateAbsoluteURLWithBytes";
        rebinds[4].replacement = (void*) ____CFURLCreateAbsoluteURLWithBytes;
        original_CFURLCreateWithFileSystemPath = (CFURLRef(*)(CFAllocatorRef, CFStringRef, CFURLPathStyle, Boolean))CFURLCreateWithFileSystemPath;
        rebinds[5].name = (char*) "CFURLCreateWithFileSystemPath";
        rebinds[5].replacement = (void*) ____CFURLCreateWithFileSystemPath;
        original_CFURLCreateFromFileSystemRepresentation = (CFURLRef(*)(CFAllocatorRef, const UInt8 *, CFIndex, Boolean))CFURLCreateFromFileSystemRepresentation;
        rebinds[6].name = (char*) "CFURLCreateFromFileSystemRepresentation";
        rebinds[6].replacement = (void*) ____CFURLCreateFromFileSystemRepresentation;
        original_CFURLCreateWithFileSystemPathRelativeToBase = (CFURLRef(*)(CFAllocatorRef, CFStringRef, CFURLPathStyle, Boolean, CFURLRef))CFURLCreateWithFileSystemPathRelativeToBase;
        rebinds[7].name = (char*) "CFURLCreateWithFileSystemPathRelativeToBase";
        rebinds[7].replacement = (void*) ____CFURLCreateWithFileSystemPathRelativeToBase;
        original_CFURLCreateFromFileSystemRepresentationRelativeToBase = (CFURLRef(*)(CFAllocatorRef, const UInt8 *, CFIndex, Boolean, CFURLRef))CFURLCreateFromFileSystemRepresentationRelativeToBase;
        rebinds[8].name = (char*) "CFURLCreateFromFileSystemRepresentationRelativeToBase";
        rebinds[8].replacement = (void*) ____CFURLCreateFromFileSystemRepresentationRelativeToBase;
        original_CFURLGetFileSystemRepresentation = (Boolean(*)(CFURLRef, Boolean, UInt8 *, CFIndex))CFURLGetFileSystemRepresentation;
        rebinds[9].name = (char*) "CFURLGetFileSystemRepresentation";
        rebinds[9].replacement = (void*) ____CFURLGetFileSystemRepresentation;
        original_CFURLGetString = (CFStringRef(*)(CFURLRef))CFURLGetString;
        rebinds[10].name = (char*) "CFURLGetString";
        rebinds[10].replacement = (void*) ____CFURLGetString;
        original_CFURLGetBaseURL = (CFURLRef(*)(CFURLRef))CFURLGetBaseURL;
        rebinds[11].name = (char*) "CFURLGetBaseURL";
        rebinds[11].replacement = (void*) ____CFURLGetBaseURL;
        original_CFURLCanBeDecomposed = (Boolean(*)(CFURLRef))CFURLCanBeDecomposed;
        rebinds[12].name = (char*) "CFURLCanBeDecomposed";
        rebinds[12].replacement = (void*) ____CFURLCanBeDecomposed;
        original_CFURLCopyScheme = (CFStringRef(*)(CFURLRef))CFURLCopyScheme;
        rebinds[13].name = (char*) "CFURLCopyScheme";
        rebinds[13].replacement = (void*) ____CFURLCopyScheme;
        original_CFURLCopyNetLocation = (CFStringRef(*)(CFURLRef))CFURLCopyNetLocation;
        rebinds[14].name = (char*) "CFURLCopyNetLocation";
        rebinds[14].replacement = (void*) ____CFURLCopyNetLocation;
        original_CFURLCopyPath = (CFStringRef(*)(CFURLRef))CFURLCopyPath;
        rebinds[15].name = (char*) "CFURLCopyPath";
        rebinds[15].replacement = (void*) ____CFURLCopyPath;
        original_CFURLCopyStrictPath = (CFStringRef(*)(CFURLRef, Boolean *))CFURLCopyStrictPath;
        rebinds[16].name = (char*) "CFURLCopyStrictPath";
        rebinds[16].replacement = (void*) ____CFURLCopyStrictPath;
        original_CFURLCopyFileSystemPath = (CFStringRef(*)(CFURLRef, CFURLPathStyle))CFURLCopyFileSystemPath;
        rebinds[17].name = (char*) "CFURLCopyFileSystemPath";
        rebinds[17].replacement = (void*) ____CFURLCopyFileSystemPath;
        original_CFURLHasDirectoryPath = (Boolean(*)(CFURLRef))CFURLHasDirectoryPath;
        rebinds[18].name = (char*) "CFURLHasDirectoryPath";
        rebinds[18].replacement = (void*) ____CFURLHasDirectoryPath;
        original_CFURLCopyResourceSpecifier = (CFStringRef(*)(CFURLRef))CFURLCopyResourceSpecifier;
        rebinds[19].name = (char*) "CFURLCopyResourceSpecifier";
        rebinds[19].replacement = (void*) ____CFURLCopyResourceSpecifier;
        original_CFURLCopyHostName = (CFStringRef(*)(CFURLRef))CFURLCopyHostName;
        rebinds[20].name = (char*) "CFURLCopyHostName";
        rebinds[20].replacement = (void*) ____CFURLCopyHostName;
        original_CFURLGetPortNumber = (SInt32(*)(CFURLRef))CFURLGetPortNumber;
        rebinds[21].name = (char*) "CFURLGetPortNumber";
        rebinds[21].replacement = (void*) ____CFURLGetPortNumber;
        original_CFURLCopyUserName = (CFStringRef(*)(CFURLRef))CFURLCopyUserName;
        rebinds[22].name = (char*) "CFURLCopyUserName";
        rebinds[22].replacement = (void*) ____CFURLCopyUserName;
        original_CFURLCopyPassword = (CFStringRef(*)(CFURLRef))CFURLCopyPassword;
        rebinds[23].name = (char*) "CFURLCopyPassword";
        rebinds[23].replacement = (void*) ____CFURLCopyPassword;
        original_CFURLCopyParameterString = (CFStringRef(*)(CFURLRef, CFStringRef))CFURLCopyParameterString;
        rebinds[24].name = (char*) "CFURLCopyParameterString";
        rebinds[24].replacement = (void*) ____CFURLCopyParameterString;
        original_CFURLCopyQueryString = (CFStringRef(*)(CFURLRef, CFStringRef))CFURLCopyQueryString;
        rebinds[25].name = (char*) "CFURLCopyQueryString";
        rebinds[25].replacement = (void*) ____CFURLCopyQueryString;
        original_CFURLCopyFragment = (CFStringRef(*)(CFURLRef, CFStringRef))CFURLCopyFragment;
        rebinds[26].name = (char*) "CFURLCopyFragment";
        rebinds[26].replacement = (void*) ____CFURLCopyFragment;
        original_CFURLCopyLastPathComponent = (CFStringRef(*)(CFURLRef))CFURLCopyLastPathComponent;
        rebinds[27].name = (char*) "CFURLCopyLastPathComponent";
        rebinds[27].replacement = (void*) ____CFURLCopyLastPathComponent;
        original_CFURLCopyPathExtension = (CFStringRef(*)(CFURLRef))CFURLCopyPathExtension;
        rebinds[28].name = (char*) "CFURLCopyPathExtension";
        rebinds[28].replacement = (void*) ____CFURLCopyPathExtension;
        original_CFURLCreateCopyAppendingPathComponent = (CFURLRef(*)(CFAllocatorRef, CFURLRef, CFStringRef, Boolean))CFURLCreateCopyAppendingPathComponent;
        rebinds[29].name = (char*) "CFURLCreateCopyAppendingPathComponent";
        rebinds[29].replacement = (void*) ____CFURLCreateCopyAppendingPathComponent;
        original_CFURLCreateCopyDeletingLastPathComponent = (CFURLRef(*)(CFAllocatorRef, CFURLRef))CFURLCreateCopyDeletingLastPathComponent;
        rebinds[30].name = (char*) "CFURLCreateCopyDeletingLastPathComponent";
        rebinds[30].replacement = (void*) ____CFURLCreateCopyDeletingLastPathComponent;
        original_CFURLCreateCopyAppendingPathExtension = (CFURLRef(*)(CFAllocatorRef, CFURLRef, CFStringRef))CFURLCreateCopyAppendingPathExtension;
        rebinds[31].name = (char*) "CFURLCreateCopyAppendingPathExtension";
        rebinds[31].replacement = (void*) ____CFURLCreateCopyAppendingPathExtension;
        original_CFURLCreateCopyDeletingPathExtension = (CFURLRef(*)(CFAllocatorRef, CFURLRef))CFURLCreateCopyDeletingPathExtension;
        rebinds[32].name = (char*) "CFURLCreateCopyDeletingPathExtension";
        rebinds[32].replacement = (void*) ____CFURLCreateCopyDeletingPathExtension;
        original_CFURLGetBytes = (CFIndex(*)(CFURLRef, UInt8 *, CFIndex))CFURLGetBytes;
        rebinds[33].name = (char*) "CFURLGetBytes";
        rebinds[33].replacement = (void*) ____CFURLGetBytes;
        original_CFURLGetByteRangeForComponent = (CFRange(*)(CFURLRef, CFURLComponentType, CFRange *))CFURLGetByteRangeForComponent;
        rebinds[34].name = (char*) "CFURLGetByteRangeForComponent";
        rebinds[34].replacement = (void*) ____CFURLGetByteRangeForComponent;
        original_CFURLCreateStringByReplacingPercentEscapes = (CFStringRef(*)(CFAllocatorRef, CFStringRef, CFStringRef))CFURLCreateStringByReplacingPercentEscapes;
        rebinds[35].name = (char*) "CFURLCreateStringByReplacingPercentEscapes";
        rebinds[35].replacement = (void*) ____CFURLCreateStringByReplacingPercentEscapes;
        original_CFURLCreateStringByReplacingPercentEscapesUsingEncoding = (CFStringRef(*)(CFAllocatorRef, CFStringRef, CFStringRef, CFStringEncoding))CFURLCreateStringByReplacingPercentEscapesUsingEncoding;
        rebinds[36].name = (char*) "CFURLCreateStringByReplacingPercentEscapesUsingEncoding";
        rebinds[36].replacement = (void*) ____CFURLCreateStringByReplacingPercentEscapesUsingEncoding;
        original_CFURLCreateStringByAddingPercentEscapes = (CFStringRef(*)(CFAllocatorRef, CFStringRef, CFStringRef, CFStringRef, CFStringEncoding))CFURLCreateStringByAddingPercentEscapes;
        rebinds[37].name = (char*) "CFURLCreateStringByAddingPercentEscapes";
        rebinds[37].replacement = (void*) ____CFURLCreateStringByAddingPercentEscapes;
        original_CFURLIsFileReferenceURL = (Boolean(*)(CFURLRef))CFURLIsFileReferenceURL;
        rebinds[38].name = (char*) "CFURLIsFileReferenceURL";
        rebinds[38].replacement = (void*) ____CFURLIsFileReferenceURL;
        original_CFURLCreateFileReferenceURL = (CFURLRef(*)(CFAllocatorRef, CFURLRef, CFErrorRef *))CFURLCreateFileReferenceURL;
        rebinds[39].name = (char*) "CFURLCreateFileReferenceURL";
        rebinds[39].replacement = (void*) ____CFURLCreateFileReferenceURL;
        original_CFURLCreateFilePathURL = (CFURLRef(*)(CFAllocatorRef, CFURLRef, CFErrorRef *))CFURLCreateFilePathURL;
        rebinds[40].name = (char*) "CFURLCreateFilePathURL";
        rebinds[40].replacement = (void*) ____CFURLCreateFilePathURL;
        original_CFURLCopyResourcePropertyForKey = (Boolean(*)(CFURLRef, CFStringRef, void *, CFErrorRef *))CFURLCopyResourcePropertyForKey;
        rebinds[41].name = (char*) "CFURLCopyResourcePropertyForKey";
        rebinds[41].replacement = (void*) ____CFURLCopyResourcePropertyForKey;
        original_CFURLCopyResourcePropertiesForKeys = (CFDictionaryRef(*)(CFURLRef, CFArrayRef, CFErrorRef *))CFURLCopyResourcePropertiesForKeys;
        rebinds[42].name = (char*) "CFURLCopyResourcePropertiesForKeys";
        rebinds[42].replacement = (void*) ____CFURLCopyResourcePropertiesForKeys;
        original_CFURLSetResourcePropertyForKey = (Boolean(*)(CFURLRef, CFStringRef, CFTypeRef, CFErrorRef *))CFURLSetResourcePropertyForKey;
        rebinds[43].name = (char*) "CFURLSetResourcePropertyForKey";
        rebinds[43].replacement = (void*) ____CFURLSetResourcePropertyForKey;
        original_CFURLSetResourcePropertiesForKeys = (Boolean(*)(CFURLRef, CFDictionaryRef, CFErrorRef *))CFURLSetResourcePropertiesForKeys;
        rebinds[44].name = (char*) "CFURLSetResourcePropertiesForKeys";
        rebinds[44].replacement = (void*) ____CFURLSetResourcePropertiesForKeys;
        original_CFURLClearResourcePropertyCacheForKey = (void(*)(CFURLRef, CFStringRef))CFURLClearResourcePropertyCacheForKey;
        rebinds[45].name = (char*) "CFURLClearResourcePropertyCacheForKey";
        rebinds[45].replacement = (void*) ____CFURLClearResourcePropertyCacheForKey;
        original_CFURLClearResourcePropertyCache = (void(*)(CFURLRef))CFURLClearResourcePropertyCache;
        rebinds[46].name = (char*) "CFURLClearResourcePropertyCache";
        rebinds[46].replacement = (void*) ____CFURLClearResourcePropertyCache;
        original_CFURLSetTemporaryResourcePropertyForKey = (void(*)(CFURLRef, CFStringRef, CFTypeRef))CFURLSetTemporaryResourcePropertyForKey;
        rebinds[47].name = (char*) "CFURLSetTemporaryResourcePropertyForKey";
        rebinds[47].replacement = (void*) ____CFURLSetTemporaryResourcePropertyForKey;
        original_CFURLResourceIsReachable = (Boolean(*)(CFURLRef, CFErrorRef *))CFURLResourceIsReachable;
        rebinds[48].name = (char*) "CFURLResourceIsReachable";
        rebinds[48].replacement = (void*) ____CFURLResourceIsReachable;
        original_CFURLCreateBookmarkData = (CFDataRef(*)(CFAllocatorRef, CFURLRef, CFURLBookmarkCreationOptions, CFArrayRef, CFURLRef, CFErrorRef *))CFURLCreateBookmarkData;
        rebinds[49].name = (char*) "CFURLCreateBookmarkData";
        rebinds[49].replacement = (void*) ____CFURLCreateBookmarkData;
        original_CFURLCreateByResolvingBookmarkData = (CFURLRef(*)(CFAllocatorRef, CFDataRef, CFURLBookmarkResolutionOptions, CFURLRef, CFArrayRef, Boolean *, CFErrorRef *))CFURLCreateByResolvingBookmarkData;
        rebinds[50].name = (char*) "CFURLCreateByResolvingBookmarkData";
        rebinds[50].replacement = (void*) ____CFURLCreateByResolvingBookmarkData;
        original_CFURLCreateResourcePropertiesForKeysFromBookmarkData = (CFDictionaryRef(*)(CFAllocatorRef, CFArrayRef, CFDataRef))CFURLCreateResourcePropertiesForKeysFromBookmarkData;
        rebinds[51].name = (char*) "CFURLCreateResourcePropertiesForKeysFromBookmarkData";
        rebinds[51].replacement = (void*) ____CFURLCreateResourcePropertiesForKeysFromBookmarkData;
        original_CFURLCreateResourcePropertyForKeyFromBookmarkData = (CFTypeRef(*)(CFAllocatorRef, CFStringRef, CFDataRef))CFURLCreateResourcePropertyForKeyFromBookmarkData;
        rebinds[52].name = (char*) "CFURLCreateResourcePropertyForKeyFromBookmarkData";
        rebinds[52].replacement = (void*) ____CFURLCreateResourcePropertyForKeyFromBookmarkData;
        original_CFURLCreateBookmarkDataFromFile = (CFDataRef(*)(CFAllocatorRef, CFURLRef, CFErrorRef *))CFURLCreateBookmarkDataFromFile;
        rebinds[53].name = (char*) "CFURLCreateBookmarkDataFromFile";
        rebinds[53].replacement = (void*) ____CFURLCreateBookmarkDataFromFile;
        original_CFURLWriteBookmarkDataToFile = (Boolean(*)(CFDataRef, CFURLRef, CFURLBookmarkFileCreationOptions, CFErrorRef *))CFURLWriteBookmarkDataToFile;
        rebinds[54].name = (char*) "CFURLWriteBookmarkDataToFile";
        rebinds[54].replacement = (void*) ____CFURLWriteBookmarkDataToFile;
        original_CFURLStartAccessingSecurityScopedResource = (Boolean(*)(CFURLRef))CFURLStartAccessingSecurityScopedResource;
        rebinds[55].name = (char*) "CFURLStartAccessingSecurityScopedResource";
        rebinds[55].replacement = (void*) ____CFURLStartAccessingSecurityScopedResource;
        original_CFURLStopAccessingSecurityScopedResource = (void(*)(CFURLRef))CFURLStopAccessingSecurityScopedResource;
        rebinds[56].name = (char*) "CFURLStopAccessingSecurityScopedResource";
        rebinds[56].replacement = (void*) ____CFURLStopAccessingSecurityScopedResource;
    });
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


