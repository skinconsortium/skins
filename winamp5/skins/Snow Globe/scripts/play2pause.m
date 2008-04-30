#include <lib/std.mi>

Global Button play, pause;

System.onScriptLoaded ()
{
	play = getScriptGroup().findObject("Play");
	pause = getScriptGroup().findObject("Pause");

	if (getStatus() != 1)
	{
		play.show();
		pause.hide();
	}
	
}

System.onPlay ()
{
	play.hide();
	pause.show();
}

System.onPause ()
{
	play.show();
	pause.hide();	
}

System.onStop ()
{
	play.show();
	pause.hide();
}

System.onResume ()
{
	play.hide();
	pause.show();
}




