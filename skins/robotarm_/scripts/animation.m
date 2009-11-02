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
Global Group display;

System.onScriptLoaded ()
{
	robotArm = getScriptGroup().findObject("animationlayer");
	animButton = getScriptGroup().findObject("animationbutton");
	display =  getScriptGroup().findObject("robotarm.display");
	normal = getScriptGroup().getParentLayout();
	reflection =  getScriptGroup().findObject("reflection");
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
		toggleArm();
	}
	
}