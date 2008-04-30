// Script by: David Serrano
//            SOOPRcow@deskmod.com

#include "../../../lib/std.mi"
#include "defines.m"

Global Layout lMain;
Global Group grpThis, bg, dtaGrp;
Global CheckBox chkLibrary, chkVisuals, chkVideo, chkPlaylist, chkConfig, chkEqualizer;
Global Int curButtonId, curButton;
Global Button butApply, butReset;
Global ToggleButton btnDTA;
Global Layer lights;

function loadSettings();
function saveSettings();

system.onScriptLoaded() {
	dtaGrp = getScriptGroup();
	lMain = getContainer("main").getLayout("normal");
	
	grpThis = getScriptGroup().getObject("config.button.option");
	
	chkLibrary   = grpThis.getObject("library");
	chkVisuals   = grpThis.getObject("visuals");
	chkVideo     = grpThis.getObject("video");
	chkPlaylist  = grpThis.getObject("playlist");
	chkConfig    = grpThis.getObject("config");
	chkEqualizer = grpThis.getObject("equalizer");
	
	butApply = grpThis.getObject("apply");
	butReset = grpThis.getObject("reset");
	btnDTA = dtaGrp.findObject("desktopalpha"); 
	lights = lMain.findObject("main.background.lights");

	bg = lMain.findObject("main.window.background"); 
	
	curButtonId = stringToInteger(getParam());
	if(!(curButtonId > 0 || curButtonId < 5))
		messageBox("Error. Button Id Param Missing","",0,"");
}


btnDTA.onToggle(boolean on)
{
//btnDTA.getActivated()
	if(btnDTA.getActivated())
	{
		bg.show();
		messageBox("show","",0,"");
	}
	else
	{
		messageBox("hide","",0,"");
		bg.hide();
	}
	
}

butApply.onLeftClick() {
	saveSettings();
}

butReset.onLeftClick() {
	int anwser = messageBox("This will reload the current settings and undo any changes you have made.\n\nAre you sure you wish to Continue?","Are You Sure?", 1|2 ,"");
	if(anwser!=2) 
		loadSettings();
}

grpThis.onSetVisible(int state) {
	loadSettings();	
}

loadSettings() {
	curButton = getPrivateInt(SKIN_NAME,"button-" + integerToString(curButtonId),-1);
	chkLibrary.setChecked(false);
	chkVisuals.setChecked(false);
	chkVideo.setChecked(false);
	chkPlaylist.setChecked(false);
	chkConfig.setChecked(false);
	chkEqualizer.setChecked(false);
	
	if(curButton == BUTTON_LIBRARY)
		chkLibrary.setChecked(true);
	else if(curButton == BUTTON_VISUALS)
		chkVisuals.setChecked(true);
	else if(curButton == BUTTON_VIDEO)
		chkVideo.setChecked(true);
	else if(curButton == BUTTON_PLAYLIST)
		chkPlaylist.setChecked(true);
	else if(curButton == BUTTON_CONFIG)
		chkConfig.setChecked(true);
	else if(curButton == BUTTON_EQUALIZER)
		chkEqualizer.setChecked(true);
	else
		chkLibrary.setChecked(true);
	
}

saveSettings() {
	int curSel = -1;
	if(chkLibrary.isChecked())   curSel = BUTTON_LIBRARY;
	if(chkVisuals.isChecked())   curSel = BUTTON_VISUALS;
	if(chkVideo.isChecked())     curSel = BUTTON_VIDEO;
	if(chkPlaylist.isChecked())  curSel = BUTTON_PLAYLIST;
	if(chkConfig.isChecked())    curSel = BUTTON_CONFIG;
	if(chkEqualizer.isChecked()) curSel = BUTTON_EQUALIZER;
	if(curSel == -1) curSel = BUTTON_CONFIG;
	//setPrivateInt(SKIN_NAME,"button-" + integerToString(curButtonId),curSel); <-- if it doesn't crash then I don't need this
	String sMsg = "changebutton-" + integerToString(curButtonId);
	lMain.onNotify(sMsg, "",curSel,0);
}