#ifndef included
#error This script can only be compiled as a #include
#endif

#ifndef __ATTRIBS2_M
#define __ATTRIBS2_M


#include <lib/config.mi>

// -----------------------------------------------------------------------------------------------------------------


// this is the page that maps its items to the options menu, you can add attribs or more pages (submenus)
#ifndef CUSTOM_OPTIONSMENU_ITEMS
#define CUSTOM_OPTIONSMENU_ITEMS "{1828D28F-78DD-4647-8532-EBA504B8FC04}"


// this is the page that maps its items to the windows menu (aka View), you can add attribs or more pages (submenus)
#define CUSTOM_WINDOWSMENU_ITEMS "{6559CA61-7EB2-4415-A8A9-A2AEEF762B7F}"

// non exposed attribs page
#define CUSTOM_PAGE_NONEXPOSED "{E9C2D926-53CA-400f-9A4D-85E31755A4CF}"
#endif
// custom options submenu item page, you can add more, just use guidgen and Config.newItem()
#define CUSTOM_PAGE "{1118eb99-e7fe-4807-9842-7bd08cf33084}"

#define CUSTOM_PAGE_COVER "{0ff91115-b854-4c37-b614-fadb84edac8f}"

#define CUSTOM_PAGE_SONGTICKER "{7061FDE0-0E12-11D8-BB41-0050DA442EF3}"

// -----------------------------------------------------------------------------------------------------------------

Function initAttribs();


// -----------------------------------------------------------------------------------------------------------------

/* all commented out for now as from another skin, but we could use these if needed
Global ConfigAttribute configAttribute_repeatType;
Global ConfigAttribute configAttribute_shuffleType;
Global ConfigAttribute configAttribute_crossfadeType;
Global ConfigAttribute configAttribute_configType;

Global ConfigAttribute configAttribute_clock_showleadingzero;
Global ConfigAttribute configAttribute_clock_show24hr;
Global ConfigAttribute configAttribute_clock_showwhenstopped;

Global ConfigAttribute myattr_SCCoverEnabled;

Global ConfigAttribute globalmyattr_SCCoverEnabled;
*/
Global ConfigAttribute vis_enabled_attrib;
Global ConfigAttribute vis_mode_style_attrib;

//RGB stuff - keep global so that accessible from any script
Global ConfigAttribute myattrib_RGB_REDColor;
Global ConfigAttribute myattrib_RGB_GREENColor;
Global ConfigAttribute myattrib_RGB_BLUEColor;

Global ConfigAttribute myattrib_RGB_ENABLE;

Global ConfigAttribute desktopalpha_enabled_attrib;

Global ConfigAttribute EQAuto_enabled_attrib;


/*
Global ConfigAttribute configAttribute_notifier_always_attrib;
Global ConfigAttribute configAttribute_notifier_windowshade_attrib;
Global ConfigAttribute configAttribute_notifier_minimized_attrib;
Global ConfigAttribute configAttribute_notifier_never_attrib;
*/

Global ConfigItem optionsmenu_page;
	
// -----------------------------------------------------------------------------------------------------------------
#ifndef NOOFF
#define NOOFF if (getData()=="0") { setData("1"); return; }
#endif
Global Int attribs_mychange;
Global ConfigAttribute sep;
Global Int sep_count = 0;

Function addMenuSeparator(ConfigItem cfgmenupage);

addMenuSeparator(ConfigItem cfgmenupage)
{
	sep_count = sep_count + 1;
	sep = cfgmenupage.newAttribute(getSkinName() + "seperator" + integerToString(sep_count), "");
	sep.setData("-");
}

Function ConfigItem addConfigSubMenu(configitem parent, string name, string guid);

ConfigItem addConfigSubMenu(configitem parent, string name, string guid)
{
	ConfigItem __ret = Config.newItem(name, guid);
	ConfigAttribute __dret = parent.newAttribute(name, "");
	__dret.setData(guid);
	return __ret;
}



initAttribs() {

//initPages();
	// create the custom cfgpage for this session (if it does exist, it just returns it)
	ConfigItem custom_page 				= Config.newItem("krazyPlayer Skin", CUSTOM_PAGE);
	
	//ConfigItem custom_page_cover		= Config.newItem("Cover", CUSTOM_PAGE_COVER);
	
	//ConfigItem custom_page_songticker	= Config.newItem("Songticker", CUSTOM_PAGE_SONGTICKER);
	

	ConfigItem custom_page_nonexposed	= Config.newItem("Hidden", CUSTOM_PAGE_NONEXPOSED);

	// load up the cfgpage in which we'll insert our custom page
	ConfigItem custom_options_page 		= Config.getItem(CUSTOM_OPTIONSMENU_ITEMS);
	optionsmenu_page = Config.getItem(CUSTOM_OPTIONSMENU_ITEMS);
	
	//ConfigItem custom_page_notifier = Config.newItem("Notifications", CUSTOM_PAGE_NOTIFIER);

	
	/*commented out but could use if needed
	configAttribute_repeatType 			= custom_page_nonexposed.newAttribute("Repeat", "1");
	configAttribute_configType 			= custom_page_nonexposed.newAttribute("Config", "1");
	configAttribute_shuffleType 		= custom_page_nonexposed.newAttribute("shuffle", "1");
	configAttribute_crossfadeType 		= custom_page_nonexposed.newAttribute("crossfade", "0");
	
	ConfigAttribute submenuattrib = custom_options_page.newAttribute("Clock", "");
	submenuattrib.setData(CUSTOM_PAGE);
	configAttribute_clock_showwhenstopped 		= custom_page.newAttribute("ShowClockwhenStopped", "1");
	configAttribute_clock_show24hr 				= custom_page.newAttribute("Show24HourClock", "1");
	configAttribute_clock_showleadingzero 		= custom_page.newAttribute("ShowClockLeadingZero", "1");
	
	ConfigAttribute submenuattrib = custom_options_page.newAttribute("Cover", "");
	submenuattrib.setData(CUSTOM_PAGE_COVER);	
	myattr_SCCoverEnabled = custom_page_cover.newAttribute("Show Cover", "0");
	myattr_SC90DegVisEnabled = custom_page_cover.newAttribute("Show Viz", "0");
	
	vis_mode_style_attrib = custom_page_nonexposed.newAttribute("Style", "1");
	globalmyattr_SCCoverEnabled = custom_page_nonexposed.newAttribute("coverenablecover", "0");
	
	*/
	
	vis_enabled_attrib = custom_page_nonexposed.newAttribute("EnableVizMode", "1"); // Martin> vis should be on by default ;)
	vis_mode_style_attrib = custom_page_nonexposed.newAttribute("VizMode", "0");
	
	//RGB stuff - need to default to blue similar to original, it will be close
	myattrib_RGB_REDColor = custom_page_nonexposed.newAttribute("RGB_Red", "0");
	myattrib_RGB_GREENColor = custom_page_nonexposed.newAttribute("RGB_Green", "10");
	myattrib_RGB_BLUEColor = custom_page_nonexposed.newAttribute("RGB_Blue", "255");

	//toggle
	myattrib_RGB_ENABLE = custom_page_nonexposed.newAttribute("ENABLE_RGB", "0");
	
	EQAuto_enabled_attrib = custom_page_nonexposed.newAttribute("ENABLE_EQAuto", "0");
	
	desktopalpha_enabled_attrib = Config.getItemByGuid("{9149C445-3C30-4E04-8433-5A518ED0FDDE}").getAttribute("Enable desktop alpha");
	
	
	/*ConfigAttribute submenuattrib = custom_options_page.newAttribute("Songticker", "");
	submenuattrib.setData(CUSTOM_PAGE_SONGTICKER);
	songticker_scrolling_enabled_attrib 		= custom_page_songticker.newAttribute("Enable Songticker scrolling", "1");
	songticker_style_old_attrib 				= custom_page_songticker.newAttribute("Classic Style", "1");
*/

	
	/*ConfigItem cfgItems;
	
	cfgItems = Config.getItem("Playlist editor");
	if (cfgItems != NULL)
	{
		configAttribute_repeatType = cfgItems.getAttribute("repeat");
	}*/
	
}



#endif




