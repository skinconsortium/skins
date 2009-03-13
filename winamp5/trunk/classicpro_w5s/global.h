#ifndef __GLOBAL_H
#define __GLOBAL_H

#define CPRO_VERSION 0.1f
#define CPRO_FLEX_XML L"classicpro.xml"


#ifdef DEBUG
#define WARN(msg) MessageBox(0, msg, L"Warning", 0)
#else
#define WARN(msg)
#endif

#endif