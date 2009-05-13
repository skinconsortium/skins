// Attrib file for rgb

#include <lib/std.mi>
#include <lib/config.mi>

#ifndef CUSTOM_PAGE_NONEXPOSED
#define CUSTOM_PAGE_NONEXPOSED "{E9C2D926-53CA-400f-9A4D-85E31755A4CF}"
#endif

Function initRGBAttribs ();

//std frame stuff
Global ConfigAttribute myattrib_stdfrmBGREDColor;
Global ConfigAttribute myattrib_stdfrmBGGREENColor;
Global ConfigAttribute myattrib_stdfrmBGBLUEColor;

Global ConfigAttribute myattrib_stdfrmBGEnabled;
Global ConfigAttribute myattrib_stdfrmBGOverlayEnabled;
Global ConfigAttribute myattrib_stdfrmBGLCDEnabled;
Global ConfigAttribute myattrib_stdfrmBGLCDTextEnabled;


Global ConfigAttribute desktopalpha_enabled_attrib;


initRGBAttribs ()
{
	ConfigItem custom_page_nonexposed	= Config.newItem("Hidden", CUSTOM_PAGE_NONEXPOSED);

	//std frame stuff
	myattrib_stdfrmBGREDColor = custom_page_nonexposed.newAttribute("stdframeBGRed", "0");
	myattrib_stdfrmBGGREENColor = custom_page_nonexposed.newAttribute("stdframeBGGreen", "0");
	myattrib_stdfrmBGBLUEColor = custom_page_nonexposed.newAttribute("stdframeBGBlue", "0");

	myattrib_stdfrmBGEnabled = custom_page_nonexposed.newAttribute("stdframeBGEnabled", "0");
	myattrib_stdfrmBGOverlayEnabled = custom_page_nonexposed.newAttribute("stdframeBGOverlayEnabled", "0");
	myattrib_stdfrmBGLCDEnabled = custom_page_nonexposed.newAttribute("stdframeBGLCDEnabled", "0");
	myattrib_stdfrmBGLCDTextEnabled = custom_page_nonexposed.newAttribute("stdframeBGLCDTextEnabled", "0");

	
	desktopalpha_enabled_attrib = Config.getItemByGuid("{9149C445-3C30-4E04-8433-5A518ED0FDDE}").getAttribute("Enable desktop alpha");

}