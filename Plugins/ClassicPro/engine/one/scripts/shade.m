#include <lib/std.mi>
#include attribs/init_Autoresize.m

#define rres 20 

Function gotoGlobal();
Function saveGlobal();
Function saveResize(int x, int y, int w, int h);
Function updateMax();

Global Group mainGroup, gr_Vis, gr_Vol, gr_seektick, gr_seektick1, gr_seektick2;
Global GuiObject progressbar;
Global Layer vol_bg, resize6, aotDoc;
Global Slider vol_sl;
Global Boolean mouseDown, docked;
Global Vis shadeVis;
Global Button mlMenu1, mlMenu2, aotBut;
Global int i, lastKnownW;
Global Timer reCheck;
Global Boolean dontResize;

Global Container main;
Global Layout shade;

//MuteButton
Global Togglebutton mute_but;

System.onScriptLoaded() {
	initAttribs_Autoresize();

	mainGroup = getScriptGroup();

	main = System.getContainer("main");
	shade = main.getLayout("shade");

	gr_Vis = mainGroup.findObject("shade.visgroup");
	gr_Vol = mainGroup.findObject("shade.volgroup");
	gr_seektick = mainGroup.findObject("shade.seekticker");
	gr_seektick1 = mainGroup.findObject("shade.seekticker1");
	gr_seektick2 = mainGroup.findObject("shade.seekticker2");
	resize6 = mainGroup.findObject("shade.resize6");
	shadeVis = mainGroup.findObject("shade.vis");
	mute_but = mainGroup.findObject("mute2");
	vol_sl = mainGroup.findObject("shade.volume");
	vol_bg = mainGroup.findObject("shade.volfg");
	vol_bg.setXmlParam("w", integerToString(getVolume()/255*40));
	progressbar = mainGroup.findObject("progressbar");
	mlMenu1 = mainGroup.findObject("shade.mlmenu.visible");
	mlMenu2 = mainGroup.findObject("shade.mlmenu.fake");
	aotDoc = mainGroup.findObject("shade.aot.docked");
	aotBut = mainGroup.findObject("shade.aot");

	if(getStatus()==STATUS_STOPPED){
		progressbar.hide();
	}

	if(getPrivateInt(getSkinName(), "muted", 0)==1){
		mute_but.setActivated(true);
		mute_but.setXmlParam("tooltip", "Turn Volume on");
	}
	
	// Reader for classic vis colors from bitmap (wa5.51)
	Map myMap = new Map;
	myMap.loadMap("vis.color.read2");
	
	shadeVis.setXmlParam("colorbandpeak",integerToString(myMap.getARGBValue(0,0,2))+","+integerToString(myMap.getARGBValue(0,0,1))+","+integerToString(myMap.getARGBValue(0,0,0)));
	
	for(i=2;i<18;i++){
		shadeVis.setXmlParam("colorband"+integerToString(18-i),integerToString(myMap.getARGBValue(0,i,2))+","+integerToString(myMap.getARGBValue(0,i,1))+","+integerToString(myMap.getARGBValue(0,i,0)));
	}

	for(i=0;i<5;i++){
		shadeVis.setXmlParam("colorosc"+integerToString(5-i),integerToString(myMap.getARGBValue(2,i,2))+","+integerToString(myMap.getARGBValue(2,i,1))+","+integerToString(myMap.getARGBValue(2,i,0)));
	}
	delete myMap;
	
	reCheck = new Timer;
	reCheck.setDelay(10);
	
	//double newscalevalue = shade.getScale();
	//shade.setXmlParam("maximum_w", integerToString(getViewPortWidthfromGuiObject(shade)/newscalevalue));
}
System.onScriptUnloading() {
	if(getPublicInt("cPro.lastmode", 0)==1) saveGlobal(); //0=normal ; 1=shade
	setPublicInt("cPro.firstlayout", 0);
	setPrivateInt(getSkinName(), "muted", mute_but.getCurCfgVal());
	delete reCheck;
}
mainGroup.onSetVisible(boolean onOff){
	if(getPrivateInt(getSkinName(), "muted", 0)==1){
		mute_but.setActivated(true);
		mute_but.setXmlParam("tooltip", "Turn Volume on");
	}
	else{
		mute_but.setActivated(false);
		mute_but.setXmlParam("tooltip", "Mute Volume");
	}
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


mainGroup.onResize(int x, int y, int w, int h){
	if(w<348){
		gr_Vis.hide();
	}
	else{
		gr_Vis.show();
	}
	
	if(w<416){
		gr_Vol.hide();
	}
	else{
		gr_Vol.show();
	}

	if(w<460){
		gr_seektick.hide();
	}
	else{
		gr_seektick.show();
	}
	
	if(w<600){
		gr_seektick1.setXmlParam("w", "100");
		gr_seektick2.hide();
	}
	else{
		gr_seektick1.setXmlParam("w", "70");
		gr_seektick2.show();
	}
}

vol_sl.onsetPosition(int newpos){
	vol_bg.setXmlParam("w", integerToString(newpos/255*40));
}
vol_sl.onPostedPosition(int newpos){
	vol_bg.setXmlParam("w", integerToString(newpos/255*40));
}

System.onStop(){
	progressbar.hide();
}
System.onPlay(){
	progressbar.show();
}

mlMenu1.onLeftClick(){
	mlMenu2.leftClick(); //pass click onto the fakebutton so because we need the menu to pop a few pixels down... not over the whole shademode ;)
}

/*resize6.onLeftButtonDown(int x, int y){mouseDown=true;}
resize6.onLeftButtonUp(int x, int y){mouseDown=false;}
resize6.onMouseMove(int x, int y){
	if(mouseDown){
		x=x-x%rres;
		int w = x+2;
		if(w<stringToInteger(mainGroup.getXmlParam("minimum_w"))){w=stringToInteger(mainGroup.getXmlParam("minimum_w"));}
		shade.resize(shade.getLeft(), shade.getTop(),w,shade.getHeight());
	}
}*/

resize6.onLeftButtonDown(int x, int y){mouseDown=true;}
resize6.onLeftButtonUp(int x, int y){mouseDown=false;}
resize6.onMouseMove(int x, int y){
	if(mouseDown){
		x=x-(x-317)%rres;
		saveResize(shade.getLeft(), shade.getTop(),x+10,23);
	}
}

gotoGlobal(){
	if(docked) return;
	int x = getPublicInt("cPro.x", getCurAppLeft());
	int y = getPublicInt("cPro.y", getCurAppTop());
	int w = getPublicInt("cPro.w", getCurAppWidth());
	int h = 23;

	//just incase... you never know :P
	if(x<0) x= 0;
	if(y<0) y= 0;
	/*if(x>System.getMonitorWidth()) x= 0;
	if(y>System.getViewportHeight()) y= 0;*/ //dont work with multi mon setup
	
	if(w<317) w= 317;
	
	//Winshade -> Normal : Bottom of screen
	if(getPublicInt("cPro.saveby", 0)==0 && collapse_bottom_attrib.getData() == "1"){
		//debugstring("pre (shade): "+integerToString(x)+", "+integerToString(y)+", "+integerToString(w)+", "+integerToString(h), 9);
		y=y+getPublicInt("cPro.h", getCurAppHeight())-23;
	}

	
	//debugstring("resize to (shade): "+integerToString(x)+", "+integerToString(y)+", "+integerToString(w)+", "+integerToString(h), 9);
	shade.resize(x,y,w,h);
}
saveGlobal(){
	if(main.getCurLayout() == shade){
		setPublicInt("cPro.x", shade.getLeft());
		setPublicInt("cPro.y", shade.getTop());
		setPublicInt("cPro.w", lastKnownW);
		setPublicInt("cPro.saveby", 1); //0=normal ; 1=shade
	}
}
shade.onResize(int x, int y, int w, int h){
	lastKnownW = w;
}
System.onShowLayout(Layout _layout){
	/*if(_layout==shade && !dontResize && getPublicInt("cPro.firstlayout", 0)==0){
		setPublicInt("cPro.firstlayout", 1);
		reCheck.start();
		dontResize=true;
	}*/
	if(_layout==shade ){
		setPublicInt("cPro.lastmode", 1); //0=normal ; 1=shade
		reCheck.start();
	}
}
System.onHideLayout(Layout _layout){
	if(_layout==shade){
		saveGlobal();
	}
}

/*
System.onCreateLayout(Layout _layout){
	if(_layout==mylayout){
		gotoGlobal();
		//debugstring("a  == "+integerToString(getPublicInt("cPro.w", getCurAppWidth())), 9);
	}
}*/
reCheck.onTimer(){
		reCheck.stop();
		gotoGlobal();
}

saveResize(int x, int y, int w, int h){
	if(docked) return;
	if(w<317) w=317;
	updateMax();
	shade.resize(x,y,w,h);
}

shade.onDock(int side){
	docked=true;
	aotBut.hide();
	aotDoc.show();
}

shade.onUndock(){
	docked=false;
	aotDoc.hide();
	aotBut.show();
}

updateMax(){
	double newscalevalue = shade.getScale();
	shade.setXmlParam("maximum_w", integerToString(getViewPortWidthfromGuiObject(shade)/newscalevalue));
}
