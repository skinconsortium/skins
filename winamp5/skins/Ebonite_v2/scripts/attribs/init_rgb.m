// Attrib file for rgb


#ifndef included
#error This script can only be compiled as a #include
#endif

#include "gen_pageguids.m"


Function initAttribs_RGB ();

//std frame stuff
Global ConfigAttribute myattrib_stdfrmBGREDColor;
Global ConfigAttribute myattrib_stdfrmBGGREENColor;
Global ConfigAttribute myattrib_stdfrmBGBLUEColor;

Global ConfigAttribute myattrib_stdfrmBGEnabled;
Global ConfigAttribute myattrib_stdfrmBGOverlayEnabled;
Global ConfigAttribute myattrib_stdfrmBGLCDEnabled;
Global ConfigAttribute myattrib_stdfrmBGLCDTextEnabled;


Global ConfigAttribute desktopalpha_enabled_attrib;


initAttribs_RGB ()
{
	ConfigItem fooPage	= Config.newItem("Hidden", CUSTOM_PAGE_NONEXPOSED);

	//std frame stuff
	myattrib_stdfrmBGREDColor = fooPage.newAttribute("stdframeBGRed", "0");
	myattrib_stdfrmBGGREENColor = fooPage.newAttribute("stdframeBGGreen", "0");
	myattrib_stdfrmBGBLUEColor = fooPage.newAttribute("stdframeBGBlue", "0");

	myattrib_stdfrmBGEnabled = fooPage.newAttribute("stdframeBGEnabled", "0");
	myattrib_stdfrmBGOverlayEnabled = fooPage.newAttribute("stdframeBGOverlayEnabled", "0");
	myattrib_stdfrmBGLCDEnabled = fooPage.newAttribute("stdframeBGLCDEnabled", "0");
	myattrib_stdfrmBGLCDTextEnabled = fooPage.newAttribute("stdframeBGLCDTextEnabled", "0");

	
	desktopalpha_enabled_attrib = Config.getItemByGuid("{9149C445-3C30-4E04-8433-5A518ED0FDDE}").getAttribute("Enable desktop alpha");

}