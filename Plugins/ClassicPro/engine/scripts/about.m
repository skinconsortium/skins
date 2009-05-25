#include lib/std.mi

Function showAbout(int no);
Function toggleCredits();


Global Group mainGroup;

Global Layer bganim, aboutLay, mousetrap;
Global Double smidge, vusmidge;
Global int aniNO, vuValue, p_ani, pp_ani, creditPage;
Global Timer animationToggle, animationToggleFade, waitForStart, creditRoll;
Global GuiObject about_pjn, about_martin, about_quad, about_slob, about_pawel, about_trance, tempobject, about_lang, about_lang1, about_other;
Global boolean creditsON;

System.onScriptLoaded() {
	mainGroup = getScriptGroup();
	bganim = mainGroup.findObject("animationscreen");
	aboutLay = mainGroup.findObject("about.layer");
	mousetrap = mainGroup.findObject("mousetrap");
	
	about_pjn = mainGroup.findObject("about.1");
	about_martin = mainGroup.findObject("about.2");
	about_quad = mainGroup.findObject("about.3");
	about_slob = mainGroup.findObject("about.4");
	about_pawel = mainGroup.findObject("about.5");
	about_trance = mainGroup.findObject("about.6");
	about_lang = mainGroup.findObject("about.7");
	about_lang1 = mainGroup.findObject("about.8");	
	about_other = mainGroup.findObject("about.9");
		
	waitForStart = new Timer;
	waitForStart.setDelay(3000);
	waitForStart.start();
}
System.onScriptUnloading() {
	delete animationToggle;
	delete animationToggleFade;
	delete creditRoll;
}

waitForStart.onTimer(){
	waitForStart.stop();
	delete waitForStart;
	
	bganim.show();
	bganim.fx_setBgFx(1);
	bganim.fx_setWrap(1);
	bganim.fx_setBilinear(1);
	bganim.fx_setAlphaMode(0);
	bganim.fx_setGridSize(10, 1);
	bganim.fx_setRect(0);
	bganim.fx_setClear(1);
	bganim.fx_setLocalized(1);
	bganim.fx_setRealtime(1);
	bganim.fx_setSpeed(50);
	bganim.fx_setEnabled(1);
	
	aboutLay.setTargetA(0);
	aboutLay.setTargetSpeed(1.5);
	aboutLay.gotoTarget();
	
	aniNO=0;
	animationToggle = new Timer;
	animationToggle.setDelay(8000);
	animationToggle.start();
	
	animationToggleFade = new Timer;
	animationToggleFade.setDelay(7000);
	animationToggleFade.start();
	
	creditsON=true;
	toggleCredits();
}

creditRoll.onTimer(){
	creditRoll.setDelay(5000);
	creditPage++;
	showAbout(creditPage);
}

animationToggle.onTimer(){
	pp_ani = p_ani;
	p_ani = aniNO;
	
	while(p_ani==aniNO || pp_ani==aniNO){
		aniNO=random(6);
		if(aniNO>5) aniNO=0;
	}
	
	aboutLay.cancelTarget();
	aboutLay.setTargetA(0);
	aboutLay.setTargetSpeed(0.7);
	aboutLay.gotoTarget();
	animationToggleFade.start();
}

animationToggleFade.onTimer(){
	animationToggleFade.stop();

	aboutLay.setTargetA(255);
	aboutLay.setTargetSpeed(1);
	aboutLay.gotoTarget();
}

//animations

/*
bganim.fx_onGetPixelR(double r, double d, double x, double y){
	return ( r+ sin(smidge)*2);
}*/


bganim.fx_onGetPixelD(double r, double d, double x, double y){
	if(aniNO==0){
		return (d +sin(smidge*2));
	}
	else if(aniNO==1){
		return ( d+ sin(smidge+d)*2);
	}
	else if(aniNO==2){
		return d+ tan(smidge);
	}
	else if(aniNO==3){
		return d+ tan(sin(d+smidge)+smidge);
	}
	else if(aniNO==4){
		return d+ tan(sin(d+smidge)+smidge);
	}
	else if(aniNO==5){
		return (d+ sin(smidge/3 + cos(vusmidge)));
	}
	else{
		return d;
	}
}

bganim.fx_onGetPixelR(double r, double d, double x, double y){
	if(aniNO==0){
		return (r+sin(r+smidge));
	}
	else if(aniNO==4){
		return (r+ tan(smidge/2));
	}
	else if(aniNO==5){
		return (r+ smidge/3 + vusmidge);
	}
	else{
		return r;
	}
}

bganim.fx_onFrame()
{
	//smidge = ( smidge + ( 0.100000001490116));
	vuValue=(getLeftVuMeter()+getRightVuMeter())/2;
	smidge +=  0.045;
	vusmidge+=0.045*((getLeftVuMeter()+getRightVuMeter()))/100;
}

showAbout(int no){
	if(creditPage>9){
		creditPage=1;
		no=1;
	}
	if(creditPage<1){
		creditPage=9;
		no=9;
	}
	
	about_pjn.hide();
	about_martin.hide();
	about_quad.hide();
	about_slob.hide();
	about_pawel.hide();
	about_trance.hide();
	about_lang.hide();
	about_lang1.hide();	
	about_other.hide();
	
	tempobject = mainGroup.findObject("about."+integerToString(no));
	if(no<7){
		tempobject.setXmlParam("x", integerToString(5+random(155)));
		tempobject.setXmlParam("y", integerToString(5+random(155)));
	}
	tempobject.show();
	delete tempobject;
}

mainGroup.onMouseWheelUp(int clicked , int lines){
	if(waitForStart!=NULL) return 1; //wait until the intro is finished
	
	if(!creditsON){
		creditsON=true;
		toggleCredits();
	}
	else{
		creditPage++;
	}
	showAbout(creditPage);
	creditRoll.setDelay(10000);
	return 1;
}
mainGroup.onMouseWheelDown(int clicked , int lines){
	if(waitForStart!=NULL) return 1; //wait until the intro is finished

	if(!creditsON){
		creditsON=true;
		toggleCredits();
	}
	else{
		creditPage--;
	}
	showAbout(creditPage);
	creditRoll.setDelay(10000);
	return 1;
}

toggleCredits(){
	if(waitForStart!=NULL) return; //wait until the intro is finished

	if(creditsON){
		creditPage=1;
		creditRoll = new Timer;
		creditRoll.setDelay(5000);
		creditRoll.start();

		about_pjn.setXmlParam("x", integerToString(5+random(155)));
		about_pjn.setXmlParam("y", integerToString(5+random(155)));
		about_pjn.setAlpha(0);
		about_pjn.setTargetA(255);
		about_pjn.setTargetSpeed(1);
		about_pjn.show();
		about_pjn.gotoTarget();
	}
	else{
		creditRoll.stop();
		delete creditRoll;
		about_pjn.hide();
		about_martin.hide();
		about_quad.hide();
		about_slob.hide();
		about_pawel.hide();
		about_trance.hide();
		about_lang.hide();
		about_lang1.hide();		
		about_other.hide();
	}
}

mousetrap.onLeftButtonDblClk(int x, int y){
	creditsON=!creditsON;
	toggleCredits();
}