/**
 * classicvis.m
 *
 * Positions vis object and handles styles
 *
 * @package	com.skinconsortium.cpro.flex
 * @author	mpdeimos
 * @date	08/11/06
 * @version	1.0
 * @param	regionID;colorsID
 */

#include <lib/std.mi>

Function String getColor(Map m, int x, int y);
Function refreshVisSettings();
Function setVis (int mode);
Function ProcessMenuResult (int a);

Global GuiObject myVisGroup;
Global Vis myVis;
Global Boolean active;
Global Layer mousetrap;

Global PopUpMenu visMenu;
Global PopUpMenu specMenu;
Global PopUpMenu oscMenu;
Global PopUpMenu pksMenu;
Global PopUpMenu anaMenu;
Global PopUpMenu styleMenu;

Global Int currentMode, a_falloffspeed, p_falloffspeed, a_coloring;
Global Boolean show_peaks;

System.onScriptLoaded ()
{
	myVisGroup = getScriptGroup();
	myVis = myVisGroup.findObject("classicvis");
	mousetrap = myVisGroup.findObject("mousetrap");

	Region r = new Region;
	r.loadFromBitmap(getToken(getParam(), ";", 0));

	active = (r.getBoundingBoxW() > 0);
	if (active)
	{
		myVis.setXmlParam("x", integerToString(r.getBoundingBoxX()));
		myVis.setXmlParam("y", integerToString(r.getBoundingBoxY()));
		myVis.setXmlParam("h", integerToString(r.getBoundingBoxH()));
		myVis.setXmlParam("w", integerToString(r.getBoundingBoxW()));

		mousetrap.setXmlParam("x", integerToString(r.getBoundingBoxX()));
		mousetrap.setXmlParam("y", integerToString(r.getBoundingBoxY()));
		mousetrap.setXmlParam("h", integerToString(r.getBoundingBoxH()));
		mousetrap.setXmlParam("w", integerToString(r.getBoundingBoxW()));

		myVisGroup.setXmlParam("background", getToken(getParam(), ";", 0));
		myVisGroup.setXmlParam("drawbackground", "0");

		Map colors = new Map;
		colors.loadMap(getToken(getParam(), ";", 1));

		if (colors.getWidth() > 2 && colors.getHeight() > 17)
		{
			myVis.setXmlParam("colorbandpeak", getColor(colors, 0, 0));

			myVis.setXmlParam("colorband1", getColor(colors, 0, 17));
			myVis.setXmlParam("colorband2", getColor(colors, 0, 16));
			myVis.setXmlParam("colorband3", getColor(colors, 0, 15));
			myVis.setXmlParam("colorband4", getColor(colors, 0, 14));
			myVis.setXmlParam("colorband5", getColor(colors, 0, 13));
			myVis.setXmlParam("colorband6", getColor(colors, 0, 12));
			myVis.setXmlParam("colorband7", getColor(colors, 0, 11));
			myVis.setXmlParam("colorband8", getColor(colors, 0, 10));
			myVis.setXmlParam("colorband9", getColor(colors, 0, 9));
			myVis.setXmlParam("colorband10", getColor(colors, 0, 8));
			myVis.setXmlParam("colorband11", getColor(colors, 0, 6));
			myVis.setXmlParam("colorband12", getColor(colors, 0, 7));
			myVis.setXmlParam("colorband13", getColor(colors, 0, 6));
			myVis.setXmlParam("colorband14", getColor(colors, 0, 5));
			myVis.setXmlParam("colorband15", getColor(colors, 0, 4));
			myVis.setXmlParam("colorband16", getColor(colors, 0, 3));

			myVis.setXmlParam("colorosc5", getColor(colors, 2, 0));
			myVis.setXmlParam("colorosc4", getColor(colors, 2, 1));
			myVis.setXmlParam("colorosc3", getColor(colors, 2, 2));
			myVis.setXmlParam("colorosc2", getColor(colors, 2, 3));
			myVis.setXmlParam("colorosc1", getColor(colors, 2, 4));
		}
		
		delete colors;

		refreshVisSettings();

		myVisGroup.show();
	}

	delete r;
}

refreshVisSettings ()
{
	currentMode = getPrivateInt(getSkinName(), "myVis Mode", 1);
	show_peaks = getPrivateInt(getSkinName(), "myVis show Peaks", 1);
	a_falloffspeed = getPrivateInt(getSkinName(), "myVis analyzer falloff", 3);
	p_falloffspeed = getPrivateInt(getSkinName(), "myVis peaks falloff", 2);
	a_coloring = getPrivateInt(getSkinName(), "myVis analyzer coloring", 0);

	myVis.setXmlParam("peaks", integerToString(show_peaks));
	myVis.setXmlParam("peakfalloff", integerToString(p_falloffspeed));
	myVis.setXmlParam("falloff", integerToString(a_falloffspeed));

	if (a_coloring == 0)
	{
		myVis.setXmlParam("coloring", "Normal");
	}
	else if (a_coloring == 1)
	{
		myVis.setXmlParam("coloring", "Normal");
	}
	else if (a_coloring == 2)
	{
		myVis.setXmlParam("coloring", "Fire");
	}
	else if (a_coloring == 3)
	{
		myVis.setXmlParam("coloring", "Line");
	}
	
	setVis (currentMode);
}

mousetrap.onLeftButtonDown (int x, int y)
{
	currentMode++;

	if (currentMode == 6)
	{
		currentMode = 0;
	}

	setVis	(currentMode);
	complete;
}

mousetrap.onRightButtonUp (int x, int y)
{
	visMenu = new PopUpMenu;
	specmenu = new PopUpMenu;
	oscmenu = new PopUpMenu;
	pksmenu = new PopUpMenu;
	anamenu = new PopUpMenu;
	stylemenu = new PopUpMenu;

	visMenu.addCommand("Presets:", 999, 0, 1);
	visMenu.addCommand("No Visualization", 100, currentMode == 0, 0);
	specmenu.addCommand("Thick Bands", 1, currentMode == 1, 0);
	specmenu.addCommand("Thin Bands", 2, currentMode == 2, 0);
	visMenu.addSubMenu(specmenu, "Spectrum Analyzer");

	oscmenu.addCommand("Solid", 3, currentMode == 3, 0);
	oscmenu.addCommand("Dots", 4, currentMode == 4, 0);
	oscmenu.addCommand("Lines", 5, currentMode == 5, 0);
	visMenu.addSubMenu(oscmenu, "Oscilloscope");

	visMenu.addSeparator();
	visMenu.addCommand("Options:", 102, 0, 1);
	visMenu.addCommand("Show Peaks", 101, show_peaks == 1, 0);
	pksmenu.addCommand("Slower", 200, p_falloffspeed == 0, 0);
	pksmenu.addCommand("Slow", 201, p_falloffspeed == 1, 0);
	pksmenu.addCommand("Moderate", 202, p_falloffspeed == 2, 0);
	pksmenu.addCommand("Fast", 203, p_falloffspeed == 3, 0);
	pksmenu.addCommand("Faster", 204, p_falloffspeed == 4, 0);
	visMenu.addSubMenu(pksmenu, "Peak Falloff Speed");
	anamenu.addCommand("Slower", 300, a_falloffspeed == 0, 0);
	anamenu.addCommand("Slow", 301, a_falloffspeed == 1, 0);
	anamenu.addCommand("Moderate", 302, a_falloffspeed == 2, 0);
	anamenu.addCommand("Fast", 303, a_falloffspeed == 3, 0);
	anamenu.addCommand("Faster", 304, a_falloffspeed == 4, 0);
	visMenu.addSubMenu(anamenu, "Analyzer Falloff Speed");
	stylemenu.addCommand("Normal", 400, a_coloring == 0, 0);
	stylemenu.addCommand("Fire", 402, a_coloring == 2, 0);
	stylemenu.addCommand("Line", 403, a_coloring == 3, 0);
	visMenu.addSubMenu(stylemenu, "Analyzer Coloring");

	ProcessMenuResult (visMenu.popAtMouse());

	delete visMenu;
	delete specmenu;
	delete oscmenu;
	delete pksmenu;
	delete anamenu;
	delete stylemenu;

	complete;	
}

ProcessMenuResult (int a)
{
	if (a < 1) return;

	if (a > 0 && a <= 6 || a == 100)
	{
		if (a == 100) a = 0;
		setVis(a);
	}

	else if (a == 101)
	{
		show_peaks = (show_peaks - 1) * (-1);
		myVis.setXmlParam("peaks", integerToString(show_peaks));
		setPrivateInt(getSkinName(), "myVis show Peaks", show_peaks);
	}

	else if (a >= 200 && a <= 204)
	{
		p_falloffspeed = a - 200;
		myVis.setXmlParam("peakfalloff", integerToString(p_falloffspeed));
		setPrivateInt(getSkinName(), "myVis peaks falloff", p_falloffspeed);
	}

	else if (a >= 300 && a <= 304)
	{
		a_falloffspeed = a - 300;
		myVis.setXmlParam("falloff", integerToString(a_falloffspeed));
		setPrivateInt(getSkinName(), "myVis analyzer falloff", a_falloffspeed);
	}

	else if (a >= 400 && a <= 403)
	{
		a_coloring = a - 400;
		if (a_coloring == 0)
		{
			myVis.setXmlParam("coloring", "Normal");
		}
		else if (a_coloring == 1)
		{
			myVis.setXmlParam("coloring", "Normal");
		}
		else if (a_coloring == 2)
		{
			myVis.setXmlParam("coloring", "Fire");
		}
		else if (a_coloring == 3)
		{
			myVis.setXmlParam("coloring", "Line");
		}
		setPrivateInt(getSkinName(), "myVis analyzer coloring", a_coloring);
	}
}

setVis(int mode)
{
	setPrivateInt(getSkinName(), "myVis Mode", mode);
	if (mode == 0)
	{
		myVis.setMode(0);
	}
	else if (mode == 1)
	{
		myVis.setXmlParam("bandwidth", "wide");
		myVis.setMode(1);
	}
	else if (mode == 2)
	{
		myVis.setXmlParam("bandwidth", "thin");
		myVis.setMode(1);
	}
	else if (mode == 3)
	{
		myVis.setXmlParam("oscstyle", "solid");
		myVis.setMode(2);
	}
	else if (mode == 4)
	{
		myVis.setXmlParam("oscstyle", "dots");
		myVis.setMode(2);
	}
	else if (mode == 5)
	{
		myVis.setXmlParam("oscstyle", "lines");
		myVis.setMode(2);
	}
	currentMode = mode;
}

String getColor(Map m, int x, int y)
{
	String ret = integertoString(m.getARGBValue(x, y, 2));
	ret += "," + integertoString(m.getARGBValue(x, y, 1));
	ret += "," + integertoString(m.getARGBValue(x, y, 0));

	return ret;
}