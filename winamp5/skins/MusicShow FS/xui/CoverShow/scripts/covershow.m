/********************************************************\
**  Filename:	coverflow.m				**
**  Version:	1.0					**
**  Date:	20. Nov. 2007 - 15:25			**
**********************************************************
**  Type:	winamp.wasabi/maki			**
**  Project:	Cover Flow				**
**********************************************************
**  Author:	Martin Poehlmann aka Deimos		**
**  E-Mail:	martin@skinconsortium.com		**
**  Internet:	http://www.skinconsortium.com		**
**		http://home.cs.tum.edu/~poehlman	**
\********************************************************/


/***** modified by leechbite.com ******/


#include <lib/std.mi>
#include <lib/pldir.mi>

function update();
function updateDim();
function setAAgroupToPos(group g, float pos);

#define NUMCOVERS = 2;

Class Layer AlbumCover;

global group scriptGroup;

Global group gprev2, gprev1, gcurr, gnext1, gnext2;
Global AlbumCover prev2, prev1, curr, next1, next2;

Global float currPos = 0;

System.onScriptLoaded () {
	scriptGroup = getScriptGroup();

	gprev2 = scriptGroup.getObject("cover.flow.prev2");
	gprev1 = scriptGroup.getObject("cover.flow.prev1");
	gcurr = scriptGroup.getObject("cover.flow.curr");
	gnext1 = scriptGroup.getObject("cover.flow.next1");
	gnext2 = scriptGroup.getObject("cover.flow.next2");
	
	prev2 = gprev2.getObject("aa.prev2");
	prev1 = gprev1.getObject("aa.prev1");
	curr = gcurr.getObject("aa.curr");
	next1 = gnext1.getObject("aa.next1");
	next2 = gnext2.getObject("aa.next2");

	/*prev1sd.fx_setBgFx(1);
	prev1sd.fx_setGridSize(2,2);
	prev1sd.fx_setRealtime(1);
	prev1sd.fx_setRect(1);
	prev1sd.fx_setWrap(0);
	prev1sd.fx_setSpeed(1000000);
	prev1sd.fx_setEnabled(0);
	prev1sd.fx_setAlphaMode(1);
	prev1sd.fx_setBilinear(1);*/

	update();
}

System.onTitleChange (String newtitle)
{
	update();
}

update () {
	int cur = PlEdit.getCurrentIndex();
	int max = PlEdit.getNumTracks();

	if (cur > 1) 
	{
		prev2.setXmlParam("source", PlEdit.getFileName(cur-2));
		prev2.show();
	}
	else	prev2.hide();

	if (cur > 0)
	{
		prev1.setXmlParam("source", PlEdit.getFileName(cur-1));
		prev1.show();
	}
	else	prev1.hide();
	
	if (cur < max-2) 
	{
		next2.setXmlParam("source", PlEdit.getFileName(cur+2));
		next2.show();
	}
	else	next2.hide();

	if (cur < max-1)
	{
		next1.setXmlParam("source", PlEdit.getFileName(cur+1));
		next1.show();
	}
	else	next1.hide();
	
	currPos = cur;
	updateDim();
	/*prev1sd.fx_setEnabled(0);
	prev1sd.fx_setEnabled(1);
	prev1sd.fx_restart();*/
}

updateDim() {

	setAAgroupToPos(gprev2, -2);
}

setAAgroupToPos(group g, float pos) {
	int w = scriptGroup.getWidth();
	int h = scriptGroup.getHeight();
	
	//int ax = w
}

/*
Global double dblSmidge;
prev1sd.fx_onGetPixelX(double r, double d, double x, double y)
{
	return x;
}
prev1sd.fx_onGetPixelY(double r, double d, double x, double y)
{
	if (y < 0)
	{
		return y;
	}
	
	return -y+dblSmidge;
}

prev1sd.fx_onGetPixelA(double r, double d, double x, double y)
{
	if (y < 0)
	{
		return 0+dblSmidge;
	}
	else
	{
		return (1-y+dblSmidge)*0.7;
	}
}
*/
