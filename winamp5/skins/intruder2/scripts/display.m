#include <lib/std.mi>

class guiobject grpObjs;

Global Group grp;

Global layout parentLayout;

Global Timer hold, mousechecker, hidetimer;
Global grpObjs t;

function fadeinout(guiobject g, int alph, double speed);

function showGrpObjs();
function hideGrpObjs();

system.onScriptLoaded() {	

  	parentLayout = getContainer("main").getLayout("normal"); // grp.getParentLayout();
  	
  	grp = parentLayout.findObject("main.control.buttons");
  	grp.hide();

	mousechecker = new Timer;
	mousechecker.setDelay(100);
	mousechecker.start();
	
	hold = new Timer;
	hold.setDelay(1000);
	
	hidetimer = new Timer;
	hidetimer.setDelay(1000);
}

System.onScriptUnloading() {

	delete hold;
	delete mousechecker;
	delete hidetimer;

}

showGrpObjs() {
	int c = 0, max = grp.getNumObjects();
	guiobject temp;
	
	for (c=0; c<max; c++) {
		temp = NULL;
		temp = grp.enumObject(c);
		if (temp!=NULL) {temp.cancelTarget(); temp.setAlpha(255); }
	}
}

hideGrpObjs() {
	int c = 0, max = grp.getNumObjects();
	guiobject temp;
	
	for (c=0; c<max; c++) {
		t = NULL;
		t = grp.enumObject(c);
		if (t!=NULL) fadeinout(t, 0, 1.0);
	}
}

hold.onTimer() {
	
	hold.stop();
	
	hideGrpObjs();
	
	hidetimer.start();
}

hidetimer.onTimer() {
	stop();
	
	grp.hide();
}

mousechecker.onTimer()
{
	if (!parentLayout.isVisible()) return;

	int mousex = getMousePosX();
	int mousey = getMousePosY();

	mousex = mousex - parentLayout.getLeft();
	mousey = mousey - parentLayout.getTop();
	
	if (mousex > parentLayout.getWidth() || mousex < 0 || mousey > parentLayout.getHeight() || mousey < 0) {
		if (grp.isVisible()) {
			if (!hold.isRunning()) hold.start();
		}
	} else {
		if (hold.isRunning()) hold.stop();
		if (!grp.isVisible()) {
			
			grp.show();
			showGrpObjs();
		}
	}
	
}

fadeinout(guiobject g, int alph, double speed) {
	//g.show();
	g.setTargetA(alph);
	g.setTargetSpeed(speed);
	g.gotoTarget();
}