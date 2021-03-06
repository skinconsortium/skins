/*************************************************************

	playlistPlus.m
	by leechbite.com
	
	script for PlaylistPlus XUI Object

*************************************************************/

#include <lib/std.mi>
#include <lib/pldir.mi>

function refreshPL();

#define SCROLL_UP 1
#define SCROLL_DOWN 2

class text plline;

global layout parentLayout;
Global group scriptGroup;

global text dummy;
global guiobject selector;
global layer mousetrap;
global string xuiparams = "";
global int currNumLines, currMaxLines, linespace, pltopMod;
global int currSel;
global string currTrackColor, currSelColorBk, playcolor, textcolor, selcolor;

global PlEdit PeListener;

global timer delayOnLoad, scrollAnim, delayRefreshPL;
global int targetPLTop, scrollSpeed, scrollDir, noSlow;

global int texth = 15;
global int lenw, numlines;
global int mousePressed, lastY, lastY2, lastpltop, pltoptrack, lastmove, lasttime, origtime;

System.onScriptLoaded() {

	scriptGroup = getScriptGroup();
	parentLayout = scriptGroup.getParentLayout();
	dummy = scriptGroup.getObject("dummy");
	selector = scriptGroup.getObject("selector");
	
	pltoptrack = getPrivateInt(getSkinName(),"PLTopTrack",0);
	playcolor = "wasabi.list.text.current";
	textcolor = "wasabi.text.color";
	
	delayOnLoad = new Timer;
	delayOnLoad.setDelay(50);
	delayOnLoad.start();
	
	delayRefreshPL = new Timer;
	delayRefreshPL.setDelay(50);
	delayRefreshPL.start();
	
	scrollAnim = new Timer;
	scrollAnim.setDelay(33);

}

System.onScriptUnloading() {
	delete delayOnLoad;
	delete scrollAnim;
	delete delayRefreshPL;
	delete PeListener;
}

delayOnLoad.onTimer() {
	stop();
	
	refreshPL();
	mousetrap = scriptGroup.getObject("mousetrap"); // init only after PL is init
	//mousetrap.bringToFront();
	
	PeListener = new PlEdit;
}

PeListener.onPleditModified () {
	pltoptrack = 0;
	pltopMod = 0;
	currSel = 0;
	
	if (!delayRefreshPL.isRunning()) delayRefreshPL.start();
}

delayRefreshPL.onTimer() {
	stop();	
	
	refreshPL();
}

scriptGroup.onResize(int x, int y, int w, int h) {
	refreshPL();
}

scriptGroup.onSetVisible(int on) {
	if (on) refreshPL();
}


refreshPL() {
	text temp;
	text templen;
	
	texth = dummy.getAutoHeight() - linespace;
	lenw = dummy.getAutoWidth();
	numlines = scriptGroup.getHeight() / texth + 1;
	int c = 0, b = 0;
	string currparam = "", par, val;
	
	selector.setXMLParam("h",integertostring(texth));
	selector.setXMLParam("y","-100");
	
	int numtracks = pledit.getNumTracks();
	int trackc;
	
	//if (numtracks < numlines) numlines = numtracks;
	
	for (c = 0; c <= numlines; c++) {
		trackc = c+pltoptrack;
		//if (pltopMod > 0) trackc--;
		
		temp = NULL;
		temp = scriptGroup.getObject("line"+integertostring(c));
		if (!temp) {
			temp = new text;
			temp.init(scriptGroup);
			
			temp.setXMLParam("id","line"+integertostring(c));
			temp.setXMLParam("x","0");
			temp.setXMLParam("w",integertostring(-lenw));
			temp.setXMLParam("h",integertostring(texth));
			temp.setXMLParam("relatw","1");
			temp.setXMLParam("rectrgn","1");
			temp.setXMLParam("move","0");
			temp.setXMLParam("ghost","1");
			temp.setXMLParam("ticker","0");

		}
		
		templen = NULL;
		templen = scriptGroup.getObject("len"+integertostring(c));
		if (!templen) {	
			templen = new text;
			templen.init(scriptGroup);
			
			templen.setXMLParam("id","len"+integertostring(c));
			templen.setXMLParam("x",integertostring(-lenw-2));
			templen.setXMLParam("w",integertostring(lenw));
			templen.setXMLParam("h",integertostring(texth));
			templen.setXMLParam("relatx","1");
			templen.setXMLParam("rectrgn","1");
			templen.setXMLParam("align","right");
			templen.setXMLParam("move","0");
			templen.setXMLParam("ghost","1");
			templen.setXMLParam("ticker","0");
			
			b = 0;
			do {
				currparam = getToken(xuiparams,";",b);
				b++;
				
				if (currparam!="") {
					par = getToken(currparam,"=",0);
					val = getToken(currparam,"=",1);
					
					temp.setXMLParam(par, val);
					templen.setXMLParam(par, val);
				}
			} while (currparam!="");
		}
		
		
		if ((c+pltoptrack) == PlEdit.getCurrentIndex ()) {
			temp.setXMLParam("color",playcolor);
			templen.setXMLParam("color",playcolor);
		} else  {
			temp.setXMLParam("color",textcolor);
			templen.setXMLParam("color",textcolor);
		}
		
		if (trackc == currSel) {
			temp.setXMLParam("color",selcolor);
			templen.setXMLParam("color",selcolor);
			selector.setXMLParam("y",integertostring(c*texth - pltopMod));
			selector.show();
		}


		temp.setXMLParam("y",integertostring(c*texth - pltopMod));
		templen.setXMLParam("y",integertostring(c*texth - pltopMod));
		
		if ((trackc < numtracks) && (trackc >= 0)) {
			temp.setText(integertostring(trackc+1)+". "+PlEdit.getTitle(trackc));
			templen.setText(PlEdit.getLength(trackc));
		} else {
			temp.setText(" ");
			templen.setText(" ");
		}
		
		if (c <= 2) {
			temp.setAlpha((c*texth - pltopMod)*70/texth + 80);
			templen.setAlpha((c*texth - pltopMod)*70/texth + 80);
		} else if ((numlines-c) <= 4) {
			temp.setAlpha(((numlines-c-2)*texth+pltopMod)*70/texth+80);
			templen.setAlpha(((numlines-c-2)*texth+pltopMod)*70/texth+80);
		} else {
			temp.setAlpha(255);
			templen.setAlpha(255);
		}


	}
	
	if (currMaxLines < numlines) currMaxLines = numlines;
	currNumLines = numlines;

	if (!scrollAnim.isRunning() && !mousePressed) {
		if (pltoptrack < 0) {
			targetPLTop = 0;
			noSlow = 0;
			scrollSpeed = texth;
			scrollDir = SCROLL_UP;
			scrollAnim.start();
		}
		if ((pltoptrack + numlines - 2) >= numtracks && numlines < numtracks) {
			targetPLTop = numtracks - numlines + 1;
			noSlow = 0;
			scrollSpeed = texth;
			scrollDir = SCROLL_DOWN;
			scrollAnim.start();
		}
	} else {
		// *** set private int only if list is not animating
		
		setPrivateInt(getSkinName(),"PLTopTrack",pltoptrack);
	}
}

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

System.onTitleChange(String newtitle) {
	
	int currTrack = PlEdit.getCurrentIndex();
	
	if ((pltoptrack > currTrack) || ((pltoptrack + numlines) < currTrack)) {
		pltopMod = 0;
		pltoptrack = currTrack - numlines/2 + 1;
		
		if ((pltoptrack + numlines - 2) >= pledit.getNumTracks()) {
			pltoptrack = pledit.getNumTracks() - numlines + 1;
			pltopMod = 0;
		}
		
		if (pltoptrack < 0) {
			pltoptrack = 0;
			pltopMod = 0;
		}
	}

	refreshPL();
}

system.onKeyDown(string key) {
	if (!parentLayout.isActive()) return;
	if (!scriptGroup.isVisible()) return;
	if (delayOnLoad.isRunning()) return;
	
	key = strlower(key);
	
	if (key == "up") {
		currSel--;
		if (currSel < 0) currSel = 0;
		
		if (currSel < pltoptrack) {
			pltoptrack = currSel;
			pltopMod = 0;
		}
		
		if ((currSel - pltoptrack + 2) > numlines) {
			pltoptrack = currSel-numlines+2;
			pltopMod = 0;
		}
		
		if (scrollAnim.isRunning()) scrollAnim.stop();
		refreshPL();
		
		complete;
		
	} else if (key == "down") {
		currSel++;
		if (currSel >= pledit.getNumTracks()) currSel = pledit.getNumTracks()-1;
		
		if (currSel < pltoptrack) {
			pltoptrack = currSel;
			pltopMod = 0;
		}
		
		if ((currSel - pltoptrack + 2) > numlines) {
			pltoptrack = currSel-numlines+2;
			pltopMod = 0;
		}
		
		if (scrollAnim.isRunning()) scrollAnim.stop();
		refreshPL();
		
		complete;
	} else if (key == "pgup") {
		currSel = currSel - numlines;
		if (currSel < 0) currSel = 0;
		
		if (currSel < pltoptrack) {
			pltoptrack = currSel;
			pltopMod = 0;
		}
		
		if (scrollAnim.isRunning()) scrollAnim.stop();
		refreshPL();
		
		complete;
		
	} else if (key == "pgdn") {
		currSel = currSel + numlines;
		if (currSel >= pledit.getNumTracks()) currSel = pledit.getNumTracks()-1;
		
		if (currSel < pltoptrack) {
			pltoptrack = currSel;
			pltopMod = 0;
		}
		
		if ((currSel - pltoptrack + 2) > numlines) {
			pltoptrack = currSel-numlines+2;
			pltopMod = 0;
			
		}
		
		if (scrollAnim.isRunning()) scrollAnim.stop();
		refreshPL();
		
		complete;
	} else if (key == "home") {
		pltoptrack = 0;
		pltopMod = 0;
		currSel = 0;
		
		if (scrollAnim.isRunning()) scrollAnim.stop();
		refreshPL();
		
		complete;
	} else if (key == "end") {
		currSel = pledit.getNumTracks()-1;
		pltoptrack = pledit.getNumTracks()-numlines+1;
		pltopMod = 0;
		if (pltoptrack < 0) pltoptrack = 0;
		
		if (scrollAnim.isRunning()) scrollAnim.stop();
		refreshPL();
		
		complete;
	} else if (key == "return") {
		pledit.playTrack(currSel);
		
		if (currSel < pltoptrack) {
			pltoptrack = currSel;
			pltopMod = 0;
		}
		
		if ((currSel - pltoptrack + 2) > numlines) {
			pltoptrack = currSel-numlines+2;
			pltopMod = 0;
		}
		
		if (scrollAnim.isRunning()) scrollAnim.stop();
		refreshPL();
		
		complete;
	} else {
		//dummy.settext(key);
		return;
	}
	
	
}

mousetrap.onLeftButtonDblClk(int x, int y) {

	lastpltop = pltoptrack;
	
	int sel = (y - mouseTrap.getTop()) / texth;
	currSel = sel + lastpltop;
	
	refreshPL();
	
	PlEdit.playTrack(currSel);

	complete;
	
}

mousetrap.onLeftButtonDown(int x, int y) {
	mousePressed = 1;
	if (scrollAnim.isRunning()) scrollAnim.stop();
	
	lastY = getMousePosY();
	lastY2 = lastY;
	lastmove = 0;
	
	lastpltop = pltoptrack*texth + pltopMod;
	lasttime = getTimeOfDay();
	origtime = lasttime;
	
	int sel = y - mouseTrap.getTop();
	currSel = (sel + lastpltop) / texth;
	
	refreshPL();
	
}

mousetrap.onMouseMove(int x, int y) {
	if (!mousePressed) return;
	
	int move = lastY - getMousePosY();
	
	if ((move < 3) && (move > -3)) { lastmove = 0; return; }

	int lasttop = pltoptrack;
	
	int numtracks = pledit.getNumTracks();
	
	int newpltop = (lastpltop + move) / texth;
	pltopMod = (lastpltop + move) % texth;
	
	if ((newpltop + numlines) >= (numtracks + 5)) { newpltop = numtracks - numlines + 4; pltopMod = texth;}
	if (newpltop < -4) { newpltop = -4; pltopMod = -texth;}
	if (numtracks < numlines) { newpltop = 0; pltopMod = 0; }
	pltoptrack = newpltop;
	
	int timediff = getTimeofDay()-lasttime;
	lasttime = getTimeOfDay();
	
	if (timediff <= 0) timediff = 1;
	lastmove = (lastY2 - getMousePosY()) * 100 / timediff;
	lastY2 = getMousePosY();
	
	refreshPL();
}

mousetrap.onLeftButtonUp(int x, int y) {
	mousePressed = 0;
	
	refreshPL();
	
	int numtracks = pledit.getNumTracks();

	if (scrollAnim.isRunning()) return;
	
	if (lastmove > texth) {
		targetPLTop = pltoptrack + lastmove/texth;
		
		if ((targetPLTop + numlines) >= (numtracks + 5)) { targetPLTop = numtracks - numlines + 4;}
		if (targetPLTop < -4) { targetPLTop = -4;}
		if (numtracks < numlines) { targetPLTop = 0; pltopMod = 0; }
			
		noSlow = 0;
		scrollSpeed = lastmove*0.1;
		if (scrollSpeed < 1) scrollSpeed = 1;
		scrollDir = SCROLL_UP;
		scrollAnim.start();
	}
	if (lastmove < (-texth)) {
		targetPLTop = pltoptrack + lastmove/texth;
		
		if ((targetPLTop + numlines) >= (numtracks + 5)) { targetPLTop = numtracks - numlines + 4;}
		if (targetPLTop < -4) { targetPLTop = -4;}
		if (numtracks < numlines) { targetPLTop = 0; pltopMod = 0; }
		
		noSlow = 0;
		scrollSpeed = -lastmove*0.1;
		if (scrollSpeed < 1) scrollSpeed = 1;
		scrollDir = SCROLL_DOWN;
		scrollAnim.start();
	}
	
}

mousetrap.onRightButtonUp(int x, int y) {
	popupMenu plMenu, mlplSubMenu, ratingSubMenu;
	int c;
	
	if (scrollAnim.isRunning()) scrollAnim.stop();
	
	lastpltop = pltoptrack*texth + pltopMod;
	
	int sel = y - mouseTrap.getTop();
	currSel = (sel + lastpltop) / texth;
	
	refreshPL();
	
	mlplSubMenu = new popupMenu;

	int numPL = PlDir.getNumItems();
	if (numPL<=0)
		mlplSubMenu.addCommand("no playlist found", -1, 0, 1);
	else {
		for (c=1; c <=numPL; c++) {
			mlplSubMenu.addCommand(PlDir.getItemName(c-1),399+c, 0, 0);
		}
	}
	
	ratingSubMenu = new popupMenu;
	ratingSubMenu.addCommand(" *****", 205, PlEdit.getRating(currSel) == 5, 0);
	ratingSubMenu.addCommand(" ****", 204, PlEdit.getRating(currSel) == 4, 0);
	ratingSubMenu.addCommand(" ***", 203, PlEdit.getRating(currSel) == 3, 0);
	ratingSubMenu.addCommand(" **", 202, PlEdit.getRating(currSel) == 2, 0);
	ratingSubMenu.addCommand(" *", 201, PlEdit.getRating(currSel) == 1, 0);
	ratingSubMenu.addCommand(" No rating", 200, PlEdit.getRating(currSel) == 0, 0);
	
	
	plMenu = new popupMenu;
	plMenu.addCommand(" Play track \tEnter", 1, 0, 0);
	plMenu.addSeparator();
	plMenu.addSubMenu(mlplSubMenu," Playlists");
	plMenu.addSubMenu(ratingSubMenu," Rate track");
	
	int res = plMenu.popAtMouse();

	delete mlplSubmenu;
	delete ratingSubMenu;
	delete plMenu;
	
	if (res == 1) {
		PlEdit.playTrack(currSel);
	} else if (res >= 400 && res < 500) {
		PlDir.playItem(res-400);
	} else if (res >= 200 && res <= 205) {
		PlEdit.setRating(currSel, res-200);
	}

	complete;
}

System.onSetXuiParam(String param, String value) {
	param = strlower(param);
	if (param=="linespacing") {
		linespace = stringtointeger(value);
	} else if (param=="selcolor") {
		selcolor = value;
	} else if (param=="selbgcolor") {
		selector.setXMLParam("color",value);
	} else if (param=="selalpha") {
		selector.setXMLParam("alpha",value);
	} else if (param=="playcolor") {
		playcolor = value;
	} else if (param=="color") {
		textcolor = value;
	} else {
		xuiparams = xuiparams + param + "=" + value + ";";
		dummy.setXMLParam(param, value);
	}
}
