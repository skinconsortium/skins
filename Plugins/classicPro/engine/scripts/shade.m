#include <lib/std.mi>

#define rres 25 

Global Group mainGroup, gr_Vis, gr_Vol, gr_seektick, gr_seektick1, gr_seektick2;
Global GuiObject progressbar;
Global Layer vol_bg, resize6;
Global Slider vol_sl;
Global Boolean mouseDown;
Global Vis shadeVis;
Global Button mlMenu1, mlMenu2;
Global int i;

//MuteButton
Global Togglebutton mute_but;

System.onScriptLoaded() {
	mainGroup = getScriptGroup();
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
	

}
System.onScriptUnloading() {
	setPrivateInt(getSkinName(), "muted", mute_but.getCurCfgVal());
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
	if(w<342){
		gr_Vis.hide();
	}
	else{
		gr_Vis.show();
	}
	
	if(w<405){
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

resize6.onLeftButtonDown(int x, int y){mouseDown=true;}
resize6.onLeftButtonUp(int x, int y){mouseDown=false;}
resize6.onMouseMove(int x, int y){
	if(mouseDown){
		x=x-x%rres;
		int w = x+2;
		if(w<stringToInteger(mainGroup.getXmlParam("minimum_w"))){w=stringToInteger(mainGroup.getXmlParam("minimum_w"));}
		mainGroup.resize(getCurAppLeft(), getCurAppTop(),w,getCurAppHeight());
	}
}