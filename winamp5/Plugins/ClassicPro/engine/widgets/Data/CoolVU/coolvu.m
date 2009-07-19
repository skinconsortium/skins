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


2009-07-19 - Updates by pjn123
> Added needle showing volume as option
> Changed the values in the menu's to text already used elsewhere in Winamp
> Made the gfx colortheme compatible and it should also look more at home in more skins

*/

#include <lib/std.mi>
#include <lib/colormgr.mi>

Function fxInit();
Function int getLevel(int ch);
Function int compress(int val, double c);

Global Timer mover, volumenotifier;
Global Layer needle, bg;
Global Double LAR,level,sens;
Global Int steps_up, steps_down, channel, limit, mode, turnby, invert, whatshow;
Global Button menubtn;
Global Boolean showVolume;

Global Text txt;

Global ColorMgr myColorMgr;

System.onScriptUnloading() {
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
	bg = tg.findObject("scale");
	showVolume = getPublicInt("cPro.CoolVU.ShowVolume", 1);
	steps_up = getPublicInt("cPro.CoolVU.steps_up", 5);
	steps_down = getPublicInt("cPro.CoolVU.steps_down", 8);
	mode = getPublicInt("cPro.CoolVU.Mode", 4);
	sens = getPublicInt("cPro.CoolVU.Sensitivity", 125)/100;

	txt = tg.getObject("txt");

	fxInit();// fx initialization
	mover = new Timer;
	mover.setDelay(10);
	mover.start();
	volumenotifier = new Timer;
	volumenotifier.setDelay(3000);
	whatshow = 0;

	Color myColor = ColorMgr.getColor("wasabi.list.text");
	int avCol = (myColor.getRed()+myColor.getGreen()+myColor.getBlue())/3;

	if(avCol<255/5){
		bg.setXmlParam("image", "scaleimg.black");
		needle.setXmlParam("image", "neddleimg.black");
	}
	else if(avCol<255/5*3){
		bg.setXmlParam("image", "scaleimg.gray");
		needle.setXmlParam("image", "neddleimg.gray");
	}
	else{
		bg.setXmlParam("image", "scaleimg.white");
		needle.setXmlParam("image", "neddleimg.white");
	}
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
	}
	else {
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
	if(!showVolume) return;
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
  
	SpeedMenu1.addCommand("Slower", 69, steps_up == 19, 0);
	SpeedMenu1.addCommand("Slow", 63, steps_up == 13, 0);
	SpeedMenu1.addCommand("Moderate", 59, steps_up == 9, 0);
	SpeedMenu1.addCommand("Fast", 55, steps_up == 5, 0);
	SpeedMenu1.addCommand("Faster", 51, steps_up == 1, 0);
	
	SpeedMenu2.addCommand("Slower", 110, steps_down == 30, 0);
	SpeedMenu2.addCommand("Slow", 102, steps_down == 22, 0);
	SpeedMenu2.addCommand("Moderate", 95, steps_down == 15, 0);
	SpeedMenu2.addCommand("Fast", 88, steps_down == 8, 0);
	SpeedMenu2.addCommand("Faster", 81, steps_down == 1, 0);
  
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
	VuMenu.addCommand("Show volume if changed", 200, showVolume,0);
	
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
		setPublicInt("cPro.CoolVU.steps_up", com-50);
	}
	else if (com > 80 && com < 111) {
		steps_down = com - 80;
		setPublicInt("cPro.CoolVU.steps_down", com-80);
	}
	else if(com==200){
		showVolume = !showVolume;
		setPublicInt("cPro.CoolVU.ShowVolume", showVolume);
		whatshow = 0;
		volumenotifier.stop();
	}
	setPublicInt("cPro.CoolVU.Sensitivity", sens*100);
	setPublicInt("cPro.CoolVU.Mode", mode);
}