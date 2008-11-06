/*********************************************************************
SLoB for krazyPlayer 2008
	load effect on startup	
	  ,,,      
	(o o)     
 -ooO--(_)--Ooo-
 
*********************************************************************/

#include <lib/std.mi>
#include "attribs.m"

Function fader (GuiObject o, float speed, int val);
Function moveDraws();

Global Container MainLogo;
Global Layout MainLogoLayout;
Global Group RGBTOGGLE_logo; //main group
Global Layer RGBTOGGLE_LCD, logo_RGB_Red, logo_RGB_Green, logo_RGB_Blue, MainShadow;
Global Group leftdraw, rightdraw;

System.onScriptLoaded()
{
	initattribs();
	
	MainLogo = getContainer("main");
	MainLogoLayout = MainLogo.getLayout("normal");
	MainShadow = MainLogoLayout.findObject("m_shadow");
	RGBTOGGLE_logo = MainLogoLayout.findObject("RGBlogo");
	
	RGBTOGGLE_LCD = MainLogoLayout.findObject("RGBToggle_lcdNormal");
	
	logo_RGB_Red = MainLogoLayout.findObject("m_lcd_Logo_RGB_Red");
	logo_RGB_Green = MainLogoLayout.findObject("m_lcd_Logo_RGB_Green");
	logo_RGB_Blue = MainLogoLayout.findObject("m_lcd_Logo_RGB_Blue");
	
	leftdraw = MainLogoLayout.findObject("drawer_left");
	rightdraw = MainLogoLayout.findObject("drawer_right");
	
	//turn on dta if its off
	if (desktopalpha_enabled_attrib.getData() == "0") desktopalpha_enabled_attrib.setData("1");
	else desktopalpha_enabled_attrib.setData("1");
		
	IF(myattrib_RGB_ENABLE.getData()=="0")
	{
		//default RGB OFF
		RGBTOGGLE_LCD.setAlpha(255);
	}
	else
	{
		
		RGBTOGGLE_LCD.setAlpha(0);
		logo_RGB_Red.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
		logo_RGB_Green.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
		logo_RGB_Blue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));			
	}
	
	//fade group
	fader (RGBTOGGLE_logo, 5.0, 0);
	moveDraws();

}


System.onScriptUnloading()
{
	
}

fader (GuiObject o, float speed, int val)
{
	o.cancelTarget();
	o.setTargetA(val);
	o.gotoTarget();
}

moveDraws()
{
//<group id="drawer_left"  x="6" y="145" w="300" h="200"/>
//<group id="drawer_right"  x="169" y="145" w="300" h="200"/>

	leftdraw.setTargetX(6);  
	leftdraw.setTargetY(145);  
	leftdraw.setTargetSpeed(1.0);  
	leftdraw.gotoTarget();
	
	rightdraw.setTargetX(169);  
	rightdraw.setTargetY(145);
	rightdraw.setTargetSpeed(1.0);
	rightdraw.gotoTarget();
	
	return;

}

leftdraw.onTargetReached()
{
		fader (MainShadow, 0.3, 200);
}