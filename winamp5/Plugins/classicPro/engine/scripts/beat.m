//amended by SLoB 2nd August 2008 - fixed vu display if only using left frame animation strip so it uses both left and right vu levels, also should be faster as removed 3 calls to get left vu value
//SLoB - tweaked beatvis vu values cos theyve been crap since 5.31, vu values are at least 50-100 lower than previous values, this gives it a bit of oomph
#include <lib/std.mi>

#define DEF_MAX 100

Function ProcessMenuResult(int a);
Function refreshView();
Function showGroup(int groupNo);
Function startTimer();

Global Group frameGroup, beatGroup, promoGroup, b01, b02;

Global AnimatedLayer t01, t02;
Global Timer myTimer;
Global int lastBeatLeft,lastBeatRight, myFrames, aniW, beatLeft, beatRight, frameLeft, frameRight, run_max;
Global Boolean showBeat, showPromo, animTypeB, oneSide;
Global Layer promoPic, mouseTrap, b01layer, b02layer, c01, c02;
Global Popupmenu selMenu;
//Global Text vutrackTitle;

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

	//dbg
	//vutrackTitle = frameGroup.findObject("SongTime");
		
		
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

//SLoB - test vu values, cos vu values seem to be shite since 5.31 - as suspected not even hitting 175, so we got loads to play with, lets make it more sensitive so we use the whole 0-255
//vutrackTitle.setText(integertostring(beatLeft));

myTimer.onTimer(){

	beatLeft = System.getLeftVuMeter();// * SENSITIVITY;
	beatRight = System.getRightVuMeter();// * SENSITIVITY;
	
	if(oneSide)
	{
		beatLeft=(beatLeft+beatRight)/2;
	}
	
	if (beatLeft > run_max) run_max = beatLeft;
	if (beatRight > run_max) run_max = beatRight;
//debug - add vutrack
	
	
	if(animTypeB){
		beatLeft=aniW/run_max*beatLeft;
		b01.setXmlParam("w", integerToString(beatLeft));
		b01.setXmlParam("x", integerToString(aniW-beatLeft));
		if(!oneSide) b02.setXmlParam("w", integerToString(aniW/run_max*beatRight));
	}
	else
	{	
		frameLeft=beatLeft/run_max*myFrames;
		frameRight=beatRight/run_max*myFrames;

		// Martin> Frames go from 0 to myFrames-1 !!!
		if (frameLeft>=myFrames) frameLeft=myFrames-1;
		if (frameRight>=myFrames) frameRight=myFrames-1;

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

System.onTitleChange(String newTxt){
	run_max=DEF_MAX;
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
		startTimer();
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
		startTimer();
	}
}

beatGroup.onSetVisible(Boolean onoff){
	//if(onoff == STATUS_PLAYING){
	if(onoff && System.getStatus() == STATUS_PLAYING){
		startTimer();
	}
	else{
		myTimer.stop();
	}
}

frameGroup.onResize(int x, int y, int w, int h){

	if(oneSide){
		//beatGroup.setXmlParam("x", integerToString(129 + (w-129-167)/2-aniW/2+xtraX));
		beatGroup.setXmlParam("x", integerToString(143+(w-317)/2-aniW/2));
		h=aniW;
	}
	else{
		//beatGroup.setXmlParam("x", integerToString(129 + (w-129-167)/2-aniW));
		beatGroup.setXmlParam("x", integerToString(143+(w-317)/2-aniW));
		h=aniW*2;
	}

	
	if(w>317+h){
		showBeat=true;
	}
	else{
		showBeat=false;
	}

	if(w>618){
		promoPic.setXmlParam("image", "cPro.promo.3");
		promoPic.resize(0,0,300,45);
		//mouseTrap.resize(0,0,300,45);
	}
	else if(w>517){
		promoPic.setXmlParam("image", "cPro.promo.2");
		promoPic.resize(50,0,200,45);
		//mouseTrap.resize(50,0,200,45);
	}
	else{
		promoPic.setXmlParam("image", "cPro.promo.1");
		promoPic.resize(150,0,99,45);
		//mouseTrap.resize(150,0,99,45);
	}
	//promoGroup.setXmlParam("x", integerToString(129 + (w-129-167)/2-promoPic.getWidth()/2));
	promoGroup.setXmlParam("x", integerToString(143+(w-317)/2-promoPic.getWidth()/2));
	
	if(w>416){
		showPromo=true;
	}
	else{
		showPromo=false;
	}

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

startTimer(){
	run_max=DEF_MAX;
	myTimer.start();
}