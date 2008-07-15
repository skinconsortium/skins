#include <lib/std.mi>

#define rres 20 

//Function updateTextSizes();
Function saveResize(int x, int y, int w, int h);
Function gotoGlobal();
Function saveGlobal();

Global Group mainGroup;
Global Container main;
Global Layout mylayout;
Global Slider vol_slider, seek_slider;
Global Layer vol_layer, tt_layer, bgLeft, bgRight, bgTop, bgBottom, bgLeftRead, bgTopRead, vol_layer2;
Global GuiObject progressbar, seekBg;
Global Vis mainVis;
Global Text tracktimer, trackTitle;
Global GuiObject infodisplay, vol_images;
Global Button bolt, fakeAbout;
Global Popupmenu selMenu;

//MuteButton
Global Togglebutton mute_but;
Global Timer reCheck;

//Global Layer resize1, resize2, resize3, resize4, resize6, resize7, resize8, resize9;
Global Layer resize6, resize8, resize9;
Global Boolean mouseDown, dontResize;
Global int i, lastKnownW, lastKnownH;

System.onScriptLoaded() {
	mainGroup = getScriptGroup();
	vol_slider = mainGroup.findObject("volume");
	seek_slider = mainGroup.findObject("seeker");
	vol_layer = mainGroup.findObject("volume.bg");
	vol_images = mainGroup.findObject("volume.images");
	vol_layer2 = mainGroup.findObject("volume.bg2");
	vol_layer.setXmlParam("w", integerToString(97/255*getVolume()));
	progressbar = mainGroup.findObject("progressbar");
	seekBg = mainGroup.findObject("progressbar.bg");
	mute_but = mainGroup.findObject("mute");
	mainVis = mainGroup.findObject("main.vis");
	tt_layer = mainGroup.findObject("hidden.tracktime");
	tracktimer = mainGroup.findObject("SongTime");
	trackTitle = mainGroup.findObject("infodisplay");
	infodisplay = mainGroup.findObject("infosongticker");
	bolt = mainGroup.findObject("winampbolt");
	fakeAbout = mainGroup.findObject("aboutwinamp.hidden");

	bgLeftRead = mainGroup.findObject("read.bg.left");
	bgTopRead = mainGroup.findObject("read.bg.top");

	bgLeft = mainGroup.findObject("cpro.bg.left");
	bgRight = mainGroup.findObject("cpro.bg.right");
	bgTop = mainGroup.findObject("cpro.bg.top");
	bgBottom = mainGroup.findObject("cpro.bg.bottom");
	
	main = System.getContainer("main");
	mylayout = main.getLayout("normal");
	
	reCheck = new Timer;
	reCheck.setDelay(10);
	
	//resize1 = mainGroup.findObject("resizer.1");
	//resize2 = mainGroup.findObject("resizer.2");
	//resize3 = mainGroup.findObject("resizer.3");
	//resize4 = mainGroup.findObject("resizer.4");
	resize6 = mainGroup.findObject("resizer.6");
	//resize7 = mainGroup.findObject("resizer.7");
	resize8 = mainGroup.findObject("resizer.8");
	resize9 = mainGroup.findObject("resizer.9");

	if(getStatus()==STATUS_STOPPED){
		progressbar.hide();
		seekBg.hide();
	}
	
	if(getPrivateInt(getSkinName(), "muted", 0)==1){
		mute_but.setActivated(true);
		mute_but.setXmlParam("tooltip", "Turn Volume on");
	}
	
		
	// Reader for classic vis colors from bitmap (wa5.51)
	Map myMap = new Map;
	myMap.loadMap("vis.color.read");
	
	mainVis.setXmlParam("colorbandpeak",integerToString(myMap.getARGBValue(0,0,2))+","+integerToString(myMap.getARGBValue(0,0,1))+","+integerToString(myMap.getARGBValue(0,0,0)));
	
	for(i=2;i<18;i++){
		mainVis.setXmlParam("colorband"+integerToString(18-i),integerToString(myMap.getARGBValue(0,i,2))+","+integerToString(myMap.getARGBValue(0,i,1))+","+integerToString(myMap.getARGBValue(0,i,0)));
	}

	for(i=0;i<5;i++){
		mainVis.setXmlParam("colorosc"+integerToString(5-i),integerToString(myMap.getARGBValue(2,i,2))+","+integerToString(myMap.getARGBValue(2,i,1))+","+integerToString(myMap.getARGBValue(2,i,0)));
	}

	//Support for colorthemes needs a bolt that can be semi transparent [cpro v1.03]
	myMap.loadMap("buttons.png");
	if(myMap.getWidth()==332){
		bolt.setXmlParam("image", "winamp.logo.1");
		bolt.setXmlParam("downImage", "winamp.logo.3");
	}
	delete myMap;
	
	
	if(vol_layer2.isInvalid()){
		vol_layer.show();
	}
	else{
		vol_images.show();
	}


	if(tt_layer.isInvalid()){
		tracktimer.setXmlParam("font", "cpro.tracktime.font");
	}

	if(!bgLeftRead.isInvalid()){
		bgLeft.setXmlParam("image", "player.left.alt");
		bgLeft.setXmlParam("tile", "0");
		bgRight.setXmlParam("image", "player.right.alt");
		bgRight.setXmlParam("tile", "0");
	}
	if(!bgTopRead.isInvalid()){
		bgTop.setXmlParam("image", "player.top.alt");
		bgTop.setXmlParam("tile", "0");
		bgBottom.setXmlParam("image", "player.bottom.alt");
		bgBottom.setXmlParam("tile", "0");
	}
	
	if(getPrivateInt(getSkinName(), "muted", 0)==1){
		mute_but.setActivated(true);
		mute_but.setXmlParam("tooltip", "Turn Volume on");
	}
	else{
		mute_but.setActivated(false);
		mute_but.setXmlParam("tooltip", "Mute Volume");
	}

	//updateTextSizes();
}
System.onScriptUnloading(){
	delete reCheck;
	saveGlobal();
	setPrivateInt(getSkinName(), "muted", mute_but.getCurCfgVal());
}

mainGroup.onResize(int x, int y, int w, int h){
	lastKnownW = w;
	lastKnownH = h;
}

gotoGlobal(){
	int x = getPublicInt("cPro.x", getCurAppLeft());
	int y = getPublicInt("cPro.y", getCurAppTop());
	int w = getPublicInt("cPro.w", getCurAppWidth());
	int h = getPublicInt("cPro.h", getCurAppHeight());
	
	if(w<317) w= 317;
	if(h<168) w= 168;
	
	//debugstring("resize to: "+integerToString(x)+", "+integerToString(y)+", "+integerToString(w)+", "+integerToString(h), 9);
	mylayout.resize(x,y,w,h);
}	
saveGlobal(){
	setPublicInt("cPro.x", mainGroup.getLeft());
	setPublicInt("cPro.y", mainGroup.getTop());
	setPublicInt("cPro.w", lastKnownW);
	setPublicInt("cPro.h", lastKnownH);
	//debugstring("save done: "+integerToString( mainGroup.getLeft())+", "+integerToString(mainGroup.getTop())+", "+integerToString(lastKnownW)+", "+integerToString(lastKnownH), 9);
}

System.onCreateLayout(Layout _layout){
	if(_layout==mylayout){
		gotoGlobal();
		//debugstring("a  == "+integerToString(getPublicInt("cPro.w", getCurAppWidth())), 9);
	}
}
System.onShowLayout(Layout _layout){
	if(dontResize){
		if(getPrivateInt(getSkinName(), "muted", 0)==1){
			mute_but.setActivated(true);
			mute_but.setXmlParam("tooltip", "Turn Volume on");
		}
		else{
			mute_but.setActivated(false);
			mute_but.setXmlParam("tooltip", "Mute Volume");
		}

	}

	if(_layout==mylayout && !dontResize){
		//gotoGlobal();
		reCheck.start();
		dontResize=true;
		//debugstring("a  == "+integerToString(getPublicInt("cPro.w", getCurAppWidth())), 9);
	}

}
reCheck.onTimer(){
		reCheck.stop();
		gotoGlobal();
}

/*tracktimer.onTextChanged(String newtxt){
	updateTextSizes();
}*/
/*updateTextSizes(){
	debugstring("mohaha"+integerToString(tracktimer.getAutoWidth()), 9);
	trackTitle.setXmlParam("x", integerToString(tracktimer.getTextWidth()+15));
	trackTitle.setXmlParam("w", "-"+integerToString(tracktimer.getTextWidth()+15+14));
	infodisplay.setXmlParam("x", integerToString(tracktimer.getTextWidth()+15));
	infodisplay.setXmlParam("w", "-"+integerToString(tracktimer.getTextWidth()+15+14));
}*/

vol_slider.onSetPosition(int newpos){
	vol_layer.setXmlParam("w", integerToString(97/255*newpos));
	
	if(mute_but.getCurCfgVal()==1 && newpos>0){
		mute_but.setActivated(false);
		setPrivateInt(getSkinName(), "muted", 0);
	}
}
vol_slider.onPostedPosition(int newpos){
	vol_layer.setXmlParam("w", integerToString(97/255*newpos));
	if(mute_but.getCurCfgVal()==1 && newpos>0){
		mute_but.setActivated(false);
		setPrivateInt(getSkinName(), "muted", 0);
	}
}

System.onStop(){
	progressbar.hide();
	seekBg.hide();
}
System.onPlay(){
	progressbar.show();
	seekBg.show();
}
System.onResume(){
	progressbar.show();
	seekBg.show();
}

mute_but.onToggle(Boolean onoff){
	if(mute_but.getCurCfgVal()==0){
		setVolume(getPrivateInt(getSkinName(), "saveVol", 100));
		mute_but.setXmlParam("tooltip", "Mute Volume");
	}
	else{
		setPrivateInt(getSkinName(), "saveVol", getVolume());
		setVolume(0);
		mute_but.setXmlParam("tooltip", "Turn Volume on");
	}
	setPrivateInt(getSkinName(), "muted", mute_but.getCurCfgVal());
}


seek_slider.onEnterArea(){
	progressbar.setXmlParam("left", "seeker.bg.left.3");
	progressbar.setXmlParam("middle", "seeker.bg.center.3");
	progressbar.setXmlParam("right", "seeker.bg.right.3");
}
seek_slider.onLeaveArea(){
	progressbar.setXmlParam("left", "seeker.bg.left.2");
	progressbar.setXmlParam("middle", "seeker.bg.center.2");
	progressbar.setXmlParam("right", "seeker.bg.right.2");
}


vol_slider.onEnterArea(){
	vol_layer.setXmlParam("image", "volume.bg.hover");
}
vol_slider.onLeaveArea(){
	vol_layer.setXmlParam("image", "volume.bg");
}

bolt.onLeftClick(){
	int a = getPublicInt("cPro.multibutton", 0);
	
	if(a==0){
		fakeAbout.leftClick();
	}
	else if(a==1){
		System.navigateUrl(getPath(getPlayItemMetaDataString("filename")));
	}
}
bolt.onRightButtonUp(int x, int y){
	selMenu = new PopupMenu;
	selMenu.addCommand("Multi-Button Action:", -1, 0, 1);
	selMenu.addSeparator();
	selMenu.addCommand("Open About Winamp", 0, 0, 0);
	selMenu.addCommand("Open Folder", 1, 0, 0);
	selMenu.checkCommand(getPublicInt("cPro.multibutton", 0), 1);
	
	int a = selMenu.popAtMouse();
	
	if(a>=0){
		setPublicInt("cPro.multibutton", a);
	}
	Complete;
	delete selMenu;
}


/*	Classic Resizers ;)
*/
resize6.onLeftButtonDown(int x, int y){mouseDown=true;}
resize6.onLeftButtonUp(int x, int y){mouseDown=false;}
resize6.onMouseMove(int x, int y){
	if(mouseDown){
		x=x-(x-317)%rres;
		saveResize(getCurAppLeft(), getCurAppTop(),x+10,getCurAppHeight());
	}
}

resize8.onLeftButtonDown(int x, int y){mouseDown=true;}
resize8.onLeftButtonUp(int x, int y){mouseDown=false;}
resize8.onMouseMove(int x, int y){
	if(mouseDown){
		y=y-(y-168)%rres;
		saveResize(getCurAppLeft(), getCurAppTop(), getCurAppWidth(),y+10);
	}
}
resize9.onLeftButtonDown(int x, int y){mouseDown=true;}
resize9.onLeftButtonUp(int x, int y){mouseDown=false;}
resize9.onMouseMove(int x, int y){
	if(mouseDown){
		x=x-(x-317)%rres;
		y=y-(y-168)%rres;
		saveResize(getCurAppLeft(), getCurAppTop(),x+10,y+10);
	}
}


saveResize(int x, int y, int w, int h){
	if(w<317) w=317;
	if(h<220) h=168;
	
	mainGroup.resize(x,y,w,h);
}