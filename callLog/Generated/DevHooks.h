#include <unistd.h>

void CFURLRequestSetHTTPRequestBody(CFTypeRef request, CFDataRef body)?;

void CFURLRequestSetHTTPRequestBodyStream(CFTypeRef request, CFReadStreamRef bodyStream)?;

CFTypeRef CFURLConnectionCreate(CFAllocatorRef alloc, CFTypeRef request, CFTypeRef* client)?;

CFTypeRef CFURLConnectionCreateWithProperties(CFAllocatorRef alloc, CFTypeRef request, CFTypeRef* client, CFDictionaryRef properties)?;

void CFURLRequestSetHTTPHeaderFieldValue(CFTypeRef mutableHTTPRequest, CFStringRef httpHeaderField, CFStringRef httpHeaderFieldValue)?;

void CFURLRequestSetMultipleHTTPHeaderFields(CFTypeRef mutableHTTPRequest, CFDictionaryRef headerFields)?;

void CFURLRequestAppendHTTPHeaderFieldValue(CFTypeRef mutableHTTPRequest, CFStringRef httpHeaderField, CFStringRef additionalHttpHeaderFieldValue)?;

CFTypeRef CFURLRequestCreateMutable(CFAllocatorRef alloc, CFURLRef URL, int cachePolicy, CFTimeInterval timeout, CFURLRef mainDocumentURL)?;

CFTypeRef CFURLRequestCreateMutableCopy(CFAllocatorRef alloc, CFTypeRef origRequest)?;

CFTypeRef CFURLRequestCreateMutableHTTPRequest(CFAllocatorRef alloc, CFTypeRef httpRequest, CFArrayRef bodyParts, int cachePolicy, CFTimeInterval	timeout, CFURLRef mainDocumentURL)?;

CFTypeRef CFURLRequestCreateHTTPRequest(CFAllocatorRef alloc, CFTypeRef httpRequest, CFArrayRef	bodyParts, int cachePolicy, CFTimeInterval timeout, CFURLRef mainDocumentURL)?;

CFTypeRef CFURLRequestCreateCopy(CFAllocatorRef	alloc, CFTypeRef   originalRequest)?;

void CFURLRequestSetURL(CFTypeRef request, CFTypeRef url)?;

void CFURLConnectionUseCredential(CFTypeRef conn, CFTypeRef creds, CFTypeRef challenge)?;

CFTypeRef CFURLCredentialCreate(CFAllocatorRef allocator, CFStringRef username, CFStringRef password, CFStringRef accountDomain, int persistence)?;

//This gets called for most NS-types (NSData, NSString, NSFileHandle), NSOutputStream is handled via CFStreams
void _NSWriteDataToFileWithExtendedAttributes(CFStringRef filePath, CFDataRef data, void *unknown, CFDictionaryRef a)?;

ssize_t write(int fildes, const void *buf, size_t nbyte)
{
  data(buf, nbyte);
}

int  open(  char  *filename,  int  access,  int  permission  )
{
  cstring(filename);
}

int close(int fd);

void *SSLHandshake(void *a, void *b)?;
