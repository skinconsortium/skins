#include <lib/std.mi>

Global Button b1, b2;
Global Group g1, g2;

System.onScriptLoaded ()
{
	g1 = getScriptGroup().findObject("g1");
	g2 = getScriptGroup().findObject("g2");
	b1 = getScriptGroup().findObject("1");
	b2 = getScriptGroup().findObject("2");
}

b1.onLeftClick ()
{
	g2.bringtoFront();
}

b2.onLeftClick ()
{
	g2.bringtoBack();
}
