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

Function GlowObject newGlowObject(String id);

Global GlowObject stop, play, pause, prev, next;

System.onScriptLoaded ()
{
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