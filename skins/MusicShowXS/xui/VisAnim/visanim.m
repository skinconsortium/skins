/*************************************************************

  visanim.m
  
  -script to control visanim xui object.
  

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
		if (c == 1) numframes = currAnim.getLength();
		
		if (!mirror)
			newframe = System.getVisBand(0, c*70/(numbars-1))*numframes/255;
		else
			newframe = System.getVisBand(0, 70-c*70/(numbars-1))*numframes/255;
		currframe = currAnim.getCurFrame();
		if (newframe < currframe) newframe = currframe - 1;
		if (newframe < 0) newframe = 0;
		currAnim.gotoFrame(newframe);

	}
	
	currAnim = NULL;
	currAnim = scriptGroup.getObject("anim"+integertostring(numbars));
	if (currAnim) currAnim.hide();
	updateAnims = 0;

}

/********************************
vislayer - the animated layer for the bar
Length - number of frames to use (can be less or equal to vislayer's number of frames)
BandStart, BandStop - the first and the last frequencies to use, all fequency values inside these boundaries are used to get the frame value [0..75]
PrevValue - use Global integer variable, set to the return function value in the previous function call (allows slow falldowns) or you can set it to 0 for immediate falldown
Offset - +value if the first frame should be (value +1)st frame of the animation (Be careful as real Length will be decreased by Offset)
       - -value if the animation should begin with louder sounds

Return Value - set it to Global integer variable and use it when using the function again as PrevValue for slow falldowns
********************************/
SetVisFrame(animatedlayer vislayer, int Length, int BandStart, int BandStop, int PrevValue, int Offset) {

	boolean playing = 0;
	If (System. getStatus()!= 0) playing = 1;
	double BandValue;
	int i;
	For (i=BandStart;i<=BandStop;i++) {BandValue = BandValue + System.getVisBand(0, i);}
	BandValue = playing*BandValue;
	If (PrevValue > BandValue) BandValue = (PrevValue * 4/5) + (BandValue / 5); // Using the old values too
	PrevValue = BandValue;
	BandValue = BandValue / 255 / (BandStop - BandStart);
	int newFrame = Integer(BandValue * Length) + Offset;
	If (newFrame >= Length) newFrame = Length - 1;
	If (newFrame < 0) newFrame = 0;
	vislayer.gotoFrame(newFrame);	
	return PrevValue;
}
