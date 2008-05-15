// ====================================================
//
// Flow :: visualizations.m
// 
// Last updated by krckoorascic
// on 6/2/05
//
// ====================================================

#include <lib/std.mi>

Function setVis(int v);
Function setMirrors(int mode);

Global Vis classic, mirror;
Global AnimatedLayer anim;
Global Layer switcher;
Global Int curVis;
Global Timer update;

System.onScriptLoaded()
{
	Group grp = getScriptGroup();
	if (grp == NULL) return;
	
	if (System.getViewPortWidth() < 900) return; //look in init.m

	classic = grp.findObject("vis");
	mirror = grp.findObject("vis.mirror");
	anim = grp.findObject("vis.anim");
	switcher = grp.findObject("vis.mousetrap");
	switcher.show();

	update = New Timer;
	update.setDelay(25);

	setVis(System.getPrivateInt("Flow", "Last vis", 1));
}

System.onScriptUnloading()
{
	if (update != NULL)	/*	if ViewPortWidth < 900	*/
		{
			update.stop();
			delete update;
		}
}

setVis(int v)
{
	if (v == 0)
		{
			classic.hide();
			mirror.hide();
			anim.hide();
			update.stop();
		}
	else if (v > 0 && v < 5)
		{
			anim.hide();
			setMirrors(v);
			update.stop();
		}
	else if (v > 4 && v < 8)
		{
			classic.hide();
			mirror.hide();
			anim.show();
			anim.setXMLParam("image", "animvis" + integerToString(v - 4));
			update.start();
		}
	else return;	//menu.popAtMouse() will return -1 if not clicked on something

	curVis = v;
	System.setPrivateInt("Flow", "Last vis", v);
}

setMirrors(int mode)
{
	if (mode < 3)	/* spectrum analyzer || osciloscope */
		{
			mirror.hide();
			classic.setXMLParam("h", "52");
			classic.show();
			classic.setMode(mode);
		}
	else if (mode == 3)	/* Mirrored Analyzer */
		{
			classic.setXMLParam("h", "26");
			mirror.show();
			classic.show();
			mirror.setMode(1);
			classic.setMode(1);
		}
	else if (mode == 4)	/* Mirrored Osciloscope */
		{
			classic.setXMLParam("h", "26");
			mirror.show();
			classic.show();
			mirror.setMode(2);
			classic.setMode(2);
		}
}

update.onTimer()
{
	float f = (System.getLeftVUMeter() + System.getRightVUMeter()) / 510;
	anim.setStartFrame(anim.getCurFrame());
	anim.setEndFrame(f * (anim.getLength() - 1));
	anim.setSpeed(0.2);
	anim.play();
}

System.onStop()
{
	anim.gotoFrame(0);
	update.stop();
}

System.onPause()
{
	update.stop();
}

System.onPlay()
{
	if (curVis > 2) update.start();
}

System.onResume()
{
	if (curVis > 2) update.start();
}

switcher.onLeftButtonUp(int x, int y)
{
	curVis++;
	if (curVis > 7) curVis = 0;
	setVis(curVis);
}

switcher.onRightButtonUp(int x, int y)
{
	popupmenu menu = new PopUpMenu;
	menu.addCommand("Spectrum Analyzer", 1, curVis == 1, 0);
	menu.addCommand("Osciloscope", 2, curVis == 2, 0);
	menu.addSeparator();
	menu.addCommand("Mirrored Analyzer", 3, curVis == 3, 0);
	menu.addCommand("Mirrored Osciloscope", 4, curVis == 4, 0);
	menu.addSeparator();
	menu.addCommand(getToken(getParam(), ",", 0), 5, curVis == 5, 0);
	menu.addCommand(getToken(getParam(), ",", 1), 6, curVis == 6, 0);
	menu.addCommand(getToken(getParam(), ",", 2), 7, curVis == 7, 0);
	menu.addSeparator();
	menu.addCommand("No Visualization", 0, curVis == 0, 0);
	setVis(menu.popAtMouse());
	complete; //prevent right-click context menu from appearing
	delete menu;
}