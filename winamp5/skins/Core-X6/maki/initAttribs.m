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

initAttribsonLoaded()
{
	ConfigItem cfgDA = Config.getItemByGuid("{9149C445-3C30-4E04-8433-5A518ED0FDDE}");
	cattrDA = cfgDA.getAttribute("Enable desktop alpha");

	ConfigItem cfgWindows = Config.GetItemByGuid(WINDOW_ITEMS); // Toggle Windows menu
	cattrAlbumArt = cfgWindows.getAttribute("Album Art\tAlt+A");
	cattrEq = cfgWindows.getAttribute("Equalizer\tAlt+G");

	
}

initAttribsonUnLoading()
{
	
}