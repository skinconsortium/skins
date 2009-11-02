#include <lib/std.mi>
Function swap (Boolean pausable);
Global Button play, pause;
System.onScriptLoaded ()
{
	play = getScriptGroup().findObject("playctrl.play");
	pause = getScriptGroup().findObject("playctrl.pause");
	if (System.getStatus() == 1)
	{
		swap (true);
	}
	else
	{
		swap (false);
	}
}
System.onPlay ()
{
	swap (true);
}
System.onResume ()
{
	swap (true);
}
System.onPause ()
{
	swap (false);
}
System.onStop ()
{
	swap (false);
}
swap (Boolean pausable)
{
	if (pausable)
	{
		pause.setXmlParam("visible","1");
		play.setXmlParam("visible","0");
	}
	else
	{
		pause.setXmlParam("visible","0");
		play.setXmlParam("visible","1");
	}
}