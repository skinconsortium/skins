#include <\lib\std.mi>

Global GuiObject go,gr;

System.onScriptLoaded() {// general initialization
  gr = getScriptGroup();
  go = getScriptGroup().getObject("coolvu.main");
}
/* do some stuff here, i recomment to use centerlayer from wasdp anyways (see bento)
go.onSetVisible (Boolean onoff)
{
	if (onoff)
	{	
		  go.setXMLparam("x",integertostring(getWidth()/2-go.getWidth()/2));
		  go.setXMLparam("y",integertostring(getHeight()/2-go.getHeight()/2));
	}
}
*/

gr.onResize(int x, int y, int w, int h) {
  go.setXMLparam("x",integertostring(w/2-go.getWidth()/2));
  go.setXMLparam("y",integertostring(h/2-go.getHeight()/2));
}