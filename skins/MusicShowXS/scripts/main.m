/*************************************************************

	main.m
	by leechbite.com
	
	main script. handles focus bg.

*************************************************************/

#include <lib/std.mi>
#include <lib/config.mi>

#define VID_GUID "{F0816D7B-FFFC-4343-80F2-E8199AA15CC3}"
#define AVS_GUID "{0000000A-000C-0010-FF7B-01014263450C}"
#define SKINTWEAKS_CFGPAGE "{0542AFA4-48D9-4c9f-8900-5739D52C114F}"

Global layout main; 

Global button buttonPL;
Global guiobject mainPL;

Global vis vis1, vis2;
Global layer vismousetrap;

Global configAttribute xfade, xfadetime, PSOVC;

Global group VISGroup;
Global WindowHolder AVSHolder, VideoHolder;
Global int localOpen, openAVS;
Global timer delayVisShow, delayClearLocalOpen;

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
	
	xfadetime.onDataChanged();
	
	VISGroup = main.findObject("player.main.vis");
	AVSHolder = VISGroup.findObject("wndhlr.avs");
	VideoHolder = VISGroup.findObject("wndhlr.vid");
	
	delayVisShow = new Timer;
	delayVisShow.setDelay(1000);
	
	delayClearLocalOpen = new Timer;
	delayClearLocalOpen.setDelay(1000);
	localOpen = 0;
	openAVS = 1;
	
	configGroup = Config.getItem(SKINTWEAKS_CFGPAGE);
    if (configGroup) {
        ConfigAttribute PSOVC = configGroup.getAttribute("Prevent video playback Stop on video window Close");
        if (PSOVC) PSOVC.setData("1");
    }
	
	main.resize(0,0, getMonitorWidth(), getMonitorHeight());
}

System.onScriptUnloading() {
	delete delayVisShow;
	
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
VISGroup.onSetVisible(int on) {
	if (on) delayVisShow.start();
}

system.onGetCancelComponent(String curguid, boolean goingvisible) {
	if (!goingvisible) return FALSE;
	
	if (curguid == VID_GUID) {
		if (localOpen) return FALSE;
		else {
			main.sendAction("REQUESTSWITCHPAGE", "", 0,0,2,0); // switches to page 3
			openAVS = 0;
			return TRUE;
		}
	}
	if (curguid == AVS_GUID) {
		if (localOpen) return FALSE;
		else {
			main.sendAction("REQUESTSWITCHPAGE", "", 0,0,2,0);
			openAVS = 1;
			return TRUE;
		}
	}
	
	return FALSE;

}

main.onAction(String action, String param, Int x, int y, int p1, int p2, GuiObject source) {
	action = strupper(action);
	param = strupper(param);
	if (action=="SWITCHPAGE") {
		if (param!="player.main.vis") {
			AVSHolder.hide();
			VideoHolder.hide();
		}
	}
}

delayVisShow.onTimer() {
	stop();
	
	localOpen = 1;
	if (isVideo() || !openAVS)
		VideoHolder.show();
	else
		AVSHolder.show();
	delayClearLocalOpen.start();
	
	openAVS = 1;
}

delayClearLocalOpen.onTimer() {
	stop();
	
	localOpen = 0;
}

// xfade main control scripts
xfadetime.onDataChanged() {
	if (getData()!="0") 
		xfade.setData("1");
	else
		xfade.setData("0");
}
