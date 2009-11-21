#include <lib/std.mi>
Function applyLayout0();//info and play controls
Function applyLayout1();//equalizer and info
Function applyLayout2();
Function applyLayout3();
Function resize2(GuiObject, int, int, int, int);
Function relocate2(GuiObject, int, int);
Global AnimatedLayer switchBase;
Global GuiObject albumArt;
Global Text txtTimer;
Global Group nfoGrp, navGrp, eqGrp, volGrp, seekGrp, toggleGrp, eqGrp, cfgGrp, rateGrp;
Global Button closeTop;
Global int currentLayout;
System.onScriptLoaded ()
{
	switchBase =	getScriptGroup().findObject("layout.sw.bg");
	albumArt =		getScriptGroup().findObject("album.art");
	nfoGrp =		getScriptGroup().findObject("nfo.group");
	navGrp =		getScriptGroup().findObject("nav.group");
	volGrp =		getScriptGroup().findObject("vol.group");
	seekGrp =		getScriptGroup().findObject("seek.group");
	toggleGrp =		getScriptGroup().findObject("toggle.group");
	eqGrp =			getScriptGroup().findObject("eq.group");
	cfgGrp =		getScriptGroup().findObject("config");
	rateGrp =		getScriptGroup().findObject("rating");
	txtTimer =		getScriptGroup().findObject("txt.timer");
	closeTop =		getScriptGroup().findObject("layout.sw");
	currentLayout = System.getPrivateInt("robotarm", "LastLayout", 0);
	if(currentLayout==1)applyLayout1();
	else if (currentLayout==2)applyLayout2();
	else if (currentLayout==3)applyLayout3();
	else applyLayout0();
}
System.onScriptUnloading()
{
	System.setPrivateInt("robotarm", "LastLayout", currentLayout);
}
closeTop.onLeftButtonUp(int x, int y)
{
	if(!closeTop.isMouseOver(x,y))return;
	popupMenu layoutsMenu = new popupMenu;
	layoutsMenu.addCommand("Normal", 0, (currentLayout==0), 0);
	layoutsMenu.addCommand("Large album art", 1, (currentLayout==1), 0);
	layoutsMenu.addCommand("Equalizer", 2, (currentLayout==2), 0);
	layoutsMenu.addCommand("Configuration", 3, (currentLayout==3), 0);
	int nextLayout = layoutsMenu.popAtXY(closeTop.clientToScreenX(closeTop.getLeft()),closeTop.clientToScreenY(closeTop.getTop()));
	delete layoutsMenu;
	if (nextLayout==currentLayout) complete;
	else if(nextLayout==0)applyLayout0();
	else if(nextLayout==1)applyLayout1();
	else if(nextLayout==2)applyLayout2();
	else if(nextLayout==3)applyLayout3();
	complete;
}
applyLayout0()
{
	currentLayout = 0;
	albumArt.show();
	nfoGrp.show();
	navGrp.show();
	volGrp.show();
	seekGrp.show();
	toggleGrp.show();
	eqGrp.hide();
	txtTimer.show();
	resize2(AlbumArt,151,47,64,64);
	nfoGrp.setXMLParam("w","208");
	relocate2(volGrp,90,95);
	seekGrp.setXMLParam("w","137");
	toggleGrp.setXMLParam("x","101");
	AlbumArt.setXMLParam("notfoundImage","64rect");
	cfgGrp.hide();
	rateGrp.show();
}
applyLayout1()
{
	currentLayout = 1;
	albumArt.show();
	nfoGrp.show();
	navGrp.show();
	volGrp.show();
	seekGrp.show();
	toggleGrp.show();
	eqGrp.hide();
	txtTimer.show();
	resize2(AlbumArt,111,7,104,104);
	nfoGrp.setXMLParam("w","96");
	relocate2(volGrp,28,47);
	seekGrp.setXMLParam("w","96");
	toggleGrp.setXMLParam("x","60");
	AlbumArt.setXMLParam("notfoundImage","104rect");
	cfgGrp.hide();
	rateGrp.hide();
}
applyLayout2()
{
	currentLayout = 2;
	albumArt.hide();
	nfoGrp.hide();
	navGrp.hide();
	volGrp.hide();
	seekGrp.hide();
	toggleGrp.hide();
	eqGrp.show();
	txtTimer.hide();
	cfgGrp.hide();
	rateGrp.hide();
}
applyLayout3()
{
	currentLayout = 3;
	albumArt.hide();
	nfoGrp.hide();
	navGrp.hide();
	volGrp.hide();
	seekGrp.hide();
	toggleGrp.hide();
	eqGrp.hide();
	txtTimer.hide();
	cfgGrp.show();
	rateGrp.hide();
}
resize2(GuiObject target, int x, int y, int w, int h)
{
	target.setXMLParam("x",System.integerToString(x));
	target.setXMLParam("y",System.integerToString(y));
	target.setXMLParam("w",System.integerToString(w));
	target.setXMLParam("h",System.integerToString(h));
}
relocate2(GuiObject target, int x, int y)
{
	target.setXMLParam("x",System.integerToString(x));
	target.setXMLParam("y",System.integerToString(y));
}