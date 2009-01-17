/**
 * glow.m
 *
 * adds glow to all buttons, handles songticker messages.
 *
 * @package	com.skinconsortium.cpro.flex
 * @author	mpdeimos
 * @date	08/10/01
 */

#include <lib/std.mi>
#include <lib/com/glowobject.m>
#include <lib/../../ClassicProFlex/classicProFlex.mi>
#include dispatch_codes.m

Function GlowObject newGlowObject(GlowObject go, GlowLayer gl, String id);

Global GlowObject stop, play, pause, prev, next, open, shuffle, repeat, mute;
Global GlowLayer stop_gl, play_gl, pause_gl, prev_gl, next_gl, open_gl, shuffle_gl, repeat_gl, mute_gl;
Global GlowObject pled, eq, ml, vs, mn;
Global GlowLayer pled_gl, eq_gl, ml_gl, vs_gl, mn_gl;
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
	else if (type == "off")
	{
		return;
	}
	else
	{
		glowType = GLOW_TYPE_HOLD;
	}
	
	

	stop = newGlowObject(stop, stop_gl, "cbutton.stop");
	play = newGlowObject(play, play_gl, "cbutton.play");
	pause = newGlowObject(pause, pause_gl, "cbutton.pause");
	prev = newGlowObject(prev, prev_gl, "cbutton.prev");
	next = newGlowObject(next, next_gl, "cbutton.next");
	open = newGlowObject(open, open_gl, "cbutton.open");
	shuffle = newGlowObject(shuffle, shuffle_gl, "pbutton.shuffle");
	repeat = newGlowObject(repeat, repeat_gl, "pbutton.repeat");
	mute = newGlowObject(mute, mute_gl, "volume.mute");
	pled = newGlowObject(pled, pled_gl, "comp.pl");
	eq = newGlowObject(eq, eq_gl, "comp.eq");
	ml = newGlowObject(ml, ml_gl, "comp.ml");
	vs = newGlowObject(vs, vs_gl, "comp.vis");
	mn = newGlowObject(mn, mn_gl, "comp.menu");

	stop_gl = stop.glow;
	play_gl = play.glow;
	pause_gl = pause.glow;
	prev_gl = prev.glow;
	next_gl = next.glow;
	open_gl = open.glow;
	shuffle_gl = shuffle.glow;
	repeat_gl = repeat.glow;
	mute_gl = mute.glow;
	pled_gl = pled.glow;
	eq_gl = eq.glow;
	ml_gl = ml.glow;
	vs_gl = vs.glow;
	mn_gl = mn.glow;
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
	else if (GlowObject == open)
	{
		tickertext = System.getString("winamp.playback", 5);
	}
	else if (GlowObject == shuffle)
	{
		ToggleButton tgb = GlowObject;
		if (tgb.getCurCfgVal() == 0)
		{
			tickertext = System.getString("winamp.playback", 31);
		}
		else
		{
			tickertext = System.getString("winamp.playback", 32);
		}
	}
	else if (GlowObject == repeat)
	{
		ToggleButton tgb = GlowObject;
		if (tgb.getCurCfgVal() == 0)
		{
			tickertext = System.getString("winamp.playback", 34);
		}
		else if (tgb.getCurCfgVal() == 1)
		{
			tickertext = System.getString("winamp.playback", 35);
		}
		else
		{
			tickertext = System.getString("winamp.playback", 36);
		}
	}	
	if (tickertext != "")
	{
		sendMessageS(SHOW_SYSINFO, tickertext);	
	}
}

GlowObject.onLeftButtonUp (int x, int y)
{
	String tickertext = "";
	if (GlowObject == shuffle)
	{
		ToggleButton tgb = GlowObject;
		if (tgb.getCurCfgVal() == 0)
		{
			tickertext = System.getString("winamp.playback", 31);
		}
		else
		{
			tickertext = System.getString("winamp.playback", 32);
		}
	}
	else if (GlowObject == repeat)
	{
		ToggleButton tgb = GlowObject;
		if (tgb.getCurCfgVal() == 0)
		{
			tickertext = System.getString("winamp.playback", 34);
		}
		else if (tgb.getCurCfgVal() == 1)
		{
			tickertext = System.getString("winamp.playback", 35);
		}
		else
		{
			tickertext = System.getString("winamp.playback", 36);
		}
	}

	if (tickertext != "")
	{
		sendMessageS(SHOW_SYSINFO, tickertext);	
	}
}