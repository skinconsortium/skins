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


/***** greatly modified by leechbite.com :D ******/


#include <lib/std.mi>
#include <lib/pldir.mi>

function update();
function updateDim(float offPos);
function updateCover(group g, int index);
function setAAgroupToPos(group g, float pos);

#define NUMCOVERS = 2;

Class Layer AlbumCover;

global group scriptGroup;

global PlEdit PeListener;

Global group gprev3, gprev2, gprev1, gcurr, gnext1, gnext2, gnext3;
global AlbumCover aaref;

Global float currPos = 0, aaWidth;
global int scw, sch, eyeDist;

global timer delayRefresh, scrollAnim;

System.onScriptLoaded () {
	scriptGroup = getScriptGroup();

	gprev3 = scriptGroup.getObject("cover.flow.prev3");
	gprev2 = scriptGroup.getObject("cover.flow.prev2");
	gprev1 = scriptGroup.getObject("cover.flow.prev1");
	gcurr = scriptGroup.getObject("cover.flow.curr");
	gnext1 = scriptGroup.getObject("cover.flow.next1");
	gnext2 = scriptGroup.getObject("cover.flow.next2");
	gnext3 = scriptGroup.getObject("cover.flow.next3");
	
	delayRefresh = new Timer;
	delayRefresh.setDelay(50);
	
	scrollAnim = new Timer;
	scrollAnim.setDelay(33);
	
	currPos = getPrivateInt(getSkinName(),"PLTopTrack",5);
		
	scriptGroup.onResize(0,0,scriptGroup.getWidth(),scriptGroup.getHeight()); // sets 3D variables;
	
	PeListener = new PlEdit;
	update();

}

system.onScriptUnloading() {
	delete delayRefresh;
	delete scrollAnim;
}

PeListener.onPleditModified () {
	if (!delayRefresh.isRunning()) delayRefresh.start();
}

// delay needed otherwise it will update like crazy on PL change.
delayRefresh.onTimer() {
	stop();
	
	currPos = 5;
	
	update();
}

scriptGroup.onResize(int x, int y, int w, int h) {
	scw = w;
	sch	= h;
	
	eyeDist = w*1.5;
	aaWidth = w*0.3;
	
	if (!scriptGroup.isVisible()) return;
	
	updateDim(0);
}

updateCover(group g, int index) {
	int max = PlEdit.getNumTracks();
	
	if (index < 0 || index >= max) { g.hide(); return; }
	
	layer aa = g.getObject("aa");
	aaref = g.getObject("aa.ref");
	
	string fname = PlEdit.getFileName(index);
	aa.setXmlParam("source", fname);
	aaref.setXmlParam("source", fname);
	
	g.show();
	
	aaref.fx_setEnabled(0);
	
	aaref.fx_setBgFx(0);
  	aaref.fx_setWrap(0);
  	aaref.fx_setBilinear(1);
	aaref.fx_setAlphaMode(1);
  	aaref.fx_setGridSize(10,10);
  	aaref.fx_setRect(1);
	aaref.fx_setClear(0);
  	aaref.fx_setLocalized(1);
  	aaref.fx_setRealtime(0);
  	
  	aaref.fx_setEnabled(1);
  	aaref.fx_restart();
}

AlbumCover.fx_onGetPixelY(double r, double d, double x, double y) {
	return -y;
}

AlbumCover.fx_onGetPixelA(double r, double d, double x, double y) {
	double ret = 0.35-y*0.65; // simplified, original: (2-(1+y)*1.3)*0.5;
	if (ret < 0) ret = 0;
	return ret;
}

update() {
	int cur = currPos;
	if (currPos - cur > 0.5) cur++;

	updateCover(gprev3, cur-3);
	updateCover(gprev2, cur-2);
	updateCover(gprev1, cur-1);
	updateCover(gcurr, cur);
	updateCover(gnext1, cur+1);
	updateCover(gnext2, cur+2);
	updateCover(gnext3, cur+3);
}

updateDim(float offPos) {
	
	
	setAAgroupToPos(gprev3, offPos-3);
	setAAgroupToPos(gprev2, offPos-2);
	setAAgroupToPos(gprev1, offPos-1);
	setAAgroupToPos(gcurr, offPos);
	setAAgroupToPos(gnext1, offPos+1);
	setAAgroupToPos(gnext2, offPos+2);
	setAAgroupToPos(gnext3, offPos+3);
}

setAAgroupToPos(group g, float pos) {
	int xmid = scw/2;
	int ymid = sch/2;
	
	if (eyeDist == 0) return;

	//*** sets 3D location of cover	
	int x1 = (pos*1.3-0.5)*aaWidth;
	int y1 = pos*aaWidth*3;
	int z1 = 0.3*aaWidth;
	if (y1 < 0) y1 = -y1;
	
	//*** calculates 3D coordinates to view plane
	double rat = eyeDist/(y1+eyeDist);
	int xp = x1*rat;
	int w = aaWidth*rat;
	int h = w*1.667;
	
	int yp = z1*rat;
	yp = ymid*1.1 + yp - w;

	g.setXMLParam("x",integerToString(xmid+xp));
	g.setXMLParam("y",integerToString(yp));
	g.setXMLParam("w",integerToString(w));
	g.setXMLParam("h",integerToString(h));
}

/*
// **** animation scripts
scrollAnim.onTimer() {
	int currtoppix = (pltoptrack*texth + pltopMod);
	int targetpix = targetPLTop*texth;
	int speed;
	
	speed = (targetpix-currtoppix)*0.2;
	if (speed < 0) speed = -speed;
	
	if (speed > scrollSpeed) speed = scrollSpeed;
	if (noSlow) speed = scrollSpeed;

	if (speed < 1) speed = 1;
		
	if (scrollDir == SCROLL_UP) {
		
		
		pltoptrack = currtoppix+speed;
		if (targetpix <= pltoptrack) {
			pltoptrack = targetpix;
			stop();
		}
	}
	
	if (scrollDir == SCROLL_DOWN) {
		//if (speed > -1) speed = -1;
		
		pltoptrack = currtoppix-speed;
		if (targetpix >= pltoptrack) {
			pltoptrack = targetpix;
			stop();
		}
	}
	
	pltopMod = pltoptrack % texth;
	pltoptrack = pltoptrack / texth;
	
	refreshPL();
	
}

*/
