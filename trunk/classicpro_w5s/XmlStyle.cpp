#include "XmlStyle.h"

XmlPair::XmlPair(StringW param, StringW value)
{
	this->param = param;
	this->value = value;
}

XmlPair::~XmlPair()
{
	this->param = NULL;
	this->value = NULL;
}

XmlStyle::XmlStyle(StringW id)
{
	this->id = id;
}

XmlStyle::~XmlStyle()
{
	for(int i = 0; i < this->tags.getNumItems(); i++)
	{
		XmlPair* xp = tags.enumItem(i);
		delete xp;
	}
}