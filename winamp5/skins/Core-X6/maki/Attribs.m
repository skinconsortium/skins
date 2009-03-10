#include <lib/std.mi>
#include <lib/config.mi>
#include </lib/fileio.mi>

#define Window_Items "{6559CA61-7EB2-4415-A8A9-A2AEEF762B7F}"
#define Options_Menu "{1828D28F-78DD-4647-8532-EBA504B8FC04}"
#define MY_OPT_MENU "{3448EFC7-D134-4F2B-BFA6-B8FC5AB48089}"
// songticker config page
#define CUSTOM_PAGE_SONGTICKER "{7061FDE0-0E12-11D8-BB41-0050DA442EF3}"
// LCD content page
#define CUSTOM_PAGE_LCD_CONTENT "{99881806-7020-4cad-92f8-d9d6ea2783a5}"

#define CUSTOM_PAGE_LCD_CONTENT_TRANSLATED "{349A0016-0950-11DE-856A-729855D89593}"

// Should be loaded first
#include "languageParser.m"

System.onScriptLoaded() {

	string LangPath = system.getParam() + "Lang";

	// Should be loaded first to use languages
	languageParserOnLoaded(LangPath);
	
	// The following lines are only loaded for data.
	ConfigItem cgiLCDcontent = Config.newItem("LCD screen", CUSTOM_PAGE_LCD_CONTENT); // LCD screen values are stored here
	ConfigAttribute attrLCDcontent1 = cgiLCDcontent.newAttribute("Normal", "1");
	ConfigAttribute attrLCDcontent2 = cgiLCDcontent.newAttribute("Visualization", "0");
	ConfigAttribute attrLCDcontent3 = cgiLCDcontent.newAttribute("Options", "0");


	ConfigItem WindowItems = Config.getItem(Window_Items);
	ConfigItem OptionsItems = Config.getItem(Options_Menu);
	ConfigItem cgiTicker = Config.newItem("Songticker", CUSTOM_PAGE_SONGTICKER);
	ConfigItem MyOptMenu = Config.newItem("Core_X6",MY_OPT_MENU);
	ConfigItem cgiLCDcontentTranslated = Config.newItem("LCD screen translated", CUSTOM_PAGE_LCD_CONTENT_TRANSLATED);
	
	ConfigAttribute attrSubMenu = OptionsItems.newAttribute("Core-X6", "");
	attrSubMenu.setData(MY_OPT_MENU);

	ConfigAttribute attrTickerMenu = MyOptMenu.newAttribute("Songticker", "");
	attrTickerMenu.SetData(CUSTOM_PAGE_SONGTICKER);
	
	ConfigAttribute attrLCDcontentMenu = MyOptMenu.newAttribute("LCD", "");
	attrLCDcontentMenu.SetData(CUSTOM_PAGE_LCD_CONTENT_TRANSLATED);

	ConfigAttribute EqAttrib = WindowItems.newAttribute("Equalizer\tAlt+G", "0");
	ConfigAttribute CoverAttrib = WindowItems.newAttribute("Album Art\tAlt+A", "0");	
	
	ConfigAttribute attrLCDcontent1Translated = cgiLCDcontentTranslated.newAttribute("Normal", "1");
	ConfigAttribute attrLCDcontent2Translated = cgiLCDcontentTranslated.newAttribute(MyTranslate(1), "0");
	ConfigAttribute attrLCDcontent3Translated = cgiLCDcontentTranslated.newAttribute("Options", "0");
	
	attrLCDcontent1Translated.setData(attrLCDcontent1.getData());
	attrLCDcontent2Translated.setData(attrLCDcontent2.getData());
	attrLCDcontent3Translated.setData(attrLCDcontent3.getData());

	ConfigAttribute songticker_scrolling_disabled_attrib = cgiTicker.newAttribute("Disable Songticker scrolling", "0");
	if (songticker_scrolling_disabled_attrib.getData() == "0") 
	{
		ConfigAttribute songticker_scrolling_modern_attrib = cgiTicker.newAttribute("Modern Songticker scrolling", "1");
	} else {
		ConfigAttribute songticker_scrolling_modern_attrib = cgiTicker.newAttribute("Modern Songticker scrolling", "0");
	}
	ConfigAttribute songticker_scrolling_classic_attrib = cgiTicker.newAttribute("Classic Songticker scrolling", "0");
	
	
}