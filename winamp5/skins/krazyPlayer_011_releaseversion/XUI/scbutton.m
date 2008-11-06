/*
Made by: Rohan Prabhu for the Skin 'minus' from Skin Consortium
©Rohan Prabhu | ©Skin Consortium
Intellectual rights ownership under the 'Skin Consortium Contributive Copyright'
To view the Skin Consortium Contributive Copyright license, visit:
  www.skinconsortium.com/license/contribute.php

After so many years, finally a working hoverButton XUI... Yippeee!!!
SLoB - it doesnt work properly for play2pause/stop2pause tho, workaround a hack
SLoB - added playtopause & stoptopause quick hack
SLoB modified for ShieldAmp

TEM - Play/Pause support commented out for Krazyplayer
SLoB - Added RGB Glow support, fucking hell man I rock ;) lol
*/

#include <lib/std.mi>
#include "../Scripts/attribs.m"
#define STATUS_PAUSE -1
#define STATUS_PLAY 1
#define STATUS_STOP 0

#define HovRGBDefaultRED 7
#define HovRGBDefaultGREEN 106
#define HovRGBDefaultBLUE 218

Global guiobject mainButton, btnplay;
Global layer backgroundlayer, shadowlayer, hoverLayer, downLayer, iconlayer;
Global int PlayStatus;
Global String sPlay, sPause;
Global group grp;

Global layer hoverLayerRGBRed, hoverLayerRGBGreen, hoverLayerRGBBlue;
Global int iGetRGBRed, iGetRGBGreen, iGetRGBBlue;

//#define DEBUG

#ifdef DEBUG
Function debug(String debugStr);
debug(String debugStr) {
	system.debugstring(debugStr,0);
}
#endif


System.onScriptLoaded() 
{
	initattribs();//for rgb
	
	grp = getScriptGroup();
		
	backgroundlayer 	= grp.findObject("background.button");
	shadowlayer 		= grp.findObject("shadow.button");
	mainButton 			= grp.findObject("normal.button");
	hoverLayer 			= grp.findObject("hover.button");
	hoverLayerRGBRed = grp.findObject("hover.button.RGB.Red");
	hoverLayerRGBGreen = grp.findObject("hover.button.RGB.Green");
	hoverLayerRGBBlue = grp.findObject("hover.button.RGB.Blue");	
	downLayer 			= grp.findObject("down.button");	
	iconlayer			= grp.findObject("icon.button");	
	btnplay				= grp.findObject("play");	
	
	hoverLayer.setAlpha(0);
	downLayer.setAlpha(0);
	
	hoverLayerRGBBlue.setAlpha(0);
	hoverLayerRGBGreen.setAlpha(0);
	hoverLayerRGBRed.setAlpha(0);
	
	
	iGetRGBRed = HovRGBDefaultRED;
	iGetRGBGreen = HovRGBDefaultGREEN;
	iGetRGBBlue = HovRGBDefaultBLUE;

}

System.onScriptUnloading() {
	mainButton = NULL;
	grp = NULL;
}

System.onSetXuiParam(string param, string value) 
{
	param = system.strlower(param);
 
	if(param == "bgimage") 
	{
		backgroundlayer.setXMLParam("image", value);
	}
	
	if(param == "shimage") 
	{
		shadowlayer.setXMLParam("image", value);
	}
	
	if(param == "noimage") 
	{
		mainButton.setXMLParam("image", value);
	}

	if(param == "hoimage") 
	{
		hoverLayer.setXMLParam("image", value);
	}
	
	if(param == "horgbblueimage")
	{
		hoverLayerRGBBlue.setXMLParam("image", value);		
	}
	if(param == "horgbgreenimage")
	{
		hoverLayerRGBGreen.setXMLParam("image", value);		
	}
	if(param == "horgbredimage")
	{
		hoverLayerRGBRed.setXMLParam("image", value);		
	}

	if(param == "doimage") 
	{
		downLayer.setXMLParam("image", value);
	}
	
	if(param == "icimage") 
	{
		iconlayer.setXMLParam("image", value);
	}

	if(param == "action") 
	{
		mainButton.setXMLParam("action", value);
	}

	if(param == "tooltip") 
	{
		mainButton.setXMLParam("tooltip", value);
	}

	if(param == "param") 
	{
		mainButton.setXMLParam("param", value);
	}

}

mainButton.onEnterArea() 
{
	/* Play Pause support - Disabled by TEM for KrazyPlayer - remove this to re-enable

	//catch if we've stopped and play button doesnt show
	string se = mainButton.getXMLParam("action");
	PlayStatus = System.getStatus();
	
	if(strlower(se)=="pause")
	{
		if(PlayStatus == STATUS_STOP || PlayStatus == STATUS_PAUSE)
		{
			mainButton.setXMLParam("action", "PLAY");
			mainButton.setXMLParam("tooltip", "Play");
			iconlayer.setXMLParam("image", "player.main.button.play");
		}
	}
	
	if(strlower(se)=="play")
	{			
		if(PlayStatus == STATUS_PLAY)
		{
			mainButton.setXMLParam("action", "PAUSE");
			mainButton.setXMLParam("tooltip", "Pause");
			iconlayer.setXMLParam("image", "player.main.button.pause");
		}
	}
	End of Play Pause support - See above comment */
	
	hoverLayer.setTargetA(255);
	hoverLayer.setTargetSpeed(0.3);
	hoverLayer.gotoTarget();


	//SLoB - this will do for the now until have time to implement proper rgb support into xui objects
	if(myattrib_RGB_ENABLE.getData()=="0")
	{
		iGetRGBRed = HovRGBDefaultRED;
		iGetRGBGreen = HovRGBDefaultGREEN;
		iGetRGBBlue = HovRGBDefaultBLUE;
	}
	else
	{
		iGetRGBRed = stringtointeger(myattrib_RGB_REDColor.getData());
		iGetRGBGreen = stringtointeger(myattrib_RGB_GREENColor.getData());
		iGetRGBBlue = stringtointeger(myattrib_RGB_BLUEColor.getData());
	
	}
	
	hoverLayerRGBBlue.setTargetA(iGetRGBBlue);
	hoverLayerRGBBlue.setTargetSpeed(0.3);
	hoverLayerRGBBlue.gotoTarget();
	hoverLayerRGBGreen.setTargetA(iGetRGBGreen);
	hoverLayerRGBGreen.setTargetSpeed(0.3);
	hoverLayerRGBGreen.gotoTarget();
	hoverLayerRGBRed.setTargetA(iGetRGBRed);
	hoverLayerRGBRed.setTargetSpeed(0.3);
	hoverLayerRGBRed.gotoTarget();
	
	complete;
	
	
}

mainButton.onLeaveArea() 
{
	hoverLayer.setTargetA(0);
	hoverLayer.setTargetSpeed(0.3);
	hoverLayer.gotoTarget();
	
	hoverLayerRGBBlue.setTargetA(0);
	hoverLayerRGBBlue.setTargetSpeed(0.3);
	hoverLayerRGBBlue.gotoTarget();
	hoverLayerRGBGreen.setTargetA(0);
	hoverLayerRGBGreen.setTargetSpeed(0.3);
	hoverLayerRGBGreen.gotoTarget();
	hoverLayerRGBRed.setTargetA(0);
	hoverLayerRGBRed.setTargetSpeed(0.3);
	hoverLayerRGBRed.gotoTarget();
		
	complete;
}

mainButton.onLeftButtonDown(int x, int y) 
{
	downLayer.setAlpha(255);
	complete;
}

mainButton.onLeftButtonUp(int x, int y) 
{
	downLayer.setAlpha(0);

	/* Play Pause support - Disabled by TEM for KrazyPlayer - remove this to re-enable
	string su = mainButton.getXMLParam("action");

	if(strlower(su)=="stop")
	{
		btnplay.setXMLParam("action", "PLAY");
		btnplay.setXMLParam("tooltip", "Play");
		btnplay.setXMLParam("icImage", "player.main.button.play");
	}

	if(strlower(su)=="pause")
	{
		mainButton.setXMLParam("action", "PLAY");
		mainButton.setXMLParam("tooltip", "Play");
		iconlayer.setXMLParam("image", "player.main.button.play");
	}
		
	if(strlower(su)=="play")
	{			
		//if(PlayStatus == STATUS_PLAY)
		//{
			mainButton.setXMLParam("action", "PAUSE");
			mainButton.setXMLParam("tooltip", "Pause");
			iconlayer.setXMLParam("image", "player.main.button.pause");
		//}
	}
	End of Play Pause support - See above comment */

	complete;
}
