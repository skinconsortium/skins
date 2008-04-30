#include "../../../lib/std.mi"
#include "defines.m"

//optimised by SLoB, now uses virtually no cpu

Global Layout disp, conf;
Global AnimatedLayer anim1t, anim1b, anim1m, ani2, ani3, ani4, ani;
Global Button visbut1, visbut2, visbut3, visbut4;
Global Group vis1, vis2, vis3, vis4;
Global Timer anim, advanim;
Global Int curvis, lastframe, x, iVisOn;
Global Double oneframe, level, oneframeT, oneframeB, oneframeM;

function changevis(int cur);
function fadeinout(guiobject g, int alph, int speed);
function showcurvis(int v);
function updateanim(animatedlayer a, int frame);
function GetOneFrame(AnimatedLayer aniGetOneFrame);

system.onScriptLoaded() {	
	disp = getContainer("main").getLayout("normal");
	conf = getContainer("win.config").getLayout("normal");

	anim1t = disp.findObject("anim1.treble");
	anim1b = disp.findObject("anim1.bass");
	anim1m = disp.findObject("anim1.mid");

	ani2 = disp.findObject("anim2");
	ani3 = disp.findObject("anim3");
	ani4 = disp.findObject("anim4");
	
	vis1 = disp.findObject("main.anim1");
	vis2 = disp.findObject("main.anim2");
	vis3 = disp.findObject("main.anim3");
	vis4 = disp.findObject("main.anim4");

	visbut1 = conf.findObject("visbut1");
	visbut2 = conf.findObject("visbut2");
	visbut3 = conf.findObject("visbut3");
	visbut4 = conf.findObject("visbut4");

	anim = new Timer;
	anim.setDelay(30);

	advanim = new Timer;
	advanim.setDelay(30);

	curvis = getPrivateInt(SKIN_NAME, "curvis", 2);

	iVisOn = getPrivateInt(SKIN_NAME, "visdisplay", 0);


	if(curvis == 1) 
	{ 
		oneframeT = GetOneFrame(anim1t);
		oneframeB = GetOneFrame(anim1b);
		oneframeM = GetOneFrame(anim1m);	

	  if(iVisOn > 0)
  	  {
		vis1.show();
		Vis1.setXmlParam("alpha", "255");
	  }
	}
	else if(curvis == 2) 
	{ 
		ani = ani2;
		oneframe = GetOneFrame(ani);

	  if(iVisOn > 0)
  	  {

		vis2.show(); 
		Vis2.setXmlParam("alpha", "255"); 
	  }
	}
	else if(curvis == 3) 
	{ 
		ani = ani3;
		oneframe = GetOneFrame(ani);

	  if(iVisOn > 0)
  	  {
		vis3.show(); 
		Vis3.setXmlParam("alpha", "255"); 
	  }
	}
	else if(curvis == 4) 
	{ 
		ani = ani4;
		oneframe = GetOneFrame(ani);

	  if(iVisOn > 0)
  	  {
		vis4.show(); 
		Vis4.setXmlParam("alpha", "255"); 
	  }
	}

	//only show if its set to on
  if(iVisOn > 0)
  {
	showcurvis(curvis);
	changevis(curvis);
  }	

	if(iVisOn==0)
	{
		anim.stop();
		advanim.stop();
	}

	if(iVisOn==1)
	{
		showcurvis(curvis);
		changevis(curvis);
		if(curvis==1)
		{
			advanim.start();
		}
		if(curvis>=2)
		{
			anim.start();
		}
	}


}

System.onScriptUnloading(){
	setPrivateInt(SKIN_NAME, "curvis", curvis);

	anim.stop();
	advanim.stop();
	delete anim;
	delete advanim;
}

GetOneFrame(AnimatedLayer aniGetOneFrame)
{
	int GotOneFrame = 255/aniGetOneFrame.getLength();
	//sometimes can return zero if vis has not loaded (if for example just using getlength),  avoid divide by zero
	if(GotOneFrame<1)
	{
		GotOneFrame = 1;
	}
	return GotOneFrame;
}

//now simple :)
updateanim(animatedlayer a, int frame) {
	a.gotoFrame(frame);
}

anim.onTimer() {
	level = ((System.getLeftVuMeter() + System.getRightVuMeter())/2)/oneframe;
	updateanim(ani, level);
}

advanim.onTimer() {
	level = ((System.getLeftVuMeter() + System.getRightVuMeter())/2)/oneframeT;
	updateanim(anim1t, level);
	
	level = 0;
	for (x=0; x<=4; x++){level = level+getVisBand(0,x);}
	level = level/5;
	updateanim(anim1b, level/oneframeB);

	level = 0;
	for (x=0; x<=5; x++){level = level+getVisBand(0,75-x*2);}
	level = level/5;
	updateanim(anim1m, level/oneframeM);
}


visbut1.onRightButtonUp(int x, int y) 
{
	anim.stop();
	advanim.stop();
	
	complete;
}

visbut2.onRightButtonUp(int x, int y) 
{
	anim.stop();
	advanim.stop();

	complete;
}

visbut3.onRightButtonUp(int x, int y) 
{
	anim.stop();
	advanim.stop();

	complete;
}

visbut4.onRightButtonUp(int x, int y) 
{
	anim.stop();
	advanim.stop();

	complete;
}

visbut1.onLeftButtonUp(int x, int y) {
	anim.stop();
	advanim.start();
	curvis = 1;
	oneframeT = GetOneFrame(anim1t);
	oneframeB = GetOneFrame(anim1b);
	oneframeM = GetOneFrame(anim1m);		
	changevis(curvis);
}

visbut2.onLeftButtonUp(int x, int y) {
	advanim.stop(); 
	
	ani = ani2;		
	oneframe = GetOneFrame(ani);
	curvis = 2;
	changevis(curvis); 
	anim.start();	
}

visbut3.onLeftButtonUp(int x, int y) {	
	advanim.stop(); 
	
	ani = ani3;
	oneframe = GetOneFrame(ani);
	curvis = 3;
	changevis(curvis);
	anim.start();
}

visbut4.onLeftButtonUp(int x, int y) {
	advanim.stop(); 
	
	ani = ani4;
	oneframe = GetOneFrame(ani);
	curvis = 4;
	changevis(curvis); 	
	anim.start();
}

vis1.onTargetReached() {
	if(vis1.getAlpha()==0) {
		showcurvis(curvis);
	}
}

vis2.onTargetReached() {
	if(vis2.getAlpha()==0) {
		showcurvis(curvis);
	}
}

vis3.onTargetReached() {
	if(vis3.getAlpha()==0) {
		showcurvis(curvis);
	}
}

vis4.onTargetReached() {
	if(vis4.getAlpha()==0) {
		showcurvis(curvis);
	}
}



changevis(int cur) {
	if(cur==1)
	{
		fadeinout(vis2,0,1);
		fadeinout(vis3,0,1);
		fadeinout(vis4,0,1);

		fadeinout(visbut2,100,1);
		fadeinout(visbut3,100,1);
		fadeinout(visbut4,100,1);

	}
	else if(cur==2) 
	{
		fadeinout(vis1,0,1);
		fadeinout(vis3,0,1);
		fadeinout(vis4,0,1);

		fadeinout(visbut1,100,1);
		fadeinout(visbut3,100,1);
		fadeinout(visbut4,100,1);

	}
	else if(cur==3) 
	{
		fadeinout(vis1,0,1);
		fadeinout(vis2,0,1);
		fadeinout(vis4,0,1);

		fadeinout(visbut1,100,1);
		fadeinout(visbut2,100,1);
		fadeinout(visbut4,100,1);

	}
	else if(cur==4) 
	{
		fadeinout(vis1,0,1);
		fadeinout(vis2,0,1);
		fadeinout(vis3,0,1);

		fadeinout(visbut1,100,1);
		fadeinout(visbut2,100,1);
		fadeinout(visbut3,100,1);

	}




}

showcurvis(int v) {
	if(v==1) 
	{
		fadeinout(vis1,255,1);
		fadeinout(visbut1,255,1);
	}
	else if(v==2) 
	{
		fadeinout(vis2,255,1);
		fadeinout(visbut2,255,1);
	}
	else if(v==3) 
	{
		fadeinout(vis3,255,1);
		fadeinout(visbut3,255,1);
	}
	else if(v==4) 
	{
		fadeinout(vis4,255,1);
		fadeinout(visbut4,255,1);
	}
}

fadeinout(guiobject g, int alph, int speed) {
	g.show();
	g.setTargetA(alph);
	g.setTargetSpeed(0.7);
	g.gotoTarget();
}

system.onPlay() {

	iVisOn = getPrivateInt(SKIN_NAME, "visdisplay", 0);

	if(iVisOn==0)
	{
		anim.stop();
		advanim.stop();
	}

	if(iVisOn==1)
	{
		showcurvis(curvis);
		changevis(curvis);
		if(curvis==1)
		{
			advanim.start();
		}
		if(curvis>=2)
		{
			anim.start();
		}
		
	}

}

system.onPause() {
	anim.stop();
	advanim.stop();
}

system.onResume() {
	iVisOn = getPrivateInt(SKIN_NAME, "visdisplay", 0);

	if(iVisOn==0)
	{
		anim.stop();
		advanim.stop();
	}

	if(iVisOn==1)
	{
		showcurvis(curvis);
		changevis(curvis);
		if(curvis==1)
		{
			advanim.start();
		}
		if(curvis>=2)
		{
			anim.start();
		}
	}
}

system.onStop() {
	anim.stop();
	advanim.stop();
}

//double check if vis is on, if not and thers still activity, switch it off
System.onTitleChange(String newtitle) {
	
	iVisOn = getPrivateInt(SKIN_NAME, "visdisplay", 0);

	if(iVisOn==0)
	{
		anim.stop();
		advanim.stop();
	}

}

