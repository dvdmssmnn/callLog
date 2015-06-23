//------------------------------------------------------------
//			CFFTPStream.h
//------------------------------------------------------------

CFReadStreamRef CFReadStreamCreateWithFTPURL(CFAllocatorRef alloc, CFURLRef ftpURL);

CFIndex CFFTPCreateParsedResourceListing(CFAllocatorRef alloc, const UInt8 *buffer, CFIndex bufferLength, CFDictionaryRef *parsed);

CFWriteStreamRef CFWriteStreamCreateWithFTPURL(CFAllocatorRef alloc, CFURLRef ftpURL);

//------------------------------------------------------------
//			CFHost.h
//------------------------------------------------------------

// CFTypeID CFHostGetTypeID();

CFHostRef CFHostCreateWithName(CFAllocatorRef allocator, CFStringRef hostname);

CFHostRef CFHostCreateWithAddress(CFAllocatorRef allocator, CFDataRef addr);

// CFHostRef CFHostCreateCopy(CFAllocatorRef alloc, CFHostRef host);

// Boolean CFHostStartInfoResolution(CFHostRef theHost, CFHostInfoType info, CFStreamError *error);

// CFArrayRef CFHostGetAddressing(CFHostRef theHost, Boolean *hasBeenResolved);

// CFArrayRef CFHostGetNames(CFHostRef theHost, Boolean *hasBeenResolved);

// CFDataRef CFHostGetReachability(CFHostRef theHost, Boolean *hasBeenResolved);

// void CFHostCancelInfoResolution(CFHostRef theHost, CFHostInfoType info);

// Boolean CFHostSetClient(CFHostRef theHost, CFHostClientCallBack clientCB, CFHostClientContext *clientContext);

// void CFHostScheduleWithRunLoop(CFHostRef theHost, CFRunLoopRef runLoop, CFStringRef runLoopMode);

// void CFHostUnscheduleFromRunLoop(CFHostRef theHost, CFRunLoopRef runLoop, CFStringRef runLoopMode);

//------------------------------------------------------------
//			CFHTTPAuthentication.h
//------------------------------------------------------------

// CFTypeID CFHTTPAuthenticationGetTypeID();

CFHTTPAuthenticationRef CFHTTPAuthenticationCreateFromResponse(CFAllocatorRef alloc, CFHTTPMessageRef response);

Boolean CFHTTPAuthenticationIsValid(CFHTTPAuthenticationRef auth, CFStreamError *error);

Boolean CFHTTPAuthenticationAppliesToRequest(CFHTTPAuthenticationRef auth, CFHTTPMessageRef request);

Boolean CFHTTPAuthenticationRequiresOrderedRequests(CFHTTPAuthenticationRef auth);

Boolean CFHTTPMessageApplyCredentials(CFHTTPMessageRef request, CFHTTPAuthenticationRef auth, CFStringRef username, CFStringRef password, CFStreamError *error);

Boolean CFHTTPMessageApplyCredentialDictionary(CFHTTPMessageRef request, CFHTTPAuthenticationRef auth, CFDictionaryRef dict, CFStreamError *error);

CFStringRef CFHTTPAuthenticationCopyRealm(CFHTTPAuthenticationRef auth);

CFArrayRef CFHTTPAuthenticationCopyDomains(CFHTTPAuthenticationRef auth);

CFStringRef CFHTTPAuthenticationCopyMethod(CFHTTPAuthenticationRef auth);

Boolean CFHTTPAuthenticationRequiresUserNameAndPassword(CFHTTPAuthenticationRef auth);

Boolean CFHTTPAuthenticationRequiresAccountDomain(CFHTTPAuthenticationRef auth);

//------------------------------------------------------------
//			CFHTTPMessage.h
//------------------------------------------------------------

// CFTypeID CFHTTPMessageGetTypeID();

CFHTTPMessageRef CFHTTPMessageCreateRequest(CFAllocatorRef alloc, CFStringRef requestMethod, CFURLRef url, CFStringRef httpVersion);

CFHTTPMessageRef CFHTTPMessageCreateResponse(CFAllocatorRef  alloc, CFIndex statusCode, CFStringRef statusDescription, CFStringRef httpVersion);

CFHTTPMessageRef CFHTTPMessageCreateEmpty(CFAllocatorRef alloc, Boolean isRequest);

CFHTTPMessageRef CFHTTPMessageCreateCopy(CFAllocatorRef alloc, CFHTTPMessageRef message);

Boolean CFHTTPMessageIsRequest(CFHTTPMessageRef message);

CFStringRef CFHTTPMessageCopyVersion(CFHTTPMessageRef message);

CFDataRef CFHTTPMessageCopyBody(CFHTTPMessageRef message);

void CFHTTPMessageSetBody(CFHTTPMessageRef message, CFDataRef bodyData);

CFStringRef CFHTTPMessageCopyHeaderFieldValue(CFHTTPMessageRef message, CFStringRef headerField);

CFDictionaryRef CFHTTPMessageCopyAllHeaderFields(CFHTTPMessageRef message);

void CFHTTPMessageSetHeaderFieldValue(CFHTTPMessageRef message, CFStringRef headerField, CFStringRef value);

Boolean CFHTTPMessageAppendBytes(CFHTTPMessageRef message, const UInt8 *newBytes, CFIndex numBytes)
{
  data(newBytes, numBytes);
}

// Boolean CFHTTPMessageIsHeaderComplete(CFHTTPMessageRef message);

// CFDataRef CFHTTPMessageCopySerializedMessage(CFHTTPMessageRef message);

CFURLRef CFHTTPMessageCopyRequestURL(CFHTTPMessageRef request);

CFStringRef CFHTTPMessageCopyRequestMethod(CFHTTPMessageRef request);

Boolean CFHTTPMessageAddAuthentication(CFHTTPMessageRef request, CFHTTPMessageRef authenticationFailureResponse, CFStringRef username, CFStringRef password, CFStringRef authenticationScheme, Boolean forProxy);

CFIndex CFHTTPMessageGetResponseStatusCode(CFHTTPMessageRef response);

CFStringRef CFHTTPMessageCopyResponseStatusLine(CFHTTPMessageRef response);

//------------------------------------------------------------
//			CFHTTPStream.h
//------------------------------------------------------------

CFReadStreamRef CFReadStreamCreateForHTTPRequest(CFAllocatorRef alloc, CFHTTPMessageRef request);

CFReadStreamRef CFReadStreamCreateForStreamedHTTPRequest(CFAllocatorRef alloc, CFHTTPMessageRef requestHeaders, CFReadStreamRef requestBody);

//------------------------------------------------------------
//			CFNetDiagnostics.h
//------------------------------------------------------------

CFNetDiagnosticRef CFNetDiagnosticCreateWithStreams(CFAllocatorRef alloc, CFReadStreamRef readStream, CFWriteStreamRef writeStream);

CFNetDiagnosticRef CFNetDiagnosticCreateWithURL(CFAllocatorRef alloc, CFURLRef url);

void CFNetDiagnosticSetName(CFNetDiagnosticRef details, CFStringRef name);

CFNetDiagnosticStatus CFNetDiagnosticDiagnoseProblemInteractively(CFNetDiagnosticRef details);

CFNetDiagnosticStatus CFNetDiagnosticCopyNetworkStatusPassively(CFNetDiagnosticRef details, CFStringRef *description);

//------------------------------------------------------------
//			CFNetServices.h
//------------------------------------------------------------

// CFTypeID CFNetServiceGetTypeID();

// CFTypeID CFNetServiceMonitorGetTypeID();

// CFTypeID CFNetServiceBrowserGetTypeID();

CFNetServiceRef CFNetServiceCreate(CFAllocatorRef alloc, CFStringRef domain, CFStringRef serviceType, CFStringRef name, SInt32 port);

CFNetServiceRef CFNetServiceCreateCopy(CFAllocatorRef alloc, CFNetServiceRef service);

CFStringRef CFNetServiceGetDomain(CFNetServiceRef theService);

CFStringRef CFNetServiceGetType(CFNetServiceRef theService);

CFStringRef CFNetServiceGetName(CFNetServiceRef theService);

Boolean CFNetServiceRegisterWithOptions(CFNetServiceRef theService, CFOptionFlags options, CFStreamError *error);

Boolean CFNetServiceResolveWithTimeout(CFNetServiceRef theService, CFTimeInterval timeout, CFStreamError *error);

void CFNetServiceCancel(CFNetServiceRef theService);

CFStringRef CFNetServiceGetTargetHost(CFNetServiceRef theService);

SInt32 CFNetServiceGetPortNumber(CFNetServiceRef theService);

CFArrayRef CFNetServiceGetAddressing(CFNetServiceRef theService);

CFDataRef CFNetServiceGetTXTData(CFNetServiceRef theService);

Boolean CFNetServiceSetTXTData(CFNetServiceRef theService, CFDataRef txtRecord);

CFDictionaryRef CFNetServiceCreateDictionaryWithTXTData(CFAllocatorRef alloc, CFDataRef txtRecord);

CFDataRef CFNetServiceCreateTXTDataWithDictionary(CFAllocatorRef alloc, CFDictionaryRef keyValuePairs);

Boolean CFNetServiceSetClient(CFNetServiceRef theService, CFNetServiceClientCallBack clientCB, CFNetServiceClientContext *clientContext);

void CFNetServiceScheduleWithRunLoop(CFNetServiceRef theService, CFRunLoopRef runLoop, CFStringRef runLoopMode);

void CFNetServiceUnscheduleFromRunLoop(CFNetServiceRef theService, CFRunLoopRef runLoop, CFStringRef runLoopMode);

CFNetServiceMonitorRef CFNetServiceMonitorCreate(CFAllocatorRef alloc, CFNetServiceRef theService, CFNetServiceMonitorClientCallBack clientCB, CFNetServiceClientContext *clientContext);

void CFNetServiceMonitorInvalidate(CFNetServiceMonitorRef monitor);

Boolean CFNetServiceMonitorStart(CFNetServiceMonitorRef monitor, CFNetServiceMonitorType recordType, CFStreamError *error);

void CFNetServiceMonitorStop(CFNetServiceMonitorRef monitor, CFStreamError *error);

void CFNetServiceMonitorScheduleWithRunLoop(CFNetServiceMonitorRef monitor, CFRunLoopRef runLoop, CFStringRef runLoopMode);

void CFNetServiceMonitorUnscheduleFromRunLoop(CFNetServiceMonitorRef monitor, CFRunLoopRef runLoop, CFStringRef runLoopMode);

CFNetServiceBrowserRef CFNetServiceBrowserCreate(CFAllocatorRef alloc, CFNetServiceBrowserClientCallBack clientCB, CFNetServiceClientContext *clientContext);

void CFNetServiceBrowserInvalidate(CFNetServiceBrowserRef browser);

Boolean CFNetServiceBrowserSearchForDomains(CFNetServiceBrowserRef browser, Boolean registrationDomains, CFStreamError *error);

Boolean CFNetServiceBrowserSearchForServices(CFNetServiceBrowserRef browser, CFStringRef domain, CFStringRef serviceType, CFStreamError *error);

void CFNetServiceBrowserStopSearch(CFNetServiceBrowserRef browser, CFStreamError *error);

void CFNetServiceBrowserScheduleWithRunLoop(CFNetServiceBrowserRef browser, CFRunLoopRef runLoop, CFStringRef runLoopMode);

void CFNetServiceBrowserUnscheduleFromRunLoop(CFNetServiceBrowserRef browser, CFRunLoopRef runLoop, CFStringRef runLoopMode);

//------------------------------------------------------------
//			CFProxySupport.h
//------------------------------------------------------------

CFArrayRef CFNetworkCopyProxiesForURL(CFURLRef url, CFDictionaryRef proxySettings);

CFArrayRef CFNetworkCopyProxiesForAutoConfigurationScript(CFStringRef proxyAutoConfigurationScript, CFURLRef targetURL, CFErrorRef *error);

CFRunLoopSourceRef CFNetworkExecuteProxyAutoConfigurationScript(CFStringRef proxyAutoConfigurationScript, CFURLRef targetURL, CFProxyAutoConfigurationResultCallback cb, CFStreamClientContext * clientContext);

CFRunLoopSourceRef CFNetworkExecuteProxyAutoConfigurationURL(CFURLRef proxyAutoConfigURL, CFURLRef targetURL, CFProxyAutoConfigurationResultCallback cb, CFStreamClientContext * clientContext);

//------------------------------------------------------------
//			CFSocketStream.h
//------------------------------------------------------------

SInt32 CFSocketStreamSOCKSGetErrorSubdomain(const CFStreamError* error);

SInt32 CFSocketStreamSOCKSGetError(const CFStreamError* error);

void CFStreamCreatePairWithSocketToCFHost(CFAllocatorRef alloc, CFHostRef host, SInt32 port, CFReadStreamRef *readStream, CFWriteStreamRef *writeStream);

void CFStreamCreatePairWithSocketToNetService(CFAllocatorRef alloc, CFNetServiceRef service, CFReadStreamRef *readStream, CFWriteStreamRef *writeStream);
