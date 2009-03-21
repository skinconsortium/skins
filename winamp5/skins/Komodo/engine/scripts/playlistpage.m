/*************************************************************

  pagescroll.m
  
  -script to control the page scrolling
  

*************************************************************/

#include <lib/std.mi>

global layout main;
global group scriptGroup;
global button buttonSwitchToCover, buttonSwitchToList;
global group plplus, covershow;

global group currGroup, nextGroup;

System.onScriptLoaded() {
	
	scriptGroup = getScriptGroup();
	main = scriptGroup.getParentLayout();
	
	buttonSwitchToList = scriptGroup.findObject("SwitchToList.button");
	buttonSwitchToCover = scriptGroup.findObject("SwitchToCover.button");

	covershow = scriptGroup.getObject("player.main.pl.coverflow");
	plplus = scriptGroup.getObject("player.main.pl.list");
	
	if (getPrivateInt(getSkinName(), "CoverShow", 1) == 0) {
		plplus.show();
		covershow.hide();
	}
}

System.onScriptUnloading() {
	
}

scriptGroup.onSetVisible(int on) {
	if (on && (getPrivateInt("Komodo","TUP",0) == 1) && covershow.isVisible())
		buttonSwitchToList.onLeftClick();
}

buttonSwitchToList.onLeftClick() {
	plplus.show();
	covershow.hide();
	
	setPrivateInt(getSkinName(), "CoverShow", 0);
}

buttonSwitchToCover.onLeftClick() {
	if (getPrivateInt("Komodo","TUP",0) == 1) {
		main.sendAction("TRIALNOTICE", "", 0,0,0,0);
		return;
	}
	
	plplus.hide();
	covershow.show();
	
	setPrivateInt(getSkinName(), "CoverShow", 1);
}