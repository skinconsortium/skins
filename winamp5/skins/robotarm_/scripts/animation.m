/*---------------------------------------------------
-----------------------------------------------------
Filename:	animation.m
Version:	1.0

Type:		maki
Date:		25. Aug. 2008 - 16:54 
Author:		Martin Poehlmann aka Deimos
E-Mail:		martin@skinconsortium.com
Internet:	www.skinconsortium.com
-----------------------------------------------------
---------------------------------------------------*/

#include <lib/std.mi>

Function fade (GuiObject g, int alpha, float speed);
Function toggleArm ();

Global AnimatedLayer robotArm;
Global Layer reflection;
Global Button animButton;
Global Layout normal;
Global Boolean armIsOut;
Global Group display, nav2;
Global GuiObject rectangle;

System.onScriptLoaded ()
{
	robotArm = getScriptGroup().findObject("animationlayer");
	animButton = getScriptGroup().findObject("animationbutton");
	display =  getScriptGroup().findObject("robotarm.display");
	nav2 =  getScriptGroup().findObject("nav.group");
	normal = getScriptGroup().getParentLayout();
	reflection =  getScriptGroup().findObject("reflection");
	rectangle =  getScriptGroup().findObject("rectangle");
}

normal.onSetVisible (Boolean onoff)
{
	if (onoff)
	{
		toggleArm();
	}
}

animButton.onLeftClick ()
{
	toggleArm();
}

toggleArm ()
{
	if (robotArm.isPlaying())
	{
		int ef = robotArm.getCurFrame();
		
		if(robotArm.getDirection()==1)	robotArm.setEndFrame(0);
		else robotArm.setEndFrame(robotArm.getLength()-1);
		
		robotArm.setStartFrame(ef);
		armIsOut = !armIsOut;
	}

	if (armIsOut && display.isVisible())
	{
		fade (display, 0, 0.5);
		if (System.getPrivateInt("robotarm", "showBackupNav", 0) == 1)
		{
			fade (nav2, 255, 0.5);
			rectangle.setXmlParam("x", "337");
			rectangle.setXmlParam("w", "120");
		}
		return;
	}

	robotarm.play();
}

robotArm.onStop ()
{
	int ef = robotArm.getEndFrame();

	if(robotArm.getDirection()==1)	robotArm.setEndFrame(0);
	else robotArm.setEndFrame(robotArm.getLength()-1);

	robotArm.setStartFrame(ef);
	armIsOut = !armIsOut;

	if (armIsOut)
	{
		reflection.show();
		fade (display, 255, 0.5);
		if (System.getPrivateInt("robotarm", "showBackupNav", 0) == 1) fade (nav2, 0, 0.5);
	}
}

fade (GuiObject g, int alpha, float speed)
{
	g.canceltarget();
	g.show();
	g.setTargetA(alpha);
	g.setTargetSpeed(speed);
	g.gotoTarget();	
}

display.onTargetReached ()
{
	if (display.getAlpha() == 0)
	{
		display.hide();
		reflection.hide();
		if (System.getPrivateInt("robotarm", "showBackupNav", 0) == 1) nav2.show();
		toggleArm();
	}
}

nav2.onTargetReached ()
{
	if (nav2.getAlpha() == 0)
	{
		nav2.hide();
		rectangle.setXmlParam("x", "427");
		rectangle.setXmlParam("w", "30");
	}
}