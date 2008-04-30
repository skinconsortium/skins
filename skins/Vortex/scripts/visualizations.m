// ====================================================
//
// Flow :: visualizations.m
// 
// Last updated by krckoorascic
// on 6/2/05
//
// edited by Martin Poehlmann aka Deimos
// edited by SLoB to add in new layerFX
// ====================================================

Function setVis(int v);

#define VIS_ATTRIBS_MGR
#include "../../../lib/std.mi"
#include "attribs.m"

Function setMirrors(int mode);
Function ProcessMenuResult(int a);

Global Vis classic, mirror, tclassic, tmirror;
Global AnimatedLayer anim;
Global Layer switcher, lyrFx, vortexlogo;
Global Int curVis;
Global Timer update;
Global Double dUFOVu, dp, tp, dx, dy, dR;
Global popupmenu menu;
Global PopUpMenu specmenu;
Global PopUpMenu oscmenu;
Global PopUpMenu mirmenu;
Global PopUpMenu animmenu;
Global PopUpMenu fxmenu;
Global PopUpMenu pksmenu;
Global PopUpMenu anamenu;
Global PopUpMenu stylemenu;

System.onScriptLoaded()
{
	initAttribs();
	Group grp = getScriptGroup();
	if (grp == NULL) return;
	
// what the hell does this call? you get gurus on low resz!
//	if (System.getViewPortWidth() < 900) return; //look in init.m

	classic = grp.findObject("vis");
	mirror = grp.findObject("vis.mirror");
	anim = grp.findObject("vis.anim");
	tclassic = grp.findObject("tvis");
	tmirror = grp.findObject("tvis.mirror");
	anim = grp.findObject("vis.anim");
	switcher = grp.findObject("vis.mousetrap");

	lyrFx = grp.findObject("vortexlfx");
	vortexlogo = grp.findObject("vortexlogo");

	curVis = stringToInteger(vis_mode_attrib.getData());

	lyrFx.fx_setBgFx(0);
  	lyrFx.fx_setWrap(0);
  	lyrFx.fx_setBilinear(1);
  	lyrFx.fx_setAlphaMode(1);
  	lyrFx.fx_setGridSize(6,6);
  	lyrFx.fx_setRect(0);
	lyrFx.fx_setClear(1);
  	lyrFx.fx_setLocalized(1);
  	lyrFx.fx_setRealtime(1);
  	lyrFx.fx_setSpeed(70);
  	lyrFx.setAlpha(180);

	dUFOVu = 0.0;
  	dp = 0.1;
  	tp = 0.1;

	lyrFx.hide();
	lyrFx.fx_setEnabled(0);
	vortexlogo.hide();

	switcher.show();

	update = New Timer;
	update.setDelay(25);

	vis_peaks_attrib.onDataChanged();
	vis_peaksfalloff_attrib.onDataChanged();
	vis_analyzerfalloff_attrib.onDataChanged();
	vis_analyzerstyle_attrib.onDataChanged();
	setVis(stringToInteger(vis_mode_attrib.getData()));
}

System.onScriptUnloading()
{
	if (update != NULL)	/*	if ViewPortWidth < 900	*/
		{
			update.stop();
			delete update;
		}

}


lyrFx.fx_onFrame() {

  	dp = dp + 0.1;
  	tp = tp + 0.3;

  	dUFOVu =  ((((System.getLeftVuMeter() + System.getRightVuMeter()) / 2)) / 350);
	if(tp>33)tp=0.3;
	if(dp>20)dp=0.1;

}


//depth
lyrFx.fx_onGetPixelD(double r, double d, double x, double y) {

	if (curVis==12)
	{
		dx=1.5-sin(tp+x);
		dy=sin(dp+y);	
		dR=d*(dx+dy*dUFOVu/6); //rebound
	}

	if (curVis==13)
	{
		x = x * cos( tp ) - y * sin( dp ); // }
        	y = y * cos( tp ) + x * sin( dp ); //	> punch out effect
		dR = d - atan2(x, y) * (dUFOVu/4); // }
	}	

	if (curVis==14)
	{
		x = y * cos(tp) + x * sin(dp); //		 > 3d ball type pulsating to and fro
		dR = d * atan2((dp-x) , sin(tp-y)) * (dUFOVu*4); // } 
	}

	if (curVis==15)
	{
		x=sin(d)*sin(dp);
		y=cos(d)*cos(dp);
		dR= sin(x) + cos(y) * (dUFOVu/1.4);
	}

	return dR;

}


setVis(int v)
{

  //  messageBox(vis_mode_attrib.getData(), "", 1, "");
	if (v == 100 || v == 0)
		{
			v = 0;
			classic.hide();
			mirror.hide();
			tmirror.hide();
			tclassic.hide();
			anim.hide();
			update.stop();
			lyrFX.hide();
			lyrFx.fx_setEnabled(0);
			vortexlogo.show();
		}
	else if (v > 0 && v < 9)
		{
			anim.hide();
			setMirrors(v);
			update.stop();
			lyrFX.hide();
			vortexlogo.hide();
			lyrFx.fx_setEnabled(0);
		}
	else if (v > 8 && v < 12)
		{
			tmirror.hide();
			tclassic.hide();
			classic.hide();
			mirror.hide();
			lyrFX.hide();
			vortexlogo.hide();
			lyrFx.fx_setEnabled(0);
			anim.show();
			anim.setXMLParam("image", "animvis" + integerToString(v - 8));
			update.start();
		}
	else if (v >= 12 && v <= 15)
		{
			classic.hide();
			mirror.hide();
			tmirror.hide();
			tclassic.hide();
			update.stop();
			anim.hide();
			vortexlogo.hide();
			lyrFX.show();
			lyrFx.fx_setEnabled(1);
		}
	else return;//menu.popAtMouse() will return -1 if not clicked on something
	curVis = v;
//	vis_mode_attrib.setData(integerToString(curVis);
}

setMirrors(int mode)
{
	vortexlogo.hide();

  if (mode == 1)
  {
	mirror.hide();
	classic.setXMLParam("h", "48");
	tclassic.setXMLParam("h", "24");
	classic.show();
	classic.setMode(1);
	tmirror.hide();
	tclassic.hide();
  }
  else if (mode == 2)
  {
	mirror.hide();
	classic.setXMLParam("h", "48");
	tclassic.setXMLParam("h", "48");
	tclassic.show();
	classic.setMode(1);
	tmirror.hide();
	classic.hide();
  }
  else if (mode == 3)
  {
	mirror.hide();
	classic.setXMLParam("h", "48");
	classic.show();
	classic.setMode(2);
	classic.setXMLParam("oscstyle", "solid");
	tmirror.hide();
	tclassic.hide();
  }
  else if (mode == 4)
  {
	mirror.hide();
	classic.setXMLParam("h", "48");
	classic.show();
	classic.setMode(2);
	classic.setXMLParam("oscstyle", "dots");
	tmirror.hide();
	tclassic.hide();
  }
  else if (mode == 5)
  {
	mirror.hide();
	classic.setXMLParam("h", "48");
	classic.show();
	classic.setMode(2);
	classic.setXMLParam("oscstyle", "lines");
	tmirror.hide();
	tclassic.hide();
  }
  else if (mode == 6)
  {
	classic.setXMLParam("h", "24");
	tclassic.setXMLParam("h", "24");
	mirror.show();
	classic.show();
	mirror.setMode(1);
	classic.setMode(1);
	tmirror.hide();
	tclassic.hide();
  }
  else if (mode == 7)
  {
	classic.setXMLParam("h", "24");
	tclassic.setXMLParam("h", "24");
	tmirror.show();
	tclassic.show();
	mirror.setMode(1);
	classic.setMode(1);
	mirror.hide();
	classic.hide();
  }
  else if (mode == 8)
  {
	classic.setXMLParam("h", "24");
	mirror.show();
	classic.show();
	mirror.setMode(2);
	classic.setMode(2);
	classic.setXMLParam("oscstyle", "solid");
	mirror.setXMLParam("oscstyle", "solid");
	tmirror.hide();
	tclassic.hide();
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
	//lyrFx.fx_setEnabled(0);
}

System.onPause()
{
	update.stop();
	//lyrFx.fx_setEnabled(0);
}

System.onPlay()
{
	if (curVis > 8 && curVis < 12) update.start();
	if (curVis > 11 && curVis <16) lyrFx.fx_setEnabled(1);
}

System.onResume()
{
	if (curVis > 8 && curVis < 12) update.start();
	if (curVis > 11 && curVis <16) lyrFx.fx_setEnabled(1);
}

switcher.onLeftButtonUp(int x, int y)
{
	curVis++;
	vis_mode_attrib.setData(integerToString(curVis));
	if (curVis > 15) {
		vortexlogo.hide();
		curVis = 0;
	}

	if(curVis == 0){
		vortexlogo.show();
	}
}

switcher.onRightButtonUp(int x, int y)
{
	menu = new PopUpMenu;
	specmenu = new PopUpMenu;
	oscmenu = new PopUpMenu;
	mirmenu = new PopUpMenu;
	animmenu = new PopUpMenu;
	fxmenu = new PopUpMenu;
	pksmenu = new PopUpMenu;
	anamenu = new PopUpMenu;
	stylemenu = new PopUpMenu;

	menu.addCommand("Presets:", 999, 0, 1);
	menu.addCommand("No Visualization", 100, curVis == 0, 0);
	specmenu.addCommand("Thick Bands", 1, curVis == 1, 0);
	specmenu.addCommand("Thin Bands", 2, curVis == 2, 0);
	menu.addSubMenu(specmenu, "Spectrum Analyzer");

	oscmenu.addCommand("Solid", 3, curVis == 3, 0);
	oscmenu.addCommand("Dots", 4, curVis == 4, 0);
	oscmenu.addCommand("Lines", 5, curVis == 5, 0);
	menu.addSubMenu(oscmenu, "Oscilloscope");

	mirmenu.addCommand("Thick Analyzer", 6, curVis == 6, 0);
	mirmenu.addCommand("Thin Analyzer", 7, curVis == 7, 0);
	mirmenu.addSeparator();
	mirmenu.addCommand("Oscilloscope", 8, curVis == 8, 0);
	menu.addSubMenu(mirmenu, "Mirrored");

	animmenu.addCommand(getToken(getParam(), ",", 0), 9, curVis == 9, 0);
	animmenu.addCommand(getToken(getParam(), ",", 1), 10, curVis == 10, 0);
	animmenu.addCommand(getToken(getParam(), ",", 2), 11, curVis == 11, 0);
	menu.addSubMenu(animmenu, "Animation");

	fxmenu.addCommand("Globe Rebound", 12, curVis == 12, 0);
	fxmenu.addCommand("Globe Let Me Out", 13, curVis == 13, 0);
	fxmenu.addCommand("Globe Floater", 14, curVis == 14, 0);
	fxmenu.addCommand("Globe Vortex", 15, curVis == 15, 0);
	menu.addSubMenu(fxmenu, "Layer FX");
	menu.addSeparator();
	menu.addCommand("Options:", 102, 0, 1);
	menu.addCommand("Show Peaks", 101, stringToInteger(vis_peaks_attrib.getData()), 0);
	pksmenu.addCommand("0", 200, vis_peaksfalloff_attrib.getData() == "0", 0);
	pksmenu.addCommand("1", 201, vis_peaksfalloff_attrib.getData() == "1", 0);
	pksmenu.addCommand("2", 202, vis_peaksfalloff_attrib.getData() == "2", 0);
	pksmenu.addCommand("3", 203, vis_peaksfalloff_attrib.getData() == "3", 0);
	pksmenu.addCommand("4", 204, vis_peaksfalloff_attrib.getData() == "4", 0);
	menu.addSubMenu(pksmenu, "Peak Falloff Speed");
	anamenu.addCommand("0 ", 300, vis_analyzerfalloff_attrib.getData() == "0", 0);
	anamenu.addCommand("1 ", 301, vis_analyzerfalloff_attrib.getData() == "1", 0);
	anamenu.addCommand("2 ", 302, vis_analyzerfalloff_attrib.getData() == "2", 0);
	anamenu.addCommand("3 ", 303, vis_analyzerfalloff_attrib.getData() == "3", 0);
	anamenu.addCommand("4 ", 304, vis_analyzerfalloff_attrib.getData() == "4", 0);
	menu.addSubMenu(anamenu, "Analyzer Falloff Speed");
	stylemenu.addCommand("Full", 400, vis_analyzerstyle_attrib.getData() == "0", 0);
	stylemenu.addCommand("Gradient", 401, vis_analyzerstyle_attrib.getData() == "1", 0);
	stylemenu.addCommand("Fire", 402, vis_analyzerstyle_attrib.getData() == "2", 0);
	stylemenu.addCommand("Line", 403, vis_analyzerstyle_attrib.getData() == "3", 0);
	menu.addSubMenu(stylemenu, "Analyzer Style");

	ProcessMenuResult(menu.popAtMouse());

	delete menu;
	delete specmenu;
	delete oscmenu;
	delete mirmenu;
	delete animmenu;
	delete fxmenu;
	delete pksmenu;
	delete anamenu;

	complete; //prevent right-click context menu from appearing
	//delete menu;
}

ProcessMenuResult(int a) {
	//bugfix: ensure a > 0
	if(a < 1) return;
	if(a > 0 && a < 20) {
		vis_mode_attrib.setData(integerToString(a));
	}
	else if (a == 100) {
		vis_mode_attrib.setData(integerToString(0));
	}
	else if (a == 101)
		{
			if (vis_peaks_attrib.getData() == "1") vis_peaks_attrib.setData("0");
			else vis_peaks_attrib.setData("1");
		}
	else if (a >= 200 && a <= 204)
		{
			vis_peaksfalloff_attrib.setData(integerToString(a-200));
		}
	else if (a >= 300 && a <= 304)
		{
			vis_analyzerfalloff_attrib.setData(integerToString(a-300));
		}
	else if (a >= 400 && a <= 403)
		{
			vis_analyzerstyle_attrib.setData(integerToString(a-400));
		}
}

vis_peaks_attrib.onDataChanged() {
	classic.setXMLParam("peaks", getData());
	mirror.setXMLParam("peaks", getData());
	tclassic.setXMLParam("peaks", getData());
	tmirror.setXMLParam("peaks", getData());
}
vis_peaksfalloff_attrib.onDataChanged() {
	classic.setXMLParam("peakfalloff", getData());
	mirror.setXMLParam("peakfalloff", getData());
	tclassic.setXMLParam("peakfalloff", getData());
	tmirror.setXMLParam("peakfalloff", getData());
}
vis_analyzerfalloff_attrib.onDataChanged() {
	classic.setXMLParam("falloff", getData());
	mirror.setXMLParam("falloff", getData());
	tclassic.setXMLParam("falloff", getData());
	tmirror.setXMLParam("falloff", getData());
}
vis_analyzerstyle_attrib.onDataChanged() {
	if (getData() == "0" || getData() == "1") {
		classic.setXMLParam("coloring", "normal");
		mirror.setXMLParam("coloring", "normal");
		tclassic.setXMLParam("coloring", "normal");
		tmirror.setXMLParam("coloring", "normal");
	} else if (getData() == "2") {
		classic.setXMLParam("coloring", "fire");
		mirror.setXMLParam("coloring", "fire");
		tclassic.setXMLParam("coloring", "fire");
		tmirror.setXMLParam("coloring", "fire");
	} else if (getData() == "3") {
		classic.setXMLParam("coloring", "line");
		mirror.setXMLParam("coloring", "line");
		tclassic.setXMLParam("coloring", "line");
		tmirror.setXMLParam("coloring", "line");
	}
	if (getData() == "0") {
		vis v;
		for ( int i = 0; i <= 3; i++ ) {
			if (i == 0) v = classic;
			if (i == 1) v = tclassic;
			if (i == 2) v = mirror;
			if (i == 3) v = tmirror;
		
			v.setXMLParam("colorband16", "46,189,210");
			v.setXMLParam("colorband15", "46,189,210");
			v.setXMLParam("colorband14", "46,189,210");
			v.setXMLParam("colorband13", "46,189,210");
			v.setXMLParam("colorband12", "46,189,210");
			v.setXMLParam("colorband11", "46,189,210");
			v.setXMLParam("colorband10", "46,189,210");
			v.setXMLParam("colorband9", "46,189,210");
			v.setXMLParam("colorband8", "46,189,210");
			v.setXMLParam("colorband7", "46,189,210");
			v.setXMLParam("colorband6", "46,189,210");
			v.setXMLParam("colorband5", "46,189,210");
			v.setXMLParam("colorband4", "46,189,210");
			v.setXMLParam("colorband3", "46,189,210");
			v.setXMLParam("colorband2", "46,189,210");
			v.setXMLParam("colorband1", "46,189,210");
		}
	} else {
		vis v;
		for ( int i = 0; i <= 3; i++ ) {
			if (i == 0) v = classic;
			if (i == 1) v = tclassic;
			if (i == 2) v = mirror;
			if (i == 3) v = tmirror;
		
			v.setXMLParam("colorband16", "46,189,210");
			v.setXMLParam("colorband15", "46,184,204");
			v.setXMLParam("colorband14", "46,177,197");
			v.setXMLParam("colorband13", "47,170,188");
			v.setXMLParam("colorband12", "47,161,178");
			v.setXMLParam("colorband11", "48,152,167");
			v.setXMLParam("colorband10", "49,142,156");
			v.setXMLParam("colorband9", "50,121,132");
			v.setXMLParam("colorband8", "50,110,119");
			v.setXMLParam("colorband7", "50,100,108");
			v.setXMLParam("colorband6", "51,91,96");
			v.setXMLParam("colorband5", "52,81,85");
			v.setXMLParam("colorband4", "52,72,75");
			v.setXMLParam("colorband3", "52,65,68");
			v.setXMLParam("colorband2", "53,58,59");
			v.setXMLParam("colorband1", "53,53,53");
		}
	
	}


}