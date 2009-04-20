/**
 * PictureBoxSelector
 *
 * @author mpdeimos
 * @date 09/04/17
 */

#include <lib/std.mi>
#include <lib/colormgr.mi>

#include dispatch_codes.m

Global Group scriptGroup;
Global GuiObject image;
Global GuiObject rectSelected, rectHover, gradientSelected;
Global Layer mousetrap;
Global boolean triggerFadeOut;

System.onScriptLoaded ()
{
	scriptGroup	= getScriptGroup();
	image		= scriptGroup.getObject("image");
	rectSelected	= scriptGroup.getObject("rect.selected");
	rectHover	= scriptGroup.getObject("rect.hover");
	mousetrap	= scriptGroup.getObject("mousetrap");

	gradientSelected = scriptGroup.findObject("gradient.selected");

	// Init Gradient Colors.
	Color c = ColorMgr.getColor("wasabi.list.text.selected.background");
	String rgb = integerToString(c.getRed()) + "," + integerToString(c.getGreen()) + "," + integerToString(c.getBlue());
	gradientSelected.setXmlParam("points", "0.0=" + rgb + ",0;1.0=" + rgb + ",255");

	setDispatcher(scriptGroup.getParent());
}

System.onSetXuiParam (String param, String value)
{
	if (strlower(param) == "selected")
	{
		if (value != "" && value != "0")
		{
			rectSelected.show();
			gradientSelected.show();
		}
		else
		{
			rectSelected.hide();
			gradientSelected.hide();
		}
	}
	
	image.setXmlParam(param, value);
	mousetrap.setXmlParam("tooltip", scriptGroup.getXmlParam("tooltip"));
}

mousetrap.onEnterArea ()
{
	sendMessageO(ON_ENTER_AREA, scriptGroup);
	rectHover.cancelTarget();
	rectHover.setTargetA(255);
	rectHover.setTargetSpeed(0.3);
	rectHover.gotoTarget();
}

mousetrap.onleaveArea ()
{
	sendMessageO(ON_LEAVE_AREA, scriptGroup);

/*	if (rectHover.isGoingToTarget())
	{
		triggerFadeOut = true;
		return;
	}*/
	
	rectHover.cancelTarget();
	rectHover.setTargetA(0);
	rectHover.setTargetSpeed(0.5);
	rectHover.gotoTarget();
}

/*rectHover.onTargetReached ()
{
	if (triggerFadeOut)
	{
		triggerFadeOut = false;
		rectHover.cancelTarget();
		rectHover.setTargetA(0);
		rectHover.setTargetSpeed(0.5);
		rectHover.gotoTarget();
	}
}*/

mousetrap.onLeftButtonUp (int x, int y)
{
	sendMessage(ON_LEFT_BUTTON_UP, x, y, 0, "", "", scriptGroup);

}

mousetrap.onRightButtonUp (int x, int y)
{
	sendMessage(ON_RIGHT_BUTTON_UP, x, y, 0, "", "", scriptGroup);

}
