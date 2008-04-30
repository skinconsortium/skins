/*************************************

	Vortex - fs.m

	main script for party! mode.

	by leechbite, www.leechbite.com

	additions by Deimos

*************************************/

#include "../../../lib/std.mi"
#include "attribs.m"

// set the following to desired minimum width and height of componets
#define COMPONENT_MIN_WIDTH 250
#define COMPONENT_MIN_HEIGHT 150

// resolution modes
#define RES_CURRENT -1
#define RES_AUTO 1
#define RES_VIEWP 2
#define RES_CUSTOM 3

// component guids
#define VID_GUID "{F0816D7B-FFFC-4343-80F2-E8199AA15CC3}"
#define VIS_GUID "{0000000A-000C-0010-FF7B-01014263450C}"
#define PL_GUID "{45F3F7C1-A6F3-4EE6-A15E-125E92FC3F8D}"
#define ML_GUID "{6B0EDF80-C9A5-11D3-9F26-00C04F39FFC6}"

function refreshPartyLayout();
function resizefsWindow(int x, int y, int w, int h);
function setfsResolution(int mode);
function int getAutoResWidth();
function int getAutoResHeight();
function setCustomRes();
function setToCustomRes();

function string changeComponent();

Function returnState(togglebutton tgb);

Function string playPause(boolean revp);

Global container mainCont;
Global layout partyLayout;

Global group grMain, grML, grPL, grVID, grPref;
Global guiObject sepVert, sepHort;

Global layer resizer;
Global boolean resizerStart;
Global int resizerStartX, resizerStartY, orgMLWidth, orgMLHeight;

Global WindowHolder whML, whPL, whAVS, whVID;

Global timer timerOpenComp, timerOpenVis, timerOpenVid, onLoadDelay;
Global boolean localOpen = false;

Global button resButton;
global button customresOk, customresCancel;

global configAttribute aot_attrib, ca_rnd;
Global Text avstxt, eqtxt;

Global Group AVSbtns, VIDbtns;

Global Vis osc, right, left;

Global button play, pause;

Global Boolean coverisshown;
Global Group Gcover, Geq, Geqbtns;
Global Button Bcover, Beq;
Global Text Tcoveq;

Global Togglebutton eq_on, eq_auto;

Global Slider Seek, vol;
Global text Songticker, swtxt;

Global Button swtch;

System.OnScriptLoaded ()
{
	initAttribs();
	mainCont = getContainer("main");
	partyLayout = mainCont.getLayout("party!");

	seek = partyLayout.findObject("seek");
	vol = partyLayout.findObject("vol");
	songticker = partyLayout.findObject("songticker");

	resizer = partyLayout.findObject("fs.resizer");
	resButton = partyLayout.findObject("button.res");
	customresOk = partyLayout.findObject("customres.ok");
	customresCancel = partyLayout.findObject("customres.cancel");
	
	grMain = partyLayout.findObject("player.fs.components");
	grML = grMain.getObject("player.fs.components.ml");
	grPL = grMain.getObject("player.fs.components.pl");
	grVID = grMain.getObject("player.fs.components.vid");
	grPref = grMain.getObject("player.fs.components.pref");
	
	sepVert = grMain.getObject("sep.vertical");
	sepHort = grMain.getObject("sep.horizontal");
	
	whML = grMain.findObject("fs.wh.ml");
	whPL = grMain.findObject("fs.wh.pl");
	whAVS = grMain.findObject("fs.wh.avs");
	whVID = grMain.findObject("fs.wh.vid");

	AVSbtns = grMain.findObject("fs.avs.buttons");
	VIDbtns = grMain.findObject("fs.vid.buttons");

	swtch = grMain.findObject("c.switch");

	coverisshown = System.getPrivateInt("vortex", "fs.cover", 1);

	Bcover = grMain.findObject("cover");
	Beq = grMain.findObject("eq");
	eq_on = grMain.findObject("on");
	eq_auto = grMain.findObject("auto");
	Gcover = grMain.findObject("cover.fs.g");
	Geq = grMain.findObject("eq.fs.g");
	Tcoveq = grMain.findObject("player.fs.components.pref").findObject("player.fs.components.title").findObject("text.window");
	Geqbtns = grMain.findObject("fs.eq.buttons");
	eqtxt = grMain.findObject("eqtxt");

	eqtxt.setText("EQ: " + returnState(eq_on) + "  Auto: " + returnState(eq_auto));

	if (coverisshown) {
		Tcoveq.setText("Cover Art");
		Geqbtns.hide();
		Beq.show();
		Gcover.show();
		Geq.hide();
	} else {
		Tcoveq.setText("Equalizer");
		Geqbtns.show();
		Beq.hide();
		Gcover.hide();
		Geq.show();
	}
		
	whML.hide();
	whPL.hide();
	whAVS.hide();
	whVID.hide();
	AVSbtns.hide();
	VIDbtns.hide();
	
	timerOpenComp = new timer;
	timerOpenComp.setDelay(100);
	
	timerOpenVis = new timer;
	timerOpenVis.setDelay(100);
	
	timerOpenVid = new timer;
	timerOpenVid.setDelay(100);
	
	onLoadDelay = new timer;
	onLoadDelay.setDelay(100);
	onLoadDelay.start();
	
	configItem configGroup = Config.getItemByGuid("{280876CF-48C0-40BC-8E86-73CE6BB462E5}");
	if (configGroup) aot_attrib = configGroup.getAttribute("Always on top");

	ca_rnd = Config.getItemByGuid("{0000000A-000C-0010-FF7B-01014263450C}").getAttribute("Random");
	avstxt = grMain.findObject("avstxt");
	ca_rnd.onDataChanged();
	
	refreshPartyLayout();

	play = partyLayout.findObject("button.play");
	pause = partyLayout.findObject("button.pause");

	right = partyLayout.findObject("fs.vis.right");
	left = partyLayout.findObject("fs.vis.left");
	osc = partyLayout.findObject("fs.vis.osc");

	play.hide();
	pause.hide();
	
	if(System.getStatus()==1) {
		playPause(1);
	} else if(System.getStatus()==0) {
		playPause(0);
	} else if(System.getStatus()==(-1)) {
		playPause(0);
	}
}

eq_on.onActivate(boolean on) {
	eqtxt.setText("EQ: " + returnState(eq_on) + "  Auto: " + returnState(eq_auto));
}

eq_auto.onActivate(boolean on) {
	eqtxt.setText("EQ: " + returnState(eq_on) + "  Auto: " + returnState(eq_auto));
}

string returnState(togglebutton tgb) {
	int v = tgb.getActivated();
	if (v == 0) return "off";
	else return "on";
}
	

Beq.onLeftClick() {
	setPrivateInt("vortex", "fs.cover", 0);
	Tcoveq.setText("Equalizer");
	Geqbtns.show();
	Beq.hide();
	Gcover.hide();
	Geq.show();
}

Bcover.onLeftClick() {
	setPrivateInt("vortex", "fs.cover", 1);
	Tcoveq.setText("Cover Art");
	Geqbtns.hide();
	Beq.show();
	Gcover.show();
	Geq.hide();
}

ca_rnd.onDataChanged() {
	if (getData() == "1") {
		avstxt.setText("Random: on");
	} else avstxt.setText("Random: off");
}
	

partyLayout.onSetVisible(int v) {
	if (v) {
		left.setMode(1);
		right.setMode(1);
		osc.setMode(2);
	}
}

System.onPlay() {playPause(1);}
System.onPause() {playPause(0);} //;
System.onStop() {playPause(0);} //;
System.onResume() {playPause(1);} //;
playPause(boolean revp) {
	if(revp) {
		pause.hide();
		play.hide();
		play.hide();
		pause.show();
	} else if(!revp) {
		pause.hide();
		play.hide();
		pause.hide();
		play.show();
	}
}

system.onScriptUnloading() {
	delete timerOpenComp;
	delete timerOpenVis;
	delete timerOpenVid;

}

// a delayed onScriptLoad, gives skin engine time to load the components..
onLoadDelay.onTimer() {
	stop();
	
	if (partyLayout == mainCont.getCurLayout()) {
	    mainCont.onSwitchToLayout(partyLayout);
	}
}

timerOpenComp.onTimer() {
	stop();
	
	localOpen = true;
	
	whML.show();
	whPL.show();
	if (getPrivateInt(getSkinName(),"party_video_open",1)==1) {
		whVID.show();
		AVSbtns.hide();
		VIDbtns.show();
		swtch.setXMLParam("text", "Switch to AVS");
	} else {
		whAVS.setXMLParam("autoopen", "1");
		whAVS.show();
		AVSbtns.show();
		VIDbtns.hide();
		swtch.setXMLParam("text", "Switch to Video");
		whAVS.setXMLParam("autoopen", "0");
	}
	localOpen = false;
}

timerOpenVis.onTimer() {
	stop();
	
	localOpen = true;
	
	whVID.hide();
	whAVS.show();

	AVSbtns.show();
	VIDbtns.hide();

	
	text titletext = grVid.findObject("text.window");
	titletext.setText("Visualization");
	swtch.setXMLParam("text", "Switch to Video");
	
	localOpen = false;
	
	setPrivateInt(getSkinName(),"party_video_open",0);
		whAVS.setXMLParam("autoopen", "0");
}

timerOpenVid.onTimer() {
	stop();
	
	localOpen = true;
	
	whAVS.hide();
	whVID.show();

	AVSbtns.hide();
	VIDbtns.show();
	
	text titletext = grVid.findObject("text.window");
	titletext.setText("Video");
	swtch.setXMLParam("text", "Switch to AVS");
	
	localOpen = false;
	
	setPrivateInt(getSkinName(),"party_video_open",1);
}

mainCont.onSwitchToLayout(layout newLay) {
	whML.hide();
	whPL.hide();
	whAVS.hide();
	whVID.hide();

	AVSbtns.hide();
	VIDbtns.hide();
	
	if (newLay == partyLayout) {
	    if (isNamedWindowVisible(VID_GUID)) hideNamedWindow(VID_GUID);
	    if (isNamedWindowVisible(VIS_GUID)) hideNamedWindow(VIS_GUID);
    	if (isNamedWindowVisible(ML_GUID)) hideNamedWindow(ML_GUID);
    	if (isNamedWindowVisible(PL_GUID)) hideNamedWindow(PL_GUID);
    	
		aot_attrib.setData("0");
    	    	
    	setfsResolution(RES_CURRENT);

		timerOpenComp.start();
		
	}
}

mainCont.onBeforeSwitchToLayout(layout oldlay, layout newLay) {
	whML.hide();
	whPL.hide();
	whAVS.hide();
	whVID.hide();

	AVSbtns.hide();
	VIDbtns.hide();
	
	if (oldLay == partyLayout) {
	    if (isNamedWindowVisible(VID_GUID)) hideNamedWindow(VID_GUID);
	    if (isNamedWindowVisible(VIS_GUID)) hideNamedWindow(VIS_GUID);
    	if (isNamedWindowVisible(ML_GUID)) hideNamedWindow(ML_GUID);
    	if (isNamedWindowVisible(PL_GUID)) hideNamedWindow(PL_GUID);
	}
}

swtch.onLeftClick() {
	localOpen = true;
	
	if (getPrivateInt(getSkinName(),"party_video_open",1)==0) {
		timerOpenVid.start();
	} else {
		whAVS.setXMLParam("autoopen", "1");
		timerOpenVis.start();
	}
	localOpen = false;
}

// components controls, return false to allow component to show, true to deny request
system.onGetCancelComponent(String guid, boolean goingvisible) {
	if (mainCont.getCurLayout() != partyLayout) return false;
	if (localOpen) return false;

	if (guid==VIS_GUID && goingvisible) {
	/*-- bug fix by deimos--*/
		localOpen = true;

		whVID.hide();
		whAVS.show();

		AVSbtns.show();
		VIDbtns.hide();

		text titletext = grVid.findObject("text.window");
		titletext.setText("Visualization");
		swtch.setXMLParam("text", "Switch to Video");

		localOpen = false;

		setPrivateInt(getSkinName(),"party_video_open",0);
		return false;
	/*----*/
	}
	if (guid==VIS_GUID && !goingvisible) {
		timerOpenVid.start();
		return true;
	}
	if (guid==VID_GUID && goingvisible) {
		whAVS.show();
		timerOpenVid.start();
		return false;
		/*-- bug fix by deimos--*/
		/*localOpen = true;

		whAVS.hide();
		whVID.show();

		VIDbtns.show();
		AVSbtns.hide();

		text titletext = grVid.findObject("text.window");
		titletext.setText("Video");

		localOpen = false;

		setPrivateInt(getSkinName(),"party_video_open",1);
		return false;*/
	/*----*/
	}
	
	return false;
}

//whAVS.onHide() { messagebox("close", ",", 0, ""); timerOpenVid.start(); }


/** redraws the components layout based on ML width and height **/
refreshPartyLayout() {
	int mlWidth = getPrivateInt(getSkinName(),"party_ml_width",100);
	int mlHeight = getPrivateInt(getSkinName(),"party_ml_height",100);
	
	int mainWidth = grMain.getWidth();
	int mainHeight = grMain.getHeight();
	
	// sets to minimum width and height of 100px
	if (mlWidth < COMPONENT_MIN_WIDTH) mlWidth = COMPONENT_MIN_WIDTH;
	if (mlHeight < COMPONENT_MIN_HEIGHT) mlHeight = COMPONENT_MIN_HEIGHT;

	if (mlWidth > (mainWidth-COMPONENT_MIN_WIDTH)) mlWidth = mainWidth-COMPONENT_MIN_WIDTH;
	if (mlHeight > (mainHeight-COMPONENT_MIN_HEIGHT)) mlHeight = mainHeight-COMPONENT_MIN_HEIGHT;
	
	string strWidth = integerToString(mlWidth);
	string strHeight = integerToString(mlHeight);
	
	grML.setXMLParam("w", strWidth);
	grML.setXMLParam("h", strHeight);
	
	grPL.setXMLParam("y", "0");
	grPL.setXMLParam("x", strWidth);
	grPL.setXMLParam("w", "-"+strWidth);
	grPL.setXMLParam("h", strHeight);
	
	grVID.setXMLParam("y", strHeight);
	grVID.setXMLParam("w", strWidth);
	grVID.setXMLParam("h", "-"+strHeight);
	
	grPref.setXMLParam("x", strWidth);
	grPref.setXMLParam("y", strHeight);
	grPref.setXMLParam("w", "-"+strWidth);
	grPref.setXMLParam("h", "-"+strHeight);
	
	sepVert.setXMLParam("x", integerToString(mlWidth-15));
	sepHort.setXMLParam("y", integerToString(mlHeight-15));
	
	resizer.setXMLParam("x", integerToString(mlWidth-18));
	resizer.setXMLParam("y", integerToString(mlHeight-18));
}

/** resizer scripts ***/
resizer.onLeftButtonDown(int x, int y) {
	resizerStart = true;
	
	resizerStartX = x; resizerStartY = y;
	orgMLWidth = getPrivateInt(getSkinName(),"party_ml_width",100);
	orgMLHeight = getPrivateInt(getSkinName(),"party_ml_height",100);
}

resizer.onLeftButtonUp(int x, int y) {
	resizerStart = false;
	
	refreshPartyLayout();
}

resizer.onMouseMove(int x, int y) {
	if (!resizerStart) return;
	
	int diffx = x - resizerStartX;
	int diffy = y - resizerStartY;
	
	setPrivateInt(getSkinName(),"party_ml_width",x-36);
	setPrivateInt(getSkinName(),"party_ml_height",y-36);
	
	refreshPartyLayout();
}

/***** Resolution Control Scripts *****/

resizefsWindow(int x, int y, int w, int h) {
  float fw  = w, fh = h;
  w = fw / partyLayout.getScale();
  h = fh / partyLayout.getScale();

  if (x < 0) x = 0;
  if (x > (partyLayout.getLeft()+partyLayout.getWidth() - 200)) x = partyLayout.getLeft()+partyLayout.getWidth() - 200;
  if (y < 0) y = 0;
  if (y > (partyLayout.getLeft()+partyLayout.getWidth() - 200)) x = partyLayout.getLeft()+partyLayout.getWidth() - 200;
  if (w < 750) w = 750;
  if (w > 1600) w = 1600;
  if (h < 650) h = 650;
  if (h > 1200) h = 1200;

  partyLayout.setXMLParam("maximum_h",integerToString(h));
  partyLayout.setXMLParam("maximum_w",integerToString(w));
  partyLayout.setXMLParam("minimum_h",integerToString(h));
  partyLayout.setXMLParam("minimum_w",integerToString(w));

  partyLayout.resize(x, y, w, h);
  refreshPartyLayout();
}

// ******* Resolution Menu *****
resButton.onLeftClick() {
  popUpMenu resMenu = new popUpMenu;

  int currMode = getPrivateInt(getSkinName(),"Screen Resolution", 1);

  resMenu.addCommand("- Screen Resolution -", -1, 0, 1);
  resMenu.addSeparator();
  resMenu.addCommand(" Auto Detect", RES_AUTO, currMode == RES_AUTO, 0);
  resMenu.addCommand(" Viewport", RES_VIEWP, currMode == RES_VIEWP, 0);
  resMenu.addCommand(" Custom", RES_CUSTOM, currMode == RES_CUSTOM, 0);
  resMenu.addSeparator();
  resMenu.addCommand(" 800 x 600", 101, currMode == 101, 0);
  resMenu.addCommand(" 1024 x 768", 102, currMode == 102, 0);
  resMenu.addCommand(" 1152 x 864", 103, currMode == 103, 0);
  resMenu.addCommand(" 1152 x 870", 104, currMode == 104, 0);
  resMenu.addCommand(" 1280 x 720", 105, currMode == 105, 0);
  resMenu.addCommand(" 1280 x 768", 106, currMode == 106, 0);
  resMenu.addCommand(" 1280 x 960", 107, currMode == 107, 0);
  resMenu.addCommand(" 1280 x 1024", 108, currMode == 108, 0);
  resMenu.addCommand(" 1600 x 1200", 109, currMode == 109, 0);

  int res = resMenu.popAtMouse();
  delete resMenu;

  if (res < 0) return;

  setfsResolution(res);

  complete;
}

setfsResolution(int mode) {
  if (mode == RES_CURRENT) {
    mode = getPrivateInt(getSkinName(),"Screen Resolution", 1);
    if (mode == RES_CUSTOM) { setToCustomRes(); return; }
  } else if (mode != RES_CUSTOM)
    setPrivateInt(getSkinName(),"Screen Resolution", mode);

  if (mode == RES_AUTO) {
    resizefsWindow(0, 0, getAutoResWidth(), getAutoResHeight());
  } else if (mode == RES_VIEWP) {
    resizefsWindow(getViewPortLeft(), getViewPortTop(), getViewPortWidth(), getViewPortHeight());
  } else if (mode == RES_CUSTOM) {
    setCustomRes();
  } else if (mode == 101) {
    resizefsWindow(0, 0, 800, 600);
  } else if (mode == 102) {
    resizefsWindow(0, 0, 1024, 768);
  } else if (mode == 103) {
    resizefsWindow(0, 0, 1152, 864);
  } else if (mode == 104) {
    resizefsWindow(0, 0, 1152, 870);
  } else if (mode == 105) {
    resizefsWindow(0, 0, 1280, 720);
  } else if (mode == 106) {
    resizefsWindow(0, 0, 1280, 768);
  } else if (mode == 107) {
    resizefsWindow(0, 0, 1280, 960);
  } else if (mode == 108) {
    resizefsWindow(0, 0, 1280, 1024);
  } else if (mode == 109) {
    resizefsWindow(0, 0, 1600, 1200);
  }

}

getAutoResWidth() {
	//if we have winamp5.33+
	if (getMonitorWidth() > 0)
	{
		return getMonitorWidth();
	}
	else
	{
		  int vpx = getViewPortLeft();
		  int vpw = getViewPortWidth();

		  int totw = vpx + vpw;

		  if (totw <= 800) totw = 800;
		  else if (totw <= 1024) totw = 1024;
		  else if (totw <= 1152) totw = 1152;
		  else if (totw <= 1280) totw = 1280;
		  else if (totw <= 1600) totw = 1600;

		  return totw;
	}
}

getAutoResHeight() {
	//if we have winamp5.33+
	if (getMonitorHeight() > 0)
	{
		return getMonitorHeight();
	}
	else
	{
		  int vpy = getViewPortTop();
		  int vph = getViewPortHeight();

		  int toth = vpy + vph;

		  if (toth <= 600) toth = 600;
		  else if (toth <= 720) toth = 720;
		  else if (toth <= 768) toth = 768;
		  else if (toth <= 864) toth = 864;
		  else if (toth <= 870) toth = 870;
		  else if (toth <= 960) toth = 960;
		  else if (toth <= 1024) toth = 1024;
		  else if (toth <= 1200) toth = 1200;

		  return toth;
	}
}

setCustomRes() {
  group customresBox = partyLayout.findObject("fs.customres");
  edit inputx = customresBox.getObject("edit.customx");
  edit inputy = customresBox.getObject("edit.customy");
  edit inputw = customresBox.getObject("edit.customw");
  edit inputh = customresBox.getObject("edit.customh");

  inputx.setText(integerToString(partyLayout.getLeft()));
  inputy.setText(integerToString(partyLayout.getTop()));
  inputw.setText(integerToString(partyLayout.getWidth()));
  inputh.setText(integerToString(partyLayout.getHeight()));

  customresBox.show();
}

customresOk.onLeftClick() {
  group customresBox = partyLayout.findObject("fs.customres");
  edit inputx = customresBox.getObject("edit.customx");
  edit inputy = customresBox.getObject("edit.customy");
  edit inputw = customresBox.getObject("edit.customw");
  edit inputh = customresBox.getObject("edit.customh");

  customresBox.hide();

  int x = stringToInteger(inputx.getText());
  int y = stringToInteger(inputy.getText());
  int w = stringToInteger(inputw.getText());
  int h = stringToInteger(inputh.getText());
  
  if (x < 0) x = 0;
  if (x > (partyLayout.getLeft()+partyLayout.getWidth() - 200)) x = partyLayout.getLeft()+partyLayout.getWidth() - 200;
  if (y < 0) y = 0;
  if (y > (partyLayout.getLeft()+partyLayout.getWidth() - 200)) x = partyLayout.getLeft()+partyLayout.getWidth() - 200;
  if (w < 750) w = 750;
  if (w > 1600) w = 1600;
  if (h < 650) h = 650;
  if (h > 1200) h = 1200;

  setPrivateInt(getSkinName(),"Screen Resolution", RES_CUSTOM);
  setPrivateInt(getSkinName(),"Custom x", x);
  setPrivateInt(getSkinName(),"Custom y", y);
  setPrivateInt(getSkinName(),"Custom w", w);
  setPrivateInt(getSkinName(),"Custom h", h);
  setToCustomRes();

}

customresCancel.onLeftClick() {
  group customresBox = partyLayout.findObject("fs.customres");

  customresBox.hide();
}

setToCustomRes() {
  group customresBox = partyLayout.findObject("fs.customres");
  edit inputx = customresBox.getObject("edit.customx");
  edit inputy = customresBox.getObject("edit.customy");
  edit inputw = customresBox.getObject("edit.customw");
  edit inputh = customresBox.getObject("edit.customh");

  resizefsWindow(getPrivateInt(getSkinName(),"Custom x", partyLayout.getLeft()),
	   getPrivateInt(getSkinName(),"Custom y", partyLayout.getTop()),
	   getPrivateInt(getSkinName(),"Custom w", partyLayout.getWidth()),
	   getPrivateInt(getSkinName(),"Custom h", partyLayout.getHeight()));
}
/*
String changeComponent() {
	boolean ml = 0, pl = 0, va = 0, ce = 0;
	ConfigAttribute ca;
	for ( int i = 0; i <= 3; i++ ) {
		if (i == 0) ca = party_frame1_attrib;
		if (i == 1) ca = party_frame2_attrib;
		if (i == 2) ca = party_frame3_attrib;
		if (i == 3) ca = party_frame4_attrib;

		if (ca.getData() == "Media Library") ml = 1;
		if (ca.getData() == "Playlist Editor") pl = 1;
		if (ca.getData() == "Video/AVS") va = 1;
		if (ca.getData() == "Cover Art/Equalizer") ce = 1;
	}
	if (!ml) return "Media Library";
	else if (!pl) return "Playlist Editor";
	else if (!va) return "Video/AVS";
	else if (!ce) return "Cover Art/Equalizer";
	else return "";
}	

Global Int attribs_mychange;

party_frame1_attrib.onDataChanged() {
	if (attribs_mychange) return;
	attribs_mychange = 1;
	if (party_frame2_attrib.getData() == party_frame1_attrib.getData()) {
		party_frame2_attrib.setData(changeComponent());

	} else 	if (party_frame3_attrib.getData() == party_frame1_attrib.getData()) {
		party_frame3_attrib.setData(changeComponent());

	} else 	if (party_frame4_attrib.getData() == party_frame1_attrib.getData()) {
		party_frame4_attrib.setData(changeComponent());

	}
	attribs_mychange = 0;
	
}

party_frame2_attrib.onDataChanged() {
	if (attribs_mychange) return;
	attribs_mychange = 1;
	if (party_frame1_attrib.getData() == party_frame2_attrib.getData()) {
		party_frame1_attrib.setData(changeComponent());

	} else 	if (party_frame3_attrib.getData() == party_frame2_attrib.getData()) {
		party_frame3_attrib.setData(changeComponent());

	} else 	if (party_frame4_attrib.getData() == party_frame2_attrib.getData()) {
		party_frame4_attrib.setData(changeComponent());

	}
	attribs_mychange = 0;
	
}

party_frame3_attrib.onDataChanged() {
	if (attribs_mychange) return;
	attribs_mychange = 1;
	if (party_frame2_attrib.getData() == party_frame3_attrib.getData()) {
		party_frame2_attrib.setData(changeComponent());

	} else 	if (party_frame1_attrib.getData() == party_frame3_attrib.getData()) {
		party_frame1_attrib.setData(changeComponent());

	} else 	if (party_frame4_attrib.getData() == party_frame3_attrib.getData()) {
		party_frame4_attrib.setData(changeComponent());

	}
	attribs_mychange = 0;
	
}

party_frame4_attrib.onDataChanged() {
	if (attribs_mychange) return;
	attribs_mychange = 1;
	if (party_frame2_attrib.getData() == party_frame4_attrib.getData()) {
		party_frame2_attrib.setData(changeComponent());

	} else 	if (party_frame3_attrib.getData() == party_frame4_attrib.getData()) {
		party_frame3_attrib.setData(changeComponent());

	} else 	if (party_frame1_attrib.getData() == party_frame4_attrib.getData()) {
		party_frame1_attrib.setData(changeComponent());

	}
	attribs_mychange = 0;
	
}*/

/*------------*/

seek.onsetPosition(int newpos) {
	Songticker.sendAction("setText", "Seek to: " + System.integerToTime(newpos/255*getPlayitemLength()) + "/" + integerToTime(getPlayitemLength()), 0, 0, 0, 0);
}

vol.onsetPosition(int newpos) {
	Songticker.sendAction("setText", "Volume: " + System.integerToString(newpos/255*100) + "%", 0, 0, 0, 0);
}