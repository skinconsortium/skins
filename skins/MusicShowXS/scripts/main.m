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
	
	buttonPL = main.findObject("main.pl");
	mainPL = main.findObject("player.main.pl");
	if (getPrivateInt(getSkinName(),"MainPLVisible",0) == 1) mainPL.show();

	
	main.resize(0,0, getMonitorWidth(), getMonitorHeight());

}

System.onScriptUnloading() {
	
}

buttonPL.onLeftClick() {
	int plshow = (getPrivateInt(getSkinName(),"MainPLVisible",0) == 0);
	setPrivateInt(getSkinName(),"MainPLVisible",plshow);
	if (plshow) 
		mainPL.show();
	else
		mainPL.hide();
}
