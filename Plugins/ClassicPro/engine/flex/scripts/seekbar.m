/**
 * seekbar.m
 *
 * Manages custom seek fillbar.
 *
 * @package	com.skinconsortium.cpro.flex
 * @author	mpdeimos
 * @date	08/10/01
 * @param	layerID;mapBitmapID
 */

#include <lib/std.mi>
#include <lib/com/fillbar.m>

Function updateSeek();

Global FillBar seekBar;
Global Timer seekTimer;

System.onScriptLoaded ()
{
	Layer tmp = getScriptGroup().findObject(getToken(getParam(), ",", 0));
	seekBar = FillBar_construct(tmp, getToken(getParam(), ",", 1));
	seekBar.dragable = TRUE;

	seekTimer = new Timer;
	seekTimer.setDelay(1000);

	FillBar_setPosition(seekBar, 0);
	updateSeek();

	if (getStatus() == STATUS_PLAYING)
	{
		seekTimer.start();
	}	
}

System.onScriptUnloading ()
{
	 FillBar_destruct(seekBar);
	 seekTimer.stop();
	 delete seekTimer;
}

updateSeek ()
{
	if (seekBar.dragging == TRUE)
	{
		return;
	}

	if (getPlayItemLength() < 1)
	{
		FillBar_setPosition(seekBar, 0);
		return;
	}
	
	int position = 255 * getPosition() / getPlayItemLength();
	FillBar_setPosition(seekBar, position);
}

/*
 * Dragging Callbacks
 */

boolean FillBar_onDrag(Fillbar fb, int pos)
{
	if (getStatus() == STATUS_STOPPED)
	{
		return FALSE;
	}
	
	return TRUE; 
}

boolean FillBar_onEndDrag(Fillbar fb, int pos)
{
	if (getStatus() == STATUS_STOPPED)
	{
		return FALSE;
	}

	System.seekTo(pos/255 * getPlayItemLength());
	return TRUE; 
}

/*
 * System handles
 */

seekTimer.onTimer ()
{
	updateSeek();
}

System.onPlay ()
{
	seekTimer.start();
}

System.onResume ()
{
	seekTimer.start();
}

System.onStop ()
{
	seekTimer.stop();
	FillBar_setPosition(seekBar, 0);
}

System.onPause ()
{
	seekTimer.stop();
}

System.onSeek (int newpos)
{
	updateSeek();
}