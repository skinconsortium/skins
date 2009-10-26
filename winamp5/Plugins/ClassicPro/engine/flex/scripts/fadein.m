/**
 * simple fade in script
 *
 * @author Martin Poehlmann <mpdeimos>
 * @data 2009/10/26
 */

#include <lib/std.mi>

Global GuiObject fader;
Global GuiObject parent;
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
