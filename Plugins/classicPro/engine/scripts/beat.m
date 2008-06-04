#include <lib/std.mi>

Function ProcessMenuResult(int a);
Function refreshView();
Function showGroup(int groupNo);
Global Group frameGroup, beatGroup, promoGroup, b01, b02;

Global AnimatedLayer t01, t02;
Global Timer myTimer;
Global int lastBeatLeft,lastBeatRight, myFrames, aniW;
Global Boolean showBeat, showPromo, animTypeB, oneSide;
Global Layer promoPic, mouseTrap, b01layer, b02layer, c01, c02;
Global Popupmenu selMenu;

System.onScriptLoaded (){

	frameGroup = getScriptGroup ();
	
	beatGroup = frameGroup.findObject("beatvis");
	promoGroup = frameGroup.findObject("beatpromo");
	promoPic = frameGroup.findObject("beat.promo");
	mouseTrap = frameGroup.findObject("beat.mousetrap");

	t01 = frameGroup.findObject("beatvis.left");
	t02 = frameGroup.findObject("beatvis.right");
	b01 = frameGroup.findObject("beatvisB.left");
	b02 = frameGroup.findObject("beatvisB.right");
	b01layer = frameGroup.findObject("beatvisB.left.layer");
	b02layer = frameGroup.findObject("beatvisB.right.layer");
	c01 = frameGroup.findObject("beatvisC.left");
	c02 = frameGroup.findObject("beatvisC.right");



	myFrames = t01.getLength();
	
	myTimer = new Timer;
	myTimer.setDelay(10);
 
	///////////////////
	Map myMap = new Map;
	myMap.loadMap("beat.left");
	aniW=myMap.getWidth();

	beatGroup.setXmlParam("w", integerToString(aniW*2));
	t01.setXmlParam("w", integerToString(aniW));
	t02.setXmlParam("x", integerToString(aniW));
	t02.setXmlParam("w", integerToString(aniW));
	b01layer.setXmlParam("x", integerToString(-aniW));
	c02.setXmlParam("x", integerToString(aniW));
	
	if(b02layer.isInvalid()){
		oneSide=true;
	}

	
	if(myMap.getHeight()==45){
		animTypeB=true;
		t01.hide();
		t02.hide();
		
		b01.show();
		if(oneSide){
			b01.setXmlParam("x", integerToString(aniW/2));
		}
		else{
			b02.show();
			b02.setXmlParam("x", integerToString(aniW));
		}
	}
	else if(myMap.getHeight()==90){
		animTypeB=true;
		t01.hide();
		t02.hide();
		b01.show();
		c01.show();

		if(oneSide){
			b01.setXmlParam("x", integerToString(aniW/2));
		}
		else{
			b02.show();
			c02.show();
			b02.setXmlParam("x", integerToString(aniW));
		}

	}
	else animTypeB=false;
	
	delete myMap;
 
}

System.onscriptunloading(){
	delete myTimer;
}


myTimer.onTimer(){

	int beatLeft = System.getLeftVuMeter();
	int beatRight = System.getRightVuMeter();
	
	if(oneSide) beatLeft=(System.getLeftVuMeter()+System.getRightVuMeter())/2;

	if(animTypeB){
		beatLeft=aniW/255*beatLeft;
		b01.setXmlParam("w", integerToString(beatLeft));
		b01.setXmlParam("x", integerToString(aniW-beatLeft));
		b02.setXmlParam("w", integerToString(aniW/255*beatRight));
	}
	else{
		beatLeft= System.getLeftVuMeter();

		int frameLeft=beatLeft/255*myFrames;
		int frameRight=beatRight/255*myFrames;


		if (frameLeft>myFrames) frameLeft=myFrames;
		if (frameRight>myFrames) frameRight=myFrames;

		if (frameLeft<lastBeatLeft){
			frameLeft=lastBeatLeft-1;
			if(frameLeft<0) frameLeft=0;
		}

		if (frameRight<lastBeatRight) {
			frameRight=lastBeatRight-1;
			if(frameRight<0) frameRight=0;
		}

		lastBeatLeft=frameLeft;
		lastBeatRight=frameRight;

		t01.gotoframe(frameLeft);
		t02.gotoframe(frameRight);
	}
}

System.onStop(){
	refreshView();
	myTimer.stop();
	t01.gotoframe(0);
	t02.gotoframe(0);
}

System.onPlay(){
	refreshView();
	if(beatGroup.isVisible()){
		myTimer.start();
	}
}
System.onPause(){
	refreshView();
	if(beatGroup.isVisible()){
		myTimer.stop();
	}
}

System.onResume(){
	refreshView();
	if(beatGroup.isVisible()){
		myTimer.start();
	}
}

beatGroup.onSetVisible(Boolean onoff){
	if(onoff == STATUS_PLAYING){
		myTimer.start();
	}
	else{
		myTimer.stop();
	}
}

frameGroup.onResize(int x, int y, int w, int h){

	if(oneSide){
		beatGroup.setXmlParam("x", integerToString(129 + (w-129-167)/2-aniW/2));
		h=aniW;
	}
	else{
		beatGroup.setXmlParam("x", integerToString(129 + (w-129-167)/2-aniW));
		h=aniW*2;
	}

	
	if(w>296+h){
		showBeat=true;
	}
	else{
		showBeat=false;
	}

	if(w>596){
		promoPic.setXmlParam("image", "cPro.promo.3");
		promoPic.resize(0,0,300,45);
		mouseTrap.resize(0,0,300,45);
	}
	else if(w>496){
		promoPic.setXmlParam("image", "cPro.promo.2");
		promoPic.resize(50,0,200,45);
		mouseTrap.resize(50,0,200,45);
	}
	else{
		promoPic.setXmlParam("image", "cPro.promo.1");
		promoPic.resize(150,0,99,45);
		mouseTrap.resize(150,0,99,45);
	}
	promoGroup.setXmlParam("x", integerToString(129 + (w-129-167)/2-promoPic.getWidth()/2));
	
	if(w>395){
		showPromo=true;
	}
	else{
		showPromo=false;
	}

	//check to see if its disabled
	//if(getPrivateInt(getSkinName(), "beatvis", 1)==0) showBeat=false;
	
	refreshView();
}

refreshView(){
	if(System.getStatus() == STATUS_STOPPED){
		showGroup(1);
	}
	else if(getPrivateInt(getSkinName(), "beatvis", 1)==0){
		showGroup(1);
	}
	else{
		showGroup(0);
	}
}

showGroup(int groupNo){
	beatGroup.hide();
	promoGroup.hide();

	if(groupNo == 0 && showBeat){
		beatGroup.show();
	}
	else if(groupNo == 1 && showPromo){
		promoGroup.show();
	}
	else if(showPromo){
		promoGroup.show();
	}
}

mouseTrap.onRightButtonup(int x, int y){
	selMenu = new PopupMenu;
	selMenu.addCommand("Show Beat vis", 1, getPrivateInt(getSkinName(), "beatvis", 1), 0);

	ProcessMenuResult(selMenu.popAtMouse());
	Complete;
	delete selMenu;
	
}

ProcessMenuResult(int a){
	if(a<0)return;

	if(a>=1){
		setPrivateInt(getSkinName(), "beatvis", !getPrivateInt(getSkinName(), "beatvis", 1));
		refreshView();
	}
}

mouseTrap.onLeftButtonDblClk(int x, int y){
		setPrivateInt(getSkinName(), "beatvis", !getPrivateInt(getSkinName(), "beatvis", 1));
		refreshView();
}