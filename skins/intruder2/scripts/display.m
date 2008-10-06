#include "../../../lib/std.mi"
#include "defines.m"

Global Layout lMain, lConf;

Global Group grp;
Global container parentContainer;
Global layout parentLayout, winshade;
Global string layoutPrivateInt, newlayoutPrivateInt, strlayout;

Global Group cbuts, disp, visanim;
Global Layer mousetrap1, mousetrap2;
Global Button visualsbut, play, pause, stop, next, prev, load;
Global Slider staysl;
Global Text staytext;
Global Timer hold, mousechecker, tmrDelayMainSongInfoHide;
Global Map mousetrapmap;
Global Boolean visdisplay, isover;
Global Int disphold;

function changedisplay(boolean d);
function changedispvis(boolean d);
function fadeinout(guiobject g, int alph, int speed);

system.onScriptLoaded() {	

	//grp = getScriptGroup();

  	parentLayout = getContainer("main").getLayout("normal"); // grp.getParentLayout();
  	parentContainer = System.getContainer("main");
	
	winshade = parentContainer.getLayout("winshade");

	lMain = getContainer("main").getLayout("normal");
	lConf = getContainer("win.config").getLayout("normal");

	cbuts = lMain.findObject("main.control.buttons");
	disp = lMain.findObject("main.display.content");

	mousetrap1 = lMain.findObject("main.mousetrap");
	mousetrap2 = lMain.findObject("main.mousetrap2");

	mousetrapmap = new map;
	mousetrapmap.loadmap("main.mousetrap.map");

	visanim = lMain.findObject("main.display.anim");

	visualsbut = lMain.findObject("visuals");

	staysl = lConf.findObject("stay.slider");
	staytext = lConf.findObject("stay.text");

	play = lMain.findObject("play");
	pause = lMain.findObject("pause");
	prev = lMain.findObject("prev");
	next = lMain.findObject("next");
	load = lMain.findObject("load");
	stop = lMain.findObject("stop");

	visdisplay = getPrivateInt(SKIN_NAME, "visdisplay", 0);

	cbuts.hide();

	if(visdisplay) {
		disp.hide();
		visanim.setXmlParam("alpha", "255");
	} else {
		visanim.hide();
		disp.setXmlParam("alpha", "255");
	}

	hold = new Timer;
	tmrDelayMainSongInfoHide = new Timer;
	tmrDelayMainSongInfoHide.setDelay(500);
	tmrDelayMainSongInfoHide.stop();

	staysl.SetPosition(getPrivateInt(SKIN_NAME, "disphold", 20));

	mousechecker = new Timer;
	mousechecker.setDelay(200);
	mousechecker.start();
}

System.onScriptUnloading() {
	setPrivateInt(SKIN_NAME, "visdisplay", visdisplay);
	setPrivateInt(SKIN_NAME, "disphold", ((disphold/1000-1)*4));

	hold.stop();
	tmrDelayMainSongInfoHide.stop();
	mousechecker.stop();

	delete hold;
	delete tmrDelayMainSongInfoHide;	
	delete mousechecker;
	delete mousetrapmap;
}
/*
play.onLeftButtonUp(int x, int y) {
	hold.stop();
	hold.setDelay(2500);
	hold.start();
}

pause.onLeftButtonUp(int x, int y) {
	hold.stop();
	hold.setDelay(2500);
	hold.start();
}

stop.onLeftButtonUp(int x, int y) {
	hold.stop();
	hold.setDelay(2500);
	hold.start();
}

next.onLeftButtonUp(int x, int y) {
	hold.stop();
	hold.setDelay(2500);
	hold.start();
}

prev.onLeftButtonUp(int x, int y) {
	hold.stop();
	hold.setDelay(2500);
	hold.start();
}

load.onLeftButtonUp(int x, int y) {
	hold.stop();
	hold.setDelay(2500);
	hold.start();
}

mousetrap1.onEnterArea() {
	if(isover == 0) {
		tmrDelayMainSongInfoHide.start();
		mousetrap1.hide();
		mousetrap2.show();
	}
}

mousetrap2.onEnterArea() {
	if(isover == 1) {
		isover = 0;
		mousetrap1.show();
		mousetrap2.hide();
	}
}
*/

hold.onTimer() {
	hold.stop();
	fadeinout(cbuts, 0, 1);
	cbuts.setXmlParam("ghost", "1");
	hold.setdelay(disphold);
}

mousechecker.onTimer()
{
	if (!lMain.isVisible()) return;

	int mousex = getMousePosX();
	int mousey = getMousePosY();

	int mapx = mousex - (lMain.getLeft()+mousetrap1.getLeft());
	int mapy = mousey - (lMain.getTop()+mousetrap1.getTop());

	if (mousetrapmap.getValue(mapx, mapy)>230) {
		if (isover) return;
		isover = 1;

		tmrDelayMainSongInfoHide.start();
		

		hold.stop();
	} else {
		if (!isover) return;
		isover = 0;
	}
}

tmrDelayMainSongInfoHide.onTimer()
{
	tmrDelayMainSongInfoHide.stop();
	changedisplay(1);
}


staysl.onSetPosition(int newStay) {
	staytext.setText(Strleft(floattostring(NewStay/4+1,2), 3) + " sec");
	disphold = (newStay/4+1)*1000; 
	hold.setdelay(disphold);
}

visualsbut.onLeftButtonDown(int x, int y) {

	//workaround vis in different script but toggled here
	if(system.getstatus() == STATUS_PLAYING)
	{
		System.pause();
	}

}

visualsbut.onLeftButtonUp(int x, int y) {

	if(visdisplay) {
		visdisplay = 0;
		changedispvis(0);
		setPrivateInt(SKIN_NAME, "visdisplay", 0);
	} else {
		visdisplay = 1;
		changedispvis(1);
		setPrivateInt(SKIN_NAME, "visdisplay", 1);
	}

	//workaround vis in different script but toggled here
	if(system.getstatus() == STATUS_PAUSED || system.getstatus() == STATUS_STOPPED)
	{
		System.play();
	}

}



cbuts.onTargetReached() {
	if(cbuts.getAlpha() == 0) {
		cbuts.hide();
		cbuts.setXmlParam("ghost", "0");

		if(!visdisplay) fadeinout(disp, 255, 1);
		else fadeinout(visanim, 255, 1);
	} else {
		hold.setdelay(disphold);
		hold.start();
	}
}

disp.onTargetReached() {
	if((disp.getAlpha() == 0) && visdisplay) {
		disp.hide();
		fadeinout(visanim, 255, 1);


	} else if(disp.getAlpha() == 0) {
		fadeinout(cbuts, 255, 1);

	}
}

visanim.onTargetReached() {
	if((visanim.getAlpha() == 0) && !visdisplay) {
		visanim.hide();
		fadeinout(disp, 255, 1);
	} else if(visanim.getAlpha() == 0) {
		fadeinout(cbuts, 255, 1);
	}
}

changedispvis(boolean d) {
	if(d) {
		fadeinout(disp, 0, 1);
	} else {
		fadeinout(visanim, 0, 1);
	}
}

changedisplay(boolean d) {
	if(d && !visdisplay) {
		fadeinout(disp, 0, 1);
	} else if(d && visdisplay) {
		fadeinout(visanim, 0, 1);
	} else {
		fadeinout(cbuts, 0, 1);
	}
}

fadeinout(guiobject g, int alph, int speed) {
	g.show();
	g.setTargetA(alph);
	g.setTargetSpeed(0.4);
	g.gotoTarget();
}

parentLayout.onEndMove() 
{
	if (parentLayout.isVisible()) 
	{

		//debug(strlayout);

    		setPrivateInt(getSkinName(), newlayoutPrivateInt+"_X", parentLayout.getLeft());
    		setPrivateInt(getSkinName(), newlayoutPrivateInt+"_Y", parentLayout.getTop());
  	}
}

winshade.onEndMove() 
{
	if (winshade.isVisible()) 
	{
    		setPrivateInt(getSkinName(), newlayoutPrivateInt+"_X", parentLayout.getLeft());
    		setPrivateInt(getSkinName(), newlayoutPrivateInt+"_Y", parentLayout.getTop());
  	}
}




parentContainer.onSwitchToLayout(layout newlayout) {

	newlayoutPrivateInt = parentContainer.getID()+"_"+newlayout.getID();
	strlayout = newlayout.getID();
	parentLayout = newlayout;
//debug(strlayout);
  	int newlayoutx = getPrivateInt(getSkinName(), newlayoutPrivateInt+"_X", 0);
  	int newlayouty = getPrivateInt(getSkinName(), newlayoutPrivateInt+"_Y", 0);

  	newlayout.resize(newlayoutx, newlayouty, newlayout.getWidth(), newlayout.getHeight());
}
