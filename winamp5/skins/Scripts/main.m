/* 	main.m by TEM 2007
	Main script controlling KrazyPlayer

	extended by martin.deimos by this features
	-winamp5.5 songticker
	-beatvis
	changed/extended by SLoB to use attrib and simplify vis for a more direct value/response
	
	01/03/2008
	SLoB - OK I think this is almost close as its going to get atm, this is what I would roughly aim for with the vis - remember the images also play a part of below too
	Please dont change anything in here unless its adding something such as the new buttons for pl etc..
	I've spent a good deal of time getting it just so, we can tweak stuff later
*/

#include <lib/std.mi>
#include "attribs.m"
#define sensitivity 1.4
#define AlphaVal 220

Function fade (GuiObject o, float speed, int val);

Class Layer BeatLayer;

Global Group mainGrp;
Global Text songTicker;
Global Timer beatVis, tmrPulseVuGlowOn, RimLightVis;
Global GuiObject SongTickerR;
Global BeatLayer beatR, beatL;
Global Boolean enableVis;
Global int lvu, rvu, iGlow;
Global int lastBeatLeft, lastBeatRight, lastBeatLights;
Global int DarkToLight,	LightToDark, iDarkLight, iOffBeat ;
Global layer beatrimlights;

System.onScriptLoaded()
{

	initAttribs();

	mainGrp = getScriptGroup();

	//songTicker = mainGrp.findObject("dbg");
	
	beatR = mainGrp.findObject("drawer_right").findObject("m_lcd_right");
	beatL = mainGrp.findObject("drawer_left").findObject("m_lcd_left");
		
	beatrimlights = mainGrp.findObject("drawer_left").findObject("m_blacksurround_rimlights_glow");
		
	enableVis = (getPrivateInt(getSkinName(), "beatVis", 1) == 1);
	iGlow = 1;
	iOffBeat = 0;
	
	beatVis = new Timer;
	beatVis.setDelay(30);
	
	tmrPulseVuGlowOn = new Timer;
	tmrPulseVuGlowOn.setDelay(800);
	
	RimLightVis = new Timer;
	RimLightVis.setDelay(30);
	
	iDarkLight = (getPrivateInt(getSkinName(), "darklight", 0) == 0);
	
	if(iDarkLight==0)
	{	
		DarkToLight = 1;
		LightToDark = 0;		
	}
	else
	{		
		DarkToLight = 0;
		LightToDark = 1;		
	}
	
	
	//check if need to pulse on startup
	if(system.getstatus()!=STATUS_PLAYING && system.getstatus()!=STATUS_STOPPED)
	{
		beatVis.stop(); //need to turn off beatvis so it does not interfere with pulse
		RimLightVis.stop();
		tmrPulseVuGlowOn.start();
	}
	else
	{
		tmrPulseVuGlowOn.stop();
	}
	
	if(vis_enabled_attrib.getData()=="1" && system.getstatus()==STATUS_PLAYING)
	{	
		if(enableVis==1)
		{
			beatVis.start();
			RimLightVis.start();
		}
		tmrPulseVuGlowOn.stop();
	}
	else
	{
		beatVis.stop();
		RimLightVis.stop();
		beatL.setAlpha(0);
		beatR.setAlpha(0);
		
	}
	
}

System.onScriptUnloading()
{
//	Martin> This is a bad idea - the values are saved correctly on change, and here we've inroduced some bug
//	setPrivateInt(getSkinName(), "beatVis", stringtointeger(vis_enabled_attrib.getData()));
//	setPrivateInt(getSkinName(), "darklight", iDarkLight);
	RimLightVis.stop();
	delete RimLightVis;
	tmrPulseVuGlowOn.stop();
	delete tmrPulseVuGlowOn;
	beatVis.stop();
	delete beatVis;
}


fade (GuiObject o, float speed, int val)
{
	o.cancelTarget();
	o.setTargetA(val);
	o.gotoTarget();
}


/* pulse vis on pause not stop 
This is same as flash version now
*/
tmrPulseVuGlowOn.onTimer()
{           
	if(iOffBeat==1)
	{
		iOffBeat = 0;
		fade(beatL, 0.8, AlphaVal);
		fade(beatR, 0.8, AlphaVal);
	}
	else
	{
		iOffBeat = 1;
		fade(beatL, 0.8, 0);
		fade(beatR, 0.8, 0);
	}
	return;
}



/** Vis */

System.onPlay ()
{
	
	if (!RimLightVis.isRunning() && enableVis) RimLightVis.start();
	if (!beatVis.isRunning() && enableVis) beatVis.start();
	if (tmrPulseVuGlowOn.isRunning()) tmrPulseVuGlowOn.stop();
}
System.onResume ()
{
	if (!RimLightVis.isRunning() && enableVis) RimLightVis.start();
	if (!beatVis.isRunning() && enableVis) beatVis.start();
	if (tmrPulseVuGlowOn.isRunning()) tmrPulseVuGlowOn.stop();
}
//kick off pulse
System.onPause()
{
	RimLightVis.stop();
	beatVis.stop(); //need to turn off beatvis so it does not interfere with pulse
	tmrPulseVuGlowOn.start();
}
System.onStop()
{
	RimLightVis.stop();
	beatVis.stop(); //need to turn off beatvis so it does not interfere with pulse
	tmrPulseVuGlowOn.stop();
	//we want to show back to full default
	fade(beatL, 0.5, 0);
	fade(beatR, 0.5, 0);
	
}

//rim lights, use similar logic to below
RimLightVis.onTimer()
{
	int beatLights = ((System.getLeftVuMeter()+System.getRightVuMeter())/2)*sensitivity;
	
	if(beatLights > 255) beatLights = 255;
	
	int framebeatLights = beatLights;
	
	if (framebeatLights < lastBeatLights)
	{
		framebeatLights = lastBeatLights-25.5;
		if (framebeatLights < 0) framebeatLights = 0;
	}

	beatrimlights.setAlpha(framebeatLights);
}

//the simpler, the quicker, the better
//brighter the lower the vu, more colour the higher the vu, *1.5 as 1 just aint enuff, we need to get max colour in there for response
//songTicker.setText(integertostring(lvu));
	/*
	SLoB - more direct approach for quicker, better response
	lvu = System.getLeftVuMeter()*sensitivity;
	rvu = System.getRightVuMeter()*sensitivity;
	if(lvu > 255) lvu = 255;
	if(rvu > 255) rvu = 255;
	
	beatL.setAlpha(255-lvu);
	beatR.setAlpha(255-rvu);*/
	
beatVis.onTimer ()
{	
	//reverted back to old version minus the suppression - need to still use as much of the spectrum as possible
	int beatLeft= System.getLeftVuMeter()*sensitivity;
	int beatRight= System.getRightVuMeter()*sensitivity;
	if(beatRight > 255) beatRight =255;
	if(beatLeft > 255) beatLeft =255;

	int frameLeft=beatLeft;
	int frameRight=beatRight;

	if (frameLeft<lastBeatLeft)
	{
		frameLeft=lastBeatLeft-25.5;
		if (frameLeft<0) frameLeft=0;
	}

	if (frameRight<lastBeatRight)
	{
		frameRight=lastBeatRight-25.5;
		if (frameRight<0) frameRight=0;
	}

	//switch darktolight lighttodark logic
	if(DarkToLight == 1)
	{
		beatL.setAlpha(255-frameLeft);
		beatR.setAlpha(255-frameRight);
	}
	
	if(LightToDark == 1)
	{
		beatL.setAlpha(frameLeft);
		beatR.setAlpha(frameRight);
	}
	
	
	//debug output
	//songTicker.setText(integertostring(frameRight));
	lastBeatLeft=frameLeft;
	lastBeatRight=frameRight;
	
	return;
}

BeatLayer.onRightButtonDown (int x, int y)
{
	PopupMenu p = new popupMenu;
	p.addCommand("KrazyPlayer - Beat Glow Viz", -1, 0, 1);
	p.addSeparator();
	p.addcommand("Enable Visualization", 1, vis_enabled_attrib.getData() == "1", 0);
	p.addcommand("VU - Dark to Light", 2, vis_mode_style_attrib.getData() == "0", 0);
	p.addcommand("VU - Light to Dark", 3, vis_mode_style_attrib.getData() == "1", 0);

	int ipopVUVal = integer(p.popatmouse());
	
	if (ipopVUVal < 1)
	{
		return;
	}
	if (ipopVUVal == 1)
	{	
		if (vis_enabled_attrib.getData() == "1") vis_enabled_attrib.setData("0");
		else vis_enabled_attrib.setData("1");
		
	}
	else if (ipopVUVal == 2)
	{
		vis_mode_style_attrib.setData("0");
		
	}
	else if (ipopVUVal == 3)
	{
		vis_mode_style_attrib.setData("1");
	}
	return;
}

BeatLayer.onRightButtonUp (int x, int y)
{
	complete;
}


vis_mode_style_attrib.onDataChanged()
{
	if(getData()=="0")
	{	
		DarkToLight = 1;
		LightToDark = 0;
		setPrivateInt(getSkinName(), "darklight", 0);
	}
	else
	{		
		DarkToLight = 0;
		LightToDark = 1;
		setPrivateInt(getSkinName(), "darklight", 1);
	}
}
	
vis_enabled_attrib.onDataChanged()
{
	if(getData()=="1")
	{	
		beatVis.start();
		RimLightVis.start();
		enableVis = true;
	}
	else
	{
		beatVis.stop();
		RimLightVis.stop();
		enableVis = false;
		beatL.setAlpha(0);
		beatR.setAlpha(0);
	}
	setPrivateInt(getSkinName(), "beatVis", stringtointeger(vis_enabled_attrib.getData()));
}


