#include <lib/std.mi>

Global Group frameGroup;
Global Layer bg;

System.onScriptLoaded(){
	frameGroup = getScriptGroup();
	bg = frameGroup.findObject("cti.bg");
}

frameGroup.onResize(int x, int y, int w, int h){
	bg.setXmlParam("x", integerToString(w/2-360/2));
}