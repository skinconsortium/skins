#include <lib/std.mi>

class guiobject cbuttonobj;

Global Group grp;

Global layout parentLayout;

Global Timer hold, mousechecker;
Global cbuttonobj cbuttons; //bplay,bstop,bnext,bprev,beject;
Global layer fireButtons;

Global int inArea = 0;

function fadeinout(guiobject g, int alph, double speed);

function showGrpObjs();
function hideGrpObjs();

system.onScriptLoaded() {	

  	parentLayout = getContainer("main").getLayout("normal");
  	
  	grp = parentLayout.findObject("main.control.buttons");
  	grp.hide();

	mousechecker = new Timer;
	mousechecker.setDelay(100);
	mousechecker.start();
	
	hold = new Timer;
	hold.setDelay(1000);
	
	fireButtons = parentLayout.findObject("anim.button");
	
	cbuttons = parentLayout.findObject("stop");
	cbuttons = parentLayout.findObject("next");
	cbuttons = parentLayout.findObject("rev");
	cbuttons = parentLayout.findObject("eject");
	cbuttons = parentLayout.findObject("play");
}

cbuttonobj.onEnterArea() {
	fireButtons.setXMLParam("x",integerToString(getGuiX()-36+getWidth()/2));
	fireButtons.setXMLParam("y",integerToString(getGuiY()-67+getHeight()/2));
	fireButtons.show();
}

cbuttonobj.onLeaveArea() {
	fireButtons.hide();
}

System.onScriptUnloading() {

	delete hold;
	delete mousechecker;
	

}

showGrpObjs() {
	int c = 0, max = grp.getNumObjects();
	guiobject temp;
	
	for (c=0; c<max; c++) {
		temp = NULL;
		temp = grp.enumObject(c);
		if (temp!=NULL) { temp.cancelTarget(); temp.setAlpha(255); }
	}
}

hideGrpObjs() {
	int c = 0, max = grp.getNumObjects();
	guiobject temp;
	string tid;
	
	for (c=0; c<max; c++) {
		temp = NULL;
		temp = grp.enumObject(c);
		if (temp!=NULL) {
			tid = strupper(temp.getID());
			//if (tid == "PLAY" || tid == "REV")
				fadeinout(temp, 0, 0.4);
			//else
				//temp.setAlpha(0);
		}
	}
}

hold.onTimer() {
	
	hold.stop();
	
	hideGrpObjs();

}

mousechecker.onTimer()
{
	if (!parentLayout.isVisible()) return;

	int mousex = getMousePosX();
	int mousey = getMousePosY();

	mousex = mousex - parentLayout.getLeft();
	mousey = mousey - parentLayout.getTop();
	
	if (mousex > parentLayout.getWidth() || mousex < 0 || mousey > parentLayout.getHeight() || mousey < 0) {
		if (inArea) {
			if (!hold.isRunning()) hold.start();

			inArea = 0;
		}
	} else {
		if (hold.isRunning()) hold.stop();
		if (!inArea) {
				
			grp.show();
			showGrpObjs();

			inArea = 1;
		}
	}
	
}

fadeinout(guiobject g, int alph, double speed) {
	//g.show();
	g.setTargetA(alph);
	g.setTargetSpeed(speed);
	g.gotoTarget();
}