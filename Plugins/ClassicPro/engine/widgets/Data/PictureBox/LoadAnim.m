/**
 * LoadAnim
 *
 * @author mpdeimos
 * @date 09/04/18
 */

#include <lib/std.mi>

Function Fade(GuiObject obj, int alpha, float speed);

Global Group scriptGroup;
Class GuiObject GlowObject;
Global GlowObject img0, img1, img2, img3;
Global boolean keepRunning;

System.onScriptLoaded ()
{
	scriptGroup	= getScriptGroup();
	img0		= scriptGroup.getObject("0");
	img1		= scriptGroup.getObject("1");
	img2		= scriptGroup.getObject("2");
	img3		= scriptGroup.getObject("3");

	keepRunning = true;

	Fade(img0, 96, 0.3);
}
/*
System.onSetXuiParam (String param, String value)
{
	if (strlower(param) == "selected")
	{
		if (value != "" && value != "0")
		{
			rectSelected.show();
		}
		else
		{
			rectSelected.hide();
		}
	}
	
	image.setXmlParam(param, value);
	mousetrap.setXmlParam("tooltip", scriptGroup.getXmlParam("tooltip"));
}
*/

GlowObject.onTargetReached ()
{
	if (keepRunning && GlowObject.getAlpha() > 0)
	{
		Fade(GlowObject, 0, 0.3);
		GlowObject next = img0;
		if (GlowObject == img0)
		{
			next = img1;
		}
		else if (GlowObject == img1)
		{
			next = img2;
		}	
		else if (GlowObject == img2)
		{
			next = img3;
		}
		Fade(next, 96, 0.3);
	}
}


Fade(GuiObject obj, int alpha, float speed)
{
	obj.canceltarget();
	obj.setTargetA(alpha);
	obj.setTargetSpeed(speed);
	obj.gotoTarget();
}