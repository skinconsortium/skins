#include <lib/std.mi>

Global Button b1, b2;

System.onScriptLoaded ()
{
	b1 = getScriptGroup().findObject("1");
	b2 = getScriptGroup().findObject("2");
}

b1.onLeftClick ()
{
	b2.bringtoFront();
}

b2.onLeftClick ()
{
	b2.bringtoback();
}
