/*---------------------------------------------------
-----------------------------------------------------
Filename:	visualizer.m

Type:		maki/source
Version:	skin version 1.2
Date:		17:39 21.02.2005
Author:		Martin P. alias Deimos
E-Mail:		martin.deimos@gmx.de
Internet:	www.martin.deimos.de.vu
-----------------------------------------------------
--------------------INCLUDES-------------------------
-SliderText
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

#include "../../../../lib/std.mi"
#define OWNVIS_ATTRIBS_MGR
#include "../../scripts/attribs.m"

#define FILENAME "visualizer.m"
#include "../../../../lib/ripprotection.mi"
Global Layer visover;

Global Vis visual;
Global Timer ClockTimer;
Global Group ClockGroup;
Global AnimatedLayer al_clock_m, al_clock_s, al_clock_h;

Global Group g_vis, g_vis4d_spec, g_vis4d_osc;

Global Int attribs_mychange;

Global AnimatedLayer al_vis;
Global Timer VisTimer, VisATimer;
Global Int i_Frames;
Global Int i_lastvu;

Global ConfigAttribute ca_speed, ca_mode, ca_over;

System.onScriptUnLoading() {
	delete ClockTimer;
	delete VisTimer;
	delete VisATimer;
}

System.onScriptLoaded() {
	initAttribs();
	Group XUIGroup = getScriptGroup();
	g_vis = XUIGroup.findObject("player.normal.display.vis");

	ClockGroup = g_vis.findObject("player.normal.display.clock");
	al_clock_h = ClockGroup.findObject("player.normal.display.clock.h");
	al_clock_m = ClockGroup.findObject("player.normal.display.clock.m");
	al_clock_s = ClockGroup.findObject("player.normal.display.clock.s");

	al_vis = g_vis.findObject("vis");
	g_vis4d_spec = g_vis.findObject("main.display.vis.4d");
	g_vis4d_osc = g_vis.findObject("main.display.vis.4dosc");

	visover = g_vis.findObject("player.normal.display.vis.overlay");
	visual = g_vis.findObject("visual");

	ClockTimer = new Timer;
	ClockTimer.setDelay(1000);

	ca_speed = Config.getItemByGuid("{E9C2D926-53CA-400f-9A4D-85E31755A4CF}").getAttribute("Visspeed");
	ca_mode = Config.getItemByGuid("{E9C2D926-53CA-400f-9A4D-85E31755A4CF}").getAttribute("Vismode");
	ca_over = Config.getItemByGuid("{9EF1EEA2-E07B-4062-9D46-CF5C771014D4}").getAttribute("Show LCD Overlay");

	VisTimer = new Timer;
	VisTimer.setDelay(stringToInteger(ca_speed.getData()) + 1);

	VisATimer = new Timer;
	VisATimer.setDelay(stringToInteger(ca_speed.getData()) + 1);

	ca_mode.onDataChanged();
	ca_over.onDataChanged();

	ripProtection("tristania");
}


ca_mode.onDataChanged() {
	if (ca_mode.getData() == "No Visualization") {
		ClockGroup.show();
		ClockTimer.onTimer();
		al_vis.hide();
		visual.hide();
		g_vis4d_spec.hide();
		g_vis4d_osc.hide();
		ClockTimer.start();
		VisATimer.stop();
		VisTimer.stop();
		visover.setXmlParam("image", "empty");
	} else if (ca_mode.getData() == "Spectrum Analyzer") {
		ClockGroup.hide();
		g_vis4d_spec.hide();
		g_vis4d_osc.hide();
		visual.setMode(1);
		visual.show();
		ClockTimer.stop();
		VisATimer.stop();
		VisTimer.stop();
		visual.show();
		al_vis.hide();
		visover.setXmlParam("image", "player.normal.display.vis.overlay.lin");
	} else if (ca_mode.getData() == "Oscilliscope") {
		ClockGroup.hide();
		g_vis4d_spec.hide();
		g_vis4d_osc.hide();
		visual.setMode(2);
		visual.show();
		ClockTimer.stop();
		VisATimer.stop();
		VisTimer.stop();
		visual.show();
		al_vis.hide();
		visover.setXmlParam("image", "player.normal.display.vis.overlay.lin");
	} else if (ca_mode.getData() == "4D Spectrum") {
		ClockGroup.hide();
		g_vis4d_spec.show();
		g_vis4d_osc.hide();
		visual.hide();
		ClockTimer.stop();
		VisATimer.stop();
		VisTimer.stop();
		al_vis.hide();
		visover.setXmlParam("image", "player.normal.display.vis.overlay.lin");
	} else if (ca_mode.getData() == "4D Oscilliscope") {
		ClockGroup.hide();
		g_vis4d_osc.show();
		g_vis4d_spec.hide();
		visual.hide();
		ClockTimer.stop();
		VisATimer.stop();
		VisTimer.stop();
		al_vis.hide();
		visover.setXmlParam("image", "player.normal.display.vis.overlay.lin");
	} else if (ca_mode.getData() == "Circle") {
		ClockGroup.hide();
		g_vis4d_spec.hide();
		g_vis4d_osc.hide();
		ClockTimer.stop();
		VisATimer.stop();
		al_vis.setXmlParam("image", "player.normal.display.vis.circle");
		i_Frames = al_vis.getLength() - 1;
		visual.hide();
		al_vis.show();
		VisTimer.start();
		visover.setXmlParam("image", "player.normal.display.vis.overlay.lcd");
	} else if (ca_mode.getData() == "SemiOrbit") {
		ClockGroup.hide();
		g_vis4d_spec.hide();
		g_vis4d_osc.hide();
		ClockTimer.stop();
		VisATimer.stop();
		al_vis.setXmlParam("image", "player.normal.display.vis.semiorbit");
		i_Frames = al_vis.getLength() - 1;
		visual.hide();
		al_vis.show();
		VisTimer.start();
		visover.setXmlParam("image", "player.normal.display.vis.overlay.lcd");
	} else if (ca_mode.getData() == "Lighting Bolt") {
		ClockGroup.hide();
		g_vis4d_spec.hide();
		g_vis4d_osc.hide();
		ClockTimer.stop();
		VisATimer.stop();
		al_vis.setXmlParam("image", "player.normal.display.vis.bolt");
		i_Frames = al_vis.getLength() - 1;
		visual.hide();
		al_vis.show();
		VisTimer.start();
		visover.setXmlParam("image", "player.normal.display.vis.overlay.lcd");
	} else if (ca_mode.getData() == "Rockin' Llamas") {
		ClockGroup.hide();
		g_vis4d_spec.hide();
		g_vis4d_osc.hide();
		ClockTimer.stop();
		VisATimer.stop();
		al_vis.setXmlParam("image", "player.normal.display.vis.llama");
		i_Frames = al_vis.getLength() - 1;
		visual.hide();
		al_vis.show();
		VisTimer.start();
		visover.setXmlParam("image", "player.normal.display.vis.overlay.lcd");
	} /*else if (ca_mode.getData() == "Dots") {
		ClockGroup.hide();
		ClockTimer.stop();
		al_vis.setXmlParam("image", "player.normal.display.vis.dots");
		visual.hide();
		al_vis.show();
		VisTimer.stop();
		VisATimer.start();
		visover.setXmlParam("image", "player.normal.display.vis.overlay.lcd");
	}*/
	else if (ca_mode.getData() == "Dots") {
		ClockGroup.hide();
		g_vis4d_spec.hide();
		g_vis4d_osc.hide();
		ClockTimer.stop();
		VisATimer.stop();
		al_vis.setXmlParam("image", "player.normal.display.vis.dots");
		i_Frames = al_vis.getLength() - 1;
		visual.hide();
		al_vis.show();
		VisTimer.start();
		visover.setXmlParam("image", "player.normal.display.vis.overlay.lcd");
	} else if (ca_mode.getData() == vis_mode_slot1_attrib.getAttributeName()) {
		ClockGroup.hide();
		g_vis4d_spec.hide();
		g_vis4d_osc.hide();
		ClockTimer.stop();
		VisATimer.stop();
		al_vis.setXmlParam("image", getToken(vis_own1_attrib.getData(), ";", 1));
		i_Frames = al_vis.getLength() - 1;
		visual.hide();
		al_vis.show();
		VisTimer.start();
		visover.setXmlParam("image", "player.normal.display.vis.overlay.lcd");
	} else if (ca_mode.getData() == vis_mode_slot2_attrib.getAttributeName()) {
		ClockGroup.hide();
		g_vis4d_spec.hide();
		g_vis4d_osc.hide();
		ClockTimer.stop();
		VisATimer.stop();
		al_vis.setXmlParam("image", getToken(vis_own2_attrib.getData(), ";", 1));
		i_Frames = al_vis.getLength() - 1;
		visual.hide();
		al_vis.show();
		VisTimer.start();
		visover.setXmlParam("image", "player.normal.display.vis.overlay.lcd");
	} else if (ca_mode.getData() == vis_mode_slot3_attrib.getAttributeName()) {
		ClockGroup.hide();
		g_vis4d_spec.hide();
		g_vis4d_osc.hide();
		ClockTimer.stop();
		VisATimer.stop();
		al_vis.setXmlParam("image", getToken(vis_own3_attrib.getData(), ";", 1));
		i_Frames = al_vis.getLength() - 1;
		visual.hide();
		al_vis.show();
		VisTimer.start();
		visover.setXmlParam("image", "player.normal.display.vis.overlay.lcd");
	} else if (ca_mode.getData() == vis_mode_slot4_attrib.getAttributeName()) {
		ClockGroup.hide();
		g_vis4d_spec.hide();
		g_vis4d_osc.hide();
		ClockTimer.stop();
		VisATimer.stop();
		al_vis.setXmlParam("image", getToken(vis_own4_attrib.getData(), ";", 1));
		i_Frames = al_vis.getLength() - 1;
		visual.hide();
		al_vis.show();
		VisTimer.start();
		visover.setXmlParam("image", "player.normal.display.vis.overlay.lcd");
	} else if (ca_mode.getData() == vis_mode_slot5_attrib.getAttributeName()) {
		ClockGroup.hide();
		g_vis4d_spec.hide();
		g_vis4d_osc.hide();
		ClockTimer.stop();
		VisATimer.stop();
		al_vis.setXmlParam("image", getToken(vis_own5_attrib.getData(), ";", 1));
		i_Frames = al_vis.getLength() - 1;
		visual.hide();
		al_vis.show();
		VisTimer.start();
		visover.setXmlParam("image", "player.normal.display.vis.overlay.lcd");
	} else if (ca_mode.getData() == vis_mode_slot6_attrib.getAttributeName()) {
		ClockGroup.hide();
		g_vis4d_spec.hide();
		g_vis4d_osc.hide();
		ClockTimer.stop();
		VisATimer.stop();
		al_vis.setXmlParam("image", getToken(vis_own6_attrib.getData(), ";", 1));
		i_Frames = al_vis.getLength() - 1;
		visual.hide();
		al_vis.show();
		VisTimer.start();
		visover.setXmlParam("image", "player.normal.display.vis.overlay.lcd");
	} else if (ca_mode.getData() == vis_mode_slot7_attrib.getAttributeName()) {
		ClockGroup.hide();
		g_vis4d_spec.hide();
		g_vis4d_osc.hide();
		ClockTimer.stop();
		VisATimer.stop();
		al_vis.setXmlParam("image", getToken(vis_own7_attrib.getData(), ";", 1));
		i_Frames = al_vis.getLength() - 1;
		visual.hide();
		al_vis.show();
		VisTimer.start();
		visover.setXmlParam("image", "player.normal.display.vis.overlay.lcd");
	} else if (ca_mode.getData() == vis_mode_slot8_attrib.getAttributeName()) {
		ClockGroup.hide();
		g_vis4d_spec.hide();
		g_vis4d_osc.hide();
		ClockTimer.stop();
		VisATimer.stop();
		al_vis.setXmlParam("image", getToken(vis_own8_attrib.getData(), ";", 1));
		i_Frames = al_vis.getLength() - 1;
		visual.hide();
		al_vis.show();
		VisTimer.start();
		visover.setXmlParam("image", "player.normal.display.vis.overlay.lcd");
	} else if (ca_mode.getData() == vis_mode_slot9_attrib.getAttributeName()) {
		ClockGroup.hide();
		g_vis4d_spec.hide();
		g_vis4d_osc.hide();
		ClockTimer.stop();
		VisATimer.stop();
		al_vis.setXmlParam("image", getToken(vis_own9_attrib.getData(), ";", 1));
		i_Frames = al_vis.getLength() - 1;
		visual.hide();
		al_vis.show();
		VisTimer.start();
		visover.setXmlParam("image", "player.normal.display.vis.overlay.lcd");
	} else if (ca_mode.getData() == vis_mode_slot10_attrib.getAttributeName()) {
		ClockGroup.hide();
		g_vis4d_spec.hide();
		g_vis4d_osc.hide();
		ClockTimer.stop();
		VisATimer.stop();
		al_vis.setXmlParam("image", getToken(vis_own10_attrib.getData(), ";", 1));
		i_Frames = al_vis.getLength() - 1;
		visual.hide();
		al_vis.show();
		VisTimer.start();
		visover.setXmlParam("image", "player.normal.display.vis.overlay.lcd");
	}
}


ca_over.onDataChanged() {
	visover.setAlpha(stringToInteger(getData()) * 255);
}

ca_speed.onDataChanged() {
	VisTimer.setDelay(stringToInteger(getData()) + 1);
	VisATimer.setDelay(stringToInteger(getData()) + 1);
}
ClockTimer.onTimer() {
	if (getDateHour(getDate()) > 11) {
		al_clock_h.gotoFrame(getDateHour(getDate()) - 12);
	} else al_clock_h.gotoFrame(getDateHour(getDate()));
	al_clock_m.gotoFrame(getDateMin(getDate()));
	al_clock_s.gotoFrame(getDateSec(getDate()));
}

VisTimer.onTimer() {
	int i_vu;
	i_vu = ((System.getLeftVuMeter() + System.getRightVuMeter() ) / 2) / 255 * i_Frames;

	if (i_vu < i_lastvu) {
		i_vu == i_lastvu - 1;
		if (i_vu < 0) i_vu=0;
	}

	i_lastvu = i_vu;

	al_vis.gotoFrame(i_vu);
}
/*
VisATimer.onTimer() {
	int i_vu;
	i_vu = (System.getLeftVuMeter() + System.getRightVuMeter() ) / 2 / 5;
	i_vu = i_vu * 5;

	al_vis.setAlpha(i_vu);
}
*/

visover.onLeftButtonDown(int x, int y) {
	prefs_visible_attrib.setData("1");
	GuiTree _tree = System.getContainer("config").getLayout("normal").findObject("wasabi.preferences.group").findObject("wasabi.preferences.tree.embedded").findObject("mylist");
	_tree.sendAction("switchToItem", "Visualization", 0, 0, 0, 0);
}
