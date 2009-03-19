#define WINDOW_ITEMS "{6559CA61-7EB2-4415-A8A9-A2AEEF762B7F}"
#define OPTIONS_MENU "{1828D28F-78DD-4647-8532-EBA504B8FC04}"
#define MY_OPT_MENU "{3448EFC7-D134-4F2B-BFA6-B8FC5AB48089}"

// songticker config page
#define CUSTOM_PAGE_SONGTICKER "{7061FDE0-0E12-11D8-BB41-0050DA442EF3}"
// LCD content page. This is loaded for data
#define CUSTOM_PAGE_LCD_CONTENT "{99881806-7020-4cad-92f8-d9d6ea2783a5}"
// This page is loaded for use (to use translations)
#define CUSTOM_PAGE_LCD_CONTENT_TRANSLATED "{349A0016-0950-11DE-856A-729855D89593}"

function initAttribsonLoaded(); // This function loads attribs
function initAttribsonUnLoading(); // This function stores attribs for future use

Global ConfigAttribute cattrDA;
Global ConfigAttribute cattrAlbumArt;
Global ConfigAttribute cattrEq;

// Attributes for LCD contents

Global List aCattrMNcontent; // List to Parse in Loop
Global configattribute CattrMNcontent1; //Separate for Triggers
Global configattribute CattrMNcontent2;
Global configattribute CattrMNcontent3;

initAttribsonLoaded()
{


/*	ConfigItem cgiLCDcontentT = Config.getItemByGuid(CUSTOM_PAGE_LCD_CONTENT_TRANSLATED);
	

	CattrMNcontent1 = cgiLCDcontentT.getAttribute("Normal");
	CattrMNcontent2 = cgiLCDcontentT.getAttribute(MyTranslate(1));
	CattrMNcontent3 = cgiLCDcontentT.getAttribute("Options");

	aCattrMNcontent = new List;
	aCattrMNcontent.addItem(CattrMNcontent1);
	aCattrMNcontent.addItem(CattrMNcontent2);
	aCattrMNcontent.addItem(CattrMNcontent3);
*/

	ConfigItem cfgDA = Config.getItemByGuid("{9149C445-3C30-4E04-8433-5A518ED0FDDE}");
	cattrDA = cfgDA.getAttribute("Enable desktop alpha");

	ConfigItem cfgWindows = Config.GetItemByGuid(WINDOW_ITEMS); // Toggle Windows menu
	cattrAlbumArt = cfgWindows.getAttribute("Album Art\tAlt+A");
	cattrEq = cfgWindows.getAttribute("Equalizer\tAlt+G");

	
}

initAttribsonUnLoading()
{

/*	ConfigAttribute cattribTemp1;
	ConfigAttribute cattribTemp2;
	ConfigItem cgiLCDcontent = Config.getItemByGuid(CUSTOM_PAGE_LCD_CONTENT);
	ConfigItem cgiLCDcontentT = Config.getItemByGuid(CUSTOM_PAGE_LCD_CONTENT_TRANSLATED);
	List aCattrMNcontentBase;
	aCattrMNcontentBase = new List;
	aCattrMNcontentBase.addItem(cgiLCDcontentT.getAttribute("Normal"));
	aCattrMNcontentBase.addItem(cgiLCDcontentT.getAttribute("Visualization"));
	aCattrMNcontentBase.addItem(cgiLCDcontentT.getAttribute("Options"));
	for ( int i = 0; i <= 2; i++ )
	{
		cattribTemp1 = aCattrMNcontentBase.enumItem(i);
		cattribTemp2 = aCattrMNcontent.enumItem(i);
		cattribTemp1.setData(cattribTemp2.getData());
	}
	delete aCattrMNcontent;
	delete aCattrMNcontentBase;
	*/
}