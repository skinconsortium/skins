#include <lib/std.mi>
#include <lib/config.mi>
#include </lib/fileio.mi>

#define Window_Items "{6559CA61-7EB2-4415-A8A9-A2AEEF762B7F}"
#define Options_Menu "{1828D28F-78DD-4647-8532-EBA504B8FC04}"
#define MY_OPT_MENU "{3448EFC7-D134-4F2B-BFA6-B8FC5AB48089}"
// songticker config page
#define CUSTOM_PAGE_SONGTICKER "{7061FDE0-0E12-11D8-BB41-0050DA442EF3}"
// LCD content page
#define CUSTOM_PAGE_LCD_CONTENT_TRANSLATED "{349A0016-0950-11DE-856A-729855D89593}"

// Should be loaded first
#include "languageParser.m"

System.onScriptLoaded() {

	string LangPath = system.getParam() + "Lang";
	int AttribChecked;

	// Should be loaded first to use languages
	languageParserOnLoaded(LangPath);

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
	
	List LCDAttrNames = new List;
	LCDAttrNames.addItem("Normal");
	LCDAttrNames.addItem(MyTranslate(1));
	LCDAttrNames.addItem("Options");

	ConfigAttribute attrLCDcontentTranslated;
	AttribChecked = System.getPrivateInt("Core-X6", "LCD_content", 0);
	for ( int i = 0; i <= 2; i++ )
	{
		attrLCDcontentTranslated = cgiLCDcontentTranslated.newAttribute(LCDAttrNames.enumItem(i), "1");
		if (AttribChecked == i) 
		{
			attrLCDcontentTranslated.setData("1");
		}
		else
		{
			attrLCDcontentTranslated.setData("0");
		}
	}
	delete LCDAttrNames;

	ConfigAttribute songticker_scrolling_disabled_attrib = cgiTicker.newAttribute("Disable Songticker scrolling", "0");
	if (songticker_scrolling_disabled_attrib.getData() == "0") 
	{
		ConfigAttribute songticker_scrolling_modern_attrib = cgiTicker.newAttribute("Modern Songticker scrolling", "1");
	} else {
		ConfigAttribute songticker_scrolling_modern_attrib = cgiTicker.newAttribute("Modern Songticker scrolling", "0");
	}
	ConfigAttribute songticker_scrolling_classic_attrib = cgiTicker.newAttribute("Classic Songticker scrolling", "0");
	
	
}