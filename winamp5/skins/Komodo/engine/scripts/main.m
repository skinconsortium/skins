/*************************************************************

	main.m
	by leechbite.com
	
	main script.

*************************************************************/

#include <lib/std.mi>
#include <lib/config.mi>
#include <lib/fileio.mi>
#include <lib/application.mi>

#define VID_GUID "{F0816D7B-FFFC-4343-80F2-E8199AA15CC3}"
#define AVS_GUID "{0000000A-000C-0010-FF7B-01014263450C}"
#define ML_GUID "{6B0EDF80-C9A5-11D3-9F26-00C04F39FFC6}"
#define SKINTWEAKS_CFGPAGE "{0542AFA4-48D9-4c9f-8900-5739D52C114F}"

#define HOMEPAGEURL "http://www.nitrousaudio.com/k/"

#define OPENVID 1
#define OPENAVS 2
#define OPENML 3
#define OPENIE 4

Global layout main; 

Global button buttonPL;
Global guiobject mainPL;

Global vis vis1, vis2;
Global layer vismousetrap;

Global configAttribute xfade, xfadetime, PSOVC;
Global configAttribute attrRepeat, attrShuffle, attrAOT;

Global group NowPlayingGroup, VISGroup, vidButtons, avsButtons;
Global WindowHolder AVSHolder, VideoHolder, MLHolder;
Global int localOpen, openVIDAVS;
Global timer delayVisShow, delayClearLocalOpen, delayRequestPageSwitch;
Global browser mainBrowser;
Global string homepage;

Global group pbuttonsWindow, pbuttonsFull;
Global button buttonWindow, buttonFull;
Global button buttonIEPrev, buttonIENext, buttonIEReload, buttonIEStop, buttonIEHome;
Global guiobject topbar;
Global int nosizesave;

//Global text titletext;
Global string newtitle;
Global int origtitlealpha;

Global text indtext;
Global timer indtextTimer;
Global int origindalpha;
Global button buttNext, buttPrev;

Global timer delayTrialCheck;
Global XmlDoc trialCheck;

Global timer mouseMonitor, firstload;
Global int lastmousex, lastmousey, returnToMainCntr;

System.onScriptLoaded() {
	
	main = getContainer("main").getLayout("normal");
	
	buttonPL = main.findObject("main.pl");
	mainPL = main.findObject("player.main.pl");
	if (getPrivateInt(getSkinName(),"MainPLVisible",0) == 1) mainPL.show();

	configItem configGroup = Config.getItemByGuid("{F1239F09-8CC6-4081-8519-C2AE99FCB14C}");
	if (configGroup) xfadetime = configGroup.getAttribute("Crossfade time");
	
	configGroup = Config.getItemByGuid("{FC3EAF78-C66E-4ED2-A0AA-1494DFCC13FF}");
	if (configGroup) xfade = configGroup.getAttribute("Enable crossfading");
	
	configGroup = Config.getItemByGuid("{280876CF-48C0-40BC-8E86-73CE6BB462E5}");
	if (configGroup) attrAOT = configGroup.getAttribute("Always on top");
	
	configItem item = Config.getItem("Playlist editor");
	attrRepeat = item.getAttribute("repeat");
	attrShuffle = item.getAttribute("shuffle");
		
	NowPlayingGroup = main.findObject("player.main.cms");
	VISGroup = main.findObject("player.main.vis");
	AVSHolder = VISGroup.findObject("wndhlr.avs");
	VideoHolder = VISGroup.findObject("wndhlr.vid");
	vidButtons = VISGroup.findObject("player.main.vid.buttons");
	avsButtons = VISGroup.findObject("player.main.avs.buttons");
	
	MLHolder = main.findObject("wndhlr.ml");
	mainBrowser = main.findObject("main.browser");
	
	buttonIEPrev = main.findObject("ieprev.button");
	buttonIENext = main.findObject("ienext.button");
	buttonIEReload = main.findObject("ierefresh.button");
	buttonIEStop = main.findObject("iestop.button");
	buttonIEHome = main.findObject("iehome.button");
	homepage = HOMEPAGEURL;
	mainBrowser.navigateURL(homepage);
	
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
	
	//titletext = main.findObject("player.main.title");
	//origtitlealpha = titletext.getAlpha();
	
	indtext = main.findObject("player.main.indicator");
	buttNext = main.findObject("next");
	buttPrev = main.findObject("rev");
	origindalpha = indtext.getAlpha();
	indtext.hide();
	indtextTimer = new Timer;
	indtextTimer.setDelay(1000);
	
	setPrivateInt("Komodo","TUP",1); // this will signal all scripts that 5 day trial is up.
	delayTrialCheck = new Timer;
	delayTrialCheck.setDelay(100);
	delayTrialCheck.start();
	
	//returnToMainCntr = 10;
	//mousemonitor = new Timer;
	//mousemonitor.setDelay(1000);
	
	if (getPrivateInt(getSkinName(),"windowmode", 0) == 0) {
		nosizesave = 1;
		buttonFull.onLeftClick();
	}
	
	if (getPrivateInt("Komodo","First Load",1) == 1) {
		setPrivateInt("Komodo","TSO",0);
		setPrivateInt("Komodo","LTS",0);
		setPrivateInt("Komodo","First Load",0);
		
		firstload = new Timer;
		firstload.setDelay(3000);
		firstload.start();
	};
}

System.onScriptUnloading() {
	delete delayVisShow;
	delete delayClearLocalOpen;
	delete delayRequestPageSwitch;
	delete indtextTimer;
	delete delayTrialCheck;
	//delete mousemonitor;
	
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
		mainBrowser.hide();
		
		if (param=="player.main.vis" || param=="player.main.ml" || param=="player.main.ie") {
			if (param=="player.main.ml") openVIDAVS = OPENML;
			else if (param=="player.main.ie") openVIDAVS = OPENIE;
			else if (openVIDAVS != OPENVID && openVIDAVS != OPENAVS) openVIDAVS = -1;
			
			delayVisShow.start();
			
			if ((isVideo() && openVIDAVS==0) || openVIDAVS == OPENVID) videoname = 1;
		} else {
			if (delayVisShow.isRunning()) delayVisShow.stop();
			openVIDAVS = -1;
		}
		
		/*group temp = NULL;
		temp = main.getObject(param);
		if (temp) {
			newtitle = temp.getXMLParam("name");
			if (videoname) newtitle = "video";
			if (titletext.isGoingToTarget()) titletext.cancelTarget();
			titletext.setTargetA(0);
			titletext.setTargetSpeed(0.5);
			titletext.gotoTarget();
		}*/
	} else if (action=="INDTEXT") {
		indtext.setText(Param);
	} else if (action=="TRIALNOTICE") {
		lockui();
		int res = messagebox("Feature requires full version. \nTo purchase full version click OK.", "Trial Notice",3, "");
		
		if (res == 1) navigateURL(HOMEPAGEURL);
		unlockui();
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
	
	if (!VISGroup.isVisible() && openVIDAVS!=OPENML && openVIDAVS!=OPENIE) return;
	
	localOpen = 1;

	if (openVIDAVS == OPENML) {
		MLHolder.show();
	} else if (openVIDAVS == OPENIE) {
		mainBrowser.show();
	} else if ((isVideo() && openVIDAVS==0) || openVIDAVS == OPENVID) {
		VideoHolder.show();
		vidButtons.show();
	} else {
		AVSHolder.show();
		avsButtons.show();
	}
	delayClearLocalOpen.start();
	
	openVIDAVS = -1;
}

delayClearLocalOpen.onTimer() {
	stop();
	
	localOpen = 0;
}

// title text scripts
/*
titletext.onTargetReached() {
	if (getAlpha()==0) {
		setText(newtitle);
		titletext.setTargetA(origtitlealpha);
		titletext.gotoTarget();
	}
}
*/
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

// xfade main control scripts
xfadetime.onDataChanged() {
	if (getData()!="0" && xfade.getData()!="1") 
		xfade.setData("1");
	if (getData()=="0" && xfade.getData()!="0") 
		xfade.setData("0");
}

// browser controls
mainBrowser.onSetVisible(int on) {
	if (!on) return;
	
	buttonIEHome.onLeftClick();
}

buttonIEPrev.onLeftClick() {
	if (!mainBrowser.isVisible()) return;
	
	mainBrowser.back();
}

buttonIENext.onLeftClick() {
	if (!mainBrowser.isVisible()) return;
	
	mainBrowser.forward();
}

buttonIEReload.onLeftClick() {
	if (!mainBrowser.isVisible()) return;
	
	mainBrowser.refresh();
}

buttonIEStop.onLeftClick() {
	if (!mainBrowser.isVisible()) return;
	
	mainBrowser.stop();
}

buttonIEHome.onLeftClick() {
	if (!mainBrowser.isVisible()) return;
	
	String strArtist = System.urlEncode(System.getPlayitemMetaDataString("artist"));
	String strAlbum = System.urlEncode(System.getPlayitemMetaDataString("album"));
	String strTitle = System.urlEncode(System.getPlayitemMetaDataString("title"));
	
	string currData = "?v="+System.urlEncode(getPrivateString(getSkinName(),"CurrentVersion","1.0")) + "&artist=" + strArtist + "&album=" + strAlbum + "&title=" +strTitle;

	mainBrowser.navigateUrl(homepage+currData);
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
	main.setXMLParam("move","1");
	
	attrAOT.setData(getPrivateString(getSkinName(),"lastAOT","0"));
}

buttonFull.onLeftClick() {
	if (getPrivateInt("Komodo","TUP",0) == 1 && !delayTrialCheck.isRunning()) {
		main.sendAction("TRIALNOTICE", "", 0,0,0,0);
		return;
	}
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
	
	attrAOT.setData("1");
}

attrAOT.onDataChanged() {
	if (pbuttonsFull.isVisible()) return;
	
	setPrivateString(getSkinName(),"lastAOT",getData());
}

main.onResize(int x, int y, int w, int h) {
	if (!pbuttonsFull.isVisible()) return;
	
	if (x!=0 || y!=0 || w!=getMonitorWidth() || h!=getMonitorHeight()) {
		nosizesave=1;
		buttonFull.onLeftClick();
	}
}

main.onMove() {
	if (!pbuttonsFull.isVisible()) return;
	
	if (main.getLeft()!=0 || main.getTop()!=0) {
		nosizesave=1;
		buttonFull.onLeftClick();
	}
}

topbar.onLeftButtonDblClk(int x, int y) {
	buttonFull.onLeftClick();
}

firstload.onTimer() {
	stop();
	
	main.sendAction("REQUESTSWITCHPAGE", "", 0,0,4,0);
	
	if (pbuttonsFull.isVisible()) {
		if (main.getLeft()!=0 || main.getTop()!=0) {
			nosizesave=1;
			buttonFull.onLeftClick();
		}
	}
}

// **** section disabled for now
// this monitors mouse activity. 
/*mousemonitor.onTimer() {
	int mx = getMousePosX();
	int my = getMousePosY();
	
	if (mx != lastmousex || my != lastmousey && isAppActive()) {
		lastmousex = mx;
		lastmousey = my;
		returnToMainCntr = 10;
	} else {
		
		if (returnToMainCntr <= 0) {
			
			returnToMainCntr = 10;
			if (!NowPlayingGroup.isVisible()) main.sendAction("REQUESTSWITCHPAGE", "", 0,0,0,0);
		} else {
			returnToMainCntr--;
			//indtext.setText("cd: "+integertostring(returnToMainCntr));
		}
	}
}

NowPlayingGroup.onSetVisible(int on) {
	if (on) 
		mousemonitor.stop();
	else {
		mousemonitor.start();}
}*/


// ***************** TRIAL CHECK UP ************************
delayTrialCheck.onTimer() {
	stop();

	xfadetime.onDataChanged();
	
	string path = Application.GetSettingsPath()+"\winamp.ini";
	
	file trialDataFile = new file;
	trialDataFile.load(path);
	int exist = trialDataFile.exists();
	delete trialDataFile;
	
	if (!exist) {
		messagebox("Invalid install, please reinstall.\nSome functions will be disabled.", "Install Error", 0, "");
		setPrivateInt("Komodo","TUP",1);
		return;
	}
	
	path = path + ":komtrial";
	//path = Application.GetSettingsPath()+"\\trial.xml";

	trialCheck = new XmlDoc;
	trialCheck.load(Path);
	trialCheck.parser_addCallback("simpleTrialXML/stamp");
	trialCheck.parser_start();
	trialCheck.parser_destroy();	

	
	if (getPrivateInt("Komodo","TUP",0) == 1) {
		if (pbuttonsFull.isVisible()) {
			buttonWindow.onLeftClick();
		}
		togglebutton bgdef = main.findObject("config.button.default");
		
		bgdef.leftClick();
	}
}

trialCheck.parser_onCallback (String xmlpath, String xmltag, list paramname, list paramvalue) {
	xmltag = strlower(xmltag);

	if (xmltag == "stamp") {

		int stamp;
		float hash, unhash;

		int c = paramname.findItem("value");
		int h = paramname.findItem("hash");
		int u = paramname.findItem("unlock");
		unhash = -1;
		if (c>=0) {
			stamp = stringToInteger(paramvalue.enumItem(c));
			hash = stringToFloat(paramvalue.enumItem(h));
			if (u >= 0) unhash = stringToFloat(paramvalue.enumItem(u));
			
			int forhash = stamp % 10000;
			int t = forhash/666;
			int forhash2 = stamp / 10000;
			float calcunhash = t * sqrt(forhash+forhash2); // trunctated after 4 digits
			
			float diff = unhash - calcunhash;
			if (diff < 0.0002 && diff > -0.0002 && unhash > 0) { //if matches the unlock code, remove all locks.
				setPrivateInt("Komodo","TUP",0);
				
				if (getPrivateInt("Komodo","FirstLoadUnlocked",1) == 1) {
					setPrivateInt("Komodo","FirstLoadUnlocked",0);
					messagebox("All features unlocked.", "Komodo",0, "");
				}
				return;
			}
					
			int prehash = stamp % 10000;
			float calchash = sin(prehash);
			if (calchash < 0) calchash = -calchash; // no abs function in maki.
			calchash = ln(prehash*calchash);
			
			float diff = hash - calchash;
						
			if (diff < 0.0002 && diff > -0.0002) {
				int stampoffset = getPrivateInt("Komodo","TSO",0);
				if (stampoffset < 0) stampoffset = 0;
				stamp = stamp - stampoffset;
				
				int currentDate = getDate();
				int lastDate = getPrivateInt("Komodo","LTS",0); // LTS = last time stamp
				if (currentDate < lastDate) { // used if people gets smart and start changing system time
					setPrivateInt("Komodo","TSO",lastDate-currentDate); // TSO = time stamp offset
					
					
					currentDate = lastDate;
				}
				setPrivateInt("Komodo","LTS",currentDate);
				
				int trialelapsed = (currentDate-stamp)/864; //24*60*60/100 = 864
				int res = 0;
				if (trialelapsed > 500) {
					setPrivateInt("Komodo","TUP",1);
					res = messagebox("Trial expired. Some functions will be disabled.\nTo purchase full version click OK.", "Trial Expired",3, "");
				} else {
					int daysleft = trialelapsed/100;
					daysleft = 5-daysleft;
					
					// only displays trial notice once-a-day.
					if (daysleft != getPrivateInt("Komodo","LDL",-1)) { // LDL = last days left
						res = messagebox(integertostring(daysleft)+" trial days left. \nTo purchase full version click OK.", "Trial Notice",3, "");
						setPrivateInt("Komodo","LDL",daysleft);
					}
					setPrivateInt("Komodo","TUP",0);
				}
				
				if (res == 1) navigateURL(HOMEPAGEURL);
			} else {
				setPrivateInt("Komodo","TUP",1);
				messagebox("Invalid install, please reinstall.\nSome functions will be disabled.", "Install Error", 0, "");
				return;
			}
		} else {
			setPrivateInt("Komodo","TUP",1);
			messagebox("Invalid install, please reinstall.\nSome functions will be disabled.", "Install Error", 0, "");
			return;
		}
		
		
	}
}