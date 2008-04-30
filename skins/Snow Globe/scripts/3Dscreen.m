/********************************************************\
**  Filename:	3Dscreen.maki				**
**  Version:	1.0					**
**  Date:	20. Nov. 2007 - 15:35			**
**********************************************************
**  Type:	winamp.wasabi/maki			**
**  Project:	Snow Globe X-Mas Skin			**
**********************************************************
**  Author:	Martin Poehlmann aka Deimos		**
**  E-Mail:	martin@skinconsortium.com		**
**  Internet:	http://www.skinconsortium.com		**
**		http://home.cs.tum.edu/~poehlman	**
\********************************************************/


#include <lib/std.mi>
#include <lib/pldir.mi>

Function screenPosToAnimatedLayer (AnimatedLayer al, int pos, boolean inv);

Function updateXoff();
Function getXoff();

Global Layout main;
Global AnimatedLayer al_xoff, ba_xoff;

//Global Core myCore;

System.onScriptLoaded ()
{
	group sg = getScriptGroup();

	main = sg.getParentlayout();
	al_xoff = sg.getObject("globe.xoff");
	ba_xoff = sg.getObject("base.xoff");

	/*myCore =  CoreAdmin.newNamedCore("f");

	myCore.setVolume(25);
	debugInt(myCore.getVolume());*/


}

main.onSetVisible (Boolean onoff)
{
	if (onoff)
	{
		al_xoff.setStartFrame(0);
		al_xoff.setEndFrame(getXoff());
		al_xoff.setSpeed(66);
		al_xoff.play();
		ba_xoff.setStartFrame(0);
		ba_xoff.setEndFrame(getXoff());
		ba_xoff.setSpeed(66);
		ba_xoff.play();
	}
}


main.onMove()
{
	updateXoff();
}


int getXoff()
{
	int l = main.getLeft();
	int fr = main.getLeft() / (getMonitorWidth()-main.getwidth()) * 30;

	if (fr < 0)
	{
		fr = 0;
	}
	if (fr > 29)
	{
		fr = 29;
	}

	return fr;
}

updateXoff ()
{
	al_xoff.stop();
	al_xoff.gotofRAME(getXOff());
	ba_xoff.stop();
	ba_xoff.gotofRAME(getXOff());
}