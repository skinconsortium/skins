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
#include dispatch_codes.m

Function GlowObject newGlowObject(GlowObject go, GlowLayer gl, String id);

Global GlowObject stop, play, pause, prev, next;
Global GlowLayer stop_gl, play_gl, pause_gl, prev_gl, next_gl;
Global int glowType;

System.onScriptLoaded ()
{
	initDispatcher();

	String type = strlower(ClassicProFlex.appearance_getGlowButtonType());
	if (type == "hold")
	{
		glowType = GLOW_TYPE_HOLD;
	}
	else if (type == "bounce")
	{
		glowType = GLOW_TYPE_BOUNCE;
	}
	else if (type == "flash")
	{
		glowType = GLOW_TYPE_FLASH;
	}

	stop = newGlowObject(stop, stop_gl, "cbutton.stop");
	play = newGlowObject(play, play_gl, "cbutton.play");
	pause = newGlowObject(pause, pause_gl, "cbutton.pause");
	prev = newGlowObject(prev, prev_gl, "cbutton.prev");
	next = newGlowObject(next, next_gl, "cbutton.next");

	stop_gl = stop.glow;
	play_gl = play.glow;
	pause_gl = pause.glow;
	prev_gl = prev.glow;
	next_gl = next.glow;
}

GlowObject newGlowObject(GlowObject go, GlowLayer gl, String id)
{
	go = getScriptGroup().findObject(id);
	gl = getScriptGroup().findObject(id+".glow");
	GlowObject go = GlowObject_construct(go, gl);
	GlowObject_setFadeInSpeed(go, ClassicProFlex.appearance_getGlowButtonFadeInSpeed());
	GlowObject_setFadeOutSpeed(go, ClassicProFlex.appearance_getGlowButtonFadeOutSpeed());
	GlowObject_setGlowType(go, glowType);
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
