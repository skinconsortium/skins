/**
 * glow.m
 *
 * adds glow to all Button Objects in this scripts parent group.
 *
 * @package	com.skinconsortium.cpro.flex
 * @author	mpdeimos
 * @date	18/10/01
 */

#include <lib/std.mi>
#include <lib/com/glowobject.m>
#include <lib/../../ClassicProFlex/classicProFlex.mi>
#include dispatch_ifc.m
#include dispatch_codes.m

Function GlowObject newGlowObject(String id);

Global GlowObject stop, play, pause, prev, next;

System.onScriptLoaded ()
{
	initDispatcher();
	stop = newGlowObject("cbutton.stop");
	play = newGlowObject("cbutton.play");
	pause = newGlowObject("cbutton.pause");
	prev = newGlowObject("cbutton.prev");
	next = newGlowObject("cbutton.next");
}

GlowObject newGlowObject(String id)
{
	GlowObject go = GlowObject_construct(getScriptGroup().findObject(id), getScriptGroup().findObject(id+".glow"));
	GlowObject_setFadeInSpeed(go, ClassicProFlex.appearance_getGlowButtonFadeInSpeed());
	GlowObject_setFadeOutSpeed(go, ClassicProFlex.appearance_getGlowButtonFadeOutSpeed());
	return go;
}

GlowObject.onLeftButtonDown (int x, int y)
{
	String tickertext = "";
	if (GlowObject == prev)
	{
		tickertext = System.getString("winamp.playback", 0);
	}
	else if (GlowObject == play)
	{
		if (getStatus() == -1)
		{
			tickertext = System.getString("winamp.playback", 6);
		}
		else if (getStatus() == 0)
		{
			tickertext = System.getString("winamp.playback", 1);
		}
		else
		{
			tickertext = System.getString("winamp.playback", 7);
		}
	}
	else if (GlowObject == pause)
	{
		if (getStatus() == -1)
		{
			tickertext = System.getString("winamp.playback", 6);
		}
		else
		{
			tickertext = System.getString("winamp.playback", 2);
		}
	}
	else if (GlowObject == stop)
	{
		tickertext = System.getString("winamp.playback", 3);
	}
	else if (GlowObject == next)
	{
		tickertext = System.getString("winamp.playback", 4);
	}
	sendMessageS(SHOW_SYSINFO, tickertext);
}
