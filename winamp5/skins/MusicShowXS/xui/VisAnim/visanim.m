/*************************************************************

  visanim.m
  
  -script to control visanim xui object.
  

*************************************************************/

#include <lib/std.mi>

global group scriptGroup;
global int numbarsset, numbars;
global int animW, animH;
global string animID;

global timer visRefresh;

System.onScriptLoaded() {
	scriptGroup = getScriptGroup();
	
	visRefresh = new Timer;
	visRefresh.setDelay(50);
	visRefresh.start();
}

System.onScriptUnloading() {
	delete visRefresh;
}

System.onSetXuiParam(String param, String value) {
	param = strlower(param);
	if (param=="numbars") {
		numbarsset = stringToInteger(value);
		scriptGroup.onResize(0,0,scriptGroup.getWidth(),0);
	} else if (param="image") {
		animID = value;
	} else if (param="speed") {
		visRefresh.setDelay(stringToInteger(value));
	} else if (param="framewidth") {
		animW = stringToInteger(value);
	} else if (param="frameheight") {
		animH = stringToInteger(value);
	}
}

scriptGroup.onResize(int x, int y, int w, int h) {
	if (animW <= 0) return;
	if (numbarsset <= 0)
		numbars = w / animW;
	else
	 	numbars = numbarsset;
}

visRefresh.onTimer() {
	
}
