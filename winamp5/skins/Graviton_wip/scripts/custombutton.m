// Script by: David Serrano
//            SOOPRcow@deskmod.com

#include "../../../lib/std.mi"
#include "defines.m"

Global Layout lMain;
Global Button bLibrary, bVisuals, bVideo, bPlaylist, bConfig, bEqualizer;
Global Int curButtonNum, curButtonId, curAniState, ButtonN;
Global AnimatedLayer aniButtonChange;
Global Layer innerMask, outerMask;

function setDisplayButton(int bnum);
function setButtonImages(int bnum);
function sinit();

system.onScriptLoaded() {
	lMain = getContainer("main").getLayout("normal");
	bLibrary   = getScriptGroup().getObject("library");
	bVisuals   = getScriptGroup().getObject("visuals");
	bVideo     = getScriptGroup().getObject("video");
	bPlaylist  = getScriptGroup().getObject("playlist");
	bConfig    = getScriptGroup().getObject("config");
	bEqualizer = getScriptGroup().getObject("equalizer");

	innerMask = lMain.findObject("main.inner.mask");
	outerMask = lMain.findObject("main.outer.mask");

	curButtonNum = -1;
	curButtonId = -1;
	curAniState = ANI_FORWARDS;
}

lMain.onNotify(string cmd, string param, int a, int b) {
	if(cmd == ("changebutton-" + integerToString(curButtonId))) {
		ButtonN = a;
		if(!aniButtonChange) aniButtonChange = lMain.getObject("button.ani");
		aniButtonChange.setXmlParam("alpha", "255");

		innerMask = lMain.findObject("main.inner.mask");
		outerMask = lMain.findObject("main.outer.mask");

		innerMask.setXmlParam("alpha", "255");
		outerMask.setXmlParam("alpha", "255");
		innerMask.setXmlParam("ghost", "0");
		outerMask.setXmlParam("ghost", "0");
		curAniState = ANI_FORWARDS;

		aniButtonChange.play();
		setDisplayButton(ButtonN);
	}
}

aniButtonChange.onStop() {
	if(curAniState == ANI_FORWARDS) {
		aniButtonChange.gotoFrame(aniButtonChange.getLength()-1);
		aniButtonChange.setEndFrame(0);
		aniButtonChange.setStartFrame(aniButtonChange.getLength()-1);
		curAniState = ANI_BACKWARDS;
		aniButtonChange.play();
	} else {
		aniButtonChange.setTargetA(0);
		aniButtonChange.gotoFrame(0);
		aniButtonChange.setStartFrame(0);
		aniButtonChange.setEndFrame(aniButtonChange.getLength()-1);
		aniButtonChange.gotoTarget();
		aniButtonChange.setXmlParam("ghost", "1");

		innerMask.setTargetA(0);
		outerMask.setTargetA(0);
		innerMask.setTargetSpeed(1);
		outerMask.setTargetSpeed(1);
		innerMask.gotoTarget();
		outerMask.gotoTarget();
		innerMask.setXmlParam("ghost", "1");
		outerMask.setXmlParam("ghost", "1");
	}
}

System.onSetXuiParam(String param, String value) {
	if(strlower(param) == "cb_id") {
		curButtonId = stringToInteger(value);
		setButtonImages(stringToInteger(value));
	}

	if(strlower(param) == "cb_def") {
		int curButton = getPrivateInt(SKIN_NAME,"button-" + integerToString(curButtonId),-1);
		if(curButton == -1) {
			setDisplayButton(stringToInteger(value));
		} else {
		setDisplayButton(curButton);
		}
	}
}

setDisplayButton(int bnum) {
	bLibrary.hide(); bVisuals.hide(); bVideo.hide(); bPlaylist.hide(); bConfig.hide(); bEqualizer.hide();
	
	if(bNum == BUTTON_LIBRARY)
		bLibrary.show();
	else if(bNum == BUTTON_VISUALS)
		bVisuals.show();
	else if(bNum == BUTTON_VIDEO)
		bVideo.show();
	else if(bNum == BUTTON_PLAYLIST)
		bPlaylist.show();
	else if(bNum == BUTTON_CONFIG)
		bConfig.show();
	else if(bNum == BUTTON_EQUALIZER)
		bEqualizer.show();
	else
		bConfig.show();
		
	curButtonNum = bnum;
	
	setPrivateInt(SKIN_NAME,"button-" + integerToString(curButtonId), bnum);
}

setButtonImages(int bnum) {
	string snum = integerToString(bNum);
	
	bLibrary.setXmlParam("image",       "custom.button." + snum + ".library");
	bLibrary.setXmlParam("hoverimage",  "custom.button." + snum + ".library.hover");
	bLibrary.setXmlParam("downimage",   "custom.button." + snum + ".library.down");
	
	bVisuals.setXmlParam("image",       "custom.button." + snum + ".visuals");
	bVisuals.setXmlParam("hoverimage",  "custom.button." + snum + ".visuals.hover");
	bVisuals.setXmlParam("downimage",   "custom.button." + snum + ".visuals.down");
	
	bVideo.setXmlParam("image",         "custom.button." + snum + ".video");
	bVideo.setXmlParam("hoverimage",    "custom.button." + snum + ".video.hover");
	bVideo.setXmlParam("downimage",     "custom.button." + snum + ".video.down");
	
	bPlaylist.setXmlParam("image",      "custom.button." + snum + ".playlist");
	bPlaylist.setXmlParam("hoverimage", "custom.button." + snum + ".playlist.hover");
	bPlaylist.setXmlParam("downimage",  "custom.button." + snum + ".playlist.down");
	
	bConfig.setXmlParam("image",        "custom.button." + snum + ".config");
	bConfig.setXmlParam("hoverimage",   "custom.button." + snum + ".config.hover");
	bConfig.setXmlParam("downimage",    "custom.button." + snum + ".config.down");
	
	bEqualizer.setXmlParam("image",     "custom.button." + snum + ".equalizer");
	bEqualizer.setXmlParam("hoverimage","custom.button." + snum + ".equalizer.hover");
	bEqualizer.setXmlParam("downimage", "custom.button." + snum + ".equalizer.down");
}