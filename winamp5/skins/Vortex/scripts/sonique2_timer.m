// *****************************
// **  Sonique2-styled timer  **
// *****************************
// coded by spleen (spleen@net.hr)
// with assistance from ThePlague and Gonzotek
// modified by FrisbeeMonkey for greater flexibility
// (rather than shanghai the SongTicker, now requires
// a new Text Object)
// additional features for vortex by martin.deimos

#include </lib/std.mi>

Function String specialTimer(int CurPos);

Global Timer tmrWait, btm;
Global Text txtTimer;
Global Boolean MinusIsOn;

Function ProcessMenuResult(int a);
Global PopUpMenu menu;
Global Int mode, blink;

System.onScriptLoaded() {
  Group mainnormal = getScriptGroup();
  txtTimer = mainnormal.findObject("s2timer");

  tmrWait = new Timer;
  tmrWait.setDelay(20);
  btm = new Timer;
  btm.setDelay(750);


  mode = getPrivateInt("Deimos/Vortex/timer", "mode", 1);
  blink = getPrivateInt("Deimos/Vortex/timer", "blink", 1);

  MinusIsOn = getPrivateInt(getSkinName()+"/timer","elapsed",0);

  if (System.getStatus()!=0 && mode == 1) tmrWait.start();
  if (mode == 2) txtTimer.setXMLParam("timerhours", "0");
  if (mode == 3) txtTimer.setXMLParam("timerhours", "1");

  if (getStatus() == -1)
  {
  	btm.start();
  }
}

System.onScriptUnloading() {
  tmrWait.stop();
  delete tmrWait;
  btm.stop();
  delete btm;
}

System.onPlay() {
  if (mode == 1) tmrWait.start();
  btm.stop();
  txttimer.show();
}

System.onPause() {
	btm.start();
}

System.onStop() {
  tmrWait.stop();
  txtTimer.setText("");
  btm.stop();
  txttimer.show();
}

System.onResume() {
	btm.stop();
	if (mode == 1) tmrWait.start();
	txttimer.show();
}

tmrWait.onTimer() {
  if (MinusIsOn) txtTimer.setText(specialTimer(getPlayItemLength()-getPosition()));
  else txtTimer.setText(specialTimer(getPosition()));
}

btm.onTimer() {
	if (txtTimer.isVisible()) {
		TxtTimer.hide();
	} else Txttimer.show();
}
	

txtTimer.onLeftButtonDown(int x, int y) {
  if (MinusIsOn) MinusIsOn=0;
  else MinusIsOn=1;
  setPrivateInt(getSkinName()+"/timer","elapsed",MinusIsOn);
}
txtTimer.onRightButtonUp(int x, int y)
{
	menu = new PopUpMenu;
	menu.addCommand("Style:", 999, 0, 1);
	menu.addCommand("Sonique2 (HH:MM:SS.ms)", 1, mode == 1, 0);
	menu.addCommand("Normal (M:SS)", 2, mode == 2, 0);
	menu.addCommand("Large (H:MM:SS)", 3, mode == 3, 0);
	menu.addSeparator();
	menu.addCommand("Blink on pause", 10, blink == 1, 0);

	ProcessMenuResult(menu.popAtMouse());
	delete menu;
	complete;
}

ProcessMenuResult(int a) {
	if(a < 1) return;
	if(a == 1) {
		mode = a;
		if (System.getStatus()!=0) tmrWait.start();
		setPublicInt("Deimos/Vortex/timer_mode", a);
	}
	else if (a == 2)
		{
			mode = a;
			tmrWait.stop();
			txtTimer.setXMLParam("timerhours", "0");
			txtTimer.setText("");
			setPublicInt("Deimos/Vortex/timer_mode", a);
		}
	else if (a == 3)
		{
			mode = a;
			tmrWait.stop();
			txtTimer.setXMLParam("timerhours", "1");
			txtTimer.setText("");
			setPublicInt("Deimos/Vortex/timer_mode", a);
		}
	else if (a == 10)
		{
			txttimer.show();
			blink = (blink-1)*(blink-1);
			if (blink && getStatus() == -1) {
				btm.start();
			} else btm.stop();
			setPublicInt("Deimos/Vortex/timer_blink", blink);
			
		}
}


String specialTimer(int CurPos) {
  String SpecTmr = integerToLongTime(CurPos) + ".";
  String Temp = integerToString(CurPos);
  int TempLen = strlen(Temp);

  if (strlen(SpecTmr)==8) SpecTmr = "0" + SpecTmr;

  if (TempLen>=3) {
    Temp = strmid(Temp,TempLen-3,2);
    SpecTmr = SpecTmr + Temp;
  } else
  if (TempLen==2) {
    Temp = strmid(Temp,0,1);
    SpecTmr = SpecTmr + "0" + Temp;
  } else
    SpecTmr = SpecTmr + "00";

  if (MinusIsOn) SpecTmr = "-" + SpecTmr;

  return SpecTmr;
}
