#ifndef __CLASSIC_PRO_PARSER_H
#define __CLASSIC_PRO_PARSER_H

#include "api.h"
#include "../xml/obj_xml.h"
#include "../xml/ifc_xmlreadercallback.h"
#include <api/service/waServiceFactory.h> 
#include "global.h"
#include "XmlStyle.h"
#include <bfc/ptrlist.h>

class ClassicProParser
{
public:
	ClassicProParser();
	~ClassicProParser();

	float skinVersion;
	const wchar_t* engineName;
	int appearance_normal_usePlayPauseButton;
	int appearance_shade_usePlayPauseButton;
	float appearance_glowButtonFadeInSpeed;
	float appearance_glowButtonFadeOutSpeed;
	StringW appearance_glowButtonType;

	PtrList<XmlStyle> xmlStyles;

private:
	obj_xml *parser;
	waServiceFactory *parserFactory;
};

class XmlParserCallback : public ifc_xmlreadercallback
{
public:
	XmlParserCallback(int callbackType, ClassicProParser* classicProParser);

	void onStartTag(const wchar_t *xmlpath, const wchar_t *xmltag, ifc_xmlreaderparams *params);
	void onEndTag(const wchar_t *xmlpath, const wchar_t *xmltag);
	void onError(const wchar_t *filename, int linenum, const wchar_t *incpath, int errcode, const wchar_t *errstr);

	RECVS_DISPATCH;
	enum
	{
		CPF_CBT_HEAD,
		CPF_CBT_APPEARANCE,
		CPF_CBT_STYLES,
	};
private:
	ClassicProParser* classicProParser;
	int callbackType;

	inline static void updateFromXml(int* data, const wchar_t* xmlParam);
	inline static void updateFromXml(float* data, const wchar_t* xmlParam);
};

#endif