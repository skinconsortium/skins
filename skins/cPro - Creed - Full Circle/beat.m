#include <lib/std.mi>
#define DEF_MAX 50

Function ProcessMenuResult(int a);
Function refreshView();
Function showGroup(int groupNo);
Function startTimer();
Function setAnimNo(int i);
Function setCustomVis(int a);

Global Group frameGroup, beatGroup, promoGroup, b01, b02;

Global AnimatedLayer beatAnimLeft, beatAnimRight;
Global Timer myTimer;
Global int lastBeatLeft,lastBeatRight, myFrames, aniW, beatLeft, beatRight, frameLeft, frameRight, run_max, cusno;
Global Boolean showBeat, showPromo, animTypeB, oneSide, customvis;
Global Layer mouseTrap, b01layer, b02layer, c01, c02;
Global Popupmenu selMenu;
Global List cusbeat_names;

System.onScriptLoaded (){
	frameGroup = getScriptGroup ();

	// mpdeimos> taking advance of grouping and get instead of find will save lots of CPU cycles and skins are more resistant against mods!

	Group cg = frameGroup.getObject("cpro.screen2");
	
	beatGroup = cg.getObject("beatvis2");
	promoGroup = cg.getObject("beatpromo2");
	mouseTrap = cg.getObject("beat.mousetrap2");

	beatAnimLeft = beatGroup.getObject("beatvis.left2");
	beatAnimRight = beatGroup.getObject("beatvis.right2");
	b01 = beatGroup.getObject("beatvisB.left2");
	b02 = beatGroup.getObject("beatvisB.right2");
	b01layer = b01.getObject("beatvisB.left.layer2");
	b02layer = b02.getObject("beatvisB.right.layer2");
	c01 = beatGroup.getObject("beatvisC.left2");
	c02 = beatGroup.getObject("beatvisC.right2");
	
	myTimer = new Timer;
	myTimer.setDelay(10);
 
	aniW=84;

	beatGroup.setXmlParam("w", integerToString(aniW));
	
	if(b02layer.isInvalid()) oneSide=true;
		
	customvis=false;

	animTypeB=false;
	myFrames = beatAnimLeft.getLength();

}

System.onscriptunloading(){
	delete myTimer;
}

setAnimNo(int i){
	Map myMap = new Map;
	myMap.loadMap("beat.left");
	
	beatAnimLeft.setXmlParam("image", "beat.left#.0");
	beatAnimRight.setXmlParam("image", "beat.left#.0");
	myFrames = beatAnimLeft.getLength();

}

myTimer.onTimer(){

	beatLeft = System.getLeftVuMeter();
	beatRight = System.getRightVuMeter();
	
	if(oneSide)
	{
		beatLeft=(beatLeft+beatRight)/2;
	}
	
	if (beatLeft > run_max) run_max = beatLeft;
	if (beatRight > run_max) run_max = beatRight;
	
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

		beatAnimLeft.gotoframe(frameLeft);
		beatAnimRight.gotoframe(frameRight);
	}
}

System.onTitleChange(String newTxt){
	run_max=DEF_MAX;
}

System.onStop(){
	refreshView();
	myTimer.stop();
	beatAnimLeft.gotoframe(0);
	beatAnimRight.gotoframe(0);
}

System.onPlay(){
	refreshView();
	if(beatGroup.isVisible()) startTimer();
}
System.onPause(){
	refreshView();
	if(beatGroup.isVisible()) myTimer.stop();
}

System.onResume(){
	refreshView();
	if(beatGroup.isVisible()) startTimer();
}

beatGroup.onSetVisible(Boolean onoff){
	if(onoff && System.getStatus() == STATUS_PLAYING) startTimer();
	else myTimer.stop();
}

frameGroup.onResize(int x, int y, int w, int h){

	beatGroup.setXmlParam("x", integerToString(w/2-aniW/2));
	h=aniW;

	
	if(w>280+h)	showBeat=true;
	else showBeat=false;

	promoGroup.setXmlParam("x", integerToString(w/2-aniW/2));
	
	if(w>280+h) showPromo=true;
	else showPromo=false;

	refreshView();
}

refreshView(){
	if(System.getStatus() == STATUS_STOPPED) showGroup(1);
	else if(getPrivateInt(getSkinName(), "beatvis", 1)==0)	showGroup(1);
	else showGroup(0);
}

showGroup(int groupNo){
	beatGroup.hide();
	promoGroup.hide();

	if(groupNo == 0 && showBeat) beatGroup.show();
	else if(groupNo == 1 && showPromo) promoGroup.show();
	else if(showPromo) promoGroup.show();
}

mouseTrap.onLeftButtonDblClk(int x, int y){
	if(customvis){
		if(getPrivateInt(getSkinName(), "beatvis", 1)){
			int u = getPrivateInt(getSkinName(), "customvis", 0)+1;

			if(u==cusbeat_names.getNumItems()){
				u=0;
				setPrivateInt(getSkinName(), "beatvis", 0);
			}
			setCustomVis(u);
		}
		else setPrivateInt(getSkinName(), "beatvis", 1);
	}
	else setPrivateInt(getSkinName(), "beatvis", !getPrivateInt(getSkinName(), "beatvis", 1));
	
	refreshView();
}

mouseTrap.onRightButtonup(int x, int y){
	selMenu = new PopupMenu;
	selMenu.addCommand("Show Beat vis", 1, getPrivateInt(getSkinName(), "beatvis", 1), 0);

	if(customvis){
		selMenu.addSeparator();
		for(int i=0;i<cusbeat_names.getNumItems(); i++){
			selMenu.addCommand(cusbeat_names.enumItem(i), 100+i, 0, 0);
	
		}
		selMenu.checkCommand(100+getPrivateInt(getSkinName(), "customvis", 0), 1);
	}

	ProcessMenuResult(selMenu.popAtMouse());
	Complete;
	delete selMenu;
	
}

ProcessMenuResult(int a){
	if(a<0) return;

	if(a>=1 && a<100){
		setPrivateInt(getSkinName(), "beatvis", !getPrivateInt(getSkinName(), "beatvis", 1));
		refreshView();
	}
	else if(a>=100 && customvis){
		setCustomVis(a-100);
	}
}

setCustomVis(int a){
	//debugString("setCustomVis=" + integerToString(a),9);
	if(a>=cusbeat_names.getNumItems()) a=0;
	beatAnimLeft.setXmlParam("image", "beat."+integerToString(a)+".left");
	if(!oneSide) beatAnimRight.setXmlParam("image", "beat."+integerToString(a)+".right");
	myFrames = beatAnimLeft.getLength();
	
	setPrivateInt(getSkinName(), "customvis", a);
}



startTimer(){
	run_max=DEF_MAX;
	myTimer.start();
}