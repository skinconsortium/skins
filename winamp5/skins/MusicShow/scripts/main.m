/*************************************************************

	main.m
	by leechbite.com
	
	main script. handles focus bg.

*************************************************************/

#include <lib/std.mi>

Global layout main, focus;

Global layer focusbg;
Global togglebutton buttonFocus;

Global vis vis1, vis2;
Global layer vismousetrap;

System.onScriptLoaded() {
	
	main = getContainer("main").getLayout("normal");
	focus = getContainer("focus").getLayout("normal");
	
	buttonFocus = main.findObject("main.button.focus");
	
	vis1 = main.findObject("main.vis");
	vis2 = main.findObject("main.vis.refl");
	vismousetrap = main.findObject("main.vis.mousetrap");
	
	focusbg = focus.findObject("focus.bg");
	focusbg.hide();
	focus.resize(0,0, getMonitorWidth(), getMonitorHeight());
	
}

System.onScriptUnloading() {
  return;
}

buttonFocus.onActivate(int on) {
	if (on) {
		focusbg.show();

		focus.setScale(1.0);
		focus.resize(0,0, getMonitorWidth(), getMonitorHeight());

	} else {
		focusbg.hide();
	}

}

focusbg.onLeftButtonDown(int x, int y) {
	buttonFocus.setActivated(0);
}

vismousetrap.onLeftButtonDown(int x, int y) {
	vis1.nextMode();
	
	vis2.setMode(vis1.getMode());
}