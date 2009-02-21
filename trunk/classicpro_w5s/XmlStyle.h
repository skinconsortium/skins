#ifndef __XMLSTYLE_H
#define __XMLSTYLE_H

#include <bfc/string/StringW.h>
#include <bfc/ptrlist.h>

class XmlPair
{
public:
	XmlPair(StringW param, StringW value);
	XmlPair::~XmlPair();
	StringW param;
	StringW value;
};

class XmlStyle
{
public:
	XmlStyle(StringW id);
	~XmlStyle();
	StringW id;
	PtrList<XmlPair> tags;
};

#endif