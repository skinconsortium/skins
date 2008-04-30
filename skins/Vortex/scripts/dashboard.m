/*---------------------------------------------------
-----------------------------------------------------
Filename:	dashboard.m

Type:		maki/source
Version:	skin version 1.2
Date:		10:11 30.08.2004
Author:		Martin P. alias Deimos
E-Mail:		martin.deimos@gmx.de
Internet:	www.martin.deimos.de.vu
-----------------------------------------------------
--------------------INCLUDES-------------------------
-Cover Art
-----------------------------------------------------
----------------------NOTE---------------------------
I've written all the script on my own. I was only
inspired by other ones, but I never copied a whole
script or parts of it! 'Cause everyone has to learn
or inspire I implement the source files too.
But if you use parts or the entire script, mail me:
Give me your name, write a little text about your
skin and a skinshot! Then leave my header in the .m
file and implement it in your skin and leave credit
to my name, email and homepage where credit is done!
THX! Deimos
-----------------------------------------------------
---------------------------------------------------*/
#include "../../../lib/std.mi"
#include "../../../lib/exd.mi"
#include "attribs.m"

#define FILENAME "dashboard.m"
#include "../wasabi/ripprotection.mi"

#define GUID_PL "{45F3F7C1-A6F3-4EE6-A15E-125E92FC3F8D}"

Class Group DBComp;
Class Button DBC_drag;
Class Button DBC_menu;

Function fade(GuiObject obj, float speed, int alpha);
Function reloadSongticker();
Function ComponentInit();
Function SetComponent(Group _group, String _private);
Function ProcessDBCMenuResult(int a);
Function string setDBCString();
Function DBComp loadDBC(int count);
Function Boolean DBC_MoveCheck(int i);
Function buildDashBoard();
Function initDBC_H();
Function countDBCs();

Function String LongDate();

Global Layout _layout, _main_normal;
Global Group PlayerDisplay, PlayerContent;
Global Text t_Songtime, t_Status, t_Songticker;
Global Int i_plH;
Global String startup = "";

Global PopupMenu menu_DBC;

Global DBC_drag btn_DBC_cover, btn_DBC_google, btn_DBC_vis, btn_DBC_playlist, btn_DBC_time;

Global DBComp DBCtoDrag, DBConDrag, dbc_cover, dbc_google, dbc_vis, dbc_playlist, dbc_time;
Global DBC_menu dm_cover, dm_google, dm_playlist, dm_vis;
Global Int dragging = 0;
Global Int dragY, downY, visibleDBCs = 0;
Global Layer ident, ident2;
Global String DBCstring;

Global Timer tmr_dte, tmr_st, tmr_set;
Global Text txt_date, txt_time;

Global Button btn_google;
Global Edit e_google;
Global boolean change = 0;
Global Boolean voling = 0;

Global int lasth;

Global Text t_artist, t_title, t_dummy;

Global layer d;

System.onScriptLoaded() {
	initAttribs();

	_layout = System.getContainer("main").getLayout("dashboard");

	tmr_set = new Timer;
	tmr_set.setDelay(1000);

	PlayerDisplay = _layout.findObject("player.dashboard.display");
	int x = getPrivateInt("Deimos/Vortex/Dashboard/", "GuiX", 0);
//	_layout.resize(x, 0, 180, getViewPortHeight());
	_layout.setXMLParam("y", integerToString(0));
	_layout.setXMLParam("x", integerToString(x));
	_layout.setXMLParam("h", integerToString(getViewPortHeight()/_layout.getScale()));


	dbc_time = _layout.findObject("dbc/time");

	txt_date = dbc_time.getObject("date");
//	txt_date.setText(setLongDateString());

	txt_time = dbc_time.getObject("time");
	txt_time.setText(dateToLongTime(getDate()));

	tmr_dte = new Timer;
	tmr_dte.setDelay(1000);
	tmr_st = new Timer;
	tmr_st.setDelay(1000);


	ComponentInit();

	e_google = dbc_google.findObject("search");
	e_google.setAutoEnter(0);

	btn_google = dbc_google.findObject("go");

	t_dummy = _layout.findObject("Songticker");
	t_artist = _layout.findObject("Songticker1");
	t_title = _layout.findObject("Songticker2");

//	reloadSongticker();

	ripProtection();
}

System.onScriptUnloading() {
	setPublicString("Deimos/Vortex/Dashboard/_DBCString", DBCstring);
	setPublicInt("Deimos/Vortex/Dashboard/_GuiX", _layout.getGuiX());
}

reloadSongTicker() {
	string sartist = System.getPlayItemMetaDataString("artist");
	string stitle = System.getPlayItemMetaDataString("title");

	if (stitle == "") stitle == "  ";

	t_artist.setText(sartist);
	t_title.setText(stitle);

}
/*
system.onPlay() { reloadSongTicker(); }
system.onTitleChange(string n) { reloadSongTicker(); }
system.onTitle2Change(string n) { reloadSongTicker(); }
system.onResume() { reloadSongTicker(); }*/
System.onVolumeChanged(int newvol) {
	int relvol = newvol / 2.55;
	t_artist.setText("Volume: " + System.integerToString(relvol)+ "%");
//	tmr_st.start();
}/*
tmr_st.onTimer() {
	reloadSongTicker();
	stop();
}*/

_layout.onSetVisible(int v) {
	if (v) {
		int x = getPrivateInt("Deimos/Vortex/Dashboard/", "GuiX", 0);
		_layout.setXMLParam("y", integerToString(0));
		_layout.setXMLParam("x", integerToString(x));
		_layout.setXMLParam("h", integerToString(getViewPortHeight()/_layout.getScale()));
	//	tmr_set.start();
	} else { 
		setPublicInt("Deimos/Vortex/Dashboard/_GuiX", _layout.getGuiX());
		tmr_set.stop();
	}
}


dbc_time.onSetVisible(int v) {
	if (v == 1) {
		tmr_dte.start();
	} else tmr_dte.stop();
}

tmr_dte.onTimer() {
	txt_time.setText(dateToLongTime(getDate()));
	txt_date.setText(longDate());
	if (txt_date.getTextWidth() > txt_date.getGuiW() - 18) {
		string s = txt_date.getText();
		string l = strleft(s, 2);
		s = cutString(s, strleft(s, strsearch(s, ",")));
		txt_date.setText(l + s);
	}
}

btn_google.onLeftClick() {
	e_google.onEnter();
}
e_google.onEnter() {
	string searchstring = getText();
	System.navigateURL("http:\\www.google.com\search?q=" + searchstring);
}

/*- Components -*/

ComponentInit() {
	dbc_cover = _layout.findObject("dbc/cover");
	dbc_google = _layout.findObject("dbc/google");
	dbc_playlist = _layout.findObject("dbc/playlist");
	dbc_vis = _layout.findObject("dbc/vis");
	dbc_time = _layout.findObject("dbc/time");

	DBCstring = getPrivateString("Deimos/Vortex/Dashboard/", "DBCString", "dbc/playlist,dbc/cover,dbc/google,");
//	DBCstring = "dbc/playlist,dbc/cover,dbc/google,";
//	visibleDBCs = getPrivateInt("Deimos/Vortex/Dashboard/", "visibleDBCs", 3);

	dm_cover = dbc_cover.findObject("menu");
	dm_google = dbc_google.findObject("menu");
	dm_playlist = dbc_playlist.findObject("menu");
	dm_vis = dbc_vis.findObject("menu");

	menu_DBC = new PopupMenu;
	menu_DBC.addCommand("Dashboard Components", 666, 0, 1);
	menu_DBC.addSeparator();
	menu_DBC.addCommand("Show Cover", 1, stringToInteger(dashboard_cover_attrib.getData()), 0);
	menu_DBC.addCommand("Show Visualization", 2, stringToInteger(dashboard_vis_attrib.getData()), 0);
	menu_DBC.addCommand("Show Google Search", 3, stringToInteger(dashboard_google_attrib.getData()), 0);

	ident = _layout.findObject("ident");
	ident2 = _layout.findObject("ident2");
	btn_DBC_cover = dbc_cover.findObject("drag.dbc/cover");
	btn_DBC_playlist = dbc_playlist.findObject("drag.dbc/playlist");
	btn_DBC_google = dbc_playlist.findObject("drag.dbc/google");
	btn_DBC_vis = dbc_playlist.findObject("drag.dbc/vis");
	btn_DBC_time = dbc_time.findObject("drag.dbc/time");

	lasth = _layout.getGuiH();

	initDBC_H();
//	tmr_set.start();

	startup = "OK";
}

_layout.onScale(Double newscalevalue) {
	if (startup != "OK" || !isVisible()) return;
//	_layout.resize(getGuix(), getGuiY(), 180, getViewPortHeight()/newscalevalue);
	_layout.setXMLParam("h", integerToString(getViewPortHeight()/newscalevalue));
	_layout.setXMLParam("y", integerToString(0));
	initDBC_H();
}
tmr_set.onTimer() {
	int h = _layout.getGuiH();
	if (lasth == h) return;
	else if (startup == "OK") {
		lasth = h;
		initDBC_H();

	}
}	

initDBC_H() {
	i_plH = _layout.getGuiH() - 205 - 35 - 5;
	boolean m = 0;
	change = 1;

	if (i_plH - dbc_cover.getGuiH() - 5 < 100) {
		dashboard_cover_attrib.setData("0");
		menu_DBC.checkCommand(1, 0);
		DBCstring = cutString(DBCString, dbc_cover.getID() + ",");
		if (!m && _layout.isVisible()) messageBox("Your screen resolution is too small to display all dashboard components\nSome components will be hidden!" , "ERROR", 1, "");
		m = 1;
	}
	if (dashboard_cover_attrib.getData() == "1" ) {
		i_plH = i_plH - dbc_cover.getGuiH() - 5;
		dbc_cover.show();
	} else dbc_cover.hide();


	if (i_plH - dbc_google.getGuiH() - 5 < 100) {
		dashboard_google_attrib.setData("0");
		menu_DBC.checkCommand(3, 0);
		DBCstring = cutString(DBCString, dbc_google.getID() + ",");
		if (!m && _layout.isVisible()) messageBox("Your screen resolution is too small to display all dashboard components\nSome components will be hidden!" , "ERROR", 1, "");
		m = 1;
	}
	if (dashboard_google_attrib.getData() == "1" ) {
		i_plH = i_plH - dbc_google.getGuiH() - 5;
		dbc_google.show();
	} else dbc_google.hide();


	if (i_plH - dbc_vis.getGuiH() - 5 < 100) {
		dashboard_vis_attrib.setData("0");
		menu_DBC.checkCommand(2, 0);
		DBCstring = cutString(DBCString, dbc_vis.getID() + ",");
		if (!m && _layout.isVisible()) messageBox("Your screen resolution is too small to display all dashboard components\nSome components will be hidden!" , "ERROR", 1, "");
		m = 1;
	}
	if (dashboard_vis_attrib.getData() == "1" ) {
		i_plH = i_plH - dbc_vis.getGuiH() - 5;
		dbc_vis.show();
	} else dbc_vis.hide();

	change = 0;

	dbc_playlist.setXMLParam("h", integerToString(i_plH));

	if (startup == "OK") {
		DBCString = setDBCString();	
	}
	buildDashBoard();
}

dashboard_cover_attrib.onDataChanged() {
	if (startup != "OK") return;
	if (change) return;
	if (getData() == "1") {
		dbc_cover.setXmlParam("y", integerToString(_layout.getGuiH()));
		menu_DBC.checkCommand(1, 1);
	} else {
		DBCString = cutString(DBCString, dbc_cover.getID() + ",");
		menu_DBC.checkCommand(1, 0);
	}
	initDBC_H();
}

dashboard_google_attrib.onDataChanged() {
	if (startup != "OK") return;
	if (change) return;
	if (getData() == "1") {
		dbc_google.setXmlParam("y", integerToString(_layout.getGuiH()));
		menu_DBC.checkCommand(3, 1);
	} else {
		DBCString = cutString(DBCString, dbc_google.getID() + ",");
		menu_DBC.checkCommand(3, 0);
	}
	initDBC_H();

}

dashboard_vis_attrib.onDataChanged() {
	if (startup != "OK") return;
	if (change) return;
	if (getData() == "1") {
		dbc_vis.setXmlParam("y", integerToString(_layout.getGuiH()));
		menu_DBC.checkCommand(2, 1);
	} else {
		DBCString = cutString(DBCString, dbc_vis.getID() + ",");
		menu_DBC.checkCommand(2, 0);
	}
	initDBC_H();

}

DBC_menu.onLeftButtonUp(int x, int y) {
	ProcessDBCMenuResult(menu_DBC.popAtMouse());
	complete;
}

ProcessDBCMenuResult(int a) {
	if(a > 0) {
		if (a == 1) {
			if (dashboard_cover_attrib.getData() == "1") {
				dashboard_cover_attrib.setData("0");			
			} else dashboard_cover_attrib.setData("1");
		}
		if (a == 2) {
			if (dashboard_vis_attrib.getData() == "1") {
				dashboard_vis_attrib.setData("0");			
			} else dashboard_vis_attrib.setData("1");
		}
		if (a == 3) {
			if (dashboard_google_attrib.getData() == "1") {
				dashboard_google_attrib.setData("0");			
			} else dashboard_google_attrib.setData("1");
		}
	}
}

DBC_drag.onLeftButtonDown(int x, int y) {
	if (dragging) return;
	if (DBC_drag == btn_DBC_time) return;
	dragging = 1;
	downY = y;
	DBCtoDrag = _layout.getObject(getToken(DBC_drag.getID(), ".", 1));
}
DBC_drag.onLeftButtonUp(int x, int y) {
	ident.hide();
	ident2.hide();
	if (dragging == 2) {
		dragging = 0;
		if (DBCtoDrag == DBConDrag || visibleDBCs == 1) return;
		if (DBConDrag == DBC_time) {
			string s = cutString(DBCString, DBCtoDrag.getID() + ",");
			DBCString = s + DBCtoDrag.getID() + ",";
		} else DBCString = fillStringBefore(cutString(DBCString, DBCtoDrag.getID() + ","), DBCtoDrag.getID() + ",", DBConDrag.getID());
		buildDashBoard();
	}
	dragging = 0;
}

DBC_drag.onMouseMove(int x, int y) {
	if (dragging == 0) {
		ident.hide();
		ident2.hide();
		return;
	}
	dragY = y;
	ident.setXMLParam("y", integerToString(y));
	ident2.setXMLParam("y", integerToString(y));
	int i = 0;
	if (DBC_MoveCheck(i)) return;
	i++;
	if (i < visibleDBCs) if (DBC_MoveCheck(i)) return;
	i++;
	if (i < visibleDBCs) if (DBC_MoveCheck(i)) return;
	ident.show();
	ident2.hide();
	dragging = 1;
}

String setDBCString() {
	int y_pl = dbc_playlist.getGuiY();
	int y_cover = dbc_cover.getGuiY();
	int y_google = dbc_google.getGuiY();
	int y_vis = dbc_vis.getGuiY();
	visibleDBCs = 0;
	string _dbcs;
	if (dbc_playlist.isVisible()) {

		_dbcs = dbc_playlist.getID() + ",";
		visibleDBCs++;
	}
	if (dbc_cover.isVisible()) {
		
		if (DBCstring == "") _dbcs = dbc_cover.getID() + ",";
		else if (y_pl > y_cover) _dbcs = dbc_cover.getID() + "," + _dbcs;
		else _dbcs = _dbcs + dbc_cover.getID() + ",";
		visibleDBCs++;
	}
	if (dbc_google.isVisible()) {
		
		if (DBCstring == "") _dbcs = dbc_google.getID() + ",";
		else if (y_pl > y_google && y_cover > y_google) _dbcs = dbc_google.getID() + "," + _dbcs;
		else if (y_pl > y_google && y_cover < y_google) _dbcs = fillStringBefore(_dbcs, dbc_google.getID() + ",", dbc_playlist.getID());
		else if (y_pl < y_google && y_cover > y_google) _dbcs = fillStringBefore(_dbcs, dbc_google.getID() + ",", dbc_playlist.getID());
		else if (y_pl < y_google && y_cover < y_google) _dbcs = _dbcs + dbc_google.getID() + ",";
		visibleDBCs++;
	}
	if (dbc_vis.isVisible()) {
		
		if (DBCstring == "") _dbcs = dbc_vis.getID() + ",";
		else if (y_vis == 205) _dbcs = dbc_vis.getID() + "," + _dbcs;
		else if (y_vis == y_pl - dbc_vis.getGuiH() - 5) _dbcs = fillStringBefore(_dbcs, dbc_vis.getID() + ",", dbc_playlist.getID());
		else if (y_vis == y_google - dbc_vis.getGuiH() - 5) _dbcs = fillStringBefore(_dbcs, dbc_vis.getID() + ",", dbc_google.getID());
		else if (y_vis == y_cover - dbc_vis.getGuiH() - 5) _dbcs = fillStringBefore(_dbcs, dbc_vis.getID() + ",", dbc_cover.getID());
		else _dbcs = _dbcs + dbc_vis.getID() + ",";
		visibleDBCs++;
	}
	return _dbcs;
}

countDBCs() {
	visibleDBCs = 0;
	if (strsearch(DBCString, dbc_cover.getID()) != -1) {
		visibleDBCs++;
	}
	if (strsearch(DBCString, dbc_playlist.getID()) != -1) {
		visibleDBCs++;
	}
	if (strsearch(DBCString, dbc_google.getID()) != -1) {
		visibleDBCs++;
	}
	if (strsearch(DBCString, dbc_vis.getID()) != -1) {
		visibleDBCs++;
	}
}

DBComp loadDBC(int count) {
	if (count == -1) return dbc_time;
	string strid = getToken(DBCString, ",", count);
	DBComp d = _layout.findObject(strid);
	return d;
}

DBC_MoveCheck(int i) {
	int _y;
/*	if (count == -1) _y = _layout.getGuiH() - 40;
	else */_y = loadDBC(i).getGuiY();
	if (!_y) return 0;
	if (dragY > _y - 5 && _y + 15 > dragY || dragY > _layout.getGuiH() - 40 - 5 && _layout.getGuiH() - 40 + 10 > dragY) {
		if (downY > _y - 5 && _y + 10 > downY) return 0;
		ident.hide();
		ident2.show();
		dragging = 2;
		if (dragY > _layout.getGuiH() - 40 - 5 && _layout.getGuiH() - 40 + 10 > dragY) DBConDrag = loadDBC(-1);
		else DBConDrag = loadDBC(i);
		return 1;
	} else return 0;
}
buildDashBoard() {
	countDBCs();
//	messageBox(DBCString , "Restore standard values", 12, "");
	int i = 0;
	DBComp d = loadDBC(0);
	if (d) d.setXmlParam("y", "205");
	i++;
	if (visibleDBCs == 1) return;
	DBComp d = loadDBC(i);
	if (d) d.setXmlParam("y", integerToString(loadDBC(i-1).getGuiY() + loadDBC(i-1).getGuiH() + 5));
	i++;
	if (visibleDBCs == 2) return;
	DBComp d = loadDBC(i);
	if (d) d.setXmlParam("y", integerToString(loadDBC(i-1).getGuiY() + loadDBC(i-1).getGuiH() + 5));
	i++;
	if (visibleDBCs == 3) return;
	DBComp d = loadDBC(i);
	if (d) d.setXmlParam("y", integerToString(loadDBC(i-1).getGuiY() + loadDBC(i-1).getGuiH() + 5));
}

fade(GuiObject obj, float speed, int alpha) {
	if (!obj) return;
	obj.setTargetSpeed(speed);
	obj.setTargetA(alpha);
	obj.gotoTarget();
}

String LongDate() {
	string s = formatLongDate(getDate());
	return strLeft(s, strlen(s) - 9);
}