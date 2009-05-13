#include <lib/std.mi>
#define FXPi 3.14159
Global group aboutGroup;

Global Layer Fx;
Global Double dp, tp, rp, dUFOVu;
Global Double dblSmidge;
Global Double dblFactor;
Global Double dCosx;
Global Double dCosy;
global double dR, dTest;
global int x, dUFOVu;
global text tResult;
global double dCosx, dCosy;
global double dx,dy,dz;

System.onScriptLoaded() {

	aboutGroup = getScriptGroup();
	Fx =  	aboutGroup.findObject("fx");

	dUFOVu = 0.0;
	tp = 0.03;
	dp = 0.01;
	dblFactor = 0.25; // adjustable level of distortion
    
	dblFactor = dblFactor * 5;
	
	Fx.fx_setBgFx(0);
  	Fx.fx_setWrap(0);
  	Fx.fx_setBilinear(1);
  	Fx.fx_setAlphaMode(0);
  	Fx.fx_setGridSize(8,8);
  	Fx.fx_setRect(0);
  	Fx.fx_setClear(0);
  	Fx.fx_setLocalized(1);
  	Fx.fx_setRealtime(1);
  	Fx.fx_setSpeed(80);
  	Fx.setAlpha(255);

}

system.onScriptUnloading() {

	Fx.fx_setEnabled(0);
	Fx.hide();
	 
  	aboutGroup = NULL; // clears all instances
  	
}

//layerfx ani stuff

Fx.fx_onGetPixelD(double r, double d, double x, double y) {
	//dR =  (d * (1.9 - sin(dp+x)) + cos(tp+y) * dUFOVu);  //floppy mexican wavish	
	
	//dR = sin(x-y+r+dp) * cos(x-y-d*FXPi*dp) * dblFactor;
	//dR = sin(x-y+r-(tp-dp)) * cos(x-y-d*FXPi*(sin((tp-dp/2))+0.01)) * dblFactor;
	//dR = (cos(pow(y+dp,2) + pow(x-dp,2))) * dblFactor;
	
	
	//dR = d*(1.01+cos(y+dp*0.325)*dblFactor); //cool
	//dR = x+sin(x-y*tp) * cos(dblFactor*dp); //verycoolswirlyrotation almost twister like
	
	/*	dx=x*cos(dp)+y*sin(dp);
		dy=-x*sin(dp)+y*cos(dp);
		dz=x*cos(tp)+d*sin(tp);
		dR= dx + dy * dz * (dblFactor/1.4);*/
		
		/*if(d==0)d=x;
		dR=cos(dp+d*x*y) - sin(tp+x*y) / (dblFactor*dp+0.01);
		
		dR = dR + x+sin(x-y*tp) * cos(dblFactor*dp);*/
				
		//dR = d*(1.01+cos(y+dp*0.325)*dblFactor); //cool swell
		
		dR = d*(1.01+cos(y+dp*0.325)*dblFactor); //cool swell
		//dR = sin(d-r+tp) + d*(1.01+cos(y+dp*0.325)*dblFactor);
		
	return dR;
}



//get vu calc only once
Fx.fx_onFrame() {
 
 	//if ya want sound meter to alter pattern
  	dUFOVu =  ((((System.getLeftVuMeter() + System.getRightVuMeter()) / 2))  /500);

	//for (x=0; x<=4; x++){dUFOVu = dUFOVu + getVisBand(0,x);}
	//dUFOVu = integer(dUFOVu/800);


//	dUFOVu = 0;
//	for (x=0; x<=4; x++){dUFOVu = dUFOVu+getVisBand(0,x);}
//	dUFOVu = (dUFOVu/5)/400;

	dp = dp + 0.1;
  	tp = tp + 0.3;

	if(tp>200)tp=0.3;
	if(dp>200)dp=0.1;
	

	//tResult.settext(" dR=" + System.floatToString(dR, 2) + " dp=" + System.floatToString(dp, 2) + " tp=" + System.floatToString(tp, 2));  	
}


aboutGroup.onSetVisible(boolean on) {
  	if (on) {

		Fx.show();
		Fx.fx_setEnabled(1);

  	} else {

		Fx.fx_setEnabled(0);
		Fx.hide();
	}
}



