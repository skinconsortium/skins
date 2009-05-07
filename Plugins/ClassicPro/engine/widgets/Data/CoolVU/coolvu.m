/*
The script to smoothly animate needles in VU meters.

Usually it's animated using AnimatedLayer with some discrete positions of needle.
There are at least two disadvantages in this method:
1) Discrecity. Less discrete - smooth animations but more graphics, more discrete - less graphics but ugly animations :(
2) Constant speed (SetStartFrame->SetEndFrame->play etc.) or the instant changing (gotoFrame) in all skins I've seen at least.
So why not to use rotation? Let's do it... But what can we do with the constant/instant speed? In any case we won't see
more frames than global timers resolution let us. Also there should not be differences in time that is need to turn the needle
by 5 degrees or 90 degrees (this is more close to real life). So we just need to fit every needle's discrete turn to frames we have.
That's all :)

Usage:
Place in the same group with needle's layer.
<script id="vu" file="scripts/vu.maki" param="needle_id/menu_button_id/[0 or 1 or 2]/limit/turn_by/invert"/>
needle_id - ID of needle's layer
menu_button_id - ID of menu button
[0 or 1 or 2] - 0 for left channel, 1 for right channel, 2 for both channels
limit - limit of turning in degrees (relative to ordinate)
  will turn beetween 10 and 170 degrees from left if you define 80 etc. (90 +/-80)
turn_by - turn VU by a custom angle
invert - 0 or 1 to invert scale (useful if you turn the VU upside down)

NO MORE UGLY DISCRETE ANIMATIONS IN VU METERS! ;)

v1.1 changes:
Animation code rewritten. Now more realistic, more accurate and more flexible :)
- Separate motion speed when rising and when falling down
- Really accurate turning. Will turn exactly beetween 20 and 160 degrees if you define 70 as a limit etc.
- Four new modes - Exponential, Hybrid (Exp+Lin), Hybrid (Log+Lin) and Logarithmic (v1.0 - Linear only)
- Ability to turn and invert whole "VU-engine"

entrase@yandex.ru
*/

#include <lib/std.mi>
//#include "E:/Scripting2/std.mi"

Function fxInit();
Function int getLevel(int ch);
Function int compress(int val, double c);

Global Timer mover, volumenotifier;
Global Layer needle;
Global Double LAR,level,sens;
Global Int steps_up, steps_down, whatshow, channel, limit, mode, turnby, invert;
Global Button menubtn;

Global Text txt;

System.onScriptUnloading() {
  //switchSkin(getSkinName());
  delete mover;
  delete volumenotifier;
}

System.onScriptLoaded() {// general initialization
  string params = getParam();
  string needleid = getToken(params, "/", 0);
  string btnid = getToken(params, "/", 1);
  channel = stringtointeger(getToken(params, "/", 2));
  limit = stringtointeger(getToken(params, "/", 3));
  turnby = stringtointeger(getToken(params, "/", 4));
  invert = stringtointeger(getToken(params, "/", 5));
  Group tg = getScriptGroup();
  needle = tg.findObject(needleid);
  menubtn = tg.findObject(btnid);
  steps_up = getPrivateInt(getSkinName(), "Rotation steps_up of "+needleid, 3);
  steps_down = getPrivateInt(getSkinName(), "Rotation steps_down of "+needleid, 10);
  mode = getPrivateInt(getSkinName(), "Mode of "+needleid, 4);
  sens = getPrivateInt(getSkinName(), "Sensitivity of "+needleid, 125)/100;

  txt = tg.getObject("txt");

  fxInit();// fx initialization
  mover = new Timer;
  mover.setDelay(10);
  mover.start();
  volumenotifier = new Timer;
  volumenotifier.setDelay(3000);
  whatshow = 0;
}

fxInit() {
  needle.fx_setGridSize(10,10);
  needle.fx_setBgFx(0);
  needle.fx_setWrap(0);
  needle.fx_setBilinear(1);
  needle.fx_setRect(0);
  needle.fx_setClear(0);
  needle.fx_setLocalized(1);
  needle.fx_setRealtime(0);
  needle.fx_setEnabled(1);
}

mover.onTimer() {
  int lim = limit;
  double chlev = getLevel(channel);
  if (chlev > level) level += ((chlev - level)/steps_up);// When rising
  level += ((chlev - level) / steps_down);// When falling down
  double degree = lim*(-level/127)+lim;
  //if(chlev>100)txt.setText(FloatToString(chlev,2));
  if (invert) LAR = turnby/57.295-degree/57.295;// Convert to radians
  else LAR = degree/57.295-turnby/57.295;// Convert to radians
  needle.fx_update();
}

needle.fx_onGetPixelR(double r, double d, double x, double y) {
  return r + LAR;
}

getLevel(int ch) {
  if (whatshow == 0) {
    if (ch == 0) return compress(getLeftVuMeter(),sens);
    else if (ch == 1) return compress(getRightVuMeter(),sens);
    else if (ch == 2) return compress((getRightVuMeter()+getLeftVuMeter())/2,sens);
    else if (ch == 3) {
      // Extra LF attenuation mode
      return compress(((getRightVuMeter()+getLeftVuMeter())/2)*(getVisBand(0,0)/850+0.7),sens);
    }
  } else {
    return getVolume();
  }
}

compress(int val, double c) {
  double ni = val*c;
  if (ni > 255) ni = 255;
  else if (mode == 1) return pow(2.718,ni/46);// Exponential
  else if (mode == 2) return ni*ni/255;// Hybrid (Exp+Lin)
  else if (mode == 3) return ni;// Linear
  else if (mode == 4) return sqrt(ni)*15.97;// Hybrid (Log+Lin)
  else if (mode == 5) return sqrt(sqrt(ni))*63.813;// Logarithmic
}

volumenotifier.onTimer() {
  whatshow = 0;
  volumenotifier.stop();
}

System.onVolumeChanged(int vol) {
  whatshow = 1;
  volumenotifier.start();
}

menubtn.onLeftButtonUp(int x, int y) {// Settings menu
  PopupMenu VuMenu;
	PopupMenu SpeedMenu1;
  PopupMenu SpeedMenu2;
  PopupMenu SensMenu;
  PopupMenu ModeMenu;
  VuMenu = new PopupMenu;
	SpeedMenu1 = new PopupMenu;
  SpeedMenu2 = new PopupMenu;
  SensMenu = new PopupMenu;
  ModeMenu = new PopupMenu;
  for (int c = 1; c < 20; c++) {
    string tip = "";
    if (c == 1) tip = "\tfast";
    else if (c == 4) tip = "\tdefault";
    else if (c == 19) tip = "\tslow";
    SpeedMenu1.addCommand(integerToString(c)+tip, c+50, steps_up == c, 0);
  }
  for (int c = 81; c < 110; c++) {
    string tip = "";
    if (c == 1) tip = "\tfast";
    else if (c == 4) tip = "\tdefault";
    else if (c == 19) tip = "\tslow";
    if (c%2==0) SpeedMenu2.addCommand(integerToString(c-80)+tip, c, steps_down == c-80, 0);
  }
  VuMenu.addSubMenu(SpeedMenu1, "Rise speed");
  VuMenu.addSubMenu(SpeedMenu2, "Falloff speed");
  SensMenu.addCommand("1.0",2,sens == 1.0,0);
  SensMenu.addCommand("1.25",3,sens == 1.25,0);
  SensMenu.addCommand("1.5",4,sens == 1.5,0);
  SensMenu.addCommand("1.75",5,sens == 1.75,0);
  SensMenu.addCommand("2.0",6,sens == 2.0,0);
  
  ModeMenu.addCommand("Exponential",7,mode == 1,0);
  ModeMenu.addCommand("Hybrid (exp+linear)",8,mode == 2,0);
  ModeMenu.addCommand("Linear",9,mode == 3,0);
  ModeMenu.addCommand("Hybrid (log+linear)",10,mode == 4,0);
  ModeMenu.addCommand("Logarithmic",11,mode == 5,0);

  VuMenu.addSubMenu(SensMenu, "Sensitivity");
  VuMenu.addSubMenu(ModeMenu, "Mode");
	//int com = VuMenu.popAtMouse();
	int com = VuMenu.popAtXY(clientToScreenX(menubtn.getLeft()), clientToScreenY(menubtn.getTop() + menubtn.getHeight()));
  
  if (com == 21) mover.stop();
  else if (com == 2) sens = 1.0;
  else if (com == 3) sens = 1.25;
  else if (com == 4) sens = 1.5;
  else if (com == 5) sens = 1.75;
  else if (com == 6) sens = 2.0;
  else if (com == 7) mode = 1;
  else if (com == 8) mode = 2;
  else if (com == 9) mode = 3;
  else if (com == 10) mode = 4;
  else if (com == 11) mode = 5;
  else if (com == 20) mover.start();
	else if (com > 49 && com < 80) {
		steps_up = com - 50;
    setPrivateInt(getSkinName(), "Rotation steps_up of "+getToken(getParam(), "/", 0), com - 50);
	}
  else if (com > 80 && com < 111) {
		steps_down = com - 80;
    setPrivateInt(getSkinName(), "Rotation steps_down of "+getToken(getParam(), "/", 0), com-80);
	}
  setPrivateInt(getSkinName(), "Sensitivity of "+getToken(getParam(), "/", 0), sens*100);
  setPrivateInt(getSkinName(), "Mode of "+getToken(getParam(), "/", 0), mode);
}