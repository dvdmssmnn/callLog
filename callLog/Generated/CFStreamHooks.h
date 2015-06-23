// CFTypeID CFReadStreamGetTypeID();

// CFTypeID CFWriteStreamGetTypeID();

CFReadStreamRef CFReadStreamCreateWithBytesNoCopy(CFAllocatorRef alloc, const UInt8 *bytes, CFIndex length, CFAllocatorRef bytesDeallocator)
{
  data(bytes, length);
}

CFWriteStreamRef CFWriteStreamCreateWithBuffer(CFAllocatorRef alloc, UInt8 *buffer, CFIndex bufferCapacity);

CFWriteStreamRef CFWriteStreamCreateWithAllocatedBuffers(CFAllocatorRef alloc, CFAllocatorRef bufferAllocator);

CFReadStreamRef CFReadStreamCreateWithFile(CFAllocatorRef alloc, CFURLRef fileURL);

CFWriteStreamRef CFWriteStreamCreateWithFile(CFAllocatorRef alloc, CFURLRef fileURL);

// void CFStreamCreateBoundPair(CFAllocatorRef alloc, CFReadStreamRef *readStream, CFWriteStreamRef *writeStream, CFIndex transferBufferSize);

// void CFStreamCreatePairWithSocket(CFAllocatorRef alloc, CFSocketNativeHandle sock, CFReadStreamRef *readStream, CFWriteStreamRef *writeStream);

void CFStreamCreatePairWithSocketToHost(CFAllocatorRef alloc, CFStringRef host, UInt32 port, CFReadStreamRef *readStream, CFWriteStreamRef *writeStream);

void CFStreamCreatePairWithPeerSocketSignature(CFAllocatorRef alloc, const CFSocketSignature *signature, CFReadStreamRef *readStream, CFWriteStreamRef *writeStream);

// CFStreamStatus CFReadStreamGetStatus(CFReadStreamRef stream);

// CFStreamStatus CFWriteStreamGetStatus(CFWriteStreamRef stream);

CFErrorRef CFReadStreamCopyError(CFReadStreamRef stream);

CFErrorRef CFWriteStreamCopyError(CFWriteStreamRef stream);

Boolean CFReadStreamOpen(CFReadStreamRef stream);

Boolean CFWriteStreamOpen(CFWriteStreamRef stream);

void CFReadStreamClose(CFReadStreamRef stream);

void CFWriteStreamClose(CFWriteStreamRef stream);

Boolean CFReadStreamHasBytesAvailable(CFReadStreamRef stream);

CFIndex CFReadStreamRead(CFReadStreamRef stream, UInt8 *buffer, CFIndex bufferLength)
{
  out(data(buffer, return_value));
}

const UInt8 *CFReadStreamGetBuffer(CFReadStreamRef stream, CFIndex maxBytesToRead, CFIndex *numBytesRead);

Boolean CFWriteStreamCanAcceptBytes(CFWriteStreamRef stream);

CFIndex CFWriteStreamWrite(CFWriteStreamRef stream, const UInt8 *buffer, CFIndex bufferLength)
{
  data(buffer, bufferLength);
}

// CFTypeRef CFReadStreamCopyProperty(CFReadStreamRef stream, CFStringRef propertyName);

// CFTypeRef CFWriteStreamCopyProperty(CFWriteStreamRef stream, CFStringRef propertyName);

// Boolean CFReadStreamSetProperty(CFReadStreamRef stream, CFStringRef propertyName, CFTypeRef propertyValue);

// Boolean CFWriteStreamSetProperty(CFWriteStreamRef stream, CFStringRef propertyName, CFTypeRef propertyValue);

// Boolean CFReadStreamSetClient(CFReadStreamRef stream, CFOptionFlags streamEvents, CFReadStreamClientCallBack clientCB, CFStreamClientContext *clientContext);

// Boolean CFWriteStreamSetClient(CFWriteStreamRef stream, CFOptionFlags streamEvents, CFWriteStreamClientCallBack clientCB, CFStreamClientContext *clientContext);

// void CFReadStreamScheduleWithRunLoop(CFReadStreamRef stream, CFRunLoopRef runLoop, CFStringRef runLoopMode);

// void CFWriteStreamScheduleWithRunLoop(CFWriteStreamRef stream, CFRunLoopRef runLoop, CFStringRef runLoopMode);

// void CFReadStreamUnscheduleFromRunLoop(CFReadStreamRef stream, CFRunLoopRef runLoop, CFStringRef runLoopMode);

// void CFWriteStreamUnscheduleFromRunLoop(CFWriteStreamRef stream, CFRunLoopRef runLoop, CFStringRef runLoopMode);

// void CFReadStreamSetDispatchQueue(CFReadStreamRef stream, dispatch_queue_t q);

// void CFWriteStreamSetDispatchQueue(CFWriteStreamRef stream, dispatch_queue_t q);

// dispatch_queue_t CFReadStreamCopyDispatchQueue(CFReadStreamRef stream);

// dispatch_queue_t CFWriteStreamCopyDispatchQueue(CFWriteStreamRef stream);

//TODO: is actually a CFStreamError
void *CFReadStreamGetError(CFReadStreamRef stream);

//TODO: is actually a CFStreamError
void *CFWriteStreamGetError(CFWriteStreamRef stream);
