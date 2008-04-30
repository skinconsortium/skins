/*************************************************************

  fs-songticker.m
  by leechbite, www.leechbite.com

  controls the party mode songticker
  
*************************************************************/

#include <lib/std.mi>


Global group scriptGroup;
Global text timertext;
Global group songtickerGroup;

System.onScriptLoaded() {
	scriptGroup = getScriptGroup();

	songtickerGroup = scriptGroup.getObject("Songticker");
	timertext = scriptGroup.getObject("s2timer");
}

System.onScriptUnloading() {
	return;
}

scriptGroup.onResize(int x, int y, int w, int h) {
	string strw = integerToString(w/2-55);
	
	songtickerGroup.setXMLParam("w", strw);
	timertext.setXMLParam("x", "-"+strw);
	timertext.setXMLParam("w", strw);
}