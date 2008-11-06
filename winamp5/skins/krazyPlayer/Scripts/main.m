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
//Global Text songTicker;
Global Timer beatVis, tmrPulseVuGlowOn, RimLightVis;
Global GuiObject SongTickerR;
Global BeatLayer beatR, beatL;
Global Boolean enableVis;
Global int lvu, rvu, iGlow;
Global int lastBeatLeft, lastBeatRight, lastBeatLights;
Global int DarkToLight,	iOffBeat, checkiDarkLight;
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
	tmrPulseVuGlowOn.setDelay(800); //matches flash version
	
	RimLightVis = new Timer;
	RimLightVis.setDelay(30);
	
	checkiDarkLight = getPrivateInt(getSkinName(), "darklight", 0);
	
	//System.messageBox("1=" + integertostring(checkiDarkLight), "Debug Error", 0, "");
	
	if(checkiDarkLight==0)
	{	
		DarkToLight = 0;		
	}
	else
	{		
		DarkToLight = 1;		
	}
	
	
	//check if need to pulse on startup
	//taken out stop as we want it to pulse either stopped or paused  && system.getstatus()!=STATUS_STOPPED
	if(system.getstatus()!=STATUS_PLAYING)
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
		
		//System.messageBox("2=" + integertostring(checkiDarkLight), "Debug Error", 0, "");
		
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
	RimLightVis.stop();
	delete RimLightVis;
	tmrPulseVuGlowOn.stop();
	delete tmrPulseVuGlowOn;
	beatVis.stop();
	delete beatVis;
}


mainGrp.onSetVisible(Boolean on)
{
	if(on)
	{	
		checkiDarkLight = getPrivateInt(getSkinName(), "darklight", 0);
		if(checkiDarkLight==0)
		{	
			DarkToLight = 0;		
		}
		else
		{		
			DarkToLight = 1;		
		}
	}
	//System.messageBox("3="+integertostring(checkiDarkLight), "Debug Error", 0, "");
}


fade (GuiObject o, float speed, int val)
{
	o.cancelTarget();
	o.setTargetA(val);
	o.gotoTarget();
}

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
	tmrPulseVuGlowOn.start();
	//we want to show back to full default
	//fade(beatL, 0.5, 0);
	//fade(beatR, 0.5, 0);
	
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

beatVis.onTimer ()
{	

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
	//light to dark - image is dark so we are just using vals from calc
	if(DarkToLight == 1)
	{	
		beatL.setAlpha(frameLeft);
		beatR.setAlpha(frameRight);
	}
	else
	{//darktolight - image is dark and we are reducing its opacity so it brightens
		beatL.setAlpha(255-frameLeft);
		beatR.setAlpha(255-frameRight);	
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
		DarkToLight = 0;
		setPrivateInt(getSkinName(), "darklight", 0);
	}
	else
	{		
		DarkToLight = 1;
		setPrivateInt(getSkinName(), "darklight", 1);
	}
	//System.messageBox("5a="+integertostring(DarkToLight), "Debug Error", 0, "");
}
	
vis_enabled_attrib.onDataChanged()
{
	if(getData()=="1")
	{	
		//System.messageBox("5b="+integertostring(DarkToLight), "Debug Error", 0, "");
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


