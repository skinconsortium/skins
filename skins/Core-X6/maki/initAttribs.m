function initAttribsonLoaded(); // This function loads attribs
function initAttribsonUnLoading(); // This function stores attribs for future use

Global ConfigAttribute cattrDA;
Global ConfigAttribute cattrAlbumArt;
Global ConfigAttribute cattrEq;

// Attributes for LCD contents

Global configattribute CattrMNcontent1; //Separate for Triggers
Global configattribute CattrMNcontent2;
Global configattribute CattrMNcontent3;

initAttribsonLoaded()
{


	ConfigItem cgiLCDcontentT = Config.getItemByGuid(CUSTOM_PAGE_LCD_CONTENT_TRANSLATED);
	
	CattrMNcontent1 = cgiLCDcontentT.getAttribute(LCDattrNames.eNumItem(0));
	CattrMNcontent2 = cgiLCDcontentT.getAttribute(LCDattrNames.eNumItem(1));
	CattrMNcontent3 = cgiLCDcontentT.getAttribute(LCDattrNames.eNumItem(2));

	ConfigItem cfgDA = Config.getItemByGuid("{9149C445-3C30-4E04-8433-5A518ED0FDDE}");
	cattrDA = cfgDA.getAttribute("Enable desktop alpha");

	ConfigItem cfgWindows = Config.GetItemByGuid(WINDOW_ITEMS); // Toggle Windows menu
	cattrAlbumArt = cfgWindows.getAttribute("Album Art\tAlt+A");
	cattrEq = cfgWindows.getAttribute("Equalizer\tAlt+G");

	
}

initAttribsonUnLoading()
{
	ConfigItem cgiLCDcontentT = Config.getItemByGuid(CUSTOM_PAGE_LCD_CONTENT_TRANSLATED);
	ConfigAttribute CattrMNcontent;

// Saving LCD content info
	for ( int i = 0; i <= 2; i++ )
	{
		CattrMNcontent = cgiLCDcontentT.getAttribute(LCDattrNames.eNumItem(i));
		if (CattrMNcontent.getData() == "1")
		{
			System.setPrivateInt("Core-X6", "LCD_content", i);
		}
	}
	
}