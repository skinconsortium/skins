/*************************************************************

  progbutton.m
  by Leechbite

  script for the programmable button.
  
  param = "buttonID,orogbuttonID,default"
  
  buttonID - button ID. for XUI object define this as xuiID;actualbuttonID. e.g. 
  			param="xui.progbutton1;xui.button,button1,EQ|Rock"
  progbuttonID - used to identify one programmable button from another. mainly
  				used for the privateString variables. buttons with same
  				progbuttonID will have same programmed function.
  default - default programmed button.
  			e.g. "EQ|Rock" or "PATH|http://www.leechbite.com/radio.nsv|Station Name"

modified by slob to catch assertion error on blank strings in url/path box
thanks to leechbite for the prog button script

modified for vortex by Deimos: Bugfixes and open Browser option
  
*************************************************************/
#include <lib/std.mi>

#include "eq-utilities.m"

#define ON 1
#define OFF 0

//function load_progbuttons();
//function unload_progbuttons();

Function ProcessMenuResult(int a);

function string getCurrProg();
function bookmarkCurrent();
function addpathURL();
function setToEQPreset(int preset);
function setToolTip();

Global group scriptGroup;
Global button progbutton;
Global string buttonID, defaultProg;

Global container queryPathURLCont;
Global layout queryPathURLLayout;
Global button queryPathURLOKButton;
Global edit queryPathURLEditBox,queryNameEditBox;

Global popupMenu progMenu, eqProgSubMenu;


System.onScriptLoaded() {

	//load popupmenu on strtup
	eqProgSubMenu = new popupMenu;
	eqProgSubMenu.addCommand("- EQ Presets -", -1, 0, 1);
	eqProgSubMenu.addSeparator();
	eqProgSubMenu.addCommand(" Flat", 100, 0, 0);
	eqProgSubMenu.addCommand(" Full", 101, 0, 0);
	eqProgSubMenu.addCommand(" Rock", 102, 0, 0);
	eqProgSubMenu.addCommand(" Soft", 103, 0, 0);
	eqProgSubMenu.addCommand(" Pop", 104, 0, 0);
	eqProgSubMenu.addCommand(" USER", 105, 0, 0);
	
	progMenu = new popupMenu;
	progMenu.addCommand("  - Programmable Button : "+buttonID+" -", -1, 0, 1);
	progMenu.addCommand(" Current mode : " + getCurrProg(), -2, 0, 1);
	progMenu.addSeparator();
	progMenu.addCommand(" Bookmark current song", 1, 0, 0);
	progMenu.addCommand(" Type path/url", 2, 0, 0);
	progMenu.addSubMenu(eqProgSubMenu," Equalizer Preset");
	progMenu.addCommand(" Reset to default", 99, 0, 0);
	scriptGroup = getScriptGroup();
	string param = getParam();
	
	string objID = getToken(getToken(param,",",0),";",0);
	string objID2 = getToken(getToken(param,",",0),";",1);
	
	if (objID2 == "")
		progbutton = scriptGroup.getObject(objID);
	else {
		group temp = scriptGroup.getObject(objID);
		progbutton = temp.getObject(objID2); 
	}	
	
	buttonID = getToken(param,",",1);
	defaultProg = getToken(param,",",2);
	
	setToolTip();
	
}

System.onScriptUnloading() {
	return;
}

string getCurrProg() {
	string currProg = getPrivateString(getSkinName(), buttonID, defaultProg);
	if (currProg == "NULL") return;
	string ret = "";
	string progmode = strupper(getToken(currProg, "|", 0));
	
	if (progmode == "PATH") {
		string path = getToken(currProg, "|", 1);
		if (strlen(path) > 30) {
			path = strleft(path, 13)+" .. "+removePath(path);
		}
		ret = "PATH - " + path;
	} else if (progmode == "EQ") {
		ret = "EQ Preset - "+getToken(currProg, "|", 1);
	} else if (progmode == "BROWSE") {
		ret = "Browse: "+getToken(currProg, "|", 1);
	}
	
	return ret;
}


progbutton.onLeftClick() {
	string currProg = getPrivateString(getSkinName(), buttonID, defaultProg);
	if (currProg == "NULL") return;
	string progmode = strupper(getToken(currProg, "|", 0));
	
	if (progmode == "PATH") {
		string path = getToken(currProg, "|", 1);
		playFile(path);
	} else if (progmode == "EQ") {
		string EQPreset = strupper(getToken(currProg, "|", 1));
		
		if (EQPreset == "FULL") {
			setEQPreset(EQ_Full);
		} else if (EQPreset == "ROCK") {
			setEQPreset(EQ_Rock);
		} else if (EQPreset == "SOFT") {
			setEQPreset(EQ_Soft);
		} else if (EQPreset == "POP") {
			setEQPreset(EQ_Pop);
		} else if (EQPreset == "USER") {
			setEQPresetUSER();
		} else {
			setEQPreset(EQ_Flat);
		}
		
		if (!getEQ()) setEQ(ON);
	} else if (progmode == "BROWSE") {
		System.navigateURL(getToken(currProg, "|", 1));
	}

	//quick hack so this appears to fly in on its own without relooping
	//setFunkyText("                    *** " + progmode + " ***          ");

}

progbutton.onRightButtonUp(int x, int y) {
	string tooltip = getXMLParam("tooltip");
	setXMLParam("tooltip","");
	
	//popupmenu created on startup
	ProcessMenuResult(progmenu.popAtMouse());

	complete; //prevent right-click context menu from appearing

}

ProcessMenuResult(int res) {
	//bugfix: ensure a > 0
	if(res > 0) {
		if (res == 1) {
			bookmarkCurrent();
		} else if (res == 2) {
			addpathURL();
		} else if (res >= 100 && res < 200) {
			setToEQPreset(res);
		} else if (res == 99) {
			setPrivateString(getSkinName(), buttonID, defaultProg);
		}

		setToolTip();
	}
}

setToolTip() {
	string currProg = getPrivateString(getSkinName(), buttonID, defaultProg);
	string progmode = strupper(getToken(currProg, "|", 0));
	string tip = "";
	
	if (progmode == "PATH") {
		string path = getToken(currProg, "|", 1);
		string protocol = strlower(getToken(path, "://", 0));
		tip = getToken(currProg, "|", 2);
		if (tip=="") {
			if (protocol == "http" || protocol == "mms")
				tip = "Internet Radio";
			else
				tip = removePath(path);
		}
	} else if (progmode == "EQ") {
		tip = "EQ Preset: "+getToken(currProg, "|", 1);
	} else if (progmode == "BROWSE") {
		tip = "Browse: "+getToken(currProg, "|", 1);
	}
	
	progButton.setXMLParam("tooltip", tip+" | Right-click to program button");
}

bookmarkCurrent() {
	string currPath = getPlayItemMetaDataString("filename");
	
	setPrivateString(getSkinName(), buttonID, "PATH|"+currPath);
}

addpathURL() {
	if (isObjectValid(queryPathURLCont)) { // if already open, dont reopen
		layout queryPathURLLayout = queryPathURLCont.enumLayout(0);
		queryPathURLLayout.setFocus();
		queryPathURLLayout.center();
		return;
	}
	
	queryPathURLCont = newDynamicContainer("query.pathurl");
	if (queryPathURLCont) {
		queryPathURLCont.show();
		queryPathURLLayout = queryPathURLCont.getLayout("normal");
		queryPathURLLayout.center();
		queryPathURLOKButton = queryPathURLLayout.findObject("ok");
		queryPathURLEditBox = queryPathURLLayout.findObject("pathurl.editbox");
		queryNameEditBox = queryPathURLLayout.findObject("medianame.editbox");
	}
}

queryPathURLOKButton.onLeftClick() {

	//get an assertion error on blank strings
	if (strlen(queryPathURLEditBox.getText()) > 0  && strlen(queryNameEditBox.getText()) > 0 ){
		setPrivateString(getSkinName(), buttonID, "PATH|"+queryPathURLEditBox.getText()+"|"+queryNameEditBox.getText());
	
	queryPathURLCont.close();
	queryPathURLCont = NULL;
	
	setToolTip();
	}
}

queryPathURLEditBox.onEnter() {
	queryNameEditBox.setFocus();
}

queryNameEditBox.onEnter() {
	queryPathURLOKButton.onLeftClick();
}

setToEQPreset(int preset) {
	string EQPresetName = "";
	if (preset == 101)
		EQPresetName = "Full";
	else if (preset == 102)
		EQPresetName = "Rock";
	else if (preset == 103)
		EQPresetName = "Soft";
	else if (preset == 104)
		EQPresetName = "Pop";
	else if (preset == 105)
		EQPresetName = "USER";
	else
		EQPresetName = "Flat";
		
	setPrivateString(getSkinName(), buttonID, "EQ|"+EQPresetName);
}