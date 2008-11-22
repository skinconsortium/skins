/*************************************************************

	main.m
	by leechbite.com
	
	main script. handles focus bg.

*************************************************************/

#include <lib/std.mi>

Global layout main; //, focus;

//Global layer focusbg;
//Global togglebutton buttonFocus;

Global button buttonPL;
Global guiobject mainPL;

Global vis vis1, vis2;
Global layer vismousetrap;

//global timer delayfocus;

System.onScriptLoaded() {
	
	main = getContainer("main").getLayout("normal");
	//focus = getContainer("focus").getLayout("normal");
	
	//buttonFocus = main.findObject("main.button.focus");
	
	buttonPL = main.findObject("main.pl");
	mainPL = main.findObject("player.main.pl");
	if (getPrivateInt(getSkinName(),"MainPLVisible",0) == 1) mainPL.show();
	
	//focusbg = focus.findObject("focus.bg");
	//focusbg.hide();
	//focus.resize(0,0, getMonitorWidth(), getMonitorHeight());
	
	//main.resize(0,0, getMonitorWidth(), getMonitorHeight());
	
	//delayfocus = new timer;
	//delayfocus.setDelay(50);
	
}

System.onScriptUnloading() {
	//delete delayfocus;
}

buttonPL.onLeftClick() {
	int plshow = (getPrivateInt(getSkinName(),"MainPLVisible",0) == 0);
	setPrivateInt(getSkinName(),"MainPLVisible",plshow);
	if (plshow) 
		mainPL.show();
	else
		mainPL.hide();
}
/*
buttonFocus.onActivate(int on) {
	if (on) {
		focusbg.show();

		focus.setScale(1.0);
		focus.resize(0,0, getMonitorWidth(), getMonitorHeight());
		
		
		delayfocus.start();

	} else {
		focusbg.hide();
	}

}

delayfocus.onTimer() {
	stop();
	main.setFocus();
}

focusbg.onLeftButtonDown(int x, int y) {
	buttonFocus.setActivated(0);
}
*/