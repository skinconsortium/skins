/*************************************************************

  visanim.m
  
  -script to control visanim xui object.
  
  original concept by Quadhelix
  original coded skin by NickMikh
  xui object by Leechbite.com
  

*************************************************************/

#include <lib/std.mi>

function SetVisFrame (animatedlayer vislayer, int Length, int BandStart, int BandStop, int PrevValue, int Offset);

global group scriptGroup;
global int numbarsset, numbars, mirror;
global int updateAnims;
global int animW, animH, animSpacer;
global string animID;

global timer visRefresh;

System.onScriptLoaded() {
	scriptGroup = getScriptGroup();
	
	mirror = 0;
	numbarsset = 0;
	animID = "TEST";
	
	updateAnims = 1;
	
	visRefresh = new Timer;
	visRefresh.setDelay(50);
	
}

System.onScriptUnloading() {
	delete visRefresh;
}

scriptGroup.onSetVisible(int on) {
	if (on)
		visRefresh.start();
	else
		visRefresh.stop();
}

System.onSetXuiParam(String param, String value) {
	param = strlower(param);
	if (param=="numbars") {
		numbarsset = stringToInteger(value);
		scriptGroup.onResize(0,0,scriptGroup.getWidth(),0);
	} else if (param=="image") {
		animID = value;
		updateAnims = 1;
	} else if (param=="speed") {
		visRefresh.setDelay(stringToInteger(value));
	} else if (param=="framewidth") {
		animW = stringToInteger(value);
		updateAnims = 1;
	} else if (param=="frameheight") {
		animH = stringToInteger(value);
		updateAnims = 1;
	} else if (param=="spacer") {
		animSpacer = stringToInteger(value);
		updateAnims = 1;
	} else if (param=="mirror") {
		mirror = stringToInteger(value);
		updateAnims = 1;
	}
}

scriptGroup.onResize(int x, int y, int w, int h) {
	if (animW <= 0) return;
	if (numbarsset <= 0)
		numbars = w / (animW+animSpacer);
	else
	 	numbars = numbarsset;
	updateAnims = 1;
}

visRefresh.onTimer() {
	int c, numframes = 1, newframe,currframe;
	animatedlayer currAnim;
	
	//numbars = 1;
	if (animID == "") return;
	
	for (c=0; c<numbars; c++) {
		currAnim = NULL;
		currAnim = scriptGroup.getObject("anim"+integertostring(c));
		if (!currAnim) {
			currAnim = new animatedlayer;
			
			currAnim.setXMLParam("id","anim"+integertostring(c));
			currAnim.setXMLParam("image",animID);
			currAnim.setXMLParam("x","0");
			currAnim.setXMLParam("y","0");
			currAnim.setXMLParam("w","5");
			currAnim.setXMLParam("h","5");

			currAnim.init(scriptGroup);
			updateAnims = 1;
			
		}	
		if (updateAnims) {
			if (!currAnim.isVisible()) currAnim.show();
			currAnim.setXMLParam("image",animID);
			currAnim.setXMLParam("x",integerToString((animSpacer+animW)*c));
			currAnim.setXMLParam("y","0");
			currAnim.setXMLParam("w",integertostring(animW));
			currAnim.setXMLParam("h",integertostring(animH));
		}
		if (c == 1) numframes = currAnim.getLength()-1;
		
		if (!mirror)
			newframe = System.getVisBand(0, c*70/(numbars-1))*numframes/255; // band 71-75 clipped off, it does not produce any values on most mp3s.
		else
			newframe = System.getVisBand(0, 70-c*70/(numbars-1))*numframes/255;
		currframe = currAnim.getCurFrame();
		if (newframe < currframe) newframe = currframe - 1;
		if (newframe < 0) newframe = 0;
		currAnim.gotoFrame(newframe);

	}
	
	currAnim = NULL;
	currAnim = scriptGroup.getObject("anim"+integertostring(numbars));
	if (currAnim!=NULL && updateAnims) currAnim.hide();
	updateAnims = 0;

}