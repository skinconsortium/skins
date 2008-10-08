#include <lib/std.mi>

Global Group grp;

Global layout parentLayout;

Global Timer hold, mousechecker, tmrDelayMainSongInfoHide;

function fadeinout(guiobject g, int alph, int speed);

system.onScriptLoaded() {	

  	parentLayout = getContainer("main").getLayout("normal"); // grp.getParentLayout();
  	
  	grp = parentLayout.findObject("main.control.buttons");
  	grp.hide();

	mousechecker = new Timer;
	mousechecker.setDelay(200);
	mousechecker.start();
	
	hold = new Timer;
	hold.setDelay(1000);
}

System.onScriptUnloading() {

	delete hold;
	delete mousechecker;

}

hold.onTimer() {
	hold.stop();
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
		}
	}
	
}

fadeinout(guiobject g, int alph, int speed) {
	g.show();
	g.setTargetA(alph);
	g.setTargetSpeed(0.4);
	g.gotoTarget();
}