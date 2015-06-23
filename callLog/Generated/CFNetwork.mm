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
CFReadStreamRef ____CFReadStreamCreateWithFTPURL(CFAllocatorRef alloc, CFURLRef ftpURL);

CFIndex ____CFFTPCreateParsedResourceListing(CFAllocatorRef alloc, const UInt8 * buffer, CFIndex bufferLength, CFDictionaryRef * parsed);

CFWriteStreamRef ____CFWriteStreamCreateWithFTPURL(CFAllocatorRef alloc, CFURLRef ftpURL);

CFHostRef ____CFHostCreateWithName(CFAllocatorRef allocator, CFStringRef hostname);

CFHostRef ____CFHostCreateWithAddress(CFAllocatorRef allocator, CFDataRef addr);

CFHTTPAuthenticationRef ____CFHTTPAuthenticationCreateFromResponse(CFAllocatorRef alloc, CFHTTPMessageRef response);

Boolean ____CFHTTPAuthenticationIsValid(CFHTTPAuthenticationRef auth, CFStreamError * error);

Boolean ____CFHTTPAuthenticationAppliesToRequest(CFHTTPAuthenticationRef auth, CFHTTPMessageRef request);

Boolean ____CFHTTPAuthenticationRequiresOrderedRequests(CFHTTPAuthenticationRef auth);

Boolean ____CFHTTPMessageApplyCredentials(CFHTTPMessageRef request, CFHTTPAuthenticationRef auth, CFStringRef username, CFStringRef password, CFStreamError * error);

Boolean ____CFHTTPMessageApplyCredentialDictionary(CFHTTPMessageRef request, CFHTTPAuthenticationRef auth, CFDictionaryRef dict, CFStreamError * error);

CFStringRef ____CFHTTPAuthenticationCopyRealm(CFHTTPAuthenticationRef auth);

CFArrayRef ____CFHTTPAuthenticationCopyDomains(CFHTTPAuthenticationRef auth);

CFStringRef ____CFHTTPAuthenticationCopyMethod(CFHTTPAuthenticationRef auth);

Boolean ____CFHTTPAuthenticationRequiresUserNameAndPassword(CFHTTPAuthenticationRef auth);

Boolean ____CFHTTPAuthenticationRequiresAccountDomain(CFHTTPAuthenticationRef auth);

CFHTTPMessageRef ____CFHTTPMessageCreateRequest(CFAllocatorRef alloc, CFStringRef requestMethod, CFURLRef url, CFStringRef httpVersion);

CFHTTPMessageRef ____CFHTTPMessageCreateResponse(CFAllocatorRef alloc, CFIndex statusCode, CFStringRef statusDescription, CFStringRef httpVersion);

CFHTTPMessageRef ____CFHTTPMessageCreateEmpty(CFAllocatorRef alloc, Boolean isRequest);

CFHTTPMessageRef ____CFHTTPMessageCreateCopy(CFAllocatorRef alloc, CFHTTPMessageRef message);

Boolean ____CFHTTPMessageIsRequest(CFHTTPMessageRef message);

CFStringRef ____CFHTTPMessageCopyVersion(CFHTTPMessageRef message);

CFDataRef ____CFHTTPMessageCopyBody(CFHTTPMessageRef message);

void ____CFHTTPMessageSetBody(CFHTTPMessageRef message, CFDataRef bodyData);

CFStringRef ____CFHTTPMessageCopyHeaderFieldValue(CFHTTPMessageRef message, CFStringRef headerField);

CFDictionaryRef ____CFHTTPMessageCopyAllHeaderFields(CFHTTPMessageRef message);

void ____CFHTTPMessageSetHeaderFieldValue(CFHTTPMessageRef message, CFStringRef headerField, CFStringRef value);

Boolean ____CFHTTPMessageAppendBytes(CFHTTPMessageRef message, const UInt8 * newBytes, CFIndex numBytes);

CFURLRef ____CFHTTPMessageCopyRequestURL(CFHTTPMessageRef request);

CFStringRef ____CFHTTPMessageCopyRequestMethod(CFHTTPMessageRef request);

Boolean ____CFHTTPMessageAddAuthentication(CFHTTPMessageRef request, CFHTTPMessageRef authenticationFailureResponse, CFStringRef username, CFStringRef password, CFStringRef authenticationScheme, Boolean forProxy);

CFIndex ____CFHTTPMessageGetResponseStatusCode(CFHTTPMessageRef response);

CFStringRef ____CFHTTPMessageCopyResponseStatusLine(CFHTTPMessageRef response);

CFReadStreamRef ____CFReadStreamCreateForHTTPRequest(CFAllocatorRef alloc, CFHTTPMessageRef request);

CFReadStreamRef ____CFReadStreamCreateForStreamedHTTPRequest(CFAllocatorRef alloc, CFHTTPMessageRef requestHeaders, CFReadStreamRef requestBody);

CFNetDiagnosticRef ____CFNetDiagnosticCreateWithStreams(CFAllocatorRef alloc, CFReadStreamRef readStream, CFWriteStreamRef writeStream);

CFNetDiagnosticRef ____CFNetDiagnosticCreateWithURL(CFAllocatorRef alloc, CFURLRef url);

void ____CFNetDiagnosticSetName(CFNetDiagnosticRef details, CFStringRef name);

CFNetDiagnosticStatus ____CFNetDiagnosticDiagnoseProblemInteractively(CFNetDiagnosticRef details);

CFNetDiagnosticStatus ____CFNetDiagnosticCopyNetworkStatusPassively(CFNetDiagnosticRef details, CFStringRef * description);

CFNetServiceRef ____CFNetServiceCreate(CFAllocatorRef alloc, CFStringRef domain, CFStringRef serviceType, CFStringRef name, SInt32 port);

CFNetServiceRef ____CFNetServiceCreateCopy(CFAllocatorRef alloc, CFNetServiceRef service);

CFStringRef ____CFNetServiceGetDomain(CFNetServiceRef theService);

CFStringRef ____CFNetServiceGetType(CFNetServiceRef theService);

CFStringRef ____CFNetServiceGetName(CFNetServiceRef theService);

Boolean ____CFNetServiceRegisterWithOptions(CFNetServiceRef theService, CFOptionFlags options, CFStreamError * error);

Boolean ____CFNetServiceResolveWithTimeout(CFNetServiceRef theService, CFTimeInterval timeout, CFStreamError * error);

void ____CFNetServiceCancel(CFNetServiceRef theService);

CFStringRef ____CFNetServiceGetTargetHost(CFNetServiceRef theService);

SInt32 ____CFNetServiceGetPortNumber(CFNetServiceRef theService);

CFArrayRef ____CFNetServiceGetAddressing(CFNetServiceRef theService);

CFDataRef ____CFNetServiceGetTXTData(CFNetServiceRef theService);

Boolean ____CFNetServiceSetTXTData(CFNetServiceRef theService, CFDataRef txtRecord);

CFDictionaryRef ____CFNetServiceCreateDictionaryWithTXTData(CFAllocatorRef alloc, CFDataRef txtRecord);

CFDataRef ____CFNetServiceCreateTXTDataWithDictionary(CFAllocatorRef alloc, CFDictionaryRef keyValuePairs);

Boolean ____CFNetServiceSetClient(CFNetServiceRef theService, CFNetServiceClientCallBack clientCB, CFNetServiceClientContext * clientContext);

void ____CFNetServiceScheduleWithRunLoop(CFNetServiceRef theService, CFRunLoopRef runLoop, CFStringRef runLoopMode);

void ____CFNetServiceUnscheduleFromRunLoop(CFNetServiceRef theService, CFRunLoopRef runLoop, CFStringRef runLoopMode);

CFNetServiceMonitorRef ____CFNetServiceMonitorCreate(CFAllocatorRef alloc, CFNetServiceRef theService, CFNetServiceMonitorClientCallBack clientCB, CFNetServiceClientContext * clientContext);

void ____CFNetServiceMonitorInvalidate(CFNetServiceMonitorRef monitor);

Boolean ____CFNetServiceMonitorStart(CFNetServiceMonitorRef monitor, CFNetServiceMonitorType recordType, CFStreamError * error);

void ____CFNetServiceMonitorStop(CFNetServiceMonitorRef monitor, CFStreamError * error);

void ____CFNetServiceMonitorScheduleWithRunLoop(CFNetServiceMonitorRef monitor, CFRunLoopRef runLoop, CFStringRef runLoopMode);

void ____CFNetServiceMonitorUnscheduleFromRunLoop(CFNetServiceMonitorRef monitor, CFRunLoopRef runLoop, CFStringRef runLoopMode);

CFNetServiceBrowserRef ____CFNetServiceBrowserCreate(CFAllocatorRef alloc, CFNetServiceBrowserClientCallBack clientCB, CFNetServiceClientContext * clientContext);

void ____CFNetServiceBrowserInvalidate(CFNetServiceBrowserRef browser);

Boolean ____CFNetServiceBrowserSearchForDomains(CFNetServiceBrowserRef browser, Boolean registrationDomains, CFStreamError * error);

Boolean ____CFNetServiceBrowserSearchForServices(CFNetServiceBrowserRef browser, CFStringRef domain, CFStringRef serviceType, CFStreamError * error);

void ____CFNetServiceBrowserStopSearch(CFNetServiceBrowserRef browser, CFStreamError * error);

void ____CFNetServiceBrowserScheduleWithRunLoop(CFNetServiceBrowserRef browser, CFRunLoopRef runLoop, CFStringRef runLoopMode);

void ____CFNetServiceBrowserUnscheduleFromRunLoop(CFNetServiceBrowserRef browser, CFRunLoopRef runLoop, CFStringRef runLoopMode);

CFArrayRef ____CFNetworkCopyProxiesForURL(CFURLRef url, CFDictionaryRef proxySettings);

CFArrayRef ____CFNetworkCopyProxiesForAutoConfigurationScript(CFStringRef proxyAutoConfigurationScript, CFURLRef targetURL, CFErrorRef * error);

CFRunLoopSourceRef ____CFNetworkExecuteProxyAutoConfigurationScript(CFStringRef proxyAutoConfigurationScript, CFURLRef targetURL, CFProxyAutoConfigurationResultCallback cb, CFStreamClientContext * clientContext);

CFRunLoopSourceRef ____CFNetworkExecuteProxyAutoConfigurationURL(CFURLRef proxyAutoConfigURL, CFURLRef targetURL, CFProxyAutoConfigurationResultCallback cb, CFStreamClientContext * clientContext);

SInt32 ____CFSocketStreamSOCKSGetErrorSubdomain(const CFStreamError * error);

SInt32 ____CFSocketStreamSOCKSGetError(const CFStreamError * error);

void ____CFStreamCreatePairWithSocketToCFHost(CFAllocatorRef alloc, CFHostRef host, SInt32 port, CFReadStreamRef * readStream, CFWriteStreamRef * writeStream);

void ____CFStreamCreatePairWithSocketToNetService(CFAllocatorRef alloc, CFNetServiceRef service, CFReadStreamRef * readStream, CFWriteStreamRef * writeStream);

CFReadStreamRef (*original_CFReadStreamCreateWithFTPURL)(CFAllocatorRef, CFURLRef);
CFIndex (*original_CFFTPCreateParsedResourceListing)(CFAllocatorRef, const UInt8 *, CFIndex, CFDictionaryRef *);
CFWriteStreamRef (*original_CFWriteStreamCreateWithFTPURL)(CFAllocatorRef, CFURLRef);
CFHostRef (*original_CFHostCreateWithName)(CFAllocatorRef, CFStringRef);
CFHostRef (*original_CFHostCreateWithAddress)(CFAllocatorRef, CFDataRef);
CFHTTPAuthenticationRef (*original_CFHTTPAuthenticationCreateFromResponse)(CFAllocatorRef, CFHTTPMessageRef);
Boolean (*original_CFHTTPAuthenticationIsValid)(CFHTTPAuthenticationRef, CFStreamError *);
Boolean (*original_CFHTTPAuthenticationAppliesToRequest)(CFHTTPAuthenticationRef, CFHTTPMessageRef);
Boolean (*original_CFHTTPAuthenticationRequiresOrderedRequests)(CFHTTPAuthenticationRef);
Boolean (*original_CFHTTPMessageApplyCredentials)(CFHTTPMessageRef, CFHTTPAuthenticationRef, CFStringRef, CFStringRef, CFStreamError *);
Boolean (*original_CFHTTPMessageApplyCredentialDictionary)(CFHTTPMessageRef, CFHTTPAuthenticationRef, CFDictionaryRef, CFStreamError *);
CFStringRef (*original_CFHTTPAuthenticationCopyRealm)(CFHTTPAuthenticationRef);
CFArrayRef (*original_CFHTTPAuthenticationCopyDomains)(CFHTTPAuthenticationRef);
CFStringRef (*original_CFHTTPAuthenticationCopyMethod)(CFHTTPAuthenticationRef);
Boolean (*original_CFHTTPAuthenticationRequiresUserNameAndPassword)(CFHTTPAuthenticationRef);
Boolean (*original_CFHTTPAuthenticationRequiresAccountDomain)(CFHTTPAuthenticationRef);
CFHTTPMessageRef (*original_CFHTTPMessageCreateRequest)(CFAllocatorRef, CFStringRef, CFURLRef, CFStringRef);
CFHTTPMessageRef (*original_CFHTTPMessageCreateResponse)(CFAllocatorRef, CFIndex, CFStringRef, CFStringRef);
CFHTTPMessageRef (*original_CFHTTPMessageCreateEmpty)(CFAllocatorRef, Boolean);
CFHTTPMessageRef (*original_CFHTTPMessageCreateCopy)(CFAllocatorRef, CFHTTPMessageRef);
Boolean (*original_CFHTTPMessageIsRequest)(CFHTTPMessageRef);
CFStringRef (*original_CFHTTPMessageCopyVersion)(CFHTTPMessageRef);
CFDataRef (*original_CFHTTPMessageCopyBody)(CFHTTPMessageRef);
void (*original_CFHTTPMessageSetBody)(CFHTTPMessageRef, CFDataRef);
CFStringRef (*original_CFHTTPMessageCopyHeaderFieldValue)(CFHTTPMessageRef, CFStringRef);
CFDictionaryRef (*original_CFHTTPMessageCopyAllHeaderFields)(CFHTTPMessageRef);
void (*original_CFHTTPMessageSetHeaderFieldValue)(CFHTTPMessageRef, CFStringRef, CFStringRef);
Boolean (*original_CFHTTPMessageAppendBytes)(CFHTTPMessageRef, const UInt8 *, CFIndex);
CFURLRef (*original_CFHTTPMessageCopyRequestURL)(CFHTTPMessageRef);
CFStringRef (*original_CFHTTPMessageCopyRequestMethod)(CFHTTPMessageRef);
Boolean (*original_CFHTTPMessageAddAuthentication)(CFHTTPMessageRef, CFHTTPMessageRef, CFStringRef, CFStringRef, CFStringRef, Boolean);
CFIndex (*original_CFHTTPMessageGetResponseStatusCode)(CFHTTPMessageRef);
CFStringRef (*original_CFHTTPMessageCopyResponseStatusLine)(CFHTTPMessageRef);
CFReadStreamRef (*original_CFReadStreamCreateForHTTPRequest)(CFAllocatorRef, CFHTTPMessageRef);
CFReadStreamRef (*original_CFReadStreamCreateForStreamedHTTPRequest)(CFAllocatorRef, CFHTTPMessageRef, CFReadStreamRef);
CFNetDiagnosticRef (*original_CFNetDiagnosticCreateWithStreams)(CFAllocatorRef, CFReadStreamRef, CFWriteStreamRef);
CFNetDiagnosticRef (*original_CFNetDiagnosticCreateWithURL)(CFAllocatorRef, CFURLRef);
void (*original_CFNetDiagnosticSetName)(CFNetDiagnosticRef, CFStringRef);
CFNetDiagnosticStatus (*original_CFNetDiagnosticDiagnoseProblemInteractively)(CFNetDiagnosticRef);
CFNetDiagnosticStatus (*original_CFNetDiagnosticCopyNetworkStatusPassively)(CFNetDiagnosticRef, CFStringRef *);
CFNetServiceRef (*original_CFNetServiceCreate)(CFAllocatorRef, CFStringRef, CFStringRef, CFStringRef, SInt32);
CFNetServiceRef (*original_CFNetServiceCreateCopy)(CFAllocatorRef, CFNetServiceRef);
CFStringRef (*original_CFNetServiceGetDomain)(CFNetServiceRef);
CFStringRef (*original_CFNetServiceGetType)(CFNetServiceRef);
CFStringRef (*original_CFNetServiceGetName)(CFNetServiceRef);
Boolean (*original_CFNetServiceRegisterWithOptions)(CFNetServiceRef, CFOptionFlags, CFStreamError *);
Boolean (*original_CFNetServiceResolveWithTimeout)(CFNetServiceRef, CFTimeInterval, CFStreamError *);
void (*original_CFNetServiceCancel)(CFNetServiceRef);
CFStringRef (*original_CFNetServiceGetTargetHost)(CFNetServiceRef);
SInt32 (*original_CFNetServiceGetPortNumber)(CFNetServiceRef);
CFArrayRef (*original_CFNetServiceGetAddressing)(CFNetServiceRef);
CFDataRef (*original_CFNetServiceGetTXTData)(CFNetServiceRef);
Boolean (*original_CFNetServiceSetTXTData)(CFNetServiceRef, CFDataRef);
CFDictionaryRef (*original_CFNetServiceCreateDictionaryWithTXTData)(CFAllocatorRef, CFDataRef);
CFDataRef (*original_CFNetServiceCreateTXTDataWithDictionary)(CFAllocatorRef, CFDictionaryRef);
Boolean (*original_CFNetServiceSetClient)(CFNetServiceRef, CFNetServiceClientCallBack, CFNetServiceClientContext *);
void (*original_CFNetServiceScheduleWithRunLoop)(CFNetServiceRef, CFRunLoopRef, CFStringRef);
void (*original_CFNetServiceUnscheduleFromRunLoop)(CFNetServiceRef, CFRunLoopRef, CFStringRef);
CFNetServiceMonitorRef (*original_CFNetServiceMonitorCreate)(CFAllocatorRef, CFNetServiceRef, CFNetServiceMonitorClientCallBack, CFNetServiceClientContext *);
void (*original_CFNetServiceMonitorInvalidate)(CFNetServiceMonitorRef);
Boolean (*original_CFNetServiceMonitorStart)(CFNetServiceMonitorRef, CFNetServiceMonitorType, CFStreamError *);
void (*original_CFNetServiceMonitorStop)(CFNetServiceMonitorRef, CFStreamError *);
void (*original_CFNetServiceMonitorScheduleWithRunLoop)(CFNetServiceMonitorRef, CFRunLoopRef, CFStringRef);
void (*original_CFNetServiceMonitorUnscheduleFromRunLoop)(CFNetServiceMonitorRef, CFRunLoopRef, CFStringRef);
CFNetServiceBrowserRef (*original_CFNetServiceBrowserCreate)(CFAllocatorRef, CFNetServiceBrowserClientCallBack, CFNetServiceClientContext *);
void (*original_CFNetServiceBrowserInvalidate)(CFNetServiceBrowserRef);
Boolean (*original_CFNetServiceBrowserSearchForDomains)(CFNetServiceBrowserRef, Boolean, CFStreamError *);
Boolean (*original_CFNetServiceBrowserSearchForServices)(CFNetServiceBrowserRef, CFStringRef, CFStringRef, CFStreamError *);
void (*original_CFNetServiceBrowserStopSearch)(CFNetServiceBrowserRef, CFStreamError *);
void (*original_CFNetServiceBrowserScheduleWithRunLoop)(CFNetServiceBrowserRef, CFRunLoopRef, CFStringRef);
void (*original_CFNetServiceBrowserUnscheduleFromRunLoop)(CFNetServiceBrowserRef, CFRunLoopRef, CFStringRef);
CFArrayRef (*original_CFNetworkCopyProxiesForURL)(CFURLRef, CFDictionaryRef);
CFArrayRef (*original_CFNetworkCopyProxiesForAutoConfigurationScript)(CFStringRef, CFURLRef, CFErrorRef *);
CFRunLoopSourceRef (*original_CFNetworkExecuteProxyAutoConfigurationScript)(CFStringRef, CFURLRef, CFProxyAutoConfigurationResultCallback, CFStreamClientContext *);
CFRunLoopSourceRef (*original_CFNetworkExecuteProxyAutoConfigurationURL)(CFURLRef, CFURLRef, CFProxyAutoConfigurationResultCallback, CFStreamClientContext *);
SInt32 (*original_CFSocketStreamSOCKSGetErrorSubdomain)(const CFStreamError *);
SInt32 (*original_CFSocketStreamSOCKSGetError)(const CFStreamError *);
void (*original_CFStreamCreatePairWithSocketToCFHost)(CFAllocatorRef, CFHostRef, SInt32, CFReadStreamRef *, CFWriteStreamRef *);
void (*original_CFStreamCreatePairWithSocketToNetService)(CFAllocatorRef, CFNetServiceRef, CFReadStreamRef *, CFWriteStreamRef *);
__attribute__((constructor))
static void initialize() {
    dispatch_async(dispatch_get_main_queue(), ^ {
        MSHookFunction((void*)&CFReadStreamCreateWithFTPURL, (void*)&____CFReadStreamCreateWithFTPURL, (void**)&original_CFReadStreamCreateWithFTPURL);
        MSHookFunction((void*)&CFFTPCreateParsedResourceListing, (void*)&____CFFTPCreateParsedResourceListing, (void**)&original_CFFTPCreateParsedResourceListing);
        MSHookFunction((void*)&CFWriteStreamCreateWithFTPURL, (void*)&____CFWriteStreamCreateWithFTPURL, (void**)&original_CFWriteStreamCreateWithFTPURL);
        MSHookFunction((void*)&CFHostCreateWithName, (void*)&____CFHostCreateWithName, (void**)&original_CFHostCreateWithName);
        MSHookFunction((void*)&CFHostCreateWithAddress, (void*)&____CFHostCreateWithAddress, (void**)&original_CFHostCreateWithAddress);
        MSHookFunction((void*)&CFHTTPAuthenticationCreateFromResponse, (void*)&____CFHTTPAuthenticationCreateFromResponse, (void**)&original_CFHTTPAuthenticationCreateFromResponse);
        MSHookFunction((void*)&CFHTTPAuthenticationIsValid, (void*)&____CFHTTPAuthenticationIsValid, (void**)&original_CFHTTPAuthenticationIsValid);
        MSHookFunction((void*)&CFHTTPAuthenticationAppliesToRequest, (void*)&____CFHTTPAuthenticationAppliesToRequest, (void**)&original_CFHTTPAuthenticationAppliesToRequest);
        MSHookFunction((void*)&CFHTTPAuthenticationRequiresOrderedRequests, (void*)&____CFHTTPAuthenticationRequiresOrderedRequests, (void**)&original_CFHTTPAuthenticationRequiresOrderedRequests);
        MSHookFunction((void*)&CFHTTPMessageApplyCredentials, (void*)&____CFHTTPMessageApplyCredentials, (void**)&original_CFHTTPMessageApplyCredentials);
        MSHookFunction((void*)&CFHTTPMessageApplyCredentialDictionary, (void*)&____CFHTTPMessageApplyCredentialDictionary, (void**)&original_CFHTTPMessageApplyCredentialDictionary);
        MSHookFunction((void*)&CFHTTPAuthenticationCopyRealm, (void*)&____CFHTTPAuthenticationCopyRealm, (void**)&original_CFHTTPAuthenticationCopyRealm);
        MSHookFunction((void*)&CFHTTPAuthenticationCopyDomains, (void*)&____CFHTTPAuthenticationCopyDomains, (void**)&original_CFHTTPAuthenticationCopyDomains);
        MSHookFunction((void*)&CFHTTPAuthenticationCopyMethod, (void*)&____CFHTTPAuthenticationCopyMethod, (void**)&original_CFHTTPAuthenticationCopyMethod);
        MSHookFunction((void*)&CFHTTPAuthenticationRequiresUserNameAndPassword, (void*)&____CFHTTPAuthenticationRequiresUserNameAndPassword, (void**)&original_CFHTTPAuthenticationRequiresUserNameAndPassword);
        MSHookFunction((void*)&CFHTTPAuthenticationRequiresAccountDomain, (void*)&____CFHTTPAuthenticationRequiresAccountDomain, (void**)&original_CFHTTPAuthenticationRequiresAccountDomain);
        MSHookFunction((void*)&CFHTTPMessageCreateRequest, (void*)&____CFHTTPMessageCreateRequest, (void**)&original_CFHTTPMessageCreateRequest);
        MSHookFunction((void*)&CFHTTPMessageCreateResponse, (void*)&____CFHTTPMessageCreateResponse, (void**)&original_CFHTTPMessageCreateResponse);
        MSHookFunction((void*)&CFHTTPMessageCreateEmpty, (void*)&____CFHTTPMessageCreateEmpty, (void**)&original_CFHTTPMessageCreateEmpty);
        MSHookFunction((void*)&CFHTTPMessageCreateCopy, (void*)&____CFHTTPMessageCreateCopy, (void**)&original_CFHTTPMessageCreateCopy);
        MSHookFunction((void*)&CFHTTPMessageIsRequest, (void*)&____CFHTTPMessageIsRequest, (void**)&original_CFHTTPMessageIsRequest);
        MSHookFunction((void*)&CFHTTPMessageCopyVersion, (void*)&____CFHTTPMessageCopyVersion, (void**)&original_CFHTTPMessageCopyVersion);
        MSHookFunction((void*)&CFHTTPMessageCopyBody, (void*)&____CFHTTPMessageCopyBody, (void**)&original_CFHTTPMessageCopyBody);
        MSHookFunction((void*)&CFHTTPMessageSetBody, (void*)&____CFHTTPMessageSetBody, (void**)&original_CFHTTPMessageSetBody);
        MSHookFunction((void*)&CFHTTPMessageCopyHeaderFieldValue, (void*)&____CFHTTPMessageCopyHeaderFieldValue, (void**)&original_CFHTTPMessageCopyHeaderFieldValue);
        MSHookFunction((void*)&CFHTTPMessageCopyAllHeaderFields, (void*)&____CFHTTPMessageCopyAllHeaderFields, (void**)&original_CFHTTPMessageCopyAllHeaderFields);
        MSHookFunction((void*)&CFHTTPMessageSetHeaderFieldValue, (void*)&____CFHTTPMessageSetHeaderFieldValue, (void**)&original_CFHTTPMessageSetHeaderFieldValue);
        MSHookFunction((void*)&CFHTTPMessageAppendBytes, (void*)&____CFHTTPMessageAppendBytes, (void**)&original_CFHTTPMessageAppendBytes);
        MSHookFunction((void*)&CFHTTPMessageCopyRequestURL, (void*)&____CFHTTPMessageCopyRequestURL, (void**)&original_CFHTTPMessageCopyRequestURL);
        MSHookFunction((void*)&CFHTTPMessageCopyRequestMethod, (void*)&____CFHTTPMessageCopyRequestMethod, (void**)&original_CFHTTPMessageCopyRequestMethod);
        MSHookFunction((void*)&CFHTTPMessageAddAuthentication, (void*)&____CFHTTPMessageAddAuthentication, (void**)&original_CFHTTPMessageAddAuthentication);
        MSHookFunction((void*)&CFHTTPMessageGetResponseStatusCode, (void*)&____CFHTTPMessageGetResponseStatusCode, (void**)&original_CFHTTPMessageGetResponseStatusCode);
        MSHookFunction((void*)&CFHTTPMessageCopyResponseStatusLine, (void*)&____CFHTTPMessageCopyResponseStatusLine, (void**)&original_CFHTTPMessageCopyResponseStatusLine);
        MSHookFunction((void*)&CFReadStreamCreateForHTTPRequest, (void*)&____CFReadStreamCreateForHTTPRequest, (void**)&original_CFReadStreamCreateForHTTPRequest);
        MSHookFunction((void*)&CFReadStreamCreateForStreamedHTTPRequest, (void*)&____CFReadStreamCreateForStreamedHTTPRequest, (void**)&original_CFReadStreamCreateForStreamedHTTPRequest);
        MSHookFunction((void*)&CFNetDiagnosticCreateWithStreams, (void*)&____CFNetDiagnosticCreateWithStreams, (void**)&original_CFNetDiagnosticCreateWithStreams);
        MSHookFunction((void*)&CFNetDiagnosticCreateWithURL, (void*)&____CFNetDiagnosticCreateWithURL, (void**)&original_CFNetDiagnosticCreateWithURL);
        MSHookFunction((void*)&CFNetDiagnosticSetName, (void*)&____CFNetDiagnosticSetName, (void**)&original_CFNetDiagnosticSetName);
        MSHookFunction((void*)&CFNetDiagnosticDiagnoseProblemInteractively, (void*)&____CFNetDiagnosticDiagnoseProblemInteractively, (void**)&original_CFNetDiagnosticDiagnoseProblemInteractively);
        MSHookFunction((void*)&CFNetDiagnosticCopyNetworkStatusPassively, (void*)&____CFNetDiagnosticCopyNetworkStatusPassively, (void**)&original_CFNetDiagnosticCopyNetworkStatusPassively);
        MSHookFunction((void*)&CFNetServiceCreate, (void*)&____CFNetServiceCreate, (void**)&original_CFNetServiceCreate);
        MSHookFunction((void*)&CFNetServiceCreateCopy, (void*)&____CFNetServiceCreateCopy, (void**)&original_CFNetServiceCreateCopy);
        MSHookFunction((void*)&CFNetServiceGetDomain, (void*)&____CFNetServiceGetDomain, (void**)&original_CFNetServiceGetDomain);
        MSHookFunction((void*)&CFNetServiceGetType, (void*)&____CFNetServiceGetType, (void**)&original_CFNetServiceGetType);
        MSHookFunction((void*)&CFNetServiceGetName, (void*)&____CFNetServiceGetName, (void**)&original_CFNetServiceGetName);
        MSHookFunction((void*)&CFNetServiceRegisterWithOptions, (void*)&____CFNetServiceRegisterWithOptions, (void**)&original_CFNetServiceRegisterWithOptions);
        MSHookFunction((void*)&CFNetServiceResolveWithTimeout, (void*)&____CFNetServiceResolveWithTimeout, (void**)&original_CFNetServiceResolveWithTimeout);
        MSHookFunction((void*)&CFNetServiceCancel, (void*)&____CFNetServiceCancel, (void**)&original_CFNetServiceCancel);
        MSHookFunction((void*)&CFNetServiceGetTargetHost, (void*)&____CFNetServiceGetTargetHost, (void**)&original_CFNetServiceGetTargetHost);
        MSHookFunction((void*)&CFNetServiceGetPortNumber, (void*)&____CFNetServiceGetPortNumber, (void**)&original_CFNetServiceGetPortNumber);
        MSHookFunction((void*)&CFNetServiceGetAddressing, (void*)&____CFNetServiceGetAddressing, (void**)&original_CFNetServiceGetAddressing);
        MSHookFunction((void*)&CFNetServiceGetTXTData, (void*)&____CFNetServiceGetTXTData, (void**)&original_CFNetServiceGetTXTData);
        MSHookFunction((void*)&CFNetServiceSetTXTData, (void*)&____CFNetServiceSetTXTData, (void**)&original_CFNetServiceSetTXTData);
        MSHookFunction((void*)&CFNetServiceCreateDictionaryWithTXTData, (void*)&____CFNetServiceCreateDictionaryWithTXTData, (void**)&original_CFNetServiceCreateDictionaryWithTXTData);
        MSHookFunction((void*)&CFNetServiceCreateTXTDataWithDictionary, (void*)&____CFNetServiceCreateTXTDataWithDictionary, (void**)&original_CFNetServiceCreateTXTDataWithDictionary);
        MSHookFunction((void*)&CFNetServiceSetClient, (void*)&____CFNetServiceSetClient, (void**)&original_CFNetServiceSetClient);
        MSHookFunction((void*)&CFNetServiceScheduleWithRunLoop, (void*)&____CFNetServiceScheduleWithRunLoop, (void**)&original_CFNetServiceScheduleWithRunLoop);
        MSHookFunction((void*)&CFNetServiceUnscheduleFromRunLoop, (void*)&____CFNetServiceUnscheduleFromRunLoop, (void**)&original_CFNetServiceUnscheduleFromRunLoop);
        MSHookFunction((void*)&CFNetServiceMonitorCreate, (void*)&____CFNetServiceMonitorCreate, (void**)&original_CFNetServiceMonitorCreate);
        MSHookFunction((void*)&CFNetServiceMonitorInvalidate, (void*)&____CFNetServiceMonitorInvalidate, (void**)&original_CFNetServiceMonitorInvalidate);
        MSHookFunction((void*)&CFNetServiceMonitorStart, (void*)&____CFNetServiceMonitorStart, (void**)&original_CFNetServiceMonitorStart);
        MSHookFunction((void*)&CFNetServiceMonitorStop, (void*)&____CFNetServiceMonitorStop, (void**)&original_CFNetServiceMonitorStop);
        MSHookFunction((void*)&CFNetServiceMonitorScheduleWithRunLoop, (void*)&____CFNetServiceMonitorScheduleWithRunLoop, (void**)&original_CFNetServiceMonitorScheduleWithRunLoop);
        MSHookFunction((void*)&CFNetServiceMonitorUnscheduleFromRunLoop, (void*)&____CFNetServiceMonitorUnscheduleFromRunLoop, (void**)&original_CFNetServiceMonitorUnscheduleFromRunLoop);
        MSHookFunction((void*)&CFNetServiceBrowserCreate, (void*)&____CFNetServiceBrowserCreate, (void**)&original_CFNetServiceBrowserCreate);
        MSHookFunction((void*)&CFNetServiceBrowserInvalidate, (void*)&____CFNetServiceBrowserInvalidate, (void**)&original_CFNetServiceBrowserInvalidate);
        MSHookFunction((void*)&CFNetServiceBrowserSearchForDomains, (void*)&____CFNetServiceBrowserSearchForDomains, (void**)&original_CFNetServiceBrowserSearchForDomains);
        MSHookFunction((void*)&CFNetServiceBrowserSearchForServices, (void*)&____CFNetServiceBrowserSearchForServices, (void**)&original_CFNetServiceBrowserSearchForServices);
        MSHookFunction((void*)&CFNetServiceBrowserStopSearch, (void*)&____CFNetServiceBrowserStopSearch, (void**)&original_CFNetServiceBrowserStopSearch);
        MSHookFunction((void*)&CFNetServiceBrowserScheduleWithRunLoop, (void*)&____CFNetServiceBrowserScheduleWithRunLoop, (void**)&original_CFNetServiceBrowserScheduleWithRunLoop);
        MSHookFunction((void*)&CFNetServiceBrowserUnscheduleFromRunLoop, (void*)&____CFNetServiceBrowserUnscheduleFromRunLoop, (void**)&original_CFNetServiceBrowserUnscheduleFromRunLoop);
        MSHookFunction((void*)&CFNetworkCopyProxiesForURL, (void*)&____CFNetworkCopyProxiesForURL, (void**)&original_CFNetworkCopyProxiesForURL);
        MSHookFunction((void*)&CFNetworkCopyProxiesForAutoConfigurationScript, (void*)&____CFNetworkCopyProxiesForAutoConfigurationScript, (void**)&original_CFNetworkCopyProxiesForAutoConfigurationScript);
        MSHookFunction((void*)&CFNetworkExecuteProxyAutoConfigurationScript, (void*)&____CFNetworkExecuteProxyAutoConfigurationScript, (void**)&original_CFNetworkExecuteProxyAutoConfigurationScript);
        MSHookFunction((void*)&CFNetworkExecuteProxyAutoConfigurationURL, (void*)&____CFNetworkExecuteProxyAutoConfigurationURL, (void**)&original_CFNetworkExecuteProxyAutoConfigurationURL);
        MSHookFunction((void*)&CFSocketStreamSOCKSGetErrorSubdomain, (void*)&____CFSocketStreamSOCKSGetErrorSubdomain, (void**)&original_CFSocketStreamSOCKSGetErrorSubdomain);
        MSHookFunction((void*)&CFSocketStreamSOCKSGetError, (void*)&____CFSocketStreamSOCKSGetError, (void**)&original_CFSocketStreamSOCKSGetError);
        MSHookFunction((void*)&CFStreamCreatePairWithSocketToCFHost, (void*)&____CFStreamCreatePairWithSocketToCFHost, (void**)&original_CFStreamCreatePairWithSocketToCFHost);
        MSHookFunction((void*)&CFStreamCreatePairWithSocketToNetService, (void*)&____CFStreamCreatePairWithSocketToNetService, (void**)&original_CFStreamCreatePairWithSocketToNetService);
    });
}

__attribute__((constructor))
static void constructor() {
}
CFReadStreamRef ____CFReadStreamCreateWithFTPURL(CFAllocatorRef alloc, CFURLRef ftpURL)
{
    if (!is_enabled() || !enabled_) {
        CFReadStreamRef return_value = original_CFReadStreamCreateWithFTPURL(alloc, ftpURL);
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
//Parse parameter alloc
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)alloc);
//Parse parameter ftpURL
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)ftpURL);
    if(ftpURL) {
        CFStringRef ftpURL_description = CFCopyDescription(ftpURL);
        parameters[1].description = (char*)calloc(CFStringGetLength(ftpURL_description) + 1, sizeof(char));
        memcpy(parameters[1].description, CFStringGetCStringPtr(ftpURL_description, kCFStringEncodingUTF8), CFStringGetLength(ftpURL_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFReadStreamCreateWithFTPURL", "0x0", parameters, 2);
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
    CFReadStreamRef return_value = original_CFReadStreamCreateWithFTPURL(alloc, ftpURL);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFReadStreamRef", MAX_TYPE_LENGTH);
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


CFIndex ____CFFTPCreateParsedResourceListing(CFAllocatorRef alloc, const UInt8 * buffer, CFIndex bufferLength, CFDictionaryRef * parsed)
{
    if (!is_enabled() || !enabled_) {
        CFIndex return_value = original_CFFTPCreateParsedResourceListing(alloc, buffer, bufferLength, parsed);
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
//Parse parameter alloc
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)alloc);
//Parse parameter buffer
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "^UInt8", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (register_t)buffer);
//Parse parameter bufferLength
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFIndex", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "%d", (int)bufferLength);
//Parse parameter parsed
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "^CFDictionaryRef", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "0x%X", (register_t)parsed);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFFTPCreateParsedResourceListing", "0x0", parameters, 4);
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
    CFIndex return_value = original_CFFTPCreateParsedResourceListing(alloc, buffer, bufferLength, parsed);
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


CFWriteStreamRef ____CFWriteStreamCreateWithFTPURL(CFAllocatorRef alloc, CFURLRef ftpURL)
{
    if (!is_enabled() || !enabled_) {
        CFWriteStreamRef return_value = original_CFWriteStreamCreateWithFTPURL(alloc, ftpURL);
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
//Parse parameter alloc
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)alloc);
//Parse parameter ftpURL
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)ftpURL);
    if(ftpURL) {
        CFStringRef ftpURL_description = CFCopyDescription(ftpURL);
        parameters[1].description = (char*)calloc(CFStringGetLength(ftpURL_description) + 1, sizeof(char));
        memcpy(parameters[1].description, CFStringGetCStringPtr(ftpURL_description, kCFStringEncodingUTF8), CFStringGetLength(ftpURL_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFWriteStreamCreateWithFTPURL", "0x0", parameters, 2);
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
    CFWriteStreamRef return_value = original_CFWriteStreamCreateWithFTPURL(alloc, ftpURL);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFWriteStreamRef", MAX_TYPE_LENGTH);
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


CFHostRef ____CFHostCreateWithName(CFAllocatorRef allocator, CFStringRef hostname)
{
    if (!is_enabled() || !enabled_) {
        CFHostRef return_value = original_CFHostCreateWithName(allocator, hostname);
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
//Parse parameter hostname
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)hostname);
    if(hostname) {
        parameters[1].description = (char*)calloc(CFStringGetLength(hostname)+1, sizeof(char));
        CFStringGetCString(hostname, parameters[1].description, CFStringGetLength(hostname) + 1, kCFStringEncodingUTF8);
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFHostCreateWithName", "0x0", parameters, 2);
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
    CFHostRef return_value = original_CFHostCreateWithName(allocator, hostname);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFHostRef", MAX_TYPE_LENGTH);
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


CFHostRef ____CFHostCreateWithAddress(CFAllocatorRef allocator, CFDataRef addr)
{
    if (!is_enabled() || !enabled_) {
        CFHostRef return_value = original_CFHostCreateWithAddress(allocator, addr);
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
//Parse parameter addr
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFDataRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)addr);
    if(addr) {
        CFStringRef addr_description = CFCopyDescription(addr);
        parameters[1].description = (char*)calloc(CFStringGetLength(addr_description) + 1, sizeof(char));
        memcpy(parameters[1].description, CFStringGetCStringPtr(addr_description, kCFStringEncodingUTF8), CFStringGetLength(addr_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFHostCreateWithAddress", "0x0", parameters, 2);
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
    CFHostRef return_value = original_CFHostCreateWithAddress(allocator, addr);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFHostRef", MAX_TYPE_LENGTH);
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


CFHTTPAuthenticationRef ____CFHTTPAuthenticationCreateFromResponse(CFAllocatorRef alloc, CFHTTPMessageRef response)
{
    if (!is_enabled() || !enabled_) {
        CFHTTPAuthenticationRef return_value = original_CFHTTPAuthenticationCreateFromResponse(alloc, response);
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
//Parse parameter alloc
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)alloc);
//Parse parameter response
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFHTTPMessageRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)response);
    if(response) {
        CFStringRef response_description = CFCopyDescription(response);
        parameters[1].description = (char*)calloc(CFStringGetLength(response_description) + 1, sizeof(char));
        memcpy(parameters[1].description, CFStringGetCStringPtr(response_description, kCFStringEncodingUTF8), CFStringGetLength(response_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFHTTPAuthenticationCreateFromResponse", "0x0", parameters, 2);
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
    CFHTTPAuthenticationRef return_value = original_CFHTTPAuthenticationCreateFromResponse(alloc, response);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFHTTPAuthenticationRef", MAX_TYPE_LENGTH);
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


Boolean ____CFHTTPAuthenticationIsValid(CFHTTPAuthenticationRef auth, CFStreamError * error)
{
    if (!is_enabled() || !enabled_) {
        Boolean return_value = original_CFHTTPAuthenticationIsValid(auth, error);
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
//Parse parameter auth
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFHTTPAuthenticationRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)auth);
//Parse parameter error
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "^CFStreamError", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (register_t)error);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFHTTPAuthenticationIsValid", "0x0", parameters, 2);
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
    Boolean return_value = original_CFHTTPAuthenticationIsValid(auth, error);
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


Boolean ____CFHTTPAuthenticationAppliesToRequest(CFHTTPAuthenticationRef auth, CFHTTPMessageRef request)
{
    if (!is_enabled() || !enabled_) {
        Boolean return_value = original_CFHTTPAuthenticationAppliesToRequest(auth, request);
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
//Parse parameter auth
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFHTTPAuthenticationRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)auth);
//Parse parameter request
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFHTTPMessageRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)request);
    if(request) {
        CFStringRef request_description = CFCopyDescription(request);
        parameters[1].description = (char*)calloc(CFStringGetLength(request_description) + 1, sizeof(char));
        memcpy(parameters[1].description, CFStringGetCStringPtr(request_description, kCFStringEncodingUTF8), CFStringGetLength(request_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFHTTPAuthenticationAppliesToRequest", "0x0", parameters, 2);
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
    Boolean return_value = original_CFHTTPAuthenticationAppliesToRequest(auth, request);
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


Boolean ____CFHTTPAuthenticationRequiresOrderedRequests(CFHTTPAuthenticationRef auth)
{
    if (!is_enabled() || !enabled_) {
        Boolean return_value = original_CFHTTPAuthenticationRequiresOrderedRequests(auth);
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
//Parse parameter auth
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFHTTPAuthenticationRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)auth);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFHTTPAuthenticationRequiresOrderedRequests", "0x0", parameters, 1);
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
    Boolean return_value = original_CFHTTPAuthenticationRequiresOrderedRequests(auth);
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


Boolean ____CFHTTPMessageApplyCredentials(CFHTTPMessageRef request, CFHTTPAuthenticationRef auth, CFStringRef username, CFStringRef password, CFStreamError * error)
{
    if (!is_enabled() || !enabled_) {
        Boolean return_value = original_CFHTTPMessageApplyCredentials(request, auth, username, password, error);
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
//Parse parameter request
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFHTTPMessageRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)request);
    if(request) {
        CFStringRef request_description = CFCopyDescription(request);
        parameters[0].description = (char*)calloc(CFStringGetLength(request_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(request_description, kCFStringEncodingUTF8), CFStringGetLength(request_description));
    }
//Parse parameter auth
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFHTTPAuthenticationRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "%d", (int)auth);
//Parse parameter username
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (int)username);
    if(username) {
        parameters[2].description = (char*)calloc(CFStringGetLength(username)+1, sizeof(char));
        CFStringGetCString(username, parameters[2].description, CFStringGetLength(username) + 1, kCFStringEncodingUTF8);
    }
//Parse parameter password
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "0x%X", (int)password);
    if(password) {
        parameters[3].description = (char*)calloc(CFStringGetLength(password)+1, sizeof(char));
        CFStringGetCString(password, parameters[3].description, CFStringGetLength(password) + 1, kCFStringEncodingUTF8);
    }
//Parse parameter error
    parameters[4].description = NULL;
    strncpy(parameters[4].type, "^CFStreamError", MAX_TYPE_LENGTH);
    snprintf(parameters[4].value, MAX_VALUE_LENGTH, "0x%X", (register_t)error);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFHTTPMessageApplyCredentials", "0x0", parameters, 5);
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
    Boolean return_value = original_CFHTTPMessageApplyCredentials(request, auth, username, password, error);
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


Boolean ____CFHTTPMessageApplyCredentialDictionary(CFHTTPMessageRef request, CFHTTPAuthenticationRef auth, CFDictionaryRef dict, CFStreamError * error)
{
    if (!is_enabled() || !enabled_) {
        Boolean return_value = original_CFHTTPMessageApplyCredentialDictionary(request, auth, dict, error);
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
//Parse parameter request
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFHTTPMessageRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)request);
    if(request) {
        CFStringRef request_description = CFCopyDescription(request);
        parameters[0].description = (char*)calloc(CFStringGetLength(request_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(request_description, kCFStringEncodingUTF8), CFStringGetLength(request_description));
    }
//Parse parameter auth
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFHTTPAuthenticationRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "%d", (int)auth);
//Parse parameter dict
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFDictionaryRef", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (int)dict);
    if(dict) {
        CFStringRef dict_description = CFCopyDescription(dict);
        parameters[2].description = (char*)calloc(CFStringGetLength(dict_description) + 1, sizeof(char));
        memcpy(parameters[2].description, CFStringGetCStringPtr(dict_description, kCFStringEncodingUTF8), CFStringGetLength(dict_description));
    }
//Parse parameter error
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "^CFStreamError", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "0x%X", (register_t)error);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFHTTPMessageApplyCredentialDictionary", "0x0", parameters, 4);
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
    Boolean return_value = original_CFHTTPMessageApplyCredentialDictionary(request, auth, dict, error);
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


CFStringRef ____CFHTTPAuthenticationCopyRealm(CFHTTPAuthenticationRef auth)
{
    if (!is_enabled() || !enabled_) {
        CFStringRef return_value = original_CFHTTPAuthenticationCopyRealm(auth);
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
//Parse parameter auth
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFHTTPAuthenticationRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)auth);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFHTTPAuthenticationCopyRealm", "0x0", parameters, 1);
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
    CFStringRef return_value = original_CFHTTPAuthenticationCopyRealm(auth);
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


CFArrayRef ____CFHTTPAuthenticationCopyDomains(CFHTTPAuthenticationRef auth)
{
    if (!is_enabled() || !enabled_) {
        CFArrayRef return_value = original_CFHTTPAuthenticationCopyDomains(auth);
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
//Parse parameter auth
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFHTTPAuthenticationRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)auth);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFHTTPAuthenticationCopyDomains", "0x0", parameters, 1);
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
    CFArrayRef return_value = original_CFHTTPAuthenticationCopyDomains(auth);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFArrayRef", MAX_TYPE_LENGTH);
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


CFStringRef ____CFHTTPAuthenticationCopyMethod(CFHTTPAuthenticationRef auth)
{
    if (!is_enabled() || !enabled_) {
        CFStringRef return_value = original_CFHTTPAuthenticationCopyMethod(auth);
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
//Parse parameter auth
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFHTTPAuthenticationRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)auth);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFHTTPAuthenticationCopyMethod", "0x0", parameters, 1);
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
    CFStringRef return_value = original_CFHTTPAuthenticationCopyMethod(auth);
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


Boolean ____CFHTTPAuthenticationRequiresUserNameAndPassword(CFHTTPAuthenticationRef auth)
{
    if (!is_enabled() || !enabled_) {
        Boolean return_value = original_CFHTTPAuthenticationRequiresUserNameAndPassword(auth);
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
//Parse parameter auth
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFHTTPAuthenticationRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)auth);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFHTTPAuthenticationRequiresUserNameAndPassword", "0x0", parameters, 1);
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
    Boolean return_value = original_CFHTTPAuthenticationRequiresUserNameAndPassword(auth);
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


Boolean ____CFHTTPAuthenticationRequiresAccountDomain(CFHTTPAuthenticationRef auth)
{
    if (!is_enabled() || !enabled_) {
        Boolean return_value = original_CFHTTPAuthenticationRequiresAccountDomain(auth);
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
//Parse parameter auth
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFHTTPAuthenticationRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)auth);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFHTTPAuthenticationRequiresAccountDomain", "0x0", parameters, 1);
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
    Boolean return_value = original_CFHTTPAuthenticationRequiresAccountDomain(auth);
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


CFHTTPMessageRef ____CFHTTPMessageCreateRequest(CFAllocatorRef alloc, CFStringRef requestMethod, CFURLRef url, CFStringRef httpVersion)
{
    if (!is_enabled() || !enabled_) {
        CFHTTPMessageRef return_value = original_CFHTTPMessageCreateRequest(alloc, requestMethod, url, httpVersion);
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
//Parse parameter alloc
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)alloc);
//Parse parameter requestMethod
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)requestMethod);
    if(requestMethod) {
        parameters[1].description = (char*)calloc(CFStringGetLength(requestMethod)+1, sizeof(char));
        CFStringGetCString(requestMethod, parameters[1].description, CFStringGetLength(requestMethod) + 1, kCFStringEncodingUTF8);
    }
//Parse parameter url
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (int)url);
    if(url) {
        CFStringRef url_description = CFCopyDescription(url);
        parameters[2].description = (char*)calloc(CFStringGetLength(url_description) + 1, sizeof(char));
        memcpy(parameters[2].description, CFStringGetCStringPtr(url_description, kCFStringEncodingUTF8), CFStringGetLength(url_description));
    }
//Parse parameter httpVersion
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "0x%X", (int)httpVersion);
    if(httpVersion) {
        parameters[3].description = (char*)calloc(CFStringGetLength(httpVersion)+1, sizeof(char));
        CFStringGetCString(httpVersion, parameters[3].description, CFStringGetLength(httpVersion) + 1, kCFStringEncodingUTF8);
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFHTTPMessageCreateRequest", "0x0", parameters, 4);
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
    CFHTTPMessageRef return_value = original_CFHTTPMessageCreateRequest(alloc, requestMethod, url, httpVersion);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFHTTPMessageRef", MAX_TYPE_LENGTH);
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


CFHTTPMessageRef ____CFHTTPMessageCreateResponse(CFAllocatorRef alloc, CFIndex statusCode, CFStringRef statusDescription, CFStringRef httpVersion)
{
    if (!is_enabled() || !enabled_) {
        CFHTTPMessageRef return_value = original_CFHTTPMessageCreateResponse(alloc, statusCode, statusDescription, httpVersion);
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
//Parse parameter alloc
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)alloc);
//Parse parameter statusCode
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFIndex", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "%d", (int)statusCode);
//Parse parameter statusDescription
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (int)statusDescription);
    if(statusDescription) {
        parameters[2].description = (char*)calloc(CFStringGetLength(statusDescription)+1, sizeof(char));
        CFStringGetCString(statusDescription, parameters[2].description, CFStringGetLength(statusDescription) + 1, kCFStringEncodingUTF8);
    }
//Parse parameter httpVersion
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "0x%X", (int)httpVersion);
    if(httpVersion) {
        parameters[3].description = (char*)calloc(CFStringGetLength(httpVersion)+1, sizeof(char));
        CFStringGetCString(httpVersion, parameters[3].description, CFStringGetLength(httpVersion) + 1, kCFStringEncodingUTF8);
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFHTTPMessageCreateResponse", "0x0", parameters, 4);
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
    CFHTTPMessageRef return_value = original_CFHTTPMessageCreateResponse(alloc, statusCode, statusDescription, httpVersion);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFHTTPMessageRef", MAX_TYPE_LENGTH);
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


CFHTTPMessageRef ____CFHTTPMessageCreateEmpty(CFAllocatorRef alloc, Boolean isRequest)
{
    if (!is_enabled() || !enabled_) {
        CFHTTPMessageRef return_value = original_CFHTTPMessageCreateEmpty(alloc, isRequest);
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
//Parse parameter alloc
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)alloc);
//Parse parameter isRequest
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "Boolean", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "%d", (int)isRequest);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFHTTPMessageCreateEmpty", "0x0", parameters, 2);
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
    CFHTTPMessageRef return_value = original_CFHTTPMessageCreateEmpty(alloc, isRequest);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFHTTPMessageRef", MAX_TYPE_LENGTH);
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


CFHTTPMessageRef ____CFHTTPMessageCreateCopy(CFAllocatorRef alloc, CFHTTPMessageRef message)
{
    if (!is_enabled() || !enabled_) {
        CFHTTPMessageRef return_value = original_CFHTTPMessageCreateCopy(alloc, message);
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
//Parse parameter alloc
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)alloc);
//Parse parameter message
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFHTTPMessageRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)message);
    if(message) {
        CFStringRef message_description = CFCopyDescription(message);
        parameters[1].description = (char*)calloc(CFStringGetLength(message_description) + 1, sizeof(char));
        memcpy(parameters[1].description, CFStringGetCStringPtr(message_description, kCFStringEncodingUTF8), CFStringGetLength(message_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFHTTPMessageCreateCopy", "0x0", parameters, 2);
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
    CFHTTPMessageRef return_value = original_CFHTTPMessageCreateCopy(alloc, message);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFHTTPMessageRef", MAX_TYPE_LENGTH);
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


Boolean ____CFHTTPMessageIsRequest(CFHTTPMessageRef message)
{
    if (!is_enabled() || !enabled_) {
        Boolean return_value = original_CFHTTPMessageIsRequest(message);
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
//Parse parameter message
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFHTTPMessageRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)message);
    if(message) {
        CFStringRef message_description = CFCopyDescription(message);
        parameters[0].description = (char*)calloc(CFStringGetLength(message_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(message_description, kCFStringEncodingUTF8), CFStringGetLength(message_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFHTTPMessageIsRequest", "0x0", parameters, 1);
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
    Boolean return_value = original_CFHTTPMessageIsRequest(message);
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


CFStringRef ____CFHTTPMessageCopyVersion(CFHTTPMessageRef message)
{
    if (!is_enabled() || !enabled_) {
        CFStringRef return_value = original_CFHTTPMessageCopyVersion(message);
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
//Parse parameter message
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFHTTPMessageRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)message);
    if(message) {
        CFStringRef message_description = CFCopyDescription(message);
        parameters[0].description = (char*)calloc(CFStringGetLength(message_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(message_description, kCFStringEncodingUTF8), CFStringGetLength(message_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFHTTPMessageCopyVersion", "0x0", parameters, 1);
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
    CFStringRef return_value = original_CFHTTPMessageCopyVersion(message);
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


CFDataRef ____CFHTTPMessageCopyBody(CFHTTPMessageRef message)
{
    if (!is_enabled() || !enabled_) {
        CFDataRef return_value = original_CFHTTPMessageCopyBody(message);
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
//Parse parameter message
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFHTTPMessageRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)message);
    if(message) {
        CFStringRef message_description = CFCopyDescription(message);
        parameters[0].description = (char*)calloc(CFStringGetLength(message_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(message_description, kCFStringEncodingUTF8), CFStringGetLength(message_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFHTTPMessageCopyBody", "0x0", parameters, 1);
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
    CFDataRef return_value = original_CFHTTPMessageCopyBody(message);
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


void ____CFHTTPMessageSetBody(CFHTTPMessageRef message, CFDataRef bodyData)
{
    if (!is_enabled() || !enabled_) {
        original_CFHTTPMessageSetBody(message, bodyData);
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
//Parse parameter message
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFHTTPMessageRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)message);
    if(message) {
        CFStringRef message_description = CFCopyDescription(message);
        parameters[0].description = (char*)calloc(CFStringGetLength(message_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(message_description, kCFStringEncodingUTF8), CFStringGetLength(message_description));
    }
//Parse parameter bodyData
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFDataRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)bodyData);
    if(bodyData) {
        CFStringRef bodyData_description = CFCopyDescription(bodyData);
        parameters[1].description = (char*)calloc(CFStringGetLength(bodyData_description) + 1, sizeof(char));
        memcpy(parameters[1].description, CFStringGetCStringPtr(bodyData_description, kCFStringEncodingUTF8), CFStringGetLength(bodyData_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFHTTPMessageSetBody", "0x0", parameters, 2);
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
    original_CFHTTPMessageSetBody(message, bodyData);
    set_enabled(false);
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
}


CFStringRef ____CFHTTPMessageCopyHeaderFieldValue(CFHTTPMessageRef message, CFStringRef headerField)
{
    if (!is_enabled() || !enabled_) {
        CFStringRef return_value = original_CFHTTPMessageCopyHeaderFieldValue(message, headerField);
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
//Parse parameter message
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFHTTPMessageRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)message);
    if(message) {
        CFStringRef message_description = CFCopyDescription(message);
        parameters[0].description = (char*)calloc(CFStringGetLength(message_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(message_description, kCFStringEncodingUTF8), CFStringGetLength(message_description));
    }
//Parse parameter headerField
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)headerField);
    if(headerField) {
        parameters[1].description = (char*)calloc(CFStringGetLength(headerField)+1, sizeof(char));
        CFStringGetCString(headerField, parameters[1].description, CFStringGetLength(headerField) + 1, kCFStringEncodingUTF8);
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFHTTPMessageCopyHeaderFieldValue", "0x0", parameters, 2);
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
    CFStringRef return_value = original_CFHTTPMessageCopyHeaderFieldValue(message, headerField);
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


CFDictionaryRef ____CFHTTPMessageCopyAllHeaderFields(CFHTTPMessageRef message)
{
    if (!is_enabled() || !enabled_) {
        CFDictionaryRef return_value = original_CFHTTPMessageCopyAllHeaderFields(message);
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
//Parse parameter message
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFHTTPMessageRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)message);
    if(message) {
        CFStringRef message_description = CFCopyDescription(message);
        parameters[0].description = (char*)calloc(CFStringGetLength(message_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(message_description, kCFStringEncodingUTF8), CFStringGetLength(message_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFHTTPMessageCopyAllHeaderFields", "0x0", parameters, 1);
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
    CFDictionaryRef return_value = original_CFHTTPMessageCopyAllHeaderFields(message);
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


void ____CFHTTPMessageSetHeaderFieldValue(CFHTTPMessageRef message, CFStringRef headerField, CFStringRef value)
{
    if (!is_enabled() || !enabled_) {
        original_CFHTTPMessageSetHeaderFieldValue(message, headerField, value);
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
//Parse parameter message
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFHTTPMessageRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)message);
    if(message) {
        CFStringRef message_description = CFCopyDescription(message);
        parameters[0].description = (char*)calloc(CFStringGetLength(message_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(message_description, kCFStringEncodingUTF8), CFStringGetLength(message_description));
    }
//Parse parameter headerField
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)headerField);
    if(headerField) {
        parameters[1].description = (char*)calloc(CFStringGetLength(headerField)+1, sizeof(char));
        CFStringGetCString(headerField, parameters[1].description, CFStringGetLength(headerField) + 1, kCFStringEncodingUTF8);
    }
//Parse parameter value
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (int)value);
    if(value) {
        parameters[2].description = (char*)calloc(CFStringGetLength(value)+1, sizeof(char));
        CFStringGetCString(value, parameters[2].description, CFStringGetLength(value) + 1, kCFStringEncodingUTF8);
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFHTTPMessageSetHeaderFieldValue", "0x0", parameters, 3);
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
    original_CFHTTPMessageSetHeaderFieldValue(message, headerField, value);
    set_enabled(false);
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
}


Boolean ____CFHTTPMessageAppendBytes(CFHTTPMessageRef message, const UInt8 * newBytes, CFIndex numBytes)
{
    if (!is_enabled() || !enabled_) {
        Boolean return_value = original_CFHTTPMessageAppendBytes(message, newBytes, numBytes);
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
//Parse parameter message
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFHTTPMessageRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)message);
    if(message) {
        CFStringRef message_description = CFCopyDescription(message);
        parameters[0].description = (char*)calloc(CFStringGetLength(message_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(message_description, kCFStringEncodingUTF8), CFStringGetLength(message_description));
    }
//Parse parameter newBytes
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "^UInt8", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (register_t)newBytes);
    parameters[1].description = (char*)calloc(2*numBytes+1, sizeof(char));
    NSData *newBytes_data = [NSData dataWithBytes:newBytes length:numBytes];
    strncpy(parameters[1].description, [[[[[newBytes_data description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] UTF8String], 2*numBytes);
//Parse parameter numBytes
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFIndex", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "%d", (int)numBytes);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFHTTPMessageAppendBytes", "0x0", parameters, 3);
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
    Boolean return_value = original_CFHTTPMessageAppendBytes(message, newBytes, numBytes);
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


CFURLRef ____CFHTTPMessageCopyRequestURL(CFHTTPMessageRef request)
{
    if (!is_enabled() || !enabled_) {
        CFURLRef return_value = original_CFHTTPMessageCopyRequestURL(request);
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
//Parse parameter request
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFHTTPMessageRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)request);
    if(request) {
        CFStringRef request_description = CFCopyDescription(request);
        parameters[0].description = (char*)calloc(CFStringGetLength(request_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(request_description, kCFStringEncodingUTF8), CFStringGetLength(request_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFHTTPMessageCopyRequestURL", "0x0", parameters, 1);
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
    CFURLRef return_value = original_CFHTTPMessageCopyRequestURL(request);
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


CFStringRef ____CFHTTPMessageCopyRequestMethod(CFHTTPMessageRef request)
{
    if (!is_enabled() || !enabled_) {
        CFStringRef return_value = original_CFHTTPMessageCopyRequestMethod(request);
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
//Parse parameter request
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFHTTPMessageRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)request);
    if(request) {
        CFStringRef request_description = CFCopyDescription(request);
        parameters[0].description = (char*)calloc(CFStringGetLength(request_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(request_description, kCFStringEncodingUTF8), CFStringGetLength(request_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFHTTPMessageCopyRequestMethod", "0x0", parameters, 1);
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
    CFStringRef return_value = original_CFHTTPMessageCopyRequestMethod(request);
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


Boolean ____CFHTTPMessageAddAuthentication(CFHTTPMessageRef request, CFHTTPMessageRef authenticationFailureResponse, CFStringRef username, CFStringRef password, CFStringRef authenticationScheme, Boolean forProxy)
{
    if (!is_enabled() || !enabled_) {
        Boolean return_value = original_CFHTTPMessageAddAuthentication(request, authenticationFailureResponse, username, password, authenticationScheme, forProxy);
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
//Parse parameter request
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFHTTPMessageRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)request);
    if(request) {
        CFStringRef request_description = CFCopyDescription(request);
        parameters[0].description = (char*)calloc(CFStringGetLength(request_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(request_description, kCFStringEncodingUTF8), CFStringGetLength(request_description));
    }
//Parse parameter authenticationFailureResponse
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFHTTPMessageRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)authenticationFailureResponse);
    if(authenticationFailureResponse) {
        CFStringRef authenticationFailureResponse_description = CFCopyDescription(authenticationFailureResponse);
        parameters[1].description = (char*)calloc(CFStringGetLength(authenticationFailureResponse_description) + 1, sizeof(char));
        memcpy(parameters[1].description, CFStringGetCStringPtr(authenticationFailureResponse_description, kCFStringEncodingUTF8), CFStringGetLength(authenticationFailureResponse_description));
    }
//Parse parameter username
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (int)username);
    if(username) {
        parameters[2].description = (char*)calloc(CFStringGetLength(username)+1, sizeof(char));
        CFStringGetCString(username, parameters[2].description, CFStringGetLength(username) + 1, kCFStringEncodingUTF8);
    }
//Parse parameter password
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "0x%X", (int)password);
    if(password) {
        parameters[3].description = (char*)calloc(CFStringGetLength(password)+1, sizeof(char));
        CFStringGetCString(password, parameters[3].description, CFStringGetLength(password) + 1, kCFStringEncodingUTF8);
    }
//Parse parameter authenticationScheme
    parameters[4].description = NULL;
    strncpy(parameters[4].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[4].value, MAX_VALUE_LENGTH, "0x%X", (int)authenticationScheme);
    if(authenticationScheme) {
        parameters[4].description = (char*)calloc(CFStringGetLength(authenticationScheme)+1, sizeof(char));
        CFStringGetCString(authenticationScheme, parameters[4].description, CFStringGetLength(authenticationScheme) + 1, kCFStringEncodingUTF8);
    }
//Parse parameter forProxy
    parameters[5].description = NULL;
    strncpy(parameters[5].type, "Boolean", MAX_TYPE_LENGTH);
    snprintf(parameters[5].value, MAX_VALUE_LENGTH, "%d", (int)forProxy);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFHTTPMessageAddAuthentication", "0x0", parameters, 6);
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
    Boolean return_value = original_CFHTTPMessageAddAuthentication(request, authenticationFailureResponse, username, password, authenticationScheme, forProxy);
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


CFIndex ____CFHTTPMessageGetResponseStatusCode(CFHTTPMessageRef response)
{
    if (!is_enabled() || !enabled_) {
        CFIndex return_value = original_CFHTTPMessageGetResponseStatusCode(response);
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
//Parse parameter response
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFHTTPMessageRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)response);
    if(response) {
        CFStringRef response_description = CFCopyDescription(response);
        parameters[0].description = (char*)calloc(CFStringGetLength(response_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(response_description, kCFStringEncodingUTF8), CFStringGetLength(response_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFHTTPMessageGetResponseStatusCode", "0x0", parameters, 1);
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
    CFIndex return_value = original_CFHTTPMessageGetResponseStatusCode(response);
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


CFStringRef ____CFHTTPMessageCopyResponseStatusLine(CFHTTPMessageRef response)
{
    if (!is_enabled() || !enabled_) {
        CFStringRef return_value = original_CFHTTPMessageCopyResponseStatusLine(response);
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
//Parse parameter response
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFHTTPMessageRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)response);
    if(response) {
        CFStringRef response_description = CFCopyDescription(response);
        parameters[0].description = (char*)calloc(CFStringGetLength(response_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(response_description, kCFStringEncodingUTF8), CFStringGetLength(response_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFHTTPMessageCopyResponseStatusLine", "0x0", parameters, 1);
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
    CFStringRef return_value = original_CFHTTPMessageCopyResponseStatusLine(response);
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


CFReadStreamRef ____CFReadStreamCreateForHTTPRequest(CFAllocatorRef alloc, CFHTTPMessageRef request)
{
    if (!is_enabled() || !enabled_) {
        CFReadStreamRef return_value = original_CFReadStreamCreateForHTTPRequest(alloc, request);
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
//Parse parameter alloc
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)alloc);
//Parse parameter request
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFHTTPMessageRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)request);
    if(request) {
        CFStringRef request_description = CFCopyDescription(request);
        parameters[1].description = (char*)calloc(CFStringGetLength(request_description) + 1, sizeof(char));
        memcpy(parameters[1].description, CFStringGetCStringPtr(request_description, kCFStringEncodingUTF8), CFStringGetLength(request_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFReadStreamCreateForHTTPRequest", "0x0", parameters, 2);
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
    CFReadStreamRef return_value = original_CFReadStreamCreateForHTTPRequest(alloc, request);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFReadStreamRef", MAX_TYPE_LENGTH);
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


CFReadStreamRef ____CFReadStreamCreateForStreamedHTTPRequest(CFAllocatorRef alloc, CFHTTPMessageRef requestHeaders, CFReadStreamRef requestBody)
{
    if (!is_enabled() || !enabled_) {
        CFReadStreamRef return_value = original_CFReadStreamCreateForStreamedHTTPRequest(alloc, requestHeaders, requestBody);
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
//Parse parameter alloc
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)alloc);
//Parse parameter requestHeaders
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFHTTPMessageRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)requestHeaders);
    if(requestHeaders) {
        CFStringRef requestHeaders_description = CFCopyDescription(requestHeaders);
        parameters[1].description = (char*)calloc(CFStringGetLength(requestHeaders_description) + 1, sizeof(char));
        memcpy(parameters[1].description, CFStringGetCStringPtr(requestHeaders_description, kCFStringEncodingUTF8), CFStringGetLength(requestHeaders_description));
    }
//Parse parameter requestBody
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFReadStreamRef", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (int)requestBody);
    if(requestBody) {
        CFStringRef requestBody_description = CFCopyDescription(requestBody);
        parameters[2].description = (char*)calloc(CFStringGetLength(requestBody_description) + 1, sizeof(char));
        memcpy(parameters[2].description, CFStringGetCStringPtr(requestBody_description, kCFStringEncodingUTF8), CFStringGetLength(requestBody_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFReadStreamCreateForStreamedHTTPRequest", "0x0", parameters, 3);
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
    CFReadStreamRef return_value = original_CFReadStreamCreateForStreamedHTTPRequest(alloc, requestHeaders, requestBody);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFReadStreamRef", MAX_TYPE_LENGTH);
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


CFNetDiagnosticRef ____CFNetDiagnosticCreateWithStreams(CFAllocatorRef alloc, CFReadStreamRef readStream, CFWriteStreamRef writeStream)
{
    if (!is_enabled() || !enabled_) {
        CFNetDiagnosticRef return_value = original_CFNetDiagnosticCreateWithStreams(alloc, readStream, writeStream);
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
//Parse parameter alloc
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)alloc);
//Parse parameter readStream
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFReadStreamRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)readStream);
    if(readStream) {
        CFStringRef readStream_description = CFCopyDescription(readStream);
        parameters[1].description = (char*)calloc(CFStringGetLength(readStream_description) + 1, sizeof(char));
        memcpy(parameters[1].description, CFStringGetCStringPtr(readStream_description, kCFStringEncodingUTF8), CFStringGetLength(readStream_description));
    }
//Parse parameter writeStream
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFWriteStreamRef", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "%d", (int)writeStream);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFNetDiagnosticCreateWithStreams", "0x0", parameters, 3);
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
    CFNetDiagnosticRef return_value = original_CFNetDiagnosticCreateWithStreams(alloc, readStream, writeStream);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFNetDiagnosticRef", MAX_TYPE_LENGTH);
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


CFNetDiagnosticRef ____CFNetDiagnosticCreateWithURL(CFAllocatorRef alloc, CFURLRef url)
{
    if (!is_enabled() || !enabled_) {
        CFNetDiagnosticRef return_value = original_CFNetDiagnosticCreateWithURL(alloc, url);
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
//Parse parameter alloc
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)alloc);
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
            insert_call(call_id, caller_id, "CFNetwork", "CFNetDiagnosticCreateWithURL", "0x0", parameters, 2);
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
    CFNetDiagnosticRef return_value = original_CFNetDiagnosticCreateWithURL(alloc, url);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFNetDiagnosticRef", MAX_TYPE_LENGTH);
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


void ____CFNetDiagnosticSetName(CFNetDiagnosticRef details, CFStringRef name)
{
    if (!is_enabled() || !enabled_) {
        original_CFNetDiagnosticSetName(details, name);
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
//Parse parameter details
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFNetDiagnosticRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)details);
//Parse parameter name
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)name);
    if(name) {
        parameters[1].description = (char*)calloc(CFStringGetLength(name)+1, sizeof(char));
        CFStringGetCString(name, parameters[1].description, CFStringGetLength(name) + 1, kCFStringEncodingUTF8);
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFNetDiagnosticSetName", "0x0", parameters, 2);
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
    original_CFNetDiagnosticSetName(details, name);
    set_enabled(false);
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
}


CFNetDiagnosticStatus ____CFNetDiagnosticDiagnoseProblemInteractively(CFNetDiagnosticRef details)
{
    if (!is_enabled() || !enabled_) {
        CFNetDiagnosticStatus return_value = original_CFNetDiagnosticDiagnoseProblemInteractively(details);
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
//Parse parameter details
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFNetDiagnosticRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)details);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFNetDiagnosticDiagnoseProblemInteractively", "0x0", parameters, 1);
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
    CFNetDiagnosticStatus return_value = original_CFNetDiagnosticDiagnoseProblemInteractively(details);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFNetDiagnosticStatus", MAX_TYPE_LENGTH);
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


CFNetDiagnosticStatus ____CFNetDiagnosticCopyNetworkStatusPassively(CFNetDiagnosticRef details, CFStringRef * description)
{
    if (!is_enabled() || !enabled_) {
        CFNetDiagnosticStatus return_value = original_CFNetDiagnosticCopyNetworkStatusPassively(details, description);
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
//Parse parameter details
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFNetDiagnosticRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)details);
//Parse parameter description
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "^CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (register_t)description);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFNetDiagnosticCopyNetworkStatusPassively", "0x0", parameters, 2);
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
    CFNetDiagnosticStatus return_value = original_CFNetDiagnosticCopyNetworkStatusPassively(details, description);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFNetDiagnosticStatus", MAX_TYPE_LENGTH);
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


CFNetServiceRef ____CFNetServiceCreate(CFAllocatorRef alloc, CFStringRef domain, CFStringRef serviceType, CFStringRef name, SInt32 port)
{
    if (!is_enabled() || !enabled_) {
        CFNetServiceRef return_value = original_CFNetServiceCreate(alloc, domain, serviceType, name, port);
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
//Parse parameter alloc
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)alloc);
//Parse parameter domain
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)domain);
    if(domain) {
        parameters[1].description = (char*)calloc(CFStringGetLength(domain)+1, sizeof(char));
        CFStringGetCString(domain, parameters[1].description, CFStringGetLength(domain) + 1, kCFStringEncodingUTF8);
    }
//Parse parameter serviceType
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (int)serviceType);
    if(serviceType) {
        parameters[2].description = (char*)calloc(CFStringGetLength(serviceType)+1, sizeof(char));
        CFStringGetCString(serviceType, parameters[2].description, CFStringGetLength(serviceType) + 1, kCFStringEncodingUTF8);
    }
//Parse parameter name
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "0x%X", (int)name);
    if(name) {
        parameters[3].description = (char*)calloc(CFStringGetLength(name)+1, sizeof(char));
        CFStringGetCString(name, parameters[3].description, CFStringGetLength(name) + 1, kCFStringEncodingUTF8);
    }
//Parse parameter port
    parameters[4].description = NULL;
    strncpy(parameters[4].type, "SInt32", MAX_TYPE_LENGTH);
    snprintf(parameters[4].value, MAX_VALUE_LENGTH, "%d", (int)port);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFNetServiceCreate", "0x0", parameters, 5);
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
    CFNetServiceRef return_value = original_CFNetServiceCreate(alloc, domain, serviceType, name, port);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFNetServiceRef", MAX_TYPE_LENGTH);
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


CFNetServiceRef ____CFNetServiceCreateCopy(CFAllocatorRef alloc, CFNetServiceRef service)
{
    if (!is_enabled() || !enabled_) {
        CFNetServiceRef return_value = original_CFNetServiceCreateCopy(alloc, service);
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
//Parse parameter alloc
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)alloc);
//Parse parameter service
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFNetServiceRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "%d", (int)service);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFNetServiceCreateCopy", "0x0", parameters, 2);
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
    CFNetServiceRef return_value = original_CFNetServiceCreateCopy(alloc, service);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFNetServiceRef", MAX_TYPE_LENGTH);
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


CFStringRef ____CFNetServiceGetDomain(CFNetServiceRef theService)
{
    if (!is_enabled() || !enabled_) {
        CFStringRef return_value = original_CFNetServiceGetDomain(theService);
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
//Parse parameter theService
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFNetServiceRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)theService);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFNetServiceGetDomain", "0x0", parameters, 1);
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
    CFStringRef return_value = original_CFNetServiceGetDomain(theService);
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


CFStringRef ____CFNetServiceGetType(CFNetServiceRef theService)
{
    if (!is_enabled() || !enabled_) {
        CFStringRef return_value = original_CFNetServiceGetType(theService);
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
//Parse parameter theService
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFNetServiceRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)theService);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFNetServiceGetType", "0x0", parameters, 1);
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
    CFStringRef return_value = original_CFNetServiceGetType(theService);
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


CFStringRef ____CFNetServiceGetName(CFNetServiceRef theService)
{
    if (!is_enabled() || !enabled_) {
        CFStringRef return_value = original_CFNetServiceGetName(theService);
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
//Parse parameter theService
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFNetServiceRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)theService);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFNetServiceGetName", "0x0", parameters, 1);
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
    CFStringRef return_value = original_CFNetServiceGetName(theService);
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


Boolean ____CFNetServiceRegisterWithOptions(CFNetServiceRef theService, CFOptionFlags options, CFStreamError * error)
{
    if (!is_enabled() || !enabled_) {
        Boolean return_value = original_CFNetServiceRegisterWithOptions(theService, options, error);
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
//Parse parameter theService
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFNetServiceRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)theService);
//Parse parameter options
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFOptionFlags", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "%d", (int)options);
//Parse parameter error
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "^CFStreamError", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (register_t)error);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFNetServiceRegisterWithOptions", "0x0", parameters, 3);
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
    Boolean return_value = original_CFNetServiceRegisterWithOptions(theService, options, error);
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


Boolean ____CFNetServiceResolveWithTimeout(CFNetServiceRef theService, CFTimeInterval timeout, CFStreamError * error)
{
    if (!is_enabled() || !enabled_) {
        Boolean return_value = original_CFNetServiceResolveWithTimeout(theService, timeout, error);
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
//Parse parameter theService
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFNetServiceRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)theService);
//Parse parameter timeout
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFTimeInterval", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "%d", (int)timeout);
//Parse parameter error
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "^CFStreamError", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (register_t)error);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFNetServiceResolveWithTimeout", "0x0", parameters, 3);
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
    Boolean return_value = original_CFNetServiceResolveWithTimeout(theService, timeout, error);
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


void ____CFNetServiceCancel(CFNetServiceRef theService)
{
    if (!is_enabled() || !enabled_) {
        original_CFNetServiceCancel(theService);
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
//Parse parameter theService
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFNetServiceRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)theService);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFNetServiceCancel", "0x0", parameters, 1);
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
    original_CFNetServiceCancel(theService);
    set_enabled(false);
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
}


CFStringRef ____CFNetServiceGetTargetHost(CFNetServiceRef theService)
{
    if (!is_enabled() || !enabled_) {
        CFStringRef return_value = original_CFNetServiceGetTargetHost(theService);
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
//Parse parameter theService
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFNetServiceRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)theService);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFNetServiceGetTargetHost", "0x0", parameters, 1);
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
    CFStringRef return_value = original_CFNetServiceGetTargetHost(theService);
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


SInt32 ____CFNetServiceGetPortNumber(CFNetServiceRef theService)
{
    if (!is_enabled() || !enabled_) {
        SInt32 return_value = original_CFNetServiceGetPortNumber(theService);
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
//Parse parameter theService
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFNetServiceRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)theService);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFNetServiceGetPortNumber", "0x0", parameters, 1);
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
    SInt32 return_value = original_CFNetServiceGetPortNumber(theService);
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


CFArrayRef ____CFNetServiceGetAddressing(CFNetServiceRef theService)
{
    if (!is_enabled() || !enabled_) {
        CFArrayRef return_value = original_CFNetServiceGetAddressing(theService);
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
//Parse parameter theService
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFNetServiceRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)theService);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFNetServiceGetAddressing", "0x0", parameters, 1);
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
    CFArrayRef return_value = original_CFNetServiceGetAddressing(theService);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFArrayRef", MAX_TYPE_LENGTH);
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


CFDataRef ____CFNetServiceGetTXTData(CFNetServiceRef theService)
{
    if (!is_enabled() || !enabled_) {
        CFDataRef return_value = original_CFNetServiceGetTXTData(theService);
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
//Parse parameter theService
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFNetServiceRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)theService);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFNetServiceGetTXTData", "0x0", parameters, 1);
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
    CFDataRef return_value = original_CFNetServiceGetTXTData(theService);
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


Boolean ____CFNetServiceSetTXTData(CFNetServiceRef theService, CFDataRef txtRecord)
{
    if (!is_enabled() || !enabled_) {
        Boolean return_value = original_CFNetServiceSetTXTData(theService, txtRecord);
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
//Parse parameter theService
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFNetServiceRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)theService);
//Parse parameter txtRecord
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFDataRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)txtRecord);
    if(txtRecord) {
        CFStringRef txtRecord_description = CFCopyDescription(txtRecord);
        parameters[1].description = (char*)calloc(CFStringGetLength(txtRecord_description) + 1, sizeof(char));
        memcpy(parameters[1].description, CFStringGetCStringPtr(txtRecord_description, kCFStringEncodingUTF8), CFStringGetLength(txtRecord_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFNetServiceSetTXTData", "0x0", parameters, 2);
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
    Boolean return_value = original_CFNetServiceSetTXTData(theService, txtRecord);
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


CFDictionaryRef ____CFNetServiceCreateDictionaryWithTXTData(CFAllocatorRef alloc, CFDataRef txtRecord)
{
    if (!is_enabled() || !enabled_) {
        CFDictionaryRef return_value = original_CFNetServiceCreateDictionaryWithTXTData(alloc, txtRecord);
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
//Parse parameter alloc
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)alloc);
//Parse parameter txtRecord
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFDataRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)txtRecord);
    if(txtRecord) {
        CFStringRef txtRecord_description = CFCopyDescription(txtRecord);
        parameters[1].description = (char*)calloc(CFStringGetLength(txtRecord_description) + 1, sizeof(char));
        memcpy(parameters[1].description, CFStringGetCStringPtr(txtRecord_description, kCFStringEncodingUTF8), CFStringGetLength(txtRecord_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFNetServiceCreateDictionaryWithTXTData", "0x0", parameters, 2);
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
    CFDictionaryRef return_value = original_CFNetServiceCreateDictionaryWithTXTData(alloc, txtRecord);
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


CFDataRef ____CFNetServiceCreateTXTDataWithDictionary(CFAllocatorRef alloc, CFDictionaryRef keyValuePairs)
{
    if (!is_enabled() || !enabled_) {
        CFDataRef return_value = original_CFNetServiceCreateTXTDataWithDictionary(alloc, keyValuePairs);
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
//Parse parameter alloc
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)alloc);
//Parse parameter keyValuePairs
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFDictionaryRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)keyValuePairs);
    if(keyValuePairs) {
        CFStringRef keyValuePairs_description = CFCopyDescription(keyValuePairs);
        parameters[1].description = (char*)calloc(CFStringGetLength(keyValuePairs_description) + 1, sizeof(char));
        memcpy(parameters[1].description, CFStringGetCStringPtr(keyValuePairs_description, kCFStringEncodingUTF8), CFStringGetLength(keyValuePairs_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFNetServiceCreateTXTDataWithDictionary", "0x0", parameters, 2);
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
    CFDataRef return_value = original_CFNetServiceCreateTXTDataWithDictionary(alloc, keyValuePairs);
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


Boolean ____CFNetServiceSetClient(CFNetServiceRef theService, CFNetServiceClientCallBack clientCB, CFNetServiceClientContext * clientContext)
{
    if (!is_enabled() || !enabled_) {
        Boolean return_value = original_CFNetServiceSetClient(theService, clientCB, clientContext);
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
//Parse parameter theService
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFNetServiceRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)theService);
//Parse parameter clientCB
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFNetServiceClientCallBack", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "%d", (int)clientCB);
//Parse parameter clientContext
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "^CFNetServiceClientContext", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (register_t)clientContext);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFNetServiceSetClient", "0x0", parameters, 3);
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
    Boolean return_value = original_CFNetServiceSetClient(theService, clientCB, clientContext);
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


void ____CFNetServiceScheduleWithRunLoop(CFNetServiceRef theService, CFRunLoopRef runLoop, CFStringRef runLoopMode)
{
    if (!is_enabled() || !enabled_) {
        original_CFNetServiceScheduleWithRunLoop(theService, runLoop, runLoopMode);
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
//Parse parameter theService
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFNetServiceRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)theService);
//Parse parameter runLoop
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFRunLoopRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "%d", (int)runLoop);
//Parse parameter runLoopMode
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (int)runLoopMode);
    if(runLoopMode) {
        parameters[2].description = (char*)calloc(CFStringGetLength(runLoopMode)+1, sizeof(char));
        CFStringGetCString(runLoopMode, parameters[2].description, CFStringGetLength(runLoopMode) + 1, kCFStringEncodingUTF8);
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFNetServiceScheduleWithRunLoop", "0x0", parameters, 3);
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
    original_CFNetServiceScheduleWithRunLoop(theService, runLoop, runLoopMode);
    set_enabled(false);
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
}


void ____CFNetServiceUnscheduleFromRunLoop(CFNetServiceRef theService, CFRunLoopRef runLoop, CFStringRef runLoopMode)
{
    if (!is_enabled() || !enabled_) {
        original_CFNetServiceUnscheduleFromRunLoop(theService, runLoop, runLoopMode);
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
//Parse parameter theService
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFNetServiceRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)theService);
//Parse parameter runLoop
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFRunLoopRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "%d", (int)runLoop);
//Parse parameter runLoopMode
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (int)runLoopMode);
    if(runLoopMode) {
        parameters[2].description = (char*)calloc(CFStringGetLength(runLoopMode)+1, sizeof(char));
        CFStringGetCString(runLoopMode, parameters[2].description, CFStringGetLength(runLoopMode) + 1, kCFStringEncodingUTF8);
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFNetServiceUnscheduleFromRunLoop", "0x0", parameters, 3);
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
    original_CFNetServiceUnscheduleFromRunLoop(theService, runLoop, runLoopMode);
    set_enabled(false);
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
}


CFNetServiceMonitorRef ____CFNetServiceMonitorCreate(CFAllocatorRef alloc, CFNetServiceRef theService, CFNetServiceMonitorClientCallBack clientCB, CFNetServiceClientContext * clientContext)
{
    if (!is_enabled() || !enabled_) {
        CFNetServiceMonitorRef return_value = original_CFNetServiceMonitorCreate(alloc, theService, clientCB, clientContext);
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
//Parse parameter alloc
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)alloc);
//Parse parameter theService
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFNetServiceRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "%d", (int)theService);
//Parse parameter clientCB
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFNetServiceMonitorClientCallBack", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "%d", (int)clientCB);
//Parse parameter clientContext
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "^CFNetServiceClientContext", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "0x%X", (register_t)clientContext);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFNetServiceMonitorCreate", "0x0", parameters, 4);
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
    CFNetServiceMonitorRef return_value = original_CFNetServiceMonitorCreate(alloc, theService, clientCB, clientContext);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFNetServiceMonitorRef", MAX_TYPE_LENGTH);
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


void ____CFNetServiceMonitorInvalidate(CFNetServiceMonitorRef monitor)
{
    if (!is_enabled() || !enabled_) {
        original_CFNetServiceMonitorInvalidate(monitor);
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
//Parse parameter monitor
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFNetServiceMonitorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)monitor);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFNetServiceMonitorInvalidate", "0x0", parameters, 1);
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
    original_CFNetServiceMonitorInvalidate(monitor);
    set_enabled(false);
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
}


Boolean ____CFNetServiceMonitorStart(CFNetServiceMonitorRef monitor, CFNetServiceMonitorType recordType, CFStreamError * error)
{
    if (!is_enabled() || !enabled_) {
        Boolean return_value = original_CFNetServiceMonitorStart(monitor, recordType, error);
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
//Parse parameter monitor
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFNetServiceMonitorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)monitor);
//Parse parameter recordType
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFNetServiceMonitorType", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "%d", (int)recordType);
//Parse parameter error
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "^CFStreamError", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (register_t)error);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFNetServiceMonitorStart", "0x0", parameters, 3);
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
    Boolean return_value = original_CFNetServiceMonitorStart(monitor, recordType, error);
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


void ____CFNetServiceMonitorStop(CFNetServiceMonitorRef monitor, CFStreamError * error)
{
    if (!is_enabled() || !enabled_) {
        original_CFNetServiceMonitorStop(monitor, error);
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
//Parse parameter monitor
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFNetServiceMonitorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)monitor);
//Parse parameter error
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "^CFStreamError", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (register_t)error);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFNetServiceMonitorStop", "0x0", parameters, 2);
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
    original_CFNetServiceMonitorStop(monitor, error);
    set_enabled(false);
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
}


void ____CFNetServiceMonitorScheduleWithRunLoop(CFNetServiceMonitorRef monitor, CFRunLoopRef runLoop, CFStringRef runLoopMode)
{
    if (!is_enabled() || !enabled_) {
        original_CFNetServiceMonitorScheduleWithRunLoop(monitor, runLoop, runLoopMode);
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
//Parse parameter monitor
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFNetServiceMonitorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)monitor);
//Parse parameter runLoop
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFRunLoopRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "%d", (int)runLoop);
//Parse parameter runLoopMode
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (int)runLoopMode);
    if(runLoopMode) {
        parameters[2].description = (char*)calloc(CFStringGetLength(runLoopMode)+1, sizeof(char));
        CFStringGetCString(runLoopMode, parameters[2].description, CFStringGetLength(runLoopMode) + 1, kCFStringEncodingUTF8);
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFNetServiceMonitorScheduleWithRunLoop", "0x0", parameters, 3);
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
    original_CFNetServiceMonitorScheduleWithRunLoop(monitor, runLoop, runLoopMode);
    set_enabled(false);
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
}


void ____CFNetServiceMonitorUnscheduleFromRunLoop(CFNetServiceMonitorRef monitor, CFRunLoopRef runLoop, CFStringRef runLoopMode)
{
    if (!is_enabled() || !enabled_) {
        original_CFNetServiceMonitorUnscheduleFromRunLoop(monitor, runLoop, runLoopMode);
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
//Parse parameter monitor
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFNetServiceMonitorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)monitor);
//Parse parameter runLoop
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFRunLoopRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "%d", (int)runLoop);
//Parse parameter runLoopMode
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (int)runLoopMode);
    if(runLoopMode) {
        parameters[2].description = (char*)calloc(CFStringGetLength(runLoopMode)+1, sizeof(char));
        CFStringGetCString(runLoopMode, parameters[2].description, CFStringGetLength(runLoopMode) + 1, kCFStringEncodingUTF8);
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFNetServiceMonitorUnscheduleFromRunLoop", "0x0", parameters, 3);
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
    original_CFNetServiceMonitorUnscheduleFromRunLoop(monitor, runLoop, runLoopMode);
    set_enabled(false);
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
}


CFNetServiceBrowserRef ____CFNetServiceBrowserCreate(CFAllocatorRef alloc, CFNetServiceBrowserClientCallBack clientCB, CFNetServiceClientContext * clientContext)
{
    if (!is_enabled() || !enabled_) {
        CFNetServiceBrowserRef return_value = original_CFNetServiceBrowserCreate(alloc, clientCB, clientContext);
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
//Parse parameter alloc
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)alloc);
//Parse parameter clientCB
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFNetServiceBrowserClientCallBack", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "%d", (int)clientCB);
//Parse parameter clientContext
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "^CFNetServiceClientContext", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (register_t)clientContext);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFNetServiceBrowserCreate", "0x0", parameters, 3);
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
    CFNetServiceBrowserRef return_value = original_CFNetServiceBrowserCreate(alloc, clientCB, clientContext);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFNetServiceBrowserRef", MAX_TYPE_LENGTH);
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


void ____CFNetServiceBrowserInvalidate(CFNetServiceBrowserRef browser)
{
    if (!is_enabled() || !enabled_) {
        original_CFNetServiceBrowserInvalidate(browser);
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
//Parse parameter browser
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFNetServiceBrowserRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)browser);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFNetServiceBrowserInvalidate", "0x0", parameters, 1);
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
    original_CFNetServiceBrowserInvalidate(browser);
    set_enabled(false);
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
}


Boolean ____CFNetServiceBrowserSearchForDomains(CFNetServiceBrowserRef browser, Boolean registrationDomains, CFStreamError * error)
{
    if (!is_enabled() || !enabled_) {
        Boolean return_value = original_CFNetServiceBrowserSearchForDomains(browser, registrationDomains, error);
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
//Parse parameter browser
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFNetServiceBrowserRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)browser);
//Parse parameter registrationDomains
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "Boolean", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "%d", (int)registrationDomains);
//Parse parameter error
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "^CFStreamError", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (register_t)error);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFNetServiceBrowserSearchForDomains", "0x0", parameters, 3);
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
    Boolean return_value = original_CFNetServiceBrowserSearchForDomains(browser, registrationDomains, error);
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


Boolean ____CFNetServiceBrowserSearchForServices(CFNetServiceBrowserRef browser, CFStringRef domain, CFStringRef serviceType, CFStreamError * error)
{
    if (!is_enabled() || !enabled_) {
        Boolean return_value = original_CFNetServiceBrowserSearchForServices(browser, domain, serviceType, error);
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
//Parse parameter browser
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFNetServiceBrowserRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)browser);
//Parse parameter domain
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)domain);
    if(domain) {
        parameters[1].description = (char*)calloc(CFStringGetLength(domain)+1, sizeof(char));
        CFStringGetCString(domain, parameters[1].description, CFStringGetLength(domain) + 1, kCFStringEncodingUTF8);
    }
//Parse parameter serviceType
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (int)serviceType);
    if(serviceType) {
        parameters[2].description = (char*)calloc(CFStringGetLength(serviceType)+1, sizeof(char));
        CFStringGetCString(serviceType, parameters[2].description, CFStringGetLength(serviceType) + 1, kCFStringEncodingUTF8);
    }
//Parse parameter error
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "^CFStreamError", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "0x%X", (register_t)error);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFNetServiceBrowserSearchForServices", "0x0", parameters, 4);
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
    Boolean return_value = original_CFNetServiceBrowserSearchForServices(browser, domain, serviceType, error);
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


void ____CFNetServiceBrowserStopSearch(CFNetServiceBrowserRef browser, CFStreamError * error)
{
    if (!is_enabled() || !enabled_) {
        original_CFNetServiceBrowserStopSearch(browser, error);
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
//Parse parameter browser
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFNetServiceBrowserRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)browser);
//Parse parameter error
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "^CFStreamError", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (register_t)error);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFNetServiceBrowserStopSearch", "0x0", parameters, 2);
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
    original_CFNetServiceBrowserStopSearch(browser, error);
    set_enabled(false);
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
}


void ____CFNetServiceBrowserScheduleWithRunLoop(CFNetServiceBrowserRef browser, CFRunLoopRef runLoop, CFStringRef runLoopMode)
{
    if (!is_enabled() || !enabled_) {
        original_CFNetServiceBrowserScheduleWithRunLoop(browser, runLoop, runLoopMode);
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
//Parse parameter browser
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFNetServiceBrowserRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)browser);
//Parse parameter runLoop
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFRunLoopRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "%d", (int)runLoop);
//Parse parameter runLoopMode
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (int)runLoopMode);
    if(runLoopMode) {
        parameters[2].description = (char*)calloc(CFStringGetLength(runLoopMode)+1, sizeof(char));
        CFStringGetCString(runLoopMode, parameters[2].description, CFStringGetLength(runLoopMode) + 1, kCFStringEncodingUTF8);
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFNetServiceBrowserScheduleWithRunLoop", "0x0", parameters, 3);
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
    original_CFNetServiceBrowserScheduleWithRunLoop(browser, runLoop, runLoopMode);
    set_enabled(false);
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
}


void ____CFNetServiceBrowserUnscheduleFromRunLoop(CFNetServiceBrowserRef browser, CFRunLoopRef runLoop, CFStringRef runLoopMode)
{
    if (!is_enabled() || !enabled_) {
        original_CFNetServiceBrowserUnscheduleFromRunLoop(browser, runLoop, runLoopMode);
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
//Parse parameter browser
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFNetServiceBrowserRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)browser);
//Parse parameter runLoop
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFRunLoopRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "%d", (int)runLoop);
//Parse parameter runLoopMode
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (int)runLoopMode);
    if(runLoopMode) {
        parameters[2].description = (char*)calloc(CFStringGetLength(runLoopMode)+1, sizeof(char));
        CFStringGetCString(runLoopMode, parameters[2].description, CFStringGetLength(runLoopMode) + 1, kCFStringEncodingUTF8);
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFNetServiceBrowserUnscheduleFromRunLoop", "0x0", parameters, 3);
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
    original_CFNetServiceBrowserUnscheduleFromRunLoop(browser, runLoop, runLoopMode);
    set_enabled(false);
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
}


CFArrayRef ____CFNetworkCopyProxiesForURL(CFURLRef url, CFDictionaryRef proxySettings)
{
    if (!is_enabled() || !enabled_) {
        CFArrayRef return_value = original_CFNetworkCopyProxiesForURL(url, proxySettings);
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
//Parse parameter proxySettings
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFDictionaryRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)proxySettings);
    if(proxySettings) {
        CFStringRef proxySettings_description = CFCopyDescription(proxySettings);
        parameters[1].description = (char*)calloc(CFStringGetLength(proxySettings_description) + 1, sizeof(char));
        memcpy(parameters[1].description, CFStringGetCStringPtr(proxySettings_description, kCFStringEncodingUTF8), CFStringGetLength(proxySettings_description));
    }
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFNetworkCopyProxiesForURL", "0x0", parameters, 2);
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
    CFArrayRef return_value = original_CFNetworkCopyProxiesForURL(url, proxySettings);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFArrayRef", MAX_TYPE_LENGTH);
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


CFArrayRef ____CFNetworkCopyProxiesForAutoConfigurationScript(CFStringRef proxyAutoConfigurationScript, CFURLRef targetURL, CFErrorRef * error)
{
    if (!is_enabled() || !enabled_) {
        CFArrayRef return_value = original_CFNetworkCopyProxiesForAutoConfigurationScript(proxyAutoConfigurationScript, targetURL, error);
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
//Parse parameter proxyAutoConfigurationScript
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)proxyAutoConfigurationScript);
    if(proxyAutoConfigurationScript) {
        parameters[0].description = (char*)calloc(CFStringGetLength(proxyAutoConfigurationScript)+1, sizeof(char));
        CFStringGetCString(proxyAutoConfigurationScript, parameters[0].description, CFStringGetLength(proxyAutoConfigurationScript) + 1, kCFStringEncodingUTF8);
    }
//Parse parameter targetURL
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)targetURL);
    if(targetURL) {
        CFStringRef targetURL_description = CFCopyDescription(targetURL);
        parameters[1].description = (char*)calloc(CFStringGetLength(targetURL_description) + 1, sizeof(char));
        memcpy(parameters[1].description, CFStringGetCStringPtr(targetURL_description, kCFStringEncodingUTF8), CFStringGetLength(targetURL_description));
    }
//Parse parameter error
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "^CFErrorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (register_t)error);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFNetworkCopyProxiesForAutoConfigurationScript", "0x0", parameters, 3);
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
    CFArrayRef return_value = original_CFNetworkCopyProxiesForAutoConfigurationScript(proxyAutoConfigurationScript, targetURL, error);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFArrayRef", MAX_TYPE_LENGTH);
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


CFRunLoopSourceRef ____CFNetworkExecuteProxyAutoConfigurationScript(CFStringRef proxyAutoConfigurationScript, CFURLRef targetURL, CFProxyAutoConfigurationResultCallback cb, CFStreamClientContext * clientContext)
{
    if (!is_enabled() || !enabled_) {
        CFRunLoopSourceRef return_value = original_CFNetworkExecuteProxyAutoConfigurationScript(proxyAutoConfigurationScript, targetURL, cb, clientContext);
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
//Parse parameter proxyAutoConfigurationScript
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFStringRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)proxyAutoConfigurationScript);
    if(proxyAutoConfigurationScript) {
        parameters[0].description = (char*)calloc(CFStringGetLength(proxyAutoConfigurationScript)+1, sizeof(char));
        CFStringGetCString(proxyAutoConfigurationScript, parameters[0].description, CFStringGetLength(proxyAutoConfigurationScript) + 1, kCFStringEncodingUTF8);
    }
//Parse parameter targetURL
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)targetURL);
    if(targetURL) {
        CFStringRef targetURL_description = CFCopyDescription(targetURL);
        parameters[1].description = (char*)calloc(CFStringGetLength(targetURL_description) + 1, sizeof(char));
        memcpy(parameters[1].description, CFStringGetCStringPtr(targetURL_description, kCFStringEncodingUTF8), CFStringGetLength(targetURL_description));
    }
//Parse parameter cb
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFProxyAutoConfigurationResultCallback", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "%d", (int)cb);
//Parse parameter clientContext
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "^CFStreamClientContext", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "0x%X", (register_t)clientContext);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFNetworkExecuteProxyAutoConfigurationScript", "0x0", parameters, 4);
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
    CFRunLoopSourceRef return_value = original_CFNetworkExecuteProxyAutoConfigurationScript(proxyAutoConfigurationScript, targetURL, cb, clientContext);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFRunLoopSourceRef", MAX_TYPE_LENGTH);
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


CFRunLoopSourceRef ____CFNetworkExecuteProxyAutoConfigurationURL(CFURLRef proxyAutoConfigURL, CFURLRef targetURL, CFProxyAutoConfigurationResultCallback cb, CFStreamClientContext * clientContext)
{
    if (!is_enabled() || !enabled_) {
        CFRunLoopSourceRef return_value = original_CFNetworkExecuteProxyAutoConfigurationURL(proxyAutoConfigURL, targetURL, cb, clientContext);
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
//Parse parameter proxyAutoConfigURL
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (int)proxyAutoConfigURL);
    if(proxyAutoConfigURL) {
        CFStringRef proxyAutoConfigURL_description = CFCopyDescription(proxyAutoConfigURL);
        parameters[0].description = (char*)calloc(CFStringGetLength(proxyAutoConfigURL_description) + 1, sizeof(char));
        memcpy(parameters[0].description, CFStringGetCStringPtr(proxyAutoConfigURL_description, kCFStringEncodingUTF8), CFStringGetLength(proxyAutoConfigURL_description));
    }
//Parse parameter targetURL
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFURLRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (int)targetURL);
    if(targetURL) {
        CFStringRef targetURL_description = CFCopyDescription(targetURL);
        parameters[1].description = (char*)calloc(CFStringGetLength(targetURL_description) + 1, sizeof(char));
        memcpy(parameters[1].description, CFStringGetCStringPtr(targetURL_description, kCFStringEncodingUTF8), CFStringGetLength(targetURL_description));
    }
//Parse parameter cb
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "CFProxyAutoConfigurationResultCallback", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "%d", (int)cb);
//Parse parameter clientContext
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "^CFStreamClientContext", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "0x%X", (register_t)clientContext);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFNetworkExecuteProxyAutoConfigurationURL", "0x0", parameters, 4);
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
    CFRunLoopSourceRef return_value = original_CFNetworkExecuteProxyAutoConfigurationURL(proxyAutoConfigURL, targetURL, cb, clientContext);
    set_enabled(false);
    parameter_t return_param;
    return_param.description = NULL;
    strncpy(return_param.type, "CFRunLoopSourceRef", MAX_TYPE_LENGTH);
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


SInt32 ____CFSocketStreamSOCKSGetErrorSubdomain(const CFStreamError * error)
{
    if (!is_enabled() || !enabled_) {
        SInt32 return_value = original_CFSocketStreamSOCKSGetErrorSubdomain(error);
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
//Parse parameter error
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "^CFStreamError", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (register_t)error);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFSocketStreamSOCKSGetErrorSubdomain", "0x0", parameters, 1);
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
    SInt32 return_value = original_CFSocketStreamSOCKSGetErrorSubdomain(error);
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


SInt32 ____CFSocketStreamSOCKSGetError(const CFStreamError * error)
{
    if (!is_enabled() || !enabled_) {
        SInt32 return_value = original_CFSocketStreamSOCKSGetError(error);
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
//Parse parameter error
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "^CFStreamError", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (register_t)error);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFSocketStreamSOCKSGetError", "0x0", parameters, 1);
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
    SInt32 return_value = original_CFSocketStreamSOCKSGetError(error);
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


void ____CFStreamCreatePairWithSocketToCFHost(CFAllocatorRef alloc, CFHostRef host, SInt32 port, CFReadStreamRef * readStream, CFWriteStreamRef * writeStream)
{
    if (!is_enabled() || !enabled_) {
        original_CFStreamCreatePairWithSocketToCFHost(alloc, host, port, readStream, writeStream);
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
    parameters = (parameter_t*)calloc(5, sizeof(parameter_t));
//Parse parameter alloc
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)alloc);
//Parse parameter host
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFHostRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "%d", (int)host);
//Parse parameter port
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "SInt32", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "%d", (int)port);
//Parse parameter readStream
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "^CFReadStreamRef", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "0x%X", (register_t)readStream);
//Parse parameter writeStream
    parameters[4].description = NULL;
    strncpy(parameters[4].type, "^CFWriteStreamRef", MAX_TYPE_LENGTH);
    snprintf(parameters[4].value, MAX_VALUE_LENGTH, "0x%X", (register_t)writeStream);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFStreamCreatePairWithSocketToCFHost", "0x0", parameters, 5);
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
    original_CFStreamCreatePairWithSocketToCFHost(alloc, host, port, readStream, writeStream);
    set_enabled(false);
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
}


void ____CFStreamCreatePairWithSocketToNetService(CFAllocatorRef alloc, CFNetServiceRef service, CFReadStreamRef * readStream, CFWriteStreamRef * writeStream)
{
    if (!is_enabled() || !enabled_) {
        original_CFStreamCreatePairWithSocketToNetService(alloc, service, readStream, writeStream);
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
    parameters = (parameter_t*)calloc(4, sizeof(parameter_t));
//Parse parameter alloc
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "CFAllocatorRef", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "%d", (int)alloc);
//Parse parameter service
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "CFNetServiceRef", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "%d", (int)service);
//Parse parameter readStream
    parameters[2].description = NULL;
    strncpy(parameters[2].type, "^CFReadStreamRef", MAX_TYPE_LENGTH);
    snprintf(parameters[2].value, MAX_VALUE_LENGTH, "0x%X", (register_t)readStream);
//Parse parameter writeStream
    parameters[3].description = NULL;
    strncpy(parameters[3].type, "^CFWriteStreamRef", MAX_TYPE_LENGTH);
    snprintf(parameters[3].value, MAX_VALUE_LENGTH, "0x%X", (register_t)writeStream);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "CFNetwork", "CFStreamCreatePairWithSocketToNetService", "0x0", parameters, 4);
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
    original_CFStreamCreatePairWithSocketToNetService(alloc, service, readStream, writeStream);
    set_enabled(false);
    thread_infos->call_id_stack->pop_back();
    set_enabled(true);
}


