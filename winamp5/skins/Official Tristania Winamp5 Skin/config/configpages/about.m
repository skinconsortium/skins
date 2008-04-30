#include "../../../../lib/std.mi"

Global Layer fx;
Global Group thisl;
Global Double rp, dp, tp, ap;
Global Int ef;
Global Layer Next;
Global Timer tmr;
Global Button hp;

FX.fx_onGetPixelA(double r, double d, double x, double y) {
//  if (ef == 0) return cos(d*3.14159);
  return 1.0;
}

Fx.fx_onGetPixelR(double r, double d, double x, double y) {
  if (!ef || ef==1) return r+cos(rp);
  if (ef == 3) return r-rp;
  return r;
}

Fx.fx_onGetPixelD(double r, double d, double x, double y) {
  if (!ef || ef==2) return d*(1.3-sin(dp)) + cos(tp)*0.2;
  if (ef == 3) return d*(1.01+cos(rp*0.325));
  return d;
}

Fx.fx_onGetPixelY(double r, double d, double x, double y) {
  if (ef==4) return y+sin(x-rp);
  return y;
}

Fx.fx_onFrame() {
  rp = rp + 0.2;
  dp = dp + 0.1;
  tp = tp + 0.3;
  ap = ap + 0.05;
}

Next.onLeftButtonDown(int x, int y) { 
  ef = ef+1;
  if (ef == 5) 
    ef = -1;
  if (ef == 4) 
    Fx.fx_setRect(1); 
  else 
    Fx.fx_setRect(0);
/*  if (ef == 0) Fx.fx_setAlphaMode(2);
  else Fx.fx_setAlphaMode(0);*/

  Fx.fx_setWrap(0);
  if (ef == 0)
    Fx.fx_setGridSize(4,4);
  else if (ef == 1 || ef == 3) 
  {
    Fx.fx_setGridSize(1,1);
    Fx.fx_setWrap(1);
  }
  else if (ef == 2)
    Fx.fx_setGridSize(6,6);
  else if (ef == 4)
    Fx.fx_setGridSize(4,4);
 /* if (ef == 0 || ef == 2 || ef == 4) {
    Fx.setAlpha(255);
  } else {
    Fx.setAlpha(192);
  }*/
}

thisl.onSetVisible(int v) {
  Fx.fx_setEnabled(v);
  if (v) tmr.start();
  else tmr.stop();
}

System.onScriptLoaded() {

  thisl = getScriptGroup();
  Next = thisl.getObject("banner");
  Fx = thisl.getObject("banner");
  tmr = new Timer;
  tmr.setDelay(3000);
  hp = thisl.findObject("url");


  Fx.fx_setBgFx(0);
  Fx.fx_setWrap(0);
  Fx.fx_setBilinear(1);
  Fx.fx_setAlphaMode(2);
  Fx.fx_setGridSize(2,2);
  Fx.fx_setRect(0);
  Fx.fx_setClear(1);
  Fx.fx_setLocalized(1);
  Fx.fx_setRealtime(1);
  Fx.fx_setSpeed(30);

  ef = 4;
  Next.onLeftButtonDown(0,0);
}

tmr.onTimer() {
	ef++;
	if (ef == 5) ef = -1;
	if (tmr == -1) tmr.setDelay(2000);
	else tmr.setDelay(5000);
}

hp.onleftclick() { System.navigateUrl("http://www.skinconsortium.com"); }

