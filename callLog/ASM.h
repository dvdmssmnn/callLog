// Copied from http://svn.saurik.com/repos/menes/trunk/aspectivec/AspectiveC.mm

#ifndef argTrace_ASM_h
#define argTrace_ASM_h

#define call(b, value) \
__asm volatile ("push {r0}\n"); \
__asm volatile ("mov r12, %0\n" :: "r"(value)); \
__asm volatile ("pop {r0}\n" #b " r12\n");

#define save() \
__asm volatile ("push {r0, r1, r2, r3}\n");

#define load() \
__asm volatile ("pop {r0, r1, r2, r3}\n");

#define link(b, value) \
__asm volatile ("push {lr}\n"); \
__asm volatile ("sub sp, #4\n"); \
call(b, value) \
__asm volatile ("add sp, #4\n"); \
__asm volatile ("pop {lr}\n");

#define restore_save() \
load()\
save()

#endif
