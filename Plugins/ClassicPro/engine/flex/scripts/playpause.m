/**
 * playpause.m
 *
 * Handles a combined play/pause button
 *
 * @package	com.skinconsortium.cpro.flex
 * @author	mpdeimos
 * @date	18/10/01
 */

#include <lib/std.mi>
#include <lib/../../../sandbox2/ClassicProFlex/ClassicPro.mi>

Global GuiObject pause, play;
Global boolean usePlayPause;

System.onScriptLoaded ()
{
	pause = getScriptGroup().findObject("cbutton.pause");
	play = getScriptGroup().findObject("cbutton.play");

	usePlayPause = 0;

	if (getScriptGroup().getParentLayout().getID() == "normal")
	{
		usePlayPause = ClassicPro.appearance_normal_usePlayPauseButton(); 
	}
	else
	{
		usePlayPause = ClassicPro.appearance_shade_usePlayPauseButton();
	}

	if (!usePlayPause)
		return;

	if (getStatus() == STATUS_PLAYING)
	{
		pause.show();
		play.hide();
	}
	else
	{
		pause.hide();
		play.show();
	}
}

System.onPlay ()
{
	if (!usePlayPause)
		return;

	pause.show();
	play.hide();	
}

System.onResume ()
{
	if (!usePlayPause)
		return;

	pause.show();
	play.hide();	
}

System.onPause ()
{
	if (!usePlayPause)
		return;

	pause.hide();
	play.show();	
}

System.onStop ()
{
	if (!usePlayPause)
		return;

	pause.hide();
	play.show();	
}

