/**
 * simple fade in script
 *
 * @author Martin Poehlmann <mpdeimos>
 * @data 2009/10/26
 */

#include <lib/std.mi>

// GuiObject that should be faded
Global GuiObject fader;

// Containing GuiObject in which the fader sits 
Global GuiObject parent;

// amount of milliseconds the fade should take
Global float ms;

System.onScriptLoaded ()
{
	parent = getScriptGroup();

	fader = getScriptGroup().findObject(getToken(getParam(), ";", 0));
	if(fader == null) fader = parent;

	ms = stringToFloat(getToken(getParam(), ";", 1));

	if (parent.isVisible())
	{
		parent.onSetVisible(true);
	}
	
}

parent.onSetVisible(boolean onoff)
{
	if (onoff)
	{
		fader.setAlpha(0);
		fader.setTargetA(255);
		fader.setTargetSpeed(ms);
		fader.gotoTarget();
	}
	
}
