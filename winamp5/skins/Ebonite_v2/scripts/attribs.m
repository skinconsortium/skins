// TODO (mpdeimos) MERGE with other attrib system!


#ifndef included
#error This script can only be compiled as a #include
#endif

#ifndef __ATTRIBS2_M
#define __ATTRIBS2_M


#include <lib/config.mi>

// -----------------------------------------------------------------------------------------------------------------


// this is the page that maps its items to the options menu, you can add attribs or more pages (submenus)
#define CUSTOM_OPTIONSMENU_ITEMS_FOO "{1828D28F-78DD-4647-8532-EBA504B8FC04}"

// this is the page that maps its items to the windows menu (aka View), you can add attribs or more pages (submenus)
#define CUSTOM_WINDOWSMENU_ITEMS_FOO "{6559CA61-7EB2-4415-A8A9-A2AEEF762B7F}"

// non exposed attribs page
#define CUSTOM_PAGE_NONEXPOSED_FOO "{E9C2D926-53CA-400f-9A4D-85E31755A4CF}"

// custom options submenu item page, you can add more, just use guidgen and Config.newItem()
#define CUSTOM_PAGE "{1118eb99-e7fe-4807-9842-7bd08cf33084}"

#define CUSTOM_PAGE_COVER "{0ff91115-b854-4c37-b614-fadb84edac8f}"

// CUT (mpdeimos) #define CUSTOM_PAGE_SONGTICKER "{7061FDE0-0E12-11D8-BB41-0050DA442EF3}"

#include "attribs_rgb.m"

// -----------------------------------------------------------------------------------------------------------------

Function initAttribs();


// -----------------------------------------------------------------------------------------------------------------

Global ConfigAttribute configAttribute_repeatType;
Global ConfigAttribute configAttribute_shuffleType;
Global ConfigAttribute configAttribute_crossfadeType;
Global ConfigAttribute configAttribute_configType;

Global ConfigAttribute myattr_SCCoverEnabled;
Global ConfigAttribute myattr_SC90DegVisEnabled;
Global ConfigAttribute myattr_SC90DegVisDirection;
Global ConfigAttribute myattr_SC90DegVisRotation;

Global ConfigAttribute vis_mode_style_attrib;
Global ConfigAttribute vis_mode_Pattern_attrib;
Global ConfigAttribute myattr_SCCubeVisEnabled;

Global ConfigAttribute globalmyattr_SCCubeVisEnabled;
Global ConfigAttribute globalmyattr_SC90DegVisEnabled;
Global ConfigAttribute globalmyattr_SCCoverEnabled;


/*
Global ConfigAttribute configAttribute_notifier_always_attrib;
Global ConfigAttribute configAttribute_notifier_windowshade_attrib;
Global ConfigAttribute configAttribute_notifier_minimized_attrib;
Global ConfigAttribute configAttribute_notifier_never_attrib;
*/

//from songticker m cos we cannot use both attribs systems, not going to change at this stage, for a new skin yes but not existing

Global ConfigItem optionsmenu_page;


//#define CUSTOM_PAGE_SONGTICKER "{7061FDE0-0E12-11D8-BB41-0050DA442EF3}"

/* CUT (mpdeimos)
Global ConfigAttribute songticker_scrolling_enabled_attrib;
Global ConfigAttribute songticker_scrolling_disabled_attrib;

Global ConfigAttribute songticker_style_modern_attrib;
Global ConfigAttribute songticker_style_old_attrib;
*/


	
// -----------------------------------------------------------------------------------------------------------------
#define NOOFF_FOO if (getData()=="0") { setData("1"); return; }
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
	ConfigItem custom_page 				= Config.newItem("Ebonite Skin", CUSTOM_PAGE);
	
	ConfigItem custom_page_cover		= Config.newItem("Cover", CUSTOM_PAGE_COVER);
	
// CUT (mpdeimos) 	ConfigItem custom_page_songticker	= Config.newItem("Songticker", CUSTOM_PAGE_SONGTICKER);
	

	ConfigItem fooPage	= Config.newItem("Hidden", CUSTOM_PAGE_NONEXPOSED_FOO);

	// load up the cfgpage in which we'll insert our custom page
	ConfigItem custom_options_page 		= Config.getItem(CUSTOM_OPTIONSMENU_ITEMS_FOO);
	optionsmenu_page = Config.getItem(CUSTOM_OPTIONSMENU_ITEMS_FOO);
	
	//ConfigItem custom_page_notifier = Config.newItem("Notifications", CUSTOM_PAGE_NOTIFIER);

	
	configAttribute_repeatType 			= fooPage.newAttribute("Repeat", "1");
	configAttribute_configType 			= fooPage.newAttribute("Config", "1");
	configAttribute_shuffleType 		= fooPage.newAttribute("shuffle", "1");
	configAttribute_crossfadeType 		= fooPage.newAttribute("crossfade", "0");
	
	myattr_SC90DegVisDirection 			= fooPage.newAttribute("VizDirection", "0");
	
	ConfigAttribute submenuattrib = custom_options_page.newAttribute("Cover", "");
	submenuattrib.setData(CUSTOM_PAGE_COVER);	
	myattr_SCCoverEnabled = custom_page_cover.newAttribute("Show Cover", "0");
	myattr_SC90DegVisEnabled = custom_page_cover.newAttribute("Show Viz", "0");
	myattr_SCCubeVisEnabled = custom_page_cover.newAttribute("Show Cube Viz", "0");
	myattr_SC90DegVisRotation = custom_page_cover.newAttribute("Rotate Std Viz", "1");
	
	vis_mode_style_attrib = fooPage.newAttribute("Style", "1");
	vis_mode_Pattern_attrib = fooPage.newAttribute("Pattern", "1");
	globalmyattr_SCCubeVisEnabled = fooPage.newAttribute("coverenablecubeviz", "0");
	globalmyattr_SCCoverEnabled = fooPage.newAttribute("coverenablecover", "0");
	globalmyattr_SC90DegVisEnabled = fooPage.newAttribute("coverenable90viz", "0");
	
	//std frame stuff
	myattrib_stdfrmBGREDColor = fooPage.newAttribute("stdframeBGRed", "0");
	myattrib_stdfrmBGGREENColor = fooPage.newAttribute("stdframeBGGreen", "0");
	myattrib_stdfrmBGBLUEColor = fooPage.newAttribute("stdframeBGBlue", "0");

	
	desktopalpha_enabled_attrib = Config.getItemByGuid("{9149C445-3C30-4E04-8433-5A518ED0FDDE}").getAttribute("Enable desktop alpha");
	
	
	
// CUT (mpdeimos) 	ConfigAttribute submenuattrib = custom_options_page.newAttribute("Songticker", "");
// CUT (mpdeimos) 	submenuattrib.setData(CUSTOM_PAGE_SONGTICKER);
// CUT (mpdeimos) 	songticker_scrolling_enabled_attrib 		= custom_page_songticker.newAttribute("Enable Songticker scrolling", "1");
// CUT (mpdeimos) 	songticker_style_old_attrib 				= custom_page_songticker.newAttribute("Classic Style", "1");

	initRGBAttribs ();
	
	ConfigItem cfgItems;
	
	cfgItems = Config.getItem("Playlist editor");
	if (cfgItems != NULL)
	{
		configAttribute_repeatType = cfgItems.getAttribute("repeat");
	}
	
}



// -----------------------------------------------------------------------------------------------------------------
	
//tri-state logic, there can be only 1		


myattr_SC90DegVisEnabled.onDataChanged()
{
	if(getData()=="1")
	{
		myattr_SCCoverEnabled.setData("0");
		myattr_SCCubeVisEnabled.setData("0");
		
		globalmyattr_SCCoverEnabled.setData("0");
		globalmyattr_SC90DegVisEnabled.setData("1");
		globalmyattr_SCCubeVisEnabled.setData("0");		
	}
	else if(getData()=="2")
	{
		myattr_SCCoverEnabled.setData("0");
		myattr_SCCubeVisEnabled.setData("0");
		
		globalmyattr_SCCoverEnabled.setData("0");
		globalmyattr_SC90DegVisEnabled.setData("2");
		globalmyattr_SCCubeVisEnabled.setData("0");		
	}
	else
	{
		globalmyattr_SC90DegVisEnabled.setData("0");
	}
}

myattr_SCCubeVisEnabled.onDataChanged()
{
	if(getData()=="1")
	{
		myattr_SCCoverEnabled.setData("0");
		myattr_SC90DegVisEnabled.setData("0");
		
		globalmyattr_SCCoverEnabled.setData("0");
		globalmyattr_SC90DegVisEnabled.setData("0");
		globalmyattr_SCCubeVisEnabled.setData("1");
	}
	else
	{
		globalmyattr_SCCubeVisEnabled.setData("0");
	}
}

// CUT (mpdeimos) 
/*
songticker_scrolling_enabled_attrib.onDataChanged()
{
  if (attribs_mychange) return;
  attribs_mychange = 1;
  if (getData() == "1") songticker_scrolling_disabled_attrib.setData("0");
  if (getData() == "0") songticker_scrolling_disabled_attrib.setData("1");
  attribs_mychange = 0;
}
songticker_scrolling_disabled_attrib.onDataChanged()
{
  if (attribs_mychange) return;
  attribs_mychange = 1;
  if (getData() == "1") songticker_scrolling_enabled_attrib.setData("0");
  if (getData() == "0") songticker_scrolling_enabled_attrib.setData("1");
  attribs_mychange = 0;
}


songticker_style_old_attrib.onDataChanged()
{
  if (attribs_mychange) return;
  attribs_mychange = 1;
  if (getData() == "1") songticker_style_modern_attrib.setData("0");
  if (getData() == "0") songticker_style_modern_attrib.setData("1");
  attribs_mychange = 0;
}
songticker_style_modern_attrib.onDataChanged()
{
  if (attribs_mychange) return;
  attribs_mychange = 1;
  if (getData() == "1") songticker_style_old_attrib.setData("0");
  if (getData() == "0") songticker_style_old_attrib.setData("1");
  attribs_mychange = 0;
}
*/


#endif