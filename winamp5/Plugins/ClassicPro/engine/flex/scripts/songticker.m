/**
 * songticker.m
 *
 * handles songticker stuff
 *
 * @author mpdeimos
 * @date 2008/10/25
 * @param songtickerID;sysinfoID
 */

#include <lib/std.mi>
#define DISPATCH
#include dispatch_codes.m

Global Text sysinfo;
Global GuiObject songticker;
Global Timer infoTimer;

System.onScriptLoaded ()
{
	initDispatcher();

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


int onMessage(int msg, int i0, int i1, int i2, String s0, String s1, GuiObject obj)
{
	if (msg == SHOW_SYSINFO)
	{
		infoTimer.stop();
		sysinfo.setText(s0);
		songticker.hide();
		sysinfo.show();
		infoTimer.start();

		return SUCCESS;
	}
}

infoTimer.onTimer ()
{
	songticker.show();
	sysinfo.hide();	
}


