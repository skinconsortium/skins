/*********************************************************************
SLoB for krazyPlayer 2008
	original idea:- Quadhelix, leechbite
	http://www.skinconsortium.com
	
	//get current theme
	string CT = strlower(getPublicString("Color Themes/" + getSkinName(), "error"));

	this script is still wip, a concept if you like, if you use the script or idea please give credit
	
	  ,,,      
	(o o)     
 -ooO--(_)--Ooo-
 
*********************************************************************/

#include <lib/std.mi>
#include "attribs.m"

#define RGBDefaultRED 0
#define RGBDefaultGREEN 10
#define RGBDefaultBLUE 255

//#define DEBUG
#ifdef DEBUG
Function debug(String debugStr);
debug(String debugStr) {
	//system.debugstring("Debug Message:" + debugStr, 0); //debug console
	
	System.messageBox(debugStr, "Debug Error", 0, "");
}
#endif


// **** global variables *****

global Container cccont, MainPlayer;
global Layout cclay, MainLayout;

global Container contPL, contVid, contVis;
global Layout layPL, layVid, layVis;

global slider redslider, greenslider, blueslider, textSlider;
global layer colorpalette;
global map mapred, mapgreen, mapblue;
global boolean colormousedown;
global text trv, tgv, tbv;

//RGB -SLoB global Layer MainBGRed, MainBGGreen, MainBGBlue; //for main background at some point
global layer MainLCDRed, MainLCDGreen, MainLCDBlue;
global layer MainBlackSurroundRed, MainBlackSurroundGreen, MainBlackSurroundBlue;
global layer MainLCDBottomLeftRed, MainLCDBottomLeftGreen, MainLCDBottomLeftBlue;
global layer MainLCDBottomRightRed, MainLCDBottomRightGreen, MainLCDBottomRightBlue;
global layer MainBGTopLightRed, MainBGTopLightGreen, MainBGTopLightBlue;
global layer MainCButtonRed, MainCButtonGreen, MainCButtonBlue;

global layer toggleRGB_bg, toggleRGB_lcd, toggleRGB_rimlights, toggleRGB_leftbar, toggleRGB_rightbar, toggleRGB_cbuttons;
//TOGGLE FOR TURNING RGB ON OFF
//myattrib_RGB_ENABLE
global checkbox cbEnableRGB;
//comp windows
global layer plright, plrightRGBBlue, plrightRGBGreen, plrightRGBRed;
global layer plleft, plleftRGBBlue, plleftRGBGreen, plleftRGBRed;

global layer vidright, vidrightRGBBlue, vidrightRGBGreen, vidrightRGBRed;
global layer vidleft, vidleftRGBBlue, vidleftRGBGreen, vidleftRGBRed;

global layer visright, visrightRGBBlue, visrightRGBGreen, visrightRGBRed;
global layer visleft, visleftRGBBlue, visleftRGBGreen, visleftRGBRed, visrnd;
global layer visrnd, visrndRGBBlue, visrndRGBGreen, visrndRGBRed, visrndEnabled;

Global ConfigAttribute ca_visrnd;
Global layer visrndbtn;


//not possible atm to change system colours, will try to set a colour for font and see if thats resettable


//SLoB test for next update version
//function RGB_ChangeColour();
//function nextColour();
//Global int r, g, b, nextr, nextg, nextb;
//Global timer tmrRGB;


System.onScriptLoaded() 
{
	initattribs();
	
	cccont = getContainer("sc.colorchanger");
	cclay = cccont.getLayout("changer");
	MainPlayer = getContainer("main");
	MainLayout = MainPlayer.getLayout("normal");
	
	contPL = getContainer("Pledit");
	layPL = contPL.getLayout("normal");
	
	contVid = getContainer("Video");
	layVid = contVid.getLayout("normal");

	contVis = getContainer("AVS");
	layVis = contVis.getLayout("normal");
	
	redslider = cclay.findObject("red.slider");
	greenslider = cclay.findObject("green.slider");
	blueslider = cclay.findObject("blue.slider");
	colorpalette = cclay.findObject("color.palette");
	
	cbEnableRGB  = cclay.findObject("checkbox.enableRGB");
	
	//toggle rgb with real layers
	toggleRGB_bg 		= MainLayout.findObject("RGBToggle_m_dummybg");
	toggleRGB_lcd 		= MainLayout.findObject("RGBToggle_m_lcd");
	toggleRGB_rimlights = MainLayout.findObject("RGBToggle_m_black_sur");
	toggleRGB_leftbar  	= MainLayout.findObject("RGBToggle_m_lcd_bottomleft");
	toggleRGB_rightbar 	= MainLayout.findObject("RGBToggle_m_lcd_bottomright");
	toggleRGB_cbuttons 	= MainLayout.findObject("RGBToggle_m_cbutton_RGB_Blue");

/*
	BGRed = MainLayout.findObject("player.background.red");
	BGGreen = MainLayout.findObject("player.background.green");
	BGBlue = MainLayout.findObject("player.background.blue");
*/
	MainLCDRed = MainLayout.findObject("m_lcd_RGB_Red");
	MainLCDGreen = MainLayout.findObject("m_lcd_RGB_Green");
	MainLCDBlue = MainLayout.findObject("m_lcd_RGB_Blue");
		
	MainBlackSurroundRed = MainLayout.findObject("m_black_sur_RGB_Red");
	MainBlackSurroundGreen = MainLayout.findObject("m_black_sur_RGB_Green");
	MainBlackSurroundBlue = MainLayout.findObject("m_black_sur_RGB_Blue");

	MainLCDBottomLeftRed = MainLayout.findObject("m_lcd_left_RGB_Red");
	MainLCDBottomLeftGreen = MainLayout.findObject("m_lcd_left_RGB_Green");
	MainLCDBottomLeftBlue = MainLayout.findObject("m_lcd_left_RGB_Blue");
	
	MainLCDBottomRightRed = MainLayout.findObject("m_lcd_right_RGB_Red");
	MainLCDBottomRightGreen = MainLayout.findObject("m_lcd_right_RGB_Green");
	MainLCDBottomRightBlue = MainLayout.findObject("m_lcd_right_RGB_Blue");

	MainBGTopLightRed = MainLayout.findObject("m_background_TopLight_RGB_Red");
	MainBGTopLightGreen = MainLayout.findObject("m_background_TopLight_RGB_Green");
	MainBGTopLightBlue = MainLayout.findObject("m_background_TopLight_RGB_Blue");

	MainCButtonRed = MainLayout.findObject("m_cbutton_RGB_Red");
	MainCButtonGreen = MainLayout.findObject("m_cbutton_RGB_Green");
	MainCButtonBlue = MainLayout.findObject("m_cbutton_RGB_Blue");


	trv = cclay.findObject("text.red");
	tgv = cclay.findObject("text.green");
	tbv = cclay.findObject("text.blue");
	
	//comp windows
	
	//PL
	plright = layPL.findObject("plright");
	plrightRGBBlue = layPL.findObject("plright.RGB.Blue");
	plrightRGBGreen = layPL.findObject("plright.RGB.Green");
	plrightRGBRed = layPL.findObject("plright.RGB.Red");
	
	plleft = layPL.findObject("plleft");
	plleftRGBBlue = layPL.findObject("plleft.RGB.Blue");
	plleftRGBGreen = layPL.findObject("plleft.RGB.Green");
	plleftRGBRed = layPL.findObject("plleft.RGB.Red");
	
	//vid
	vidright = layVid.findObject("vidright");
	vidrightRGBBlue = layVid.findObject("vidright.RGB.Blue");
	vidrightRGBGreen = layVid.findObject("vidright.RGB.Green");
	vidrightRGBRed = layVid.findObject("vidright.RGB.Red");
	
	vidleft = layVid.findObject("vidleft");
	vidleftRGBBlue = layVid.findObject("vidleft.RGB.Blue");
	vidleftRGBGreen = layVid.findObject("vidleft.RGB.Green");
	vidleftRGBRed = layVid.findObject("vidleft.RGB.Red");

	//	  vis
	visright = layVis.findObject("visright");
	visrightRGBBlue = layVis.findObject("visright.RGB.Blue");
	visrightRGBGreen = layVis.findObject("visright.RGB.Green");
	visrightRGBRed = layVis.findObject("visright.RGB.Red");
	
	visleft = layVis.findObject("visleft");
	visleftRGBBlue = layVis.findObject("visleft.RGB.Blue");
	visleftRGBGreen = layVis.findObject("visleft.RGB.Green");
	visleftRGBRed = layVis.findObject("visleft.RGB.Red");
	
	visrnd = layVis.findObject("visrnd");
	visrndRGBBlue = layVis.findObject("visrnd.RGB.Blue");
	visrndRGBGreen = layVis.findObject("visrnd.RGB.Green");
	visrndRGBRed = layVis.findObject("visrnd.RGB.Red");
	visrndEnabled = layVis.findObject("visrnd.RGB.Enabled");
	ca_visrnd = config.getItemByGuid("{0000000A-000C-0010-FF7B-01014263450C}").getAttribute("Random");
	visrndbtn = layVis.findObject("visrnd.RGB.Button.Enabled");
	
	//set default colour on first startup
	redslider.setPosition(getPrivateInt(getSkinName(),"red", stringtointeger(myattrib_RGB_REDColor.getData())));
	greenslider.setPosition(getPrivateInt(getSkinName(),"green", stringtointeger(myattrib_RGB_GREENColor.getData())));
	blueslider.setPosition(getPrivateInt(getSkinName(),"blue", stringtointeger(myattrib_RGB_BLUEColor.getData())));
	
	
/*
	mapred = new map;
	mapred.loadMap("color.map.red");

	mapgreen = new map;
	mapgreen.loadMap("color.map.green");

	mapblue = new map;
	mapblue.loadMap("color.map.blue");
*/

	colormousedown = 0;
	
	//set all the colours for the various sections based on saved colours, wow wot a list :)
	//BG
	/*BGRed.setAlpha(getPrivateInt(getSkinName(),"redbg", 0));
	BGGreen.setAlpha(getPrivateInt(getSkinName(),"greenbg", 0));
	BGBlue.setAlpha(getPrivateInt(getSkinName(),"bluebg", 0));
	*/

	MainLCDRed.setAlpha(getPrivateInt(getSkinName(),"redlcd", RGBDefaultRED));
	MainLCDGreen.setAlpha(getPrivateInt(getSkinName(),"greenlcd", RGBDefaultGREEN));
	MainLCDBlue.setAlpha(getPrivateInt(getSkinName(),"bluelcd", RGBDefaultBLUE));
	
	MainBlackSurroundRed.setAlpha(getPrivateInt(getSkinName(),"redlcd", RGBDefaultRED));
	MainBlackSurroundGreen.setAlpha(getPrivateInt(getSkinName(),"greenlcd", RGBDefaultGREEN));
	MainBlackSurroundBlue.setAlpha(getPrivateInt(getSkinName(),"bluelcd", RGBDefaultBLUE));
	
	
	MainLCDBottomLeftRed.setAlpha(getPrivateInt(getSkinName(),"redlcd", RGBDefaultRED));
	MainLCDBottomLeftGreen.setAlpha(getPrivateInt(getSkinName(),"greenlcd", RGBDefaultRED));
	MainLCDBottomLeftBlue.setAlpha(getPrivateInt(getSkinName(),"bluelcd", RGBDefaultBLUE));
	MainLCDBottomRightRed.setAlpha(getPrivateInt(getSkinName(),"redlcd", RGBDefaultRED));
	MainLCDBottomRightGreen.setAlpha(getPrivateInt(getSkinName(),"greenlcd", RGBDefaultGREEN));
	MainLCDBottomRightBlue.setAlpha(getPrivateInt(getSkinName(),"bluelcd", RGBDefaultBLUE));
	
	MainBGTopLightRed.setAlpha(getPrivateInt(getSkinName(),"redlcd", RGBDefaultRED));
	MainBGTopLightGreen.setAlpha(getPrivateInt(getSkinName(),"greenlcd", RGBDefaultGREEN));
	MainBGTopLightBlue.setAlpha(getPrivateInt(getSkinName(),"bluelcd", RGBDefaultBLUE));

	MainCButtonRed.setAlpha(getPrivateInt(getSkinName(),"redlcd", RGBDefaultRED));
	MainCButtonGreen.setAlpha(getPrivateInt(getSkinName(),"greenlcd", RGBDefaultGREEN));
	MainCButtonBlue.setAlpha(getPrivateInt(getSkinName(),"bluelcd", RGBDefaultBLUE));
	
	
	//string stdfrmcol = "" + myattrib_RGB_REDColor.getData() + "," + myattrib_RGB_GREENColor.getData() + "," + myattrib_RGB_BLUEColor.getData() + "";
	//debug(stdfrmcol);
	//comptitle_dummy.setXMLParam("color", "" + stdfrmcol + "");
	//comptitle_dummy.setXMLParam("color",integerToString(redslider.getPosition())+","+integerToString(greenslider.getPosition())+","+integerToString(blueslider.getPosition()));
	
	//toggle RGB
	IF(myattrib_RGB_ENABLE.getData()=="0")
	{
		//default RGB OFF
		toggleRGB_bg.setAlpha(255);
		toggleRGB_lcd.setAlpha(255);
		toggleRGB_rimlights.setAlpha(255);
		toggleRGB_leftbar.setAlpha(255);
		toggleRGB_rightbar.setAlpha(255);
		toggleRGB_cbuttons.setAlpha(255);
		cbEnableRGB.setChecked(0);
		//compwindows
		plright.setAlpha(255);
		plrightRGBBlue.setAlpha(0);
		plrightRGBGreen.setAlpha(0);
		plrightRGBRed.setAlpha(0);
		
		plleft.setAlpha(255);
		plleftRGBBlue.setAlpha(0);
		plleftRGBGreen.setAlpha(0);
		plleftRGBRed.setAlpha(0);
		
		vidright.setAlpha(255);
		vidrightRGBBlue.setAlpha(0);
		vidrightRGBGreen.setAlpha(0);
		vidrightRGBRed.setAlpha(0);
		
		vidleft.setAlpha(255);
		vidleftRGBBlue.setAlpha(0);
		vidleftRGBGreen.setAlpha(0);
		vidleftRGBRed.setAlpha(0);
		
		visright.setAlpha(255);
		visrightRGBBlue.setAlpha(0);
		visrightRGBGreen.setAlpha(0);
		visrightRGBRed.setAlpha(0);
		
		visleft.setAlpha(255);
		visleftRGBBlue.setAlpha(0);
		visleftRGBGreen.setAlpha(0);
		visleftRGBRed.setAlpha(0);
		
		visrnd.setAlpha(255);
		visrndRGBBlue.setAlpha(0);
		visrndRGBGreen.setAlpha(0);
		visrndRGBRed.setAlpha(0);
	
	}
	else
	{
		//turn RGB on
		toggleRGB_bg.setAlpha(0);
		toggleRGB_lcd.setAlpha(0);
		toggleRGB_rimlights.setAlpha(0);
		toggleRGB_leftbar.setAlpha(0);
		toggleRGB_rightbar.setAlpha(0);
		toggleRGB_cbuttons.setAlpha(0);
		cbEnableRGB.setChecked(1);
		//compwindows
		plright.setAlpha(0);
		plrightRGBBlue.setAlpha(getPrivateInt(getSkinName(),"bluelcd", RGBDefaultBLUE));
		plrightRGBGreen.setAlpha(getPrivateInt(getSkinName(),"greenlcd", RGBDefaultGREEN));
		plrightRGBRed.setAlpha(getPrivateInt(getSkinName(),"redlcd", RGBDefaultRED));
		
		plleft.setAlpha(0);
		plleftRGBBlue.setAlpha(getPrivateInt(getSkinName(),"bluelcd", RGBDefaultBLUE));
		plleftRGBGreen.setAlpha(getPrivateInt(getSkinName(),"greenlcd", RGBDefaultGREEN));
		plleftRGBRed.setAlpha(getPrivateInt(getSkinName(),"redlcd", RGBDefaultRED));
		
		vidright.setAlpha(0);
		vidrightRGBBlue.setAlpha(getPrivateInt(getSkinName(),"bluelcd", RGBDefaultBLUE));
		vidrightRGBGreen.setAlpha(getPrivateInt(getSkinName(),"greenlcd", RGBDefaultGREEN));
		vidrightRGBRed.setAlpha(getPrivateInt(getSkinName(),"redlcd", RGBDefaultRED));
		
		vidleft.setAlpha(0);
		vidleftRGBBlue.setAlpha(getPrivateInt(getSkinName(),"bluelcd", RGBDefaultBLUE));
		vidleftRGBGreen.setAlpha(getPrivateInt(getSkinName(),"greenlcd", RGBDefaultGREEN));
		vidleftRGBRed.setAlpha(getPrivateInt(getSkinName(),"redlcd", RGBDefaultRED));
		
		visright.setAlpha(0);
		visrightRGBBlue.setAlpha(getPrivateInt(getSkinName(),"bluelcd", RGBDefaultBLUE));
		visrightRGBGreen.setAlpha(getPrivateInt(getSkinName(),"greenlcd", RGBDefaultGREEN));
		visrightRGBRed.setAlpha(getPrivateInt(getSkinName(),"redlcd", RGBDefaultRED));
		
		visleft.setAlpha(0);
		visleftRGBBlue.setAlpha(getPrivateInt(getSkinName(),"bluelcd", RGBDefaultBLUE));
		visleftRGBGreen.setAlpha(getPrivateInt(getSkinName(),"greenlcd", RGBDefaultGREEN));
		visleftRGBRed.setAlpha(getPrivateInt(getSkinName(),"redlcd", RGBDefaultRED));
		
		visrnd.setAlpha(0);
		visrndRGBBlue.setAlpha(getPrivateInt(getSkinName(),"bluelcd", RGBDefaultBLUE));
		visrndRGBGreen.setAlpha(getPrivateInt(getSkinName(),"greenlcd", RGBDefaultGREEN));
		visrndRGBRed.setAlpha(getPrivateInt(getSkinName(),"redlcd", RGBDefaultRED));
		
	}

	//toggle layer on/off for vis rnd button
	//System.messageBox(ca_visrnd.getData(), "Debug Error", 0, "");
	if (ca_visrnd.getData() == "1")
	{
		visrndEnabled.setAlpha(0);
		visrndbtn.setAlpha(0);
	}
	else
	{
		visrndEnabled.setAlpha(255);
		visrndbtn.setAlpha(255);
	}
	
	//tmrRGB = new timer;
	//tmrRGB.setdelay(60);
	
	//if(myattrib_RGB_ENABLE.getData()=="1")
	//{
	//	RGB_ChangeColour();
	//}
	
}


//SLoB new code - shud b commented out for release version, this is just for testing
/*
RGB_ChangeColour()
{

	if(myattrib_RGB_ENABLE.getData()=="1")
	{
		r = System.random(255);
		b = System.random(100);
		g = System.random(255);
		nextr = System.random(255);
		nextb = System.random(100);
		nextg = System.random(255);
		
		redslider.SetPosition(r);
		greenslider.SetPosition(g);
		blueslider.SetPosition(b);
		
		//myattrib_RGB_REDColor.setData(integertostring(r));
		//myattrib_RGB_GREENColor.setData(integertostring(g));
		//myattrib_RGB_BLUEColor.setData(integertostring(b));
		
		tmrRGB.start();
	}
	else
	{
		tmrRGB.stop();
	}
}

nextColour()
{
	if (r>nextr) {r=r-1;}
	if (r<nextr) {r++;}	
	if (b>nextb) {b=b-1;}
	if (b<nextb) {b++;}		
	if (g>nextg) {g=g-1;}
	if (g<nextg) {g++;}
	if (r==nextr)
	{
		if (g==nextg)
		{
			if (b==nextb)
			{
				nextr = System.random(255);
				nextb = System.random(255);
				nextg = System.random(255);
			}
		}
	}

	redslider.SetPosition(r);
	greenslider.SetPosition(g);
	blueslider.SetPosition(b);
	
	//myattrib_RGB_REDColor.setData(integertostring(r));
	//myattrib_RGB_GREENColor.setData(integertostring(g));
	//myattrib_RGB_BLUEColor.setData(integertostring(b));

}

tmrRGB.onTimer()
{
	nextColour();
}
*/

System.onScriptUnloading()
{
	
	//delete tmrRGB; //test
  delete mapred;
  delete mapgreen;
  delete mapblue;
}



ca_visrnd.onDataChanged()
{
	if(getData()=="1")
	{
		visrndEnabled.setAlpha(0);
		visrndbtn.setAlpha(0);
	}
	else
	{
		visrndEnabled.setAlpha(255);
		visrndbtn.setAlpha(255);
	}
}


//toggle RGB
cbEnableRGB.onToggle(int newstate)
{
	if(newstate == 1)
	{
		myattrib_RGB_ENABLE.setData("1");	
	}
	else
	{
		myattrib_RGB_ENABLE.setData("0");
	}
}


myattrib_RGB_ENABLE.onDataChanged()
{
	if(getData()=="0")
	{
		//default RGB OFF
		toggleRGB_bg.setAlpha(255);
		toggleRGB_lcd.setAlpha(255);
		toggleRGB_rimlights.setAlpha(255);
		toggleRGB_leftbar.setAlpha(255);
		toggleRGB_rightbar.setAlpha(255);
		toggleRGB_cbuttons.setAlpha(255);
		cbEnableRGB.setChecked(0);
		plright.setAlpha(255);
		plrightRGBBlue.setAlpha(0);
		plrightRGBGreen.setAlpha(0);
		plrightRGBRed.setAlpha(0);
		
		plleft.setAlpha(255);
		plleftRGBBlue.setAlpha(0);
		plleftRGBGreen.setAlpha(0);
		plleftRGBRed.setAlpha(0);
		
		vidright.setAlpha(255);
		vidrightRGBBlue.setAlpha(0);
		vidrightRGBGreen.setAlpha(0);
		vidrightRGBRed.setAlpha(0);
		
		vidleft.setAlpha(255);
		vidleftRGBBlue.setAlpha(0);
		vidleftRGBGreen.setAlpha(0);
		vidleftRGBRed.setAlpha(0);
		
		visright.setAlpha(255);
		visrightRGBBlue.setAlpha(0);
		visrightRGBGreen.setAlpha(0);
		visrightRGBRed.setAlpha(0);
		
		visleft.setAlpha(255);
		visleftRGBBlue.setAlpha(0);
		visleftRGBGreen.setAlpha(0);
		visleftRGBRed.setAlpha(0);
		
		visrnd.setAlpha(255);
		visrndRGBBlue.setAlpha(0);
		visrndRGBGreen.setAlpha(0);
		visrndRGBRed.setAlpha(0);
	
	}
	else
	{
		//turn RGB on
		toggleRGB_bg.setAlpha(0);
		toggleRGB_lcd.setAlpha(0);
		toggleRGB_rimlights.setAlpha(0);
		toggleRGB_leftbar.setAlpha(0);
		toggleRGB_rightbar.setAlpha(0);
		toggleRGB_cbuttons.setAlpha(0);
		cbEnableRGB.setChecked(1);
		plright.setAlpha(0);
		plrightRGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
		plrightRGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
		plrightRGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
		
		plleft.setAlpha(0);
		plleftRGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
		plleftRGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
		plleftRGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));

		vidright.setAlpha(0);
		vidrightRGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
		vidrightRGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
		vidrightRGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
		
		vidleft.setAlpha(0);
		vidleftRGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
		vidleftRGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
		vidleftRGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
	
		visright.setAlpha(0);
		visrightRGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
		visrightRGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
		visrightRGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
		
		visleft.setAlpha(0);
		visleftRGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
		visleftRGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
		visleftRGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
		
		visrnd.setAlpha(0);
		visrndRGBBlue.setAlpha(stringtointeger(myattrib_RGB_BLUEColor.getData()));
		visrndRGBGreen.setAlpha(stringtointeger(myattrib_RGB_GREENColor.getData()));
		visrndRGBRed.setAlpha(stringtointeger(myattrib_RGB_REDColor.getData()));
		
	}
}	




//reduce mem, only use as necessary
cclay.onSetVisible(Boolean on)
{
	if(on)
	{		

		mapred = new map;
		mapred.loadMap("color.map.red");

		mapgreen = new map;
		mapgreen.loadMap("color.map.green");

		mapblue = new map;
		mapblue.loadMap("color.map.blue");	
	}
	else
	{
		if (mapred != NULL)
		{
			delete mapred;
		}
		if (mapgreen != NULL)
		{
			delete mapgreen;
		}
		if (mapblue != NULL)
		{
			delete mapblue;
		}
	
	}
	
}


colorpalette.onLeftButtonDown(int x, int y) {
  colormousedown = 1;
}

colorpalette.onLeftButtonUp(int x, int y) {
  colormousedown = 0;
}

colorpalette.onMouseMove(int x, int y)
{
	if (!colormousedown) return;

	int rx = x - getLeft();
	int ry = y - getTop();

	if ((rx<0) || (ry<0)) return;
	if ( (rx > getWidth()) || (ry > getHeight())) return;

	redslider.setPosition(mapred.getValue(rx, ry));
	greenslider.setPosition(mapgreen.getValue(rx, ry));
	blueslider.setPosition(mapblue.getValue(rx, ry));
}

//debug(integertostring(newpos));

redslider.onSetPosition(int newpos)
{

	if(myattrib_RGB_ENABLE.getData()=="1")
	{
		//handled in stdframe
		//cclaycomptitle_dummy.setXMLParam("color",integerToString(iRed)+","+integerToString(iGreen)+","+integerToString(iBlue));
		//layplcomptitle_dummy.setXMLParam("color",integerToString(iRed)+","+integerToString(iGreen)+","+integerToString(iBlue));
		
		//BGRed.setAlpha(newpos);
		MainLCDRed.setAlpha(newpos);
		MainBlackSurroundRed.setAlpha(newpos);
		MainLCDBottomLeftRed.setAlpha(newpos);
		MainLCDBottomRightRed.setAlpha(newpos);
		MainBGTopLightRed.setAlpha(newpos);
		MainCButtonRed.setAlpha(newpos);
		
		//stdfrm
		myattrib_RGB_REDColor.setData(integertostring(newpos));
		
		//compwindows
		plrightRGBRed.setAlpha(newpos);
		plleftRGBRed.setAlpha(newpos);

		vidrightRGBRed.setAlpha(newpos);
		vidleftRGBRed.setAlpha(newpos);
		
		visrightRGBRed.setAlpha(newpos);
		visleftRGBRed.setAlpha(newpos);	
		visrndRGBRed.setAlpha(newpos);	
		
		setPrivateInt(getSkinName(),"redlcd", newpos);
		trv.setText(integertostring(newpos));
		setPrivateInt(getSkinName(),"red", newpos);
	
	}
}

greenslider.onSetPosition(int newpos) 
{

	if(myattrib_RGB_ENABLE.getData()=="1")
	{
		//handled in stdframe
		//cclaycomptitle_dummy.setXMLParam("color",integerToString(iRed)+","+integerToString(iGreen)+","+integerToString(iBlue));
		//layplcomptitle_dummy.setXMLParam("color",integerToString(iRed)+","+integerToString(iGreen)+","+integerToString(iBlue));
		
		//BGGreen.setAlpha(newpos);
		MainLCDGreen.setAlpha(newpos);
		MainBlackSurroundGreen.setAlpha(newpos);
		MainLCDBottomLeftGreen.setAlpha(newpos);
		MainLCDBottomRightGreen.setAlpha(newpos);
		MainBGTopLightGreen.setAlpha(newpos);
		MainCButtonGreen.setAlpha(newpos);

		//stdfrm
		myattrib_RGB_GREENColor.setData(integertostring(newpos));
		
		//compwindows
		plrightRGBGreen.setAlpha(newpos);
		plleftRGBGreen.setAlpha(newpos);

		vidrightRGBGreen.setAlpha(newpos);
		vidleftRGBGreen.setAlpha(newpos);

		visrightRGBGreen.setAlpha(newpos);
		visleftRGBGreen.setAlpha(newpos);
		visrndRGBGreen.setAlpha(newpos);
		
		setPrivateInt(getSkinName(),"greenlcd", newpos);	
		tgv.setText(integertostring(newpos));	
		setPrivateInt(getSkinName(),"green", newpos);
		
		
	}
}

blueslider.onSetPosition(int newpos) 
{

	if(myattrib_RGB_ENABLE.getData()=="1")
	{
		//handled in stdframe
		//cclaycomptitle_dummy.setXMLParam("color",integerToString(iRed)+","+integerToString(iGreen)+","+integerToString(iBlue));
		//layplcomptitle_dummy.setXMLParam("color",integerToString(iRed)+","+integerToString(iGreen)+","+integerToString(iBlue));
			
		//BGBlue.setAlpha(newpos);
		MainLCDBlue.setAlpha(newpos);
		MainBlackSurroundBlue.setAlpha(newpos);
		MainLCDBottomLeftBlue.setAlpha(newpos);
		MainLCDBottomRightBlue.setAlpha(newpos);
		MainBGTopLightBlue.setAlpha(newpos);
		MainCButtonBlue.setAlpha(newpos);
		
		//stdfrm
		myattrib_RGB_BLUEColor.setData(integertostring(newpos));
		
		//compwindows
		plrightRGBBlue.setAlpha(newpos);
		plleftRGBBlue.setAlpha(newpos);
		
		vidrightRGBBlue.setAlpha(newpos);
		vidleftRGBBlue.setAlpha(newpos);
		
		visrightRGBBlue.setAlpha(newpos);
		visleftRGBBlue.setAlpha(newpos);
		visrndRGBBlue.setAlpha(newpos);
		
		setPrivateInt(getSkinName(),"bluelcd", newpos);
		tbv.setText(integertostring(newpos));
		setPrivateInt(getSkinName(),"blue", newpos);
		
	}
}