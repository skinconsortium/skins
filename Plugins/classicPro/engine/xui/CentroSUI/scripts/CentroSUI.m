#include <lib/std.mi>
#include <lib/pldir.mi>

#define VIDEO_GUID "{F0816D7B-FFFC-4343-80F2-E8199AA15CC3}"
#define VIS_GUID "{0000000A-000C-0010-FF7B-01014263450C}"
#define ML_GUID "{6B0EDF80-C9A5-11D3-9F26-00C04F39FFC6}"
#define CE_GUID "{00000000-0000-0000-0000-000000000000}"
#define CON_GUID "{7383A6FB-1D01-413B-A99A-7E6F655F4591}"
#define LIR_GUID "{7A8B2D76-9531-43B9-91A1-AC455A7C8242}"
#define DL_GUID "{A3EF47BD-39EB-435A-9FB3-A5D87F6F17A5}"
#define PL_GUID "{45F3F7C1-A6F3-4EE6-A15E-125E92FC3F8D}"
#define JTF_GUID "{5F8D8373-EAA7-4390-B5AB-402E86A5F9DD}"

#define DEFAULT_TAB_ORDER "0;1;2;3;4;5;6"
#define TAB_STATSUSBAR_HIDE "Hide Component Buttons for this tab"
#define TAB_STATSUSBAR_SHOW "Show Component Buttons for this tab"
#define TAB_TABSELECT "Select Visible deactive tabs"
#define TAB_TABDEACTIVE "Hide this tab when inactive?"

#define myDelay 10

#define CODE_MARTIN //

Function openMainLayoutNow();
Function setDrawer(boolean onOff);
Function openTabNo(int tabNo);
Function spaceTabs(boolean important);
Function openMini(int miniNo);
Function refreshComponentButtons();
Function initTabSubMenu();
Function updateTabButtonStates();
Function updateTabShow();
Function setTabSubMenuResult(int sel);
Function setMainFrame(boolean open);

// new dynamic tabs (dynamic size, custom position, hideable..will show again when system trigger it ;)
Function tab_SetText(int tab, int limit);
Function tab_SetX(int tab, int x);
Function int tab_GetX(int tab);
Function int tab_GetW(int tab);
Function int tab_isVisible(int tab);
Function setDividerX(int x1);
Function int tab_GetTotalW();
Function moveTab(int tab, int newpos);
Function String replaceString(string baseString, string toreplace, string replacedby);

Function setFrame1();
Function setFrame2(int pos, int h);

Global Group xuiGroup, tab_library, tab_video, tab_avs, tab_Browser, tab_Playlist, tab_Other, tab_Widget, drawer, mainTabsheet;
Global Group area_left, area_right, area_mini, area_right_pl, ocFrame, tabsGroup;
Global Group mini_Cover, mini_Video, mini_AVS, mini_SavedPL;
Global Group tabbut_vid, tabbut_avs, tabbut_pl, browserGroup;

Global Container player;
Global Layout normal;
Global PopUpMenu popMenu, tabMenu;

Global Browser xuiBrowser;

Global GuiObject visRectBg, tempbutton, nowPlaying;

Global Button but_miniGoto, closeFrame, openFrame;

Global Text visName, plText1, plText2;

Global ToggleButton tog_library, tog_video, tog_avs, tog_Browser, tog_Playlist, tog_Other, tog_NowPlay, tog_drawer;
Global GuiObject tog_library1, tog_video1, tog_avs1, tog_Browser1, tog_Playlist1, tog_Other1, tog_Widget1, tog_fake1, guihold_Pl2;
Global WindowHolder hold_Other, hold_Pl1, hold_Pl2, hold_vid, hold_avs, hold_ml;

Global Frame mainFrame, plFrame;
Global Timer openMainLayout, openDefaultTab, refreshAIOTab, checkVisName, ssWinHol;
Global GuiObject main_Frame;
Global boolean openLib, openVid, openVis, loaded, open_drawer, skipLoad, mouseDownF1, mouseDownF2, busyWithDrawer, busyWithThisFunction, wasTabTrig, stopResizeRight, openMePlease, delayStart;
Global int default_drawer_h, active_tab, tab_openned, delayStartTab;
Global String guid_blacklist, tabNames, closeGUID;


//dynamic tabs
Global boolean tabMouseDown, mmove;
Global GuiObject tabDivider;
Global int lastDivider, downX, lastSpaceTab;

// Preview Tip
Global Timer waitForPreview;
Global Container preview_container;
Global Layout preview_layout;
Global GuiObject preview_video, preview_video_1;

CODE_MARTIN start
Global ComponentBucket dummyBuck;
Global GuiObject customObj;
CODE_MARTIN end

System.onScriptLoaded() {
	delayStart=true;
	delayStartTab=0;

	player = getContainer("main");
	normal = player.getLayout("normal");

	preview_container = newDynamicContainer("preview");
	preview_layout = preview_container.getLayout("normal");
	preview_video = preview_layout.findObject("preview1_1");
	preview_video_1 = preview_layout.findObject("preview1_2");

	active_tab = getPublicInt("cPro.lastComponentPage", 0);
	tab_openned = -1;
	lastSpaceTab = 0;
	

	xuiGroup = getScriptGroup();
	mainTabsheet = xuiGroup.findObject("centro.componentsheet");
	mainFrame = xuiGroup.findObject("centro.mainframe");
	plFrame = xuiGroup.findObject("centro.plframe");

	ocFrame = xuiGroup.findObject("centro.componentsheet.opencloseframe");
	tabsGroup = xuiGroup.findObject("centro.componentsheet.tabs");
	
	visName = xuiGroup.findObject("centro.visname");
	
	closeFrame = xuiGroup.findObject("close.rightframe");
	openFrame = xuiGroup.findObject("open.rightframe");

	tabDivider = xuiGroup.findObject("centro.tabdivider");

	drawer = xuiGroup.findObject("centro.multidrawer");

	// Reader for albumart gradient
	Map myMap = new Map;
	myMap.loadMap("wasabi.list.background");
	nowPlaying = xuiGroup.findObject("nowplaying.component");
	nowPlaying.setXmlParam("bgcolor", integerToString(myMap.getARGBValue(0,0,2))+","+integerToString(myMap.getARGBValue(0,0,1))+","+integerToString(myMap.getARGBValue(0,0,0)));
	delete myMap;

	//Tab Component Buttons
	tabbut_vid = xuiGroup.findObject("centro.video.buttons");
	tabbut_avs = xuiGroup.findObject("centro.visualization.buttons");
	tabbut_pl = xuiGroup.findObject("centro.playlist2.buttons");

	//Mini Area
	but_miniGoto = xuiGroup.findObject("comp.goto");
	mini_Cover = xuiGroup.findObject("centro.playlist.directory.cov");
	mini_Video = xuiGroup.findObject("centro.playlist.directory.vid");
	mini_AVS = xuiGroup.findObject("centro.playlist.directory.vis");
	mini_SavedPL = xuiGroup.findObject("centro.playlist.directory.spl");

	plText1 = xuiGroup.findObject("centro.playlist.pltext1");
	plText2 = xuiGroup.findObject("centro.playlist.pltext2");

///////////////////////
	xuiBrowser = xuiGroup.findObject("cpro.browser");
	browserGroup = xuiGroup.findObject("cpro.browser");

	tempbutton = browserGroup.findObject("browser.navigate");
	tempbutton.setXmlParam("text", "Go");
	tempbutton = browserGroup.findObject("search.go");
	tempbutton.setXmlParam("text", "Search");
	
	Map myMap = new Map;
	myMap.loadMap("browser.fullpng");
	
	if(myMap.getWidth()>=284){
		tempbutton = browserGroup.findObject("browser.scraper").findObject("browser.dlds.settings");
		tempbutton.setXmlParam("icon_id", "browser.button.settings2");
		
		tempbutton = browserGroup.findObject("dlds.mode").findObject("scraper.switch");
		tempbutton.setXmlParam("icon_id", "browser.button.scraper2");
		tempbutton = browserGroup.findObject("dlds.mode").findObject("dlds.switch");
		tempbutton.setXmlParam("icon_id", "browser.button.dlds2");

		tempbutton = browserGroup.findObject("scraper.mode").findObject("scraper.switch");
		tempbutton.setXmlParam("icon_id", "browser.button.scraper2");
		tempbutton = browserGroup.findObject("scraper.mode").findObject("dlds.switch");
		tempbutton.setXmlParam("icon_id", "browser.button.dlds2");

	}
	delete myMap;

//////////////////

	
	tab_library = xuiGroup.findObject("centro.library");
	tab_video = xuiGroup.findObject("centro.video");
	tab_avs = xuiGroup.findObject("centro.visualization");
	tab_Browser = xuiGroup.findObject("centro.browser");
	tab_Playlist = xuiGroup.findObject("centro.playlist2");
	tab_Other = xuiGroup.findObject("centro.other");
	tab_Widget = xuiGroup.findObject("centro.widget");
	tog_drawer = xuiGroup.findObject("tog.drawer");
	
	area_left = xuiGroup.findObject("centro.components");
	area_right = xuiGroup.findObject("centro.playlist1");
	area_right_pl = xuiGroup.findObject("centro.playlist.component"); 
	area_mini = xuiGroup.findObject("centro.playlist.directory");

	hold_Pl1 = xuiGroup.findObject("centro.windowholder.playlist1");
	hold_Pl2 = xuiGroup.findObject("centro.windowholder.playlist2");
	guihold_Pl2 = xuiGroup.findObject("centro.windowholder.playlist2");
	hold_vid = xuiGroup.findObject("centro.windowholder.video");
	hold_avs = xuiGroup.findObject("centro.windowholder.visualization");
	hold_ml = xuiGroup.findObject("centro.windowholder.library");
	
	visRectBg = xuiGroup.findObject("centro.windowholder.visualization.bg");

	tog_library = xuiGroup.findObject("centro.tabtog.0");
	tog_video = xuiGroup.findObject("centro.tabtog.1");
	tog_avs = xuiGroup.findObject("centro.tabtog.2");
	tog_Browser = xuiGroup.findObject("centro.tabtog.3");
	tog_Playlist = xuiGroup.findObject("centro.tabtog.4");
	tog_Other = xuiGroup.findObject("centro.tabtog.5");
	tog_NowPlay = xuiGroup.findObject("centro.tabtog.6");

	tog_library1 = xuiGroup.findObject("centro.tabtog.0");
	tog_video1 = xuiGroup.findObject("centro.tabtog.1");
	tog_avs1 = xuiGroup.findObject("centro.tabtog.2");
	tog_Browser1 = xuiGroup.findObject("centro.tabtog.3");
	tog_Playlist1 = xuiGroup.findObject("centro.tabtog.4");
	tog_Other1 = xuiGroup.findObject("centro.tabtog.5");
	tog_Widget1 = xuiGroup.findObject("centro.tabtog.6");

	CODE_MARTIN start
	dummyBuck = xuiGroup.findObject("widget.loader.mini");
	customObj = xuiGroup.findObject("widget.holder.mini");
	CODE_MARTIN end
		
	default_drawer_h = 150;
	open_drawer=false;
	guid_blacklist=="";
	skipLoad=true;

	hold_Other = xuiGroup.findObject("centro.windowholder.other");

	openMainLayout = new Timer;
	openMainLayout.setDelay(myDelay);
	waitForPreview = new Timer;
	waitForPreview.setDelay(400);
	openDefaultTab = new Timer;
	openDefaultTab.setDelay(myDelay);
	refreshAIOTab = new Timer;
	refreshAIOTab.setDelay(myDelay);
	checkVisName = new Timer;
	checkVisName.setDelay(500);
	ssWinHol = new Timer;
	ssWinHol.setDelay(66);
	
	//Saved Settings
	openMini(getPublicInt("cPro.lastMini", 0));
	setDrawer(getPublicInt("cPro.draweropened", 0));
	refreshComponentButtons();
}
System.onscriptunloading(){
	delete waitForPreview;
	delete openMainLayout;
	delete openDefaultTab;
	delete refreshAIOTab;
	delete checkVisName;
	delete ssWinHol;
}

xuiGroup.onSetVisible(boolean onOff){
	if(skipLoad && 	!wasTabTrig){
		int pageNo = getPublicInt("cPro.lastComponentPage", 0);
		if(pageNo==5) pageNo=0;
		openTabNo(pageNo);
		ssWinHol.start();
		skipLoad=false;
	}
	
	//if(onOff) setDrawer(getPublicInt("cPro.draweropened", 0));
	
	if(mainFrame.getPosition()==0){
		area_right.hide();
	}
	
	spaceTabs(true); //true because this is important check.. so dont mind if this is double check.... else it wont show correct on skin start
}

tab_SetText(int tab, int limit){
	tog_fake1 = xuiGroup.findObject("centro.tabtog." + getToken(getPublicString("cPro.tabOrder", DEFAULT_TAB_ORDER), ";", tab));

	int tokenNo = stringToInteger(getToken(getPublicString("cPro.tabOrder", DEFAULT_TAB_ORDER), ";", tab));
	
	String pluginName = "";
	if(stringToFloat(System.getWinampVersion())>5.531) pluginName = hold_Other.getComponentName();
	
	if (pluginName=="") pluginName="Plugin";
	
	String tabnames;
	if(limit==0)  tabnames = "Media Library;Video;Visualization;Browser;Playlist;"+pluginName+";AlbumArt";
	else if(limit==1)  tabnames = "ML;Vid;Vis;Bro;PL;"+System.strleft(pluginName, 3)+";Art";
	else if(limit==2)  tabnames = "M;V;V;B;P;"+System.strleft(pluginName, 1)+";W";

	tog_fake1.setXmlParam("tabtext", getToken(tabnames, ";", tokenNo));
}

tab_SetX(int tab, int x){
	tog_fake1 = xuiGroup.findObject("centro.tabtog." + getToken(getPublicString("cPro.tabOrder", DEFAULT_TAB_ORDER), ";", tab));
	tog_fake1.setXmlParam("x", integerToString(x));
}
int tab_GetX(int tab){
	tog_fake1 = xuiGroup.findObject("centro.tabtog." + getToken(getPublicString("cPro.tabOrder", DEFAULT_TAB_ORDER), ";", tab));
	return stringToInteger(tog_fake1.getXmlParam("x"));
}
int tab_GetW(int tab){
	tog_fake1 = xuiGroup.findObject("centro.tabtog." + getToken(getPublicString("cPro.tabOrder", DEFAULT_TAB_ORDER), ";", tab));
	return tog_fake1.getWidth();
}
int tab_isVisible(int tab){
	tog_fake1 = xuiGroup.findObject("centro.tabtog." + getToken(getPublicString("cPro.tabOrder", DEFAULT_TAB_ORDER), ";", tab));
	return tog_fake1.isVisible();
}
int tab_GetTotalW(){
	//int output = tab_GetX(0);
	int output = 2;
	for(int i = 0;i<7;i++){
		output+=tab_GetW(i)*tab_isVisible(i);
	}
	return output;
}

setDividerX(int x1){
	int output, itempos;
	
	if(x1<tab_GetW(0)/2 && tab_isVisible(0)){
		output=tab_GetX(0);
		itempos=0;
	}
	else if(x1<tab_GetX(1)+tab_GetW(1)/2 && tab_isVisible(1)){
		output=tab_GetX(1);
		itempos=1;
	}
	else if(x1<tab_GetX(2)+tab_GetW(2)/2 && tab_isVisible(2)){
		output=tab_GetX(2);
		itempos=2;
	}
	else if(x1<tab_GetX(3)+tab_GetW(3)/2 && tab_isVisible(3)){
		output=tab_GetX(3);
		itempos=3;
	}
	else if(x1<tab_GetX(4)+tab_GetW(4)/2 && tab_isVisible(4)){
		output=tab_GetX(4);
		itempos=4;
	}
	else if(x1<tab_GetX(5)+tab_GetW(5)/2 && tab_isVisible(5)){
		output=tab_GetX(5);
		itempos=5;
	}
	else if(x1<tab_GetX(6)+tab_GetW(6)/2 && tab_isVisible(6)){
		output=tab_GetX(6);
		itempos=6;
	}
	else{
		output=tab_GetTotalW();
		itempos=7;
	}
	
	output-=3;
	lastDivider=itempos;
	tabDivider.setXmlParam("x", integerToString(output));
}

moveTab(int tab, int newpos){
	String z = getPublicString("cPro.tabOrder", DEFAULT_TAB_ORDER);
	z = replaceString(z, integerToString(tab), "x");

	if(newpos==0) z = integerToString(tab)+";"+z;
	else if(newpos==7) z = z +";"+integerToString(tab);
	else{
		String temp1 = strleft(z, newpos*2);
		String temp2 = strright(z, 13-newpos*2);
		z= temp1+integerToString(tab)+";"+temp2;
	}
	z = replaceString(z, "x;", "");
	z = replaceString(z, ";x", "");
	setPublicString("cPro.tabOrder", z);
	spaceTabs(true); //width wasnt change so need it to be true to force update ;)
}
String replaceString(string baseString, string toreplace, string replacedby) {
	if (toreplace == "") return baseString;
	string sf1 = strupper(baseString);
	string sf2 = strupper(toreplace);
	int i = strsearch(sf1, sf2);
	if (i == -1) return baseString;
	string left = "", right = "";
	if (i != 0) left = strleft(baseString, i);

	if (strlen(basestring) - i - strlen(toreplace) != 0) {
		right = strright(basestring, strlen(basestring) - i - strlen(toreplace));
	}
	return left + replacedby + right;
}


spaceTabs(boolean important){
	if(!xuiGroup.isVisible()) return;
	//area_left
	int oc = 50;
	if(!ocFrame.isVisible()) oc = 26;
	
	if(lastSpaceTab == area_left.getWidth()-oc && !important) return; //dont need to check the same width again ;) ... if important do it anyway ;)
	lastSpaceTab = area_left.getWidth()-oc;
	
	//Set text of all the tabs to the biggest version
	for(int i=0;i<=6;i++){
		tab_SetText(i, 0);
	}

	int totalTabW;
	if(!skipLoad){
		for(int noLongTabs=14; noLongTabs>0; noLongTabs--){
			totalTabW = tab_GetTotalW();
			
			if(area_left.getWidth()-oc<totalTabW){
				if(noLongTabs>7) tab_SetText(noLongTabs-8, 1);  //make sure about this!
				else tab_SetText(noLongTabs-1, 2);
			}
			else break;
		}
	}
	//mainFrame.setXmlParam("maxwidth", integerToString(-totalTabW-50));
	
	//Set position of all the tab buttons
	tab_SetX(0, 2);
	for(int i=1;i<=6;i++){
		tab_SetX(i, tab_GetX(i-1)+tab_GetW(i-1)*tab_isVisible(i-1));
	}
}

System.onSetXuiParam(String param, String value) {
	if(strlower(param) == "enable_drawer"){
		setDrawer(stringToInteger(value));
	}
	else if(strlower(param) == "drawer_h"){
		default_drawer_h = stringToInteger(value);
		setDrawer(open_drawer);
	}
	else if(strlower(param) == "guid_blacklist"){
		guid_blacklist = value;
	}
}
setDrawer(boolean onOff){
	busyWithDrawer=true;
	boolean dontSave = false;

	if(xuiGroup.getHeight()<default_drawer_h+90){ //0 = first load... not drawn yet
		onOff=false;
		dontSave=true;
	}
	
	//drawer = xuiGroup.findObject("centro.multidrawer");
	if(onOff){
		drawer.show();
		drawer.setXmlParam("y", integerToString(default_drawer_h*-1));
		drawer.setXmlParam("h", integerToString(default_drawer_h));
		mainTabsheet.setXmlParam("h", integerToString(default_drawer_h*-1-4));
		tog_drawer.setXmlParam("tooltip", "Close drawer");
		open_drawer=true;
	}
	else{
		drawer.hide();
		drawer.setXmlParam("y", "0");
		drawer.setXmlParam("h", "0");
		mainTabsheet.setXmlParam("h", "0");
		open_drawer=false;
		tog_drawer.setXmlParam("tooltip", "Open drawer");
	}
	tog_drawer.setActivated(open_drawer);

	if(!dontSave){
		setPublicInt("cPro.draweropened", open_drawer);
	}
	busyWithDrawer=false;
}
tog_drawer.onToggle(Boolean onoff){
	setDrawer(onoff);
}

drawer.onSetVisible(boolean onOff){
	//setDrawer(onOff);
	if(!busyWithDrawer) setDrawer(getPublicInt("cPro.draweropened", 0));
}

System.onOpenUrl(string url){
	//openTabNo(3);
	return 1;
}

System.onGetCancelComponent(String guid, boolean goingvisible){
	//debugstring(guid,9);
	// Check to see if this component is on the blacklist, and if it is, it will open in its own window or just close it...
	for(int i=0;i<10;i++){
		if(getToken(guid_blacklist, ";", i)== guid){
			return false;
		}
		else if(getToken(guid_blacklist, ";", i)== ""){
			break;
		}
	}

	//debug(integerToString(goingvisible)+guid);
	//If a component want to open (else = close)
	if(goingvisible){
		
		openMainLayoutNow();

		//Resize player bigger on component activity if size is to small
		if(xuiGroup.getheight()<10){
			normal.resize(getCurAppLeft(),getCurAppTop(),getCurAppWidth(), 300);
		}
		
		if(guid == PL_GUID){ //Playlist
			if(mainFrame.getPosition()==0){
				hold_Pl2.setXmlParam("autoopen", "0");
				openTabNo(4);
				hold_Pl2.setXmlParam("autoopen", "1");
			}
		}
		else if(guid == ML_GUID){
			if(active_tab!=0){
				hold_ml.setXmlParam("autoopen", "0");
				openTabNo(0);
				hold_ml.setXmlParam("autoopen", "1");
			}
		}
		else if(guid == VIDEO_GUID){
			if(setPublicInt("cPro.lastMini", 0)==1 && area_mini.isVisible()){
				//do nothing
			}
			else if(active_tab!=1){
				hold_vid.setXmlParam("autoopen", "0");
				openTabNo(1);
				hold_vid.setXmlParam("autoopen", "1");
			}
		}
		else if(guid == VIS_GUID){
			if(getPublicInt("cPro.lastMini", 0)==2 && area_mini.isVisible()){
				//do nothing
			}
			else if(getPublicInt("cPro.lastDrawer", 0)==3 && open_drawer){
				//do nothing
			}
			else if(active_tab!=2){
				hold_avs.setXmlParam("autoopen", "0");
				openTabNo(2);
				hold_avs.setXmlParam("autoopen", "1");
			}
		}
		else{
			if(active_tab!=5){
				openTabNo(5);
			}
			else{
				hold_Other.hide();
				hold_Other.setXMLParam("hold", "");
				hold_Other.show();
				hold_Other.setXMLParam("hold", "@all@");
			}
			refreshAIOTab.start();
			return false;
		}
		spaceTabs(true);
		
		if(delayStart) return true; //dont try to open component because its not visible yet!
		return false;
	}
	else{
		closeGUID = guid;
		
		if(delayStart) return false; //somehow if this is here then the if you close with vid tab last open it wont timmy on start
		
		openDefaultTab.start();
		return true;
	}
}

refreshAIOTab.onTimer(){
	spaceTabs(true);
	refreshAIOTab.stop();
}

openDefaultTab.onTimer(){
	openDefaultTab.stop();
	//debugString(closeGUID,9);
	//debugstring("openDefaultTab.onTimer()",9);

	if(closeGUID == PL_GUID){ //PL
		if(mainFrame.getPosition()!=0){
			//mainFrame.setPosition(0);
			setMainFrame(false);
			return;
		}
	}
	else if(closeGUID == VIDEO_GUID){
		if(getPublicInt("cPro.lastMini", 0)==1){	//video is openned in mini view
			openMini(0);
			return;
		}
	}
	else if(closeGUID == VIS_GUID){
		if(getPublicInt("cPro.lastDrawer", 0)==3 && open_drawer){
			drawer.sendAction ("switch_to_drawer", "", 0, 0, 0, 0);
			return;
		}
		else if(getPublicInt("cPro.lastMini", 0)==2){
			openMini(0);
			return;
		}
	}

	if(active_tab==0){
		openTabNo(1);
	}
	else{
		openTabNo(0);
	}
	spaceTabs(true);
}

updateTabShow(){

	if(getPublicInt("cPro.tab.onoff.0", 1)==1 || active_tab==0) tog_library1.show();
	else tog_library1.hide();

	if(getPublicInt("cPro.tab.onoff.1", 1)==1 || active_tab==1) tog_video1.show();
	else tog_video1.hide();

	if(getPublicInt("cPro.tab.onoff.2", 1)==1 || active_tab==2) tog_avs1.show();
	else tog_avs1.hide();

	if(getPublicInt("cPro.tab.onoff.3", 1)==1 || active_tab==3) tog_Browser1.show();
	else tog_Browser1.hide();

	if(getPublicInt("cPro.tab.onoff.4", 1)==1 || active_tab==4) tog_Playlist1.show();
	else tog_Playlist1.hide();
	
	if(getPublicInt("cPro.tab.onoff.6", 1)==1 || active_tab==6) tog_Widget1.show();
	else tog_Widget1.hide();

	if(active_tab==5) tog_Other1.show();
	else tog_Other1.hide();
	
	spaceTabs(true);	//true because when user hides it the width wasnt change since last check
}

updateTabButtonStates(){
	tog_library.setActivated(0);
	tog_video.setActivated(0);
	tog_avs.setActivated(0);
	tog_Browser.setActivated(0);
	tog_Playlist.setActivated(0);
	tog_Other.setActivated(0);
	tog_NowPlay.setActivated(0);

	if(active_tab==1) tog_video.setActivated(1);
	else if(active_tab==2) tog_avs.setActivated(1);
	else if(active_tab==3) tog_Browser.setActivated(1);
	else if(active_tab==4) tog_Playlist.setActivated(1);
	else if(active_tab==5) tog_Other.setActivated(1);
	else if(active_tab==6) tog_NowPlay.setActivated(1);
	else tog_library.setActivated(1);

}

openTabNo(int tabNo){
	if(delayStart && tabNo!=5){
		delayStartTab=tabNo;
		return;
	}
	else if(delayStart) delayStartTab=tabNo;
	//debugstring("openTabNo()="+integerToString(tabNo),9);

	if(busyWithThisFunction) return;
	busyWithThisFunction=true;
	
	if(skipLoad) wasTabTrig=true;
	active_tab = tabNo;
	
	if(active_tab!=tab_openned){ //check to see if the current tab is already opened...
		tab_library.hide();
		tab_video.hide();
		tab_avs.hide();
		tab_Browser.hide();
		tab_Playlist.hide();
		tab_Other.hide();
		tab_Widget.hide();
	}
	
	updateTabButtonStates();
	tab_openned = tabNo;
	
	if(tabNo==1){
		if(getPublicInt("cPro.lastMini", 0)==1){
			openMini(0);
		}
		//close any video tip
		waitForPreview.stop();
		preview_layout.hide();

		tab_video.show();
		tog_video.setActivated(1);
	}
	else if(tabNo==2){
		if(getPublicInt("cPro.lastMini", 0)==2){
			openMini(0);
		}
		if(getPublicInt("cPro.lastDrawer", 0)==3){
			drawer.sendAction ("switch_to_drawer", "", 0, 0, 0, 0); //close drawer vis
		}	
		tab_avs.show();
		tog_avs.setActivated(1);
		checkVisName.start();
	}
	else if(tabNo==3){
		tab_Browser.show();
		tog_Browser.setActivated(1);
	}
	else if(tabNo==4){
		if(mainFrame.getPosition()!=0) setMainFrame(false); //if not closed.. close sideview
		tab_Playlist.show();
		tog_Playlist.setActivated(1);
	}
	else if(tabNo==5){
		tab_Other.show();
		tog_Other.setActivated(1);
		tog_Other1.show();
	}
	else if(tabNo==6){
		tab_Widget.show();
		tog_NowPlay.setActivated(1);
		tog_Widget1.show();
	}
	else{
		tab_library.show();
		tog_library.setActivated(1);
		//pjn123 add show tab?
	}
	
	if(tabNo!=5){
		tog_Other1.hide();
	}
	
	if(tabNo!=-1){
		setPublicInt("cPro.lastComponentPage", tabNo);
	}
	updateTabShow();
	busyWithThisFunction=false;
	spaceTabs(true);
}

checkVisName.onTimer(){
	checkVisName.stop();
	if(tab_openned==2)	visName.setText(hold_avs.getComponentName());
}

openMainLayoutNow(){
	Boolean isShade = (player.getCurLayout() != normal);
	if(isShade)	openMainLayout.start();
}
openMainLayout.onTimer(){
	player.switchToLayout("normal");
	openMainLayout.stop();
}

/* --------------
	tog_library.setActivated(0);
	tog_video.setActivated(0);
	tog_avs.setActivated(0);
	tog_Browser.setActivated(0);
	tog_Playlist.setActivated(0);
	tog_Other.setActivated(0);

*/
tog_library.onLeftButtonDown(int x, int y){
	tabMouseDown=true;
	mmove=false;
	downX=x;
}
tog_library.onLeftButtonUp(int x, int y){
	if(tabMouseDown){
		tabMouseDown=false;
		if(mmove){
			tog_library1.setAlpha(255);
			tabDivider.hide();
			moveTab(0, lastDivider);
		}
	}
}
tog_library.onMouseMove(int x, int y){
	if(downX > x+3|| downX < x-3) mmove=true;
	if(tabMouseDown && mmove){
		tog_library1.setAlpha(200);
		tabDivider.show();
		//setDividerX(x-tog_library.getLeft());
		setDividerX(x-tab_GetX(0));
	}
}

tog_video.onLeftButtonDown(int x, int y){
	tabMouseDown=true;
	mmove=false;
	downX=x;
}
tog_video.onLeftButtonUp(int x, int y){
	if(tabMouseDown){
		tabMouseDown=false;
		if(mmove){
			tog_video1.setAlpha(255);
			tabDivider.hide();
			moveTab(1, lastDivider);
		}
	}
}
tog_video.onMouseMove(int x, int y){
	if(downX > x+3|| downX < x-3) mmove=true;
	if(tabMouseDown && mmove){
		tog_video1.setAlpha(200);
		tabDivider.show();
		//setDividerX(x-tog_library.getLeft());
		setDividerX(x-tab_GetX(0));
	}
}

tog_avs.onLeftButtonDown(int x, int y){
	tabMouseDown=true;
	mmove=false;
	downX=x;
}
tog_avs.onLeftButtonUp(int x, int y){
	if(tabMouseDown){
		tabMouseDown=false;
		if(mmove){
			tog_avs1.setAlpha(255);
			tabDivider.hide();
			moveTab(2, lastDivider);
		}
	}
}
tog_avs.onMouseMove(int x, int y){
	if(downX > x+3|| downX < x-3) mmove=true;
	if(tabMouseDown && mmove){
		tog_avs1.setAlpha(200);
		tabDivider.show();
		//setDividerX(x-tog_library.getLeft());
		setDividerX(x-tab_GetX(0));
	}
}

tog_Browser.onLeftButtonDown(int x, int y){
	tabMouseDown=true;
	mmove=false;
	downX=x;
}
tog_Browser.onLeftButtonUp(int x, int y){
	if(tabMouseDown){
		tabMouseDown=false;
		if(mmove){
			tog_Browser1.setAlpha(255);
			tabDivider.hide();
			moveTab(3, lastDivider);
		}
	}
}
tog_Browser.onMouseMove(int x, int y){
	if(downX > x+3|| downX < x-3) mmove=true;
	if(tabMouseDown && mmove){
		tog_Browser1.setAlpha(200);
		tabDivider.show();
		//setDividerX(x-tog_library.getLeft());
		setDividerX(x-tab_GetX(0));
	}
}

tog_Playlist.onLeftButtonDown(int x, int y){
	tabMouseDown=true;
	mmove=false;
	downX=x;
}
tog_Playlist.onLeftButtonUp(int x, int y){
	if(tabMouseDown){
		tabMouseDown=false;
		if(mmove){
			tog_Playlist1.setAlpha(255);
			tabDivider.hide();
			moveTab(4, lastDivider);
		}
	}
}
tog_Playlist.onMouseMove(int x, int y){
	if(downX > x+3|| downX < x-3) mmove=true;
	if(tabMouseDown && mmove){
		tog_Playlist1.setAlpha(200);
		tabDivider.show();
		//setDividerX(x-tog_library.getLeft());
		setDividerX(x-tab_GetX(0));
	}
}


tog_NowPlay.onLeftButtonDown(int x, int y){
	tabMouseDown=true;
	mmove=false;
	downX=x;
}
tog_NowPlay.onLeftButtonUp(int x, int y){
	if(tabMouseDown){
		tabMouseDown=false;
		if(mmove){
			tog_Widget1.setAlpha(255);
			tabDivider.hide();
			moveTab(6, lastDivider);
		}
	}
}
tog_NowPlay.onMouseMove(int x, int y){
	if(downX > x+3|| downX < x-3) mmove=true;
	if(tabMouseDown && mmove){
		tog_Widget1.setAlpha(200);
		tabDivider.show();
		setDividerX(x-tab_GetX(0));
	}
}


tog_Other.onLeftButtonDown(int x, int y){
	tabMouseDown=true;
	mmove=false;
	downX=x;
}
tog_Other.onLeftButtonUp(int x, int y){
	if(tabMouseDown){
		tabMouseDown=false;
		if(mmove){
			tog_Other1.setAlpha(255);
			tabDivider.hide();
			moveTab(5, lastDivider);
		}
	}
}
tog_Other.onMouseMove(int x, int y){
	if(downX > x+3|| downX < x-3) mmove=true;
	if(tabMouseDown && mmove){
		tog_Other1.setAlpha(200);
		tabDivider.show();
		setDividerX(x-tab_GetX(0));
	}
}


// add other tab!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

/* --------------
*/

tog_library.onLeftClick(){
	if(!mmove) openTabNo(0);
	updateTabButtonStates();
}
tog_video.onLeftClick(){
	if(!mmove) openTabNo(1);
	updateTabButtonStates();
}
tog_avs.onLeftClick(){
	if(!mmove) openTabNo(2);
	updateTabButtonStates();
}
tog_Browser.onLeftClick(){
	if(!mmove) openTabNo(3);
	updateTabButtonStates();
}
tog_Playlist.onLeftClick(){
	if(!mmove) openTabNo(4);
	updateTabButtonStates();
}
tog_Other.onLeftClick(){
	if(!mmove) openTabNo(5);
	updateTabButtonStates();
}
tog_NowPlay.onLeftClick(){
	if(!mmove) openTabNo(6);
	updateTabButtonStates();
}

area_right.onSetVisible(boolean onOff){
	if(onOff && getPublicInt("cPro.lastComponentPage", 0)==4 && !skipLoad) openTabNo(0); //dont want two playlist hey?
	//spaceTabs();
}


area_mini.onResize(int x, int y, int w, int h){
	//Hide/Show the area
	if(w<10){
		area_mini.hide();
		if(getPublicInt("cPro.lastMini", 0)==2){openMini(0);}
	}
	else if(h<40){
		area_mini.hide();
		if(getPublicInt("cPro.lastMini", 0)==2){openMini(0);}
	}
	else area_mini.show();
}


but_miniGoto.onleftClick(){
	popMenu = new PopUpMenu;

	popMenu.addCommand("Album Art", 0, mini_Cover.isVisible(), 0);
	popMenu.addCommand("Video", 1, mini_Video.isVisible(), 0);
	popMenu.addCommand("Visualization", 2, mini_AVS.isVisible(), 0);
	popMenu.addCommand("Saved Playlists", 3, mini_SavedPL.isVisible(), 0);

	//** Widgets code start
	PopUpMenu widgetmenu;
	widgetmenu = new PopUpMenu;

	int count = 0;
	for (int x = 0; x < dummyBuck.getNumChildren(); x++) {//**
		GuiObject gr = dummyBuck.enumChildren(x);
		widgetmenu.addCommand(gr.getXMLparam("name"), 100+x, getPublicInt("cPro.lastMini", 0) == 100+x, 0);
		count++;
	}

	if (count == 0) widgetmenu.addCommand("No widgets found for this view!", -1, 0, 1);
	popMenu.addSubMenu(widgetmenu, "Widgets");
	//** Widgets code end

	popMenu.checkCommand(getPublicInt("cPro.lastMini", 0), 1);

	int result = popMenu.popAtXY(clientToScreenX(but_miniGoto.getLeft()), clientToScreenY(but_miniGoto.getTop() + but_miniGoto.getHeight()));

	if(result>=0){
		openMini(result);
	}
	delete popMenu;
	delete widgetmenu;//** Widgets code
	complete;
}

openMini(int miniNo){
	//Safety check to see if the widgets is still there ;)
	if(miniNo>=100){
		if(dummyBuck.getNumChildren()<miniNo-99) miniNo=0;
	}

	mini_Cover.hide();
	mini_Video.hide();
	mini_AVS.hide();
	mini_SavedPL.hide();

	//** Widgets code start
	customObj.hide();
	//** Widgets code end

  
  if(miniNo==0){
		mini_Cover.show();
	}
	else if(miniNo==1){
		if(getPublicInt("cPro.lastComponentPage", 0)==1){
			openTabNo(0);
		}
		mini_Video.show();
	}
	else if(miniNo==2){
		if(getPublicInt("cPro.lastComponentPage", 0)==2){
			openTabNo(0);
		}
		if(getPublicInt("cPro.lastDrawer", 0)==3){
				drawer.sendAction ("switch_to_drawer", "", 0, 0, 0, 0); //close drawer vis
		}

		mini_AVS.show();
	}
	else if(miniNo==3){
		mini_SavedPL.show();
	}
 
	//** Widgets code start
	else if(miniNo >= 100) {
		GuiObject gr = dummyBuck.enumChildren(miniNo-100);
		String id = gr.getXMLparam("userdata");
		customObj.setXmlParam("groupid", id);
		customObj.show();
	}
	//** Widgets code end

	setPublicInt("cPro.lastMini", miniNo);
}



/*
Preview Tip Code
*/
tog_video.onEnterArea(){
	waitForPreview.start();
}
tog_video.onLeaveArea(){
	waitForPreview.stop();
	preview_layout.hide();
}
waitForPreview.onTimer(){
	preview_video.hide();
	preview_video_1.hide();

	if(tog_video.isMouseOverRect() && active_tab!=1 && !mini_Video.isVisible()){
		if(strleft(getDecoderName(getPlayItemString()),19)=="Nullsoft DirectShow" || isVideo()){
			preview_video.show();
		}
		else{
			preview_video_1.show();
		}
		preview_layout.resize(tog_video.clientToScreenX(tog_video.getLeft()), tog_video.clientToScreenY(tog_video.getTop() + tog_video.getHeight()),150,150);
		preview_layout.show();
		// Fix if always on top is enabled.. it just refresh the ontop ;)
		preview_layout.setXmlParam("ontop", "0");
		preview_layout.setXmlParam("ontop", "1");
	}
	waitForPreview.stop();
}

/*
Toggle component buttons
*/
initTabSubMenu(){
	tabMouseDown=false;
	tabMenu = new PopUpMenu;
	tabMenu.addCommand(TAB_TABSELECT, -1, 0, 1);
	tabMenu.addSeparator();
	tabMenu.addCommand("Media Library", 100, getPublicInt("cPro.tab.onoff.0", 1), 0);
	tabMenu.addCommand("Video", 101, getPublicInt("cPro.tab.onoff.1", 1), 0);
	tabMenu.addCommand("Visualization", 102, getPublicInt("cPro.tab.onoff.2", 1), 0);
	tabMenu.addCommand("Browser", 103, getPublicInt("cPro.tab.onoff.3", 1), 0);
	tabMenu.addCommand("Playlist", 104, getPublicInt("cPro.tab.onoff.4", 1), 0);
	tabMenu.addCommand("AlbumArt", 106, getPublicInt("cPro.tab.onoff.6", 1), 0);
}
setTabSubMenuResult(int opt){
	if(opt>=0 && opt<7 && opt!=5) setPublicInt("cPro.tab.onoff."+integerToString(opt), !getPublicInt("cPro.tab.onoff."+integerToString(opt), 1));
}

tog_video.onRightButtonUp(int x, int y){
	popMenu = new PopUpMenu;

	initTabSubMenu();
	popMenu.addSubmenu(tabMenu, TAB_TABSELECT);
	popMenu.addCommand(TAB_TABDEACTIVE, 50, !getPublicInt("cPro.tab.onoff.1", 1), 0);
	popMenu.addSeparator();
	if(getPublicInt("ClassicPro.1.vidbuttons", 1)==1) popMenu.addCommand(TAB_STATSUSBAR_HIDE, 1, 0, 0);
	else popMenu.addCommand(TAB_STATSUSBAR_SHOW, 0, 0, 0);

	int result = popMenu.popAtXY(clientToScreenX(tog_video.getLeft()), clientToScreenY(tog_video.getTop() + tog_video.getHeight()));
	if(result==1 || result==0) setPublicInt("ClassicPro.1.vidbuttons", !result);
	else if(result==50) setPublicInt("cPro.tab.onoff.1", !getPublicInt("cPro.tab.onoff.1", 1));
	else if(result>99 && result<107) setTabSubMenuResult(result-100);
	delete popMenu;
	refreshComponentButtons();
	updateTabShow();
	complete;
}
tog_avs.onRightButtonUp(int x, int y){
	popMenu = new PopUpMenu;
	
	initTabSubMenu();
	popMenu.addSubmenu(tabMenu, TAB_TABSELECT);
	popMenu.addCommand(TAB_TABDEACTIVE, 50, !getPublicInt("cPro.tab.onoff.2", 1), 0);
	popMenu.addSeparator();

	if(getPublicInt("ClassicPro.1.avsbuttons", 1)==1) popMenu.addCommand(TAB_STATSUSBAR_HIDE, 1, 0, 0);
	else popMenu.addCommand(TAB_STATSUSBAR_SHOW, 0, 0, 0);
	int result = popMenu.popAtXY(clientToScreenX(tog_avs.getLeft()), clientToScreenY(tog_avs.getTop() + tog_avs.getHeight()));
	if(result==1 || result==0) setPublicInt("ClassicPro.1.avsbuttons", !result);
	else if(result==50) setPublicInt("cPro.tab.onoff.2", !getPublicInt("cPro.tab.onoff.2", 1));
	else if(result>99 && result<107) setTabSubMenuResult(result-100);
	delete popMenu;
	refreshComponentButtons();
	updateTabShow();
	complete;
}
tog_Playlist.onRightButtonUp(int x, int y){
	popMenu = new PopUpMenu;
	
	initTabSubMenu();
	popMenu.addSubmenu(tabMenu, TAB_TABSELECT);
	popMenu.addCommand(TAB_TABDEACTIVE, 50, !getPublicInt("cPro.tab.onoff.4", 1), 0);
	popMenu.addSeparator();

	if(getPublicInt("ClassicPro.1.plbuttons", 1)==1) popMenu.addCommand(TAB_STATSUSBAR_HIDE, 1, 0, 0);
	else popMenu.addCommand(TAB_STATSUSBAR_SHOW, 0, 0, 0);
	int result = popMenu.popAtXY(clientToScreenX(tog_Playlist.getLeft()), clientToScreenY(tog_Playlist.getTop() + tog_Playlist.getHeight()));
	if(result==1 || result==0) setPublicInt("ClassicPro.1.plbuttons", !result);
	else if(result==50) setPublicInt("cPro.tab.onoff.4", !getPublicInt("cPro.tab.onoff.4", 1));
	else if(result>99 && result<107) setTabSubMenuResult(result-100);
	delete popMenu;
	refreshComponentButtons();
	updateTabShow();
	complete;
}

tog_Browser.onRightButtonUp(int x, int y){
	popMenu = new PopUpMenu;
	
	initTabSubMenu();
	popMenu.addSubmenu(tabMenu, TAB_TABSELECT);
	popMenu.addCommand(TAB_TABDEACTIVE, 50, !getPublicInt("cPro.tab.onoff.3", 1), 0);

	int result = popMenu.popAtXY(clientToScreenX(tog_Browser.getLeft()), clientToScreenY(tog_Browser.getTop() + tog_Browser.getHeight()));
	if(result==50) setPublicInt("cPro.tab.onoff.3", !getPublicInt("cPro.tab.onoff.3", 1));
	else if(result>99 && result<107) setTabSubMenuResult(result-100);
	delete popMenu;
	refreshComponentButtons();
	updateTabShow();
	complete;
}

tog_library.onRightButtonUp(int x, int y){
	popMenu = new PopUpMenu;
	
	initTabSubMenu();
	popMenu.addSubmenu(tabMenu, TAB_TABSELECT);
	popMenu.addCommand(TAB_TABDEACTIVE, 50, !getPublicInt("cPro.tab.onoff.0", 1), 0);

	int result = popMenu.popAtXY(clientToScreenX(tog_library.getLeft()), clientToScreenY(tog_library.getTop() + tog_library.getHeight()));
	if(result==50) setPublicInt("cPro.tab.onoff.0", !getPublicInt("cPro.tab.onoff.0", 1));
	else if(result>99 && result<107) setTabSubMenuResult(result-100);
	delete popMenu;
	refreshComponentButtons();
	updateTabShow();
	complete;
}

tog_NowPlay.onRightButtonUp(int x, int y){
	popMenu = new PopUpMenu;
	
	initTabSubMenu();
	popMenu.addSubmenu(tabMenu, TAB_TABSELECT);
	popMenu.addCommand(TAB_TABDEACTIVE, 50, !getPublicInt("cPro.tab.onoff.6", 1), 0);

	int result = popMenu.popAtXY(clientToScreenX(tog_NowPlay.getLeft()), clientToScreenY(tog_NowPlay.getTop() + tog_NowPlay.getHeight()));
	if(result==50) setPublicInt("cPro.tab.onoff.6", !getPublicInt("cPro.tab.onoff.6", 1));
	else if(result>99 && result<107) setTabSubMenuResult(result-100);
	delete popMenu;
	refreshComponentButtons();
	updateTabShow();
	complete;
}


tog_other.onRightButtonUp(int x, int y){
	popMenu = new PopUpMenu;
	
	initTabSubMenu();
	popMenu.addSubmenu(tabMenu, TAB_TABSELECT);

	int result = popMenu.popAtXY(clientToScreenX(tog_other.getLeft()), clientToScreenY(tog_other.getTop() + tog_other.getHeight()));
	if(result>99 && result<107) setTabSubMenuResult(result-100);
	delete popMenu;
	refreshComponentButtons();
	updateTabShow();
	complete;
}



refreshComponentButtons(){
	if(getPublicInt("ClassicPro.1.plbuttons", 1)){
			guihold_Pl2.setXmlParam("h", "-27");
			tabbut_pl.show();
	}
	else{
			guihold_Pl2.setXmlParam("h", "-4");
			tabbut_pl.hide();
	}

	if(getPublicInt("ClassicPro.1.vidbuttons", 1)){
			hold_vid.setXmlParam("h", "-27");
			tabbut_vid.show();
	}
	else{
			hold_vid.setXmlParam("h", "-4");
			tabbut_vid.hide();
	}
	
	if(getPublicInt("ClassicPro.1.avsbuttons", 1)){
			hold_avs.setXmlParam("h", "-27");
			visRectBg.setXmlParam("h", "-27");
			tabbut_avs.show();
	}
	else{
			hold_avs.setXmlParam("h", "-4");
			visRectBg.setXmlParam("h", "-4");
			tabbut_avs.hide();
	}		
}



xuiGroup.onAction (String action, String param, int x, int y, int p1, int p2, GuiObject source)
{
	// Switch to new tab
	if (strlower(action) == "switch_to_tab"){
		openTabNo(x);
	}
	else if (strlower(action) == "browser_url"){
		openTabNo(3);
		updateTabButtonStates();
		xuiBrowser.sendAction ("openurl", param, 0, 0, 0, 0);
	}
	else if (strlower(action) == "browser_search"){
		openTabNo(3);
		updateTabButtonStates();
		xuiBrowser.sendAction ("search", param, 0, 0, 0, 0);
	}
	else if (strlower(action) == "drawer_onoff"){
		setDrawer(x);		
	}
	else if (strlower(action) == "switch_to_mini"){
		openMini(x);		
	}
	else if (strlower(action) == "frame_main_setsize"){
		mainFrame.setPosition(x);
	}
	else if (strlower(action) == "frame_mini_setsize"){
		setPublicInt("cpro.e1.frame2", plFrame.getPosition());
		setFrame2(x, area_right_pl.getHeight());
	}
	else if (strlower(action) == "sideview_onoff"){
		if(x==1) setMainFrame(true);
		else setMainFrame(false);
	}
}

//Main Frame code
xuiGroup.onResize(int x, int y, int w, int h){
	//debugString("xuiGroup: x="+integerToString(x)+" y="+integerToString(y)+" w="+integerToString(w)+" h="+integerToString(h),9);
	setDrawer(getPublicInt("cPro.draweropened", 0));
	
	//if(w<410){
	if(w<413){
		//boolean prevState = ocFrame.isVisible();
		ocFrame.hide();
		tog_drawer.setXmlParam("x", "-24");
		tabsGroup.setXmlParam("w", "-27");

		if(mainFrame.getPosition()!=0){
			mainFrame.setPosition(0);
			setPublicInt("cpro.mainframe.sysclose", 1);
		}
		
		//if(prevState) spaceTabs(true);
	}
	else{
		tog_drawer.setXmlParam("x", "-48");
		ocFrame.show();
		tabsGroup.setXmlParam("w", "-51");
	}
	//spaceTabs(true);
	//mainFrame.setPosition(mainFrame.getPosition()); //This is done to refresh the hide of the resizer ;)

	/*if(w<413 && mainFrame.getPosition()==0 && ocFrame.isVisible() && getPublicInt("cpro.mainframe.sysclose", 0)==1){
		setMainFrame(true);
	}*/
	if(w>=413 && getPublicInt("cpro.mainframe.sysclose", 0)==1){
		setMainFrame(true);
		//openMePlease=true;
	}

}
area_left.onResize(int x, int y, int w, int h){
	setFrame1();
	spaceTabs(false);
	
	//mainFrame.setPosition(mainFrame.getPosition()); //mainframe refresh :(
	/*if(openMePlease){
		setMainFrame(true);
	}*/
}

area_right.onResize(int x, int y, int w, int h){
	if(stopResizeRight){
		stopResizeRight = false;
		return;
	}
	stopResizeRight = true;

	if(w<10){
		area_right.hide();

		//Update window size toggle
		closeFrame.hide();
		openFrame.show();
		if(!mouseDownF1) mainFrame.setXmlParam("resizable", "0");
	}
	else{
		area_right.show();

		//Update window size toggle
		closeFrame.show();
		openFrame.hide();
	}
	
	if(w<158 && mainFrame.getPosition()!=0){
		if(mouseDownF1){
			setPublicInt("cpro.mainframe.sysclose", 0);
			mainFrame.setPosition(0);
		}
		/*else{
			setPublicInt("cpro.mainframe.sysclose", 1);
			mainFrame.setXmlParam("resizable", "0");
		}*/
	}
	setFrame1();

	stopResizeRight = false;
	
	//mainFrame.setPosition(mainFrame.getPosition()); //mainframe refresh :(

}


mainFrame.onLeftButtonDown(int x, int y){
	setPublicInt("cpro.e1.closeframe.lastpos", mainFrame.getPosition()); //TESTING THIS...CHANGE BACK
	mainFrame.setXmlParam("resizable", "1");
	mouseDownF1=true;
}

mainFrame.onLeftButtonUp(int x, int y){
	mouseDownF1=false;
	if(area_right.getWidth()<10) mainFrame.setXmlParam("resizable", "0");
	else setPublicInt("cpro.e1.closeframe.lastpos", mainFrame.getPosition()); //TESTING THIS...CHANGE BACK
	
	mainFrame.setPosition(mainFrame.getPosition()); //This is done to refresh the hide of the resizer ;)
}

setFrame1(){
	if(mainFrame.getPosition()<180 && mainFrame.getPosition()>=158){
		mainFrame.setPosition(158);
	}
}
closeFrame.onLeftClick(){
	setMainFrame(false);
}
openFrame.onLeftClick(){
	setMainFrame(true);
}

setMainFrame(boolean open){
	setPublicInt("cpro.mainframe.sysclose", 0);
	if(open){
		int pos = getPublicInt("cpro.e1.closeframe.lastpos", 200);
		if(pos<158) pos = 158;
		mainFrame.setXmlParam("resizable", "1");
		mainFrame.setPosition(pos);
	}
	else{
		setPublicInt("cpro.e1.closeframe.lastpos", mainFrame.getPosition());
		mainFrame.setXmlParam("resizable", "0");
		mainFrame.setPosition(0);
	}
	mainFrame.setPosition(mainFrame.getPosition()); //This is done to refresh the hide of the resizer ;)
}


//Mini Frame code
plFrame.onLeftButtonDown(int x, int y){
	mouseDownF2=true;
}
plFrame.onLeftButtonUp(int x, int y){
	mouseDownF2=false;
	setPublicInt("cpro.e1.frame2", plFrame.getPosition());

}
area_right_pl.onResize(int x, int y, int w, int h){
	if(mouseDownF2)	setPublicInt("cpro.e1.frame2", plFrame.getPosition());
	setFrame2(getPublicInt("cpro.e1.frame2", plFrame.getPosition()), h);
}
setFrame2(int pos, int h){
	int output = pos;

	//Magnet-clip the framedivider
	if(pos<40){
		output=0;
	}
	else{
		output=xuiGroup.getHeight()-48;
	}
	
	if(output<40) output=0;
	if(output>getPublicInt("cpro.e1.frame2", plFrame.getPosition())) output=getPublicInt("cpro.e1.frame2", plFrame.getPosition());
	
	if(output!=plFrame.getPosition()) plFrame.setPosition(output);
}

plText1.onLeftButtonDblClk(int x, int y){
	PlEdit.showCurrentlyPlayingTrack ();
}
plText2.onLeftButtonDblClk(int x, int y){
	PlEdit.showCurrentlyPlayingTrack ();
}


/*
DEBUG CODE!!!!!!!!!!!!
*/
/*
tab_library.onSetVisible(boolean onOff){
	debugString("tab_library="+integerToString(onOff),9);
}
tab_video.onSetVisible(boolean onOff){
	debugString("tab_video="+integerToString(onOff),9);
}
tab_avs.onSetVisible(boolean onOff){
	debugString("tab_avs="+integerToString(onOff),9);
}
tab_Browser.onSetVisible(boolean onOff){
	debugString("tab_Browser="+integerToString(onOff),9);
}
tab_Playlist.onSetVisible(boolean onOff){
	debugString("tab_Playlist="+integerToString(onOff),9);
}
tab_Other.onSetVisible(boolean onOff){
	debugString("tab_Other="+integerToString(onOff),9);
}
tab_Widget.onSetVisible(boolean onOff){
	debugString("tab_Widget="+integerToString(onOff),9);
}*/

ssWinHol.onTimer(){
	delayStart=false;
	ssWinHol.stop();
	
	openTabNo(delayStartTab);

	//hold_ml.show();
	/*hold_Pl1.show();
	hold_Pl2.show();
	hold_vid.show();
	System.hideNamedWindow(VIDEO_GUID);
	
	openTabNo(active_tab);*/
	
	
}