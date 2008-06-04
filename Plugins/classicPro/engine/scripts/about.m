#include <lib/std.mi>

Function gotoAbout(boolean onOff);
Function showAboutPage(int page);

Global Group mainGroup, grpLayer;
Global Group about0, about1, about2, about3, about4, about5, about6;

Global Layer l_about, bganim;
Global Timer toggleMode, pageTimer;
Global boolean currentMode;
Global int pageNo, prevPage;
Global Double smidge;

System.onScriptLoaded() {
	mainGroup = getScriptGroup();
	l_about = mainGroup.findObject("cpro.about.gfx");
	grpLayer = mainGroup.findObject("about.main.layer");

	about0 = mainGroup.findObject("credit.0");
	about1 = mainGroup.findObject("credit.1");
	about2 = mainGroup.findObject("credit.2");
	about3 = mainGroup.findObject("credit.3");
	about4 = mainGroup.findObject("credit.4");
	about5 = mainGroup.findObject("credit.5");
	about6 = mainGroup.findObject("credit.6");

	bganim = mainGroup.findObject("credit.bg.ani");
	bganim.fx_setBgFx(0);
	bganim.fx_setWrap(1);
	bganim.fx_setBilinear(1);
	bganim.fx_setAlphaMode(0);
	bganim.fx_setGridSize(5, 1);
	bganim.fx_setRect(0);
	bganim.fx_setClear(1);
	bganim.fx_setLocalized(1);
	bganim.fx_setRealtime(1);
	bganim.fx_setSpeed(50);
	bganim.fx_setEnabled(1);
	
	toggleMode = new Timer;
	toggleMode.setDelay(2000);
	toggleMode.start();
	
	pageNo=0;
	prevPage=0;
	
	pageTimer = new Timer;
	pageTimer.setDelay(3500);
}

System.onscriptunloading(){
	delete toggleMode;
	delete pageTimer;
}

toggleMode.onTimer(){
	gotoAbout(true);
	toggleMode.stop();
}

gotoAbout(boolean onOff){
	currentMode = !currentMode;

	if(onOff){
		showAboutPage(0);
		pageTimer.start();
	
		l_about.setTargetX(255);
		l_about.setTargetY(215);
		l_about.setTargetW(118);
		l_about.setTargetH(100);
	}
	else{
		showAboutPage(0);
		pageTimer.stop();
		
		l_about.setTargetX(0);
		l_about.setTargetY(0);
		l_about.setTargetW(380);
		l_about.setTargetH(321);
	}
	
	l_about.setTargetSpeed(1);
	l_about.gotoTarget();
}

l_about.onLeftButtonUp(int x, int y){
	toggleMode.stop();
	gotoAbout(!currentMode);
}

pageTimer.onTimer(){
	showAboutPage(pageNo+1);
}

showAboutPage(int page){
	if(page>6) page=0;
	
	pageNo=page;
	
	if(prevPage==page) return;

	//Do this with current page
	if(prevPage==0){
		about0.setTargetX(-380);
	}
	else if(prevPage==1){
		about1.setTargetX(-380);;
	}
	else if(prevPage==2){
		about2.setTargetX(-380);
	}
	else if(prevPage==3){
		about3.setTargetX(-380);
	}
	else if(prevPage==4){
		about4.setTargetX(-380);
	}
	else if(prevPage==5){
		about5.setTargetX(-380);
	}
	else if(prevPage==6){
		about6.setTargetX(-380);
	}


	//Going to this page
	if(page==0){
		pageTimer.setDelay(3500);
		about0.setXmlParam("x", "380");
		about0.setTargetX(0);
	}
	else if(page==1){
		about1.setXmlParam("x", "380");
		about1.setTargetX(0);
	}
	else if(page==2){
		about2.setXmlParam("x", "380");
		about2.setTargetX(0);
	}
	else if(page==3){
		about3.setXmlParam("x", "380");
		about3.setTargetX(0);
	}
	else if(page==4){
		about4.setXmlParam("x", "380");
		about4.setTargetX(0);
	}
	else if(page==5){
		about5.setXmlParam("x", "380");
		about5.setTargetX(0);
	}
	else if(page==6){
		about6.setXmlParam("x", "380");
		about6.setTargetX(0);
		pageTimer.setDelay(6000);
	}
	
	about0.setTargetSpeed(1);
	about1.setTargetSpeed(1);
	about2.setTargetSpeed(1);
	about3.setTargetSpeed(1);
	about4.setTargetSpeed(1);
	about5.setTargetSpeed(1);
	about6.setTargetSpeed(1);

	about0.gotoTarget();
	about1.gotoTarget();
	about2.gotoTarget();
	about3.gotoTarget();
	about4.gotoTarget();
	about5.gotoTarget();
	about6.gotoTarget();
	
	prevPage=page;
}

//animations
bganim.fx_onGetPixelR(double r, double d, double x, double y)
{
	return ( r + ( System.cos(smidge) * ( 0.5)));
}

bganim.fx_onFrame()
{
	smidge = ( smidge + ( 0.100000001490116));
}