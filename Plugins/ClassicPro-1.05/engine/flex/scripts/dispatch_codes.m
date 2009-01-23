/**
 * dispatch_codes.m
 *
 * dispatch message definitions
 *
 * @author mpdeimos
 * @date 2008/10/25
 * @version 0.1
 */

#ifndef included
#error This script can only be compiled as a #include
#endif

#include <lib/com/dispatch_ifc.m>

#define SUCCESS 1
#define FAIL 0

/*
 *  Messages
 */

// Call with sendMessageS. Returns SUCCESS on message recieved.
#define SHOW_SYSINFO 0000