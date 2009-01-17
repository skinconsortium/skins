/**
 * ClassicProTabButton.m
 *
 * Tab Button handling including moveable tabs
 *
 * @package	com.skinconsortium.cpro.one
 * @author	mpdeimos
 * @date	2008/11/21
 */

#include <lib/std.mi>

#include dispatch_codes.m

Function setButtonState(int mode);

Global ToggleButton trigger;
Global Group parent;
Global GuiObject grid;
Global Text label;
Global boolean wasActive, movingTab, mouseDown;
Global int dx;

System.onScriptLoaded ()
{
	setDispatcher(getScriptGroup().getParent());

	trigger = getScriptGroup().findObject("cpro.tab.button");
	label = getScriptGroup().findObject("cpro.tab.text");
	grid = getScriptGroup().findObject("cpro.tab.grid");
	parent = getScriptGroup();
}

trigger.onLeftButtonDown (int x, int y)
{
	mouseDown=true;
	wasActive = getActivated();
	dx = x;

	sendMessage(ON_LEFT_BUTTON_DOWN, x, x, 0, "", "", parent);
}

trigger.onMouseMove (int x, int y)
{
	if(mouseDown){
		sendMessage(ON_MOUSE_MOVE, x, x, 0, "", "", parent);

		if(!movingTab){
			if (dx > x+4 || dx < x-4){
				movingTab=true;
			}
		}
	}
}

trigger.onLeftButtonUp (int x, int y)
{
	mouseDown=false;
	if (!movingTab)
	{
		setActivated(1);
		if(!wasActive) sendMessageO(ON_TAB_ACTIVATED, parent);
	}
	else
	{
		setActivated(wasActive);
	}
	
	movingTab=false;
	sendMessage(ON_LEFT_BUTTON_UP, x, x, 0, "", "", parent);
}

trigger.onRightButtonUp (int x, int y)
{
	sendMessage(ON_RIGHT_BUTTON_UP, x, clientToScreenX(trigger.getLeft()), clientToScreenY(trigger.getTop()+26), "", "", parent);
}

trigger.onActivate (boolean onOff)
{
	if (onOff)
	{
		setButtonState(1);
	}
	else
	{
		setButtonState(2);
	}
}

trigger.onEnterArea()
{
	if (!trigger.getActivated())
		setButtonState(3);
}

trigger.onLeaveArea()
{
	if (!trigger.getActivated())
		setButtonState(2);
}

setButtonState (int mode)
{
	grid.setXmlParam("topleft", "wasabi.tabsheet.button.left."+integerToString(mode));
	grid.setXmlParam("top", "wasabi.tabsheet.button.center."+integerToString(mode));
	grid.setXmlParam("topright", "wasabi.tabsheet.button.right."+integerToString(mode));
	label.setXmlParam("color", "");

	if (mode == 1)
	{
		label.setXmlParam("y", "6");
		label.setXmlParam("color", "Tab.Text.On");
	}
	else if (mode == 2)
	{
		label.setXmlParam("color", "Tab.Text.Off");
		label.setXmlParam("y", "7");
	}
	else
	{
		label.setXmlParam("y", "7");
		label.setXmlParam("color", "Tab.Text.Hover");
	}
}

label.onTextChanged (String newtxt)
{
	trigger.setXmlParam("tooltip", newtxt);
	sendMessageO(ON_TAB_TEXT_UPDATED, parent);
}
