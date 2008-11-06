//SLoB 
//	- add mmd3 animation vis's, left button down cycles, as this is an override we shouldnt conflict with the right click menu?
// http://www.skinconsortium.com
// http://slob.org.uk
// 1st August 2008
// updated by pjn123 17 August 2008
//updated by SLoB 9th Sept 2008 - removed beatvis stuff as now included in new customvis, but still need to shift it to center in this skin
#include <lib/std.mi>

Global Group  maininnerscreen;
Global Container myContainer;
Global Layout myLayout;

System.onScriptLoaded(){	
	myContainer = getContainer("main");
	if(myContainer==null) return; //this means cpro isnt installed

	myLayout =  myContainer.getLayout("normal");
	maininnerscreen = myLayout.findObject("cpro.screen");

	if(maininnerscreen!=null){	//wont crash if the user choose not to run with cpro 1.04
		maininnerscreen.setXMLParam("x", "15");
		maininnerscreen.setXMLParam("y", "-1");
		maininnerscreen.setXMLParam("w", "-15");
	}
}