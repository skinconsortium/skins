/*************************************************************

	main.m
	by leechbite.com
	
	main script.

*************************************************************/

#include <lib/std.mi>
#include <lib/config.mi>

#define VID_GUID "{F0816D7B-FFFC-4343-80F2-E8199AA15CC3}"
#define AVS_GUID "{0000000A-000C-0010-FF7B-01014263450C}"
#define ML_GUID "{6B0EDF80-C9A5-11D3-9F26-00C04F39FFC6}"
#define SKINTWEAKS_CFGPAGE "{0542AFA4-48D9-4c9f-8900-5739D52C114F}"

#define OPENVID 1
#define OPENAVS 2
#define OPENML 3

Global layout main; 

Global button buttonPL;
Global guiobject mainPL;

Global vis vis1, vis2;
Global layer vismousetrap;

Global text avsRandomInd;

Global configAttribute xfade, xfadetime, PSOVC, avsRandom;
Global configAttribute attrRepeat, attrShuffle;

Global group VISGroup, vidButtons, avsButtons;
Global WindowHolder AVSHolder, VideoHolder, MLHolder;
Global int localOpen, openVIDAVS;
Global timer delayVisShow, delayClearLocalOpen, delayRequestPageSwitch;

Global group pbuttonsWindow, pbuttonsFull;
Global button buttonWindow, buttonFull;
Global guiobject topbar;
Global int nosizesave;

Global text titletext;
Global string newtitle;
Global int origtitlealpha;

Global text indtext;
Global timer indtextTimer;
Global int origindalpha;
Global button buttNext, buttPrev;

//global timer delayfocus;

System.onScriptLoaded() {
	
	main = getContainer("main").getLayout("normal");
	
	buttonPL = main.findObject("main.pl");
	mainPL = main.findObject("player.main.pl");
	if (getPrivateInt(getSkinName(),"MainPLVisible",0) == 1) mainPL.show();

	configItem configGroup = Config.getItemByGuid("{F1239F09-8CC6-4081-8519-C2AE99FCB14C}");
	if (configGroup) xfadetime = configGroup.getAttribute("Crossfade time");
	
	configGroup = Config.getItemByGuid("{FC3EAF78-C66E-4ED2-A0AA-1494DFCC13FF}");
	if (configGroup) xfade = configGroup.getAttribute("Enable crossfading");
	
	configItem item = Config.getItem("Playlist editor");
	attrRepeat = item.getAttribute("repeat");
	attrShuffle = item.getAttribute("shuffle");
	
	xfadetime.onDataChanged();
	
	configGroup = Config.getItemByGuid("{0000000A-000C-0010-FF7B-01014263450C}");
	if (configGroup) avsRandom = configGroup.getAttribute("Random");
	
	VISGroup = main.findObject("player.main.vis");
	AVSHolder = VISGroup.findObject("wndhlr.avs");
	VideoHolder = VISGroup.findObject("wndhlr.vid");
	avsRandomInd = VISGroup.findObject("random.text.ind");
	vidButtons = VISGroup.findObject("player.main.vid.buttons");
	avsButtons = VISGroup.findObject("player.main.avs.buttons");
	avsRandom.onDataChanged();
	
	MLHolder = main.findObject("wndhlr.ml");
	
	delayVisShow = new Timer;
	delayVisShow.setDelay(1500);
	
	delayClearLocalOpen = new Timer;
	delayClearLocalOpen.setDelay(1000);
	localOpen = 0;
	openVIDAVS = 0;
	
	delayRequestPageSwitch = new Timer;
	delayRequestPageSwitch.setDelay(500);
	
	configGroup = Config.getItem(SKINTWEAKS_CFGPAGE);
    if (configGroup) {
        ConfigAttribute PSOVC = configGroup.getAttribute("Prevent video playback Stop on video window Close");
        if (PSOVC) PSOVC.setData("1");
    }
    
    pbuttonsWindow = main.findObject("player.main.pbuttons.window");
    pbuttonsFull = main.findObject("player.main.pbuttons.full");
	buttonWindow = pbuttonsFull.getObject("pbutton.window");
	buttonFull = pbuttonsWindow.getObject("pbutton.full");
	topbar = pbuttonsWindow.getObject("pbutton.topbar");
	
	titletext = main.findObject("player.main.title");
	origtitlealpha = titletext.getAlpha();
	
	indtext = main.findObject("player.main.indicator");
	buttNext = main.findObject("next");
	buttPrev = main.findObject("rev");
	origindalpha = indtext.getAlpha();
	indtext.hide();
	indtextTimer = new Timer;
	indtextTimer.setDelay(1000);
	
	if (getPrivateInt(getSkinName(),"windowmode", 0) == 0) {
		nosizesave = 1;
		buttonFull.onLeftClick();
	}
}

System.onScriptUnloading() {
	delete delayVisShow;
	delete delayClearLocalOpen;
	delete delayRequestPageSwitch;
	delete indtextTimer;
	
	if (PSOVC) PSOVC.setData("0");
}

buttonPL.onLeftClick() {
	int plshow = (getPrivateInt(getSkinName(),"MainPLVisible",0) == 0);
	setPrivateInt(getSkinName(),"MainPLVisible",plshow);
	if (plshow) 
		mainPL.show();
	else
		mainPL.hide();
}

// ***** AVS/Video Control Scripts
system.onGetCancelComponent(String curguid, boolean goingvisible) {
	if (!goingvisible) return FALSE;
	
	if (curguid == VID_GUID) {
		if (localOpen) return FALSE;
		else {
			delayRequestPageSwitch.start();
			openVIDAVS = OPENVID;
			return TRUE;
		}
	}
	if (curguid == AVS_GUID) {
		if (localOpen) return FALSE;
		else {
			delayRequestPageSwitch.start();
			openVIDAVS = OPENAVS;
			return TRUE;
		}
	}
	if (curguid == ML_GUID) {
		if (localOpen) return FALSE;
		else {
			delayRequestPageSwitch.start();
			openVIDAVS = OPENML;
			return TRUE;
		}
	}
	
	return FALSE;

}

main.onAction(String action, String param, Int x, int y, int p1, int p2, GuiObject source) {
	int videoname = 0;
	action = strupper(action);

	if (action=="SWITCHPAGE") {
		vidButtons.hide();
		avsButtons.hide();
		AVSHolder.hide();
		VideoHolder.hide();
		MLHolder.hide();
		if (param=="player.main.vis" || param=="player.main.ml") {
			if (param=="player.main.ml") openVIDAVS = OPENML;
			delayVisShow.start();
			
			if ((isVideo() && openVIDAVS==0) || openVIDAVS == OPENVID) videoname = 1;
		} else {
			if (delayVisShow.isRunning()) delayVisShow.stop();
		}
		
		group temp = NULL;
		temp = main.getObject(param);
		if (temp) {
			newtitle = temp.getXMLParam("name");
			if (videoname) newtitle = "video";
			if (titletext.isGoingToTarget()) titletext.cancelTarget();
			titletext.setTargetA(0);
			titletext.setTargetSpeed(0.5);
			titletext.gotoTarget();
		}
	} else if (action=="INDTEXT") {
		indtext.setText(Param);
	}
}

delayRequestPageSwitch.onTimer() {
	stop();
	
	if (openVIDAVS == OPENML)
		main.sendAction("REQUESTSWITCHPAGE", "", 0,0,3,0);  // switches to page 4
	else
		main.sendAction("REQUESTSWITCHPAGE", "", 0,0,2,0);  // switches to page 3
}

delayVisShow.onTimer() {
	stop();
	
	if (!VISGroup.isVisible() && openVIDAVS!=OPENML) return;
	
	localOpen = 1;
	if (openVIDAVS == OPENML) {
		MLHolder.show();
	} else if ((isVideo() && openVIDAVS==0) || openVIDAVS == OPENVID) {
		VideoHolder.show();
		vidButtons.show();
	} else {
		AVSHolder.show();
		avsButtons.show();
	}
	delayClearLocalOpen.start();
	
	openVIDAVS = 0;
}

delayClearLocalOpen.onTimer() {
	stop();
	
	localOpen = 0;
}

// title text scripts
titletext.onTargetReached() {
	if (getAlpha()==0) {
		setText(newtitle);
		titletext.setTargetA(origtitlealpha);
		titletext.gotoTarget();
	}
}

// indicator scripts
system.onVolumeChanged(int newvol) {
	string newtext = integerToString(newvol*100/255);
	
	indtext.setText("Volume: "+newtext+"%");
}

system.onPlay() { indtext.setText("Play"); }
system.onStop() { indtext.setText("Stop"); }
system.onResume() {	indtext.setText("Resume Play"); }
system.onPause() { indtext.setText("Pause"); }
buttNext.onLeftClick() { indtext.setText("Next Track"); }
buttPrev.onLeftClick() { indtext.setText("Previous Track"); }

attrRepeat.onDataChanged() {
	if (getData()=="1")
		indtext.setText("Repeat All");
	else if (getData()=="-1")
		indtext.setText("Repeat Track");
	else
		indtext.setText("Repeat Off");
}

attrShuffle.onDataChanged() {
	if (getData()=="1")
		indtext.setText("Shuffle On");
	else
		indtext.setText("Shuffle Off");
}

indtext.onTextChanged(string newtext) {
	if (newtext=="") return;
	if (indtext.isGoingToTarget()) indtext.cancelTarget();
	indtext.setAlpha(origindalpha);
	indtext.show();
	indtextTimer.start();
}

indtextTimer.onTimer() {
	stop();
	indtext.setTargetA(0);
	indtext.setTargetSpeed(1);
	indtext.gotoTarget();
}

indtext.onTargetReached() {
	if (indtext.getAlpha()==0) {
		indtext.hide();
		indtext.settext("");
	}
}

// avs random text indication script
avsRandom.onDataChanged() {
	if (getData()=="0")
		avsRandomInd.setText("OFF");
	else
		avsRandomInd.setText("ON");
}

// xfade main control scripts
xfadetime.onDataChanged() {
	if (getData()!="0" && xfade.getData()!="1") 
		xfade.setData("1");
	if (getData()=="0" && xfade.getData()!="0") 
		xfade.setData("0");
}

// window/fullscreen controls

buttonWindow.onLeftClick() {
	pbuttonsWindow.show();
	pbuttonsFull.hide();
	
	int wx = getPrivateInt(getSkinName(),"windowx", 50);
	int wy = getPrivateInt(getSkinName(),"windowy", 50);
	int ww = getPrivateInt(getSkinName(),"windoww", 640);
	int wh = getPrivateInt(getSkinName(),"windowh", 480);
	setPrivateInt(getSkinName(),"windowmode", 1);
	
	main.resize(wx,wy,ww,wh);
	main.setXMLParam("lockminmax","0");
}

buttonFull.onLeftClick() {
	pbuttonsWindow.hide();
	pbuttonsFull.show();
	
	if (!nosizesave) {
		setPrivateInt(getSkinName(),"windowx", main.getLeft());
		setPrivateInt(getSkinName(),"windowy", main.getTop());
		setPrivateInt(getSkinName(),"windoww", main.getWidth());
		setPrivateInt(getSkinName(),"windowh", main.getHeight());
		
	}
	
	setPrivateInt(getSkinName(),"windowmode", 0);
	nosizesave = 0;
	
	main.resize(0,0, getMonitorWidth(), getMonitorHeight());
	main.setXMLParam("lockminmax","1");
}

topbar.onLeftButtonDblClk(int x, int y) {
	buttonFull.onLeftClick();
}
