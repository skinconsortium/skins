/**
 * ipc.m
 *
 * handles inter program calls
 *
 * @param songtickerID;sysinfoID
 */

#include <lib/std.mi>

Global Text sysinfo;
Global GuiObject songticker;
Global Layout parent;
Global Timer infoTimer;

System.onScriptLoaded ()
{
	parent = getScriptGroup().getParentLayout();

	songticker = getScriptGroup().findObject(getToken(getParam(), ";", 0));
	sysinfo = getScriptGroup().findObject(getToken(getParam(), ";", 1));

	infoTimer = new Timer;
	infoTimer.setDelay(666);
}

System.onScriptUnloading ()
{
	infoTimer.stop();
	delete infoTimer;
}


parent.onAction (String action, String param, Int x, int y, int p1, int p2, GuiObject source)
{
	if (action == "sysinfo")
	{
		infoTimer.stop();
		sysinfo.setText(param);
		songticker.hide();
		sysinfo.show();
		infoTimer.start();
	}
}

infoTimer.onTimer ()
{
	songticker.show();
	sysinfo.hide();	
}


