/********************************************************\
**  Filename:	GlowButton.m				**
**  Version:	1.0					**
**  Date:	02. Mrz. 2008 - 22:15 			**
**********************************************************
**  Type:	winamp.wasabi/maki			**
**  Project:	krazyPlayer				**
**********************************************************
**  Author:	Martin Poehlmann aka Deimos		**
**  E-Mail:	martin@skinconsortium.com		**
**  Internet:	http://www.skinconsortium.com		**
**		http://home.cs.tum.edu/~poehlman	**
\********************************************************/


#include <lib/std.mi>

Function fade (GuiObject o, float speed, int val);

Global button b;
Global layer l;

System.onScriptLoaded ()
{
	b = getScriptGroup().findObject("normal.button");
	l = getScriptGroup().findObject("button.glow");
}

System.onSetXuiParam (String param, String value)
{
	if ( strlower(param) == "glowimage" ) l.setXmlParam("image", value);
	else if ( strlower(param) == "xtooltip" ) b.setXmlParam("tooltip", value);
}

b.onEnterArea ()
{
	//fade(l, 0.1, 255);
	l.cancelTarget();
	l.setAlpha(255);
}

b.onLeaveArea ()
{
	fade(l, 0.3, 0);
}

fade (GuiObject o, float speed, int val)
{
	o.cancelTarget();
	o.setTargetA(val);
	o.gotoTarget();
}
