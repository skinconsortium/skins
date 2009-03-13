#include "ClassicProParser.h"
#include "../nu/AutoChar.h"
#include <strsafe.h>
#include <bfc/std.h>

ClassicProParser::ClassicProParser ()
{
	skinVersion = 0;
	appearance_normal_usePlayPauseButton = false;
	appearance_shade_usePlayPauseButton = false;
	appearance_glowButtonFadeInSpeed = 0.3f;
	appearance_glowButtonFadeOutSpeed = 0.5f;


	// PARSER

	parser = NULL;
	parserFactory = NULL;

	parserFactory = WASABI_API_SVC->service_getServiceByGuid(obj_xmlGUID);
	if (parserFactory)
		parser = (obj_xml *)parserFactory->getInterface();

	if (parser)
	{
		XmlParserCallback xpcbHead(XmlParserCallback::CPF_CBT_HEAD, this);
		XmlParserCallback xpcbAppearance(XmlParserCallback::CPF_CBT_APPEARANCE, this);
		XmlParserCallback xpcbStyles(XmlParserCallback::CPF_CBT_STYLES, this);

		parser->xmlreader_registerCallback(L"ClassicPro", &xpcbHead);
		parser->xmlreader_registerCallback(L"ClassicPro\fAppearance\f*", &xpcbAppearance);
		parser->xmlreader_registerCallback(L"ClassicPro\f*\fStyle", &xpcbStyles);
		parser->xmlreader_open();

		wchar_t filename[1024];
		WCSNPRINTF(filename, 1024, L"%s\\%s", WASABI_API_SKIN->getSkinPath(), CPRO_FLEX_XML);
		HANDLE file = CreateFileW(filename, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING, NULL, NULL);

		if (file == INVALID_HANDLE_VALUE)
			WARN(L"classicpro.xml file could not be found!");

		char data[1024];

		DWORD bytesRead;
		while (true)
		{
			if (ReadFile(file, data, 1024, &bytesRead, NULL) && bytesRead)
			{
				parser->xmlreader_feed(data, bytesRead);
			}
			else
				break;
		}

		CloseHandle(file);
		parser->xmlreader_feed(0, 0);

		parser->xmlreader_unregisterCallback(&xpcbHead);
		parser->xmlreader_unregisterCallback(&xpcbAppearance);
		parser->xmlreader_unregisterCallback(&xpcbStyles);
		parser->xmlreader_close();
	}

	if (parserFactory && parser)
		parserFactory->releaseInterface(parser);

	parserFactory = 0;
	parser = 0;
}

ClassicProParser::~ClassicProParser ()
{
	/*for (int i = 0; this->xmlStyles.getNumItems(); i++)
	{
		delete this->xmlStyles.enumItem(i);
	}*/
	this->xmlStyles.freeAll();
	//free(appearance_glowButtonType);
}

XmlParserCallback::XmlParserCallback(int callbackType, ClassicProParser* classicProParser)
{
	this->callbackType = callbackType;
	this->classicProParser = classicProParser;
}

void XmlParserCallback::onStartTag(const wchar_t *xmlpath, const wchar_t *xmltag, ifc_xmlreaderparams *params)
{
	switch (this->callbackType)
	{
	case CPF_CBT_HEAD:
		this->classicProParser->skinVersion = (float)_wtof(params->getItemValue(L"version"));
		this->classicProParser->engineName = _wcsdup(params->getItemValue(L"engine"));
		break;
	case CPF_CBT_APPEARANCE:
		if (!WCSICMP(xmltag, L"PlayPauseButton"))
		{
			updateFromXml(&this->classicProParser->appearance_normal_usePlayPauseButton, params->getItemValue(L"normal"));
			updateFromXml(&this->classicProParser->appearance_shade_usePlayPauseButton, params->getItemValue(L"shade"));
		}
		else if (!WCSICMP(xmltag, L"ButtonGlow"))
		{
			updateFromXml(&this->classicProParser->appearance_glowButtonFadeInSpeed, params->getItemValue(L"fadeInSpeed"));
			updateFromXml(&this->classicProParser->appearance_glowButtonFadeOutSpeed, params->getItemValue(L"fadeOutSpeed"));
			this->classicProParser->appearance_glowButtonType = params->getItemValue(L"type");
		}
		break;
	case CPF_CBT_STYLES:
		if (!params->getItemValue(L"id"))
		{
			MessageBox(0, L"TextStyle id not specified!", L"ClassicPro::Flex ERROR", 0);
			break;
		}
		
		XmlStyle* style = new XmlStyle(params->getItemValue(L"id"));
		for (int i = 0; i != params->getNbItems(); i++)
		{
			if (WCSICMP(params->getItemName(i), L"id"))
			{
				XmlPair* tag = new XmlPair(params->getItemName(i), params->getItemValue(i));
				//MessageBox(0, params->getItemValue(i), params->getItemName(i), 0);
				style->tags.addItem(tag);
			}
		}
		this->classicProParser->xmlStyles.addItem(style);
		break;
	}
}
void XmlParserCallback::onEndTag(const wchar_t *xmlpath, const wchar_t *xmltag)
{
}
void XmlParserCallback::onError(const wchar_t *filename, int linenum, const wchar_t *incpath, int errcode, const wchar_t *errstr)
{
}

inline void XmlParserCallback::updateFromXml(int* data, const wchar_t* xmlParam)
{
	if (xmlParam)
	{
		*data = _wtoi(xmlParam);
	}
}

inline void XmlParserCallback::updateFromXml(float* data, const wchar_t* xmlParam)
{
	if (xmlParam)
	{
		*data = (float)_wtof(xmlParam);
	}
}

#ifdef CBCLASS
#undef CBCLASS
#endif

#define CBCLASS XmlParserCallback
START_DISPATCH;
VCB(ONSTARTELEMENT, onStartTag)
VCB(ONENDELEMENT, onEndTag)
VCB(ONERROR, onError)
END_DISPATCH;