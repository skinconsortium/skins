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
function updateCover(group g, string source);
function setAAgroupToPos(group g, float pos);

#define NUMCOVERS = 2;

Class Layer AlbumCover;

global group scriptGroup;

Global group gprev3, gprev2, gprev1, gcurr, gnext1, gnext2, gnext3;
Global AlbumCover prev2, prev1, curr, next1, next2;

Global float currPos = 0, aaWidth;
global int scw, sch, eyeDist;

System.onScriptLoaded () {
	scriptGroup = getScriptGroup();

	gprev3 = scriptGroup.getObject("cover.flow.prev3");
	gprev2 = scriptGroup.getObject("cover.flow.prev2");
	gprev1 = scriptGroup.getObject("cover.flow.prev1");
	gcurr = scriptGroup.getObject("cover.flow.curr");
	gnext1 = scriptGroup.getObject("cover.flow.next1");
	gnext2 = scriptGroup.getObject("cover.flow.next2");
	gnext3 = scriptGroup.getObject("cover.flow.next3");
	
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
	
	eyeDist = 100;
	aaWidth = 80;
	
	scriptGroup.onResize(0,0,scriptGroup.getWidth(),scriptGroup.getHeight()); // sets 3D variables;
	

}

System.onTitleChange (String newtitle) {
	update();
	//updateDim();
}

scriptGroup.onResize(int x, int y, int w, int h) {
	scw = w;
	sch	= h;
	
	eyeDist = w*1.5;
	aaWidth = w/3;
	
	updateDim();
}

updateCover(group g, string source) {
	layer aa = g.getObject("aa");
	layer aaref = g.getObject("aa.ref");
	
	aa.setXmlParam("source", source);
	aaref.setXmlParam("source", source);
}

update () {
	int cur = PlEdit.getCurrentIndex();
	int max = PlEdit.getNumTracks();

	if (cur > 2)  {
		updateCover(gprev3, PlEdit.getFileName(cur-3));
		gprev3.show();
	}
	
	if (cur > 1)  {
		updateCover(gprev2, PlEdit.getFileName(cur-2));
		gprev2.show();
	}
	else gprev2.hide();

	if (cur > 0) {
		updateCover(gprev1, PlEdit.getFileName(cur-1));
		gprev1.show();
	}
	else prev1.hide();
	
	updateCover(gcurr, PlEdit.getFileName(cur));
	
	if (cur < max-3) {
		updateCover(gnext3, PlEdit.getFileName(cur+3));
		gnext3.show();
	}
	else gnext1.hide();
	
	if (cur < max-2) {
		updateCover(gnext2, PlEdit.getFileName(cur+2));
		gnext2.show();
	}
	else gnext2.hide();

	if (cur < max-1) {
		updateCover(gnext1, PlEdit.getFileName(cur+1));
		gnext1.show();
	}
	else gnext1.hide();
	
	
	
	currPos = cur;
	/*prev1sd.fx_setEnabled(0);
	prev1sd.fx_setEnabled(1);
	prev1sd.fx_restart();*/
}

updateDim() {
	setAAgroupToPos(gprev3, -3);
	setAAgroupToPos(gprev2, -2);
	setAAgroupToPos(gprev1, -1);
	setAAgroupToPos(gcurr, 0);
	setAAgroupToPos(gnext1, 1);
	setAAgroupToPos(gnext2, 2);
	setAAgroupToPos(gnext3, 3);
}

setAAgroupToPos(group g, float pos) {
	int xmid = scw/2;
	int y1 = pos*aaWidth*2;
	int x1 = (pos-0.5)*aaWidth;
	//if (pos < 0) x1 = x1-aaWidth/4;
	//if (pos > 0) x1 = x1+aaWidth/4;
	
	if (y1 < 0) y1 = -y1;
	
	if ((y1+eyeDist) == 0) return;
	
	double rat = eyeDist/(y1+eyeDist);
	int xp = x1*rat;
		
	int w = aaWidth*rat;

	int h = w*1.667;
	int yp = (sch - w)/2;

	g.setXMLParam("x",integerToString(xmid+xp));
	g.setXMLParam("y",integerToString(yp));
	g.setXMLParam("w",integerToString(w));
	g.setXMLParam("h",integerToString(h));
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
