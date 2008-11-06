/*
Script by TEM 2007

XUI version of the clock script.

Script shows clock (fades in and out) when stopped.
*/

#include <lib/std.mi>

Function ShowClock(int state); // 0: turn off, 1: turn on
Function ProcessMenu(int iC);

Global Text time, clock;
Global Timer ClockTmr;
Global PopUpMenu clockMenu;
Global Int clockon, clock0s, clock24;
Global Group grp;

//#define DEBUG

#ifdef DEBUG
Function debug(String debugStr);
debug(String debugStr) {
	system.debugstring(debugStr,0);
}
#endif


System.onScriptLoaded() 
{
	grp = getScriptGroup();
		
	time = grp.findObject("timer");
	clock = grp.findObject("clock");

	clockon = getPrivateInt("SC:Clock","clockon",1);
	clock0s = getPrivateInt("SC:Clock","clock0s",1);
	clock24 = getPrivateInt("SC:Clock","clock24",1);

	clockTmr = new Timer;
	clockTmr.setDelay(100);

	if (system.getStatus() == 0) ShowClock(1);

}

System.onScriptUnloading() 
{
	time = NULL;
	clock = NULL;
	grp = NULL;
	delete clockTmr;
}

System.onSetXuiParam(string param, string value) 
{
	param = system.strlower(param);
 
	if(param == "w") 
	{
		time.setXMLParam("w", value);
		clock.setXMLParam("w", value);
	}
	
	if(param == "h") 
	{
		time.setXMLParam("h", value);
		clock.setXMLParam("h", value);
	}
	
	if(param == "color") 
	{
		time.setXMLParam("color", value);
		clock.setXMLParam("color", value);
	}

	if(param == "font") 
	{
		time.setXMLParam("font", value);
		clock.setXMLParam("font", value);
	}
	
	if(param == "fontsize") 
	{
		time.setXMLParam("fontsize", value);
		clock.setXMLParam("fontsize", value);
	}

	if(param == "antialias") 
	{
		time.setXMLParam("antialias", value);
		clock.setXMLParam("antialias", value);
	}

	if(param == "align") 
	{
		time.setXMLParam("align", value);
		clock.setXMLParam("align", value);
	}

	if(param == "timeroffstyle") 
	{
		time.setXMLParam("timeroffstyle", value);
		clock.setXMLParam("timeroffstyle", value);
	}

	if(param == "timecolonwidth") 
	{
		time.setXMLParam("timecolonwidth", value);
		clock.setXMLParam("timecolonwidth", value);
	}

	if(param == "tooltip") 
	{
		time.setXMLParam("tooltip", value);
		clock.setXMLParam("tooltip", value);
	}

}

time.onRightButtonDown(int x,int y)
{
	clockMenu = New PopupMenu;

	clockMenu.addCommand("Clock Menu", 0, 0, 1);
	clockMenu.addSeparator();
	clockMenu.addCommand("Show Clock When Stopped", 1, clockon, 0);
	clockMenu.addCommand("24 Hour Mode", 2, clock24, 0);
	clockMenu.addCommand("Add Leading 0",3, clock0s, 0);

	int temp = clockMenu.popAtMouse();
	
	ProcessMenu(temp);	

	delete clockMenu;
	complete;
}

ProcessMenu(int iC)
{
	if (iC == 1)
	{
		if (clockon) {clockon = 0; clock.setText("");}
		else {clockon = 1; clockTmr.start();}
		setPrivateInt("SC:Clock","clockon",clockon);
	}

	if (iC == 2)
	{
		if (clock24) clock24 = 0;
		else clock24 = 1;
		setPrivateInt("SC:Clock","clock24",clock24);
	}

	if (iC == 3)
	{
		if (clock0s) clock0s = 0;
		else clock0s = 1;
		setPrivateInt("SC:Clock","clock0s",clock0s);
	}

	complete;
}

clockTmr.onTimer()
{
	int temp;

	if ((getStatus() == 0) && (clockon))
	{
		
        	string timerText = integertoLongTime(getTimeOfDay());

		string temp_hours = getToken(timerText,":",0);
		string temp_mins = getToken(timerText,":",1);

		temp = stringtoInteger(temp_hours);

		if((!clock24)&&(temp>12))
		{
			temp = temp - 12;
			temp_hours = integertoString(temp);
		}
		
		if((clock0s)&&(temp < 10))
		{	
			temp_hours = "0" + temp_hours;
		}

	        clock.setText(temp_hours + ":" + temp_mins);
	}
}

System.onStop()
{
	if (clockon) ShowClock(1);
}

System.onPlay()
{
	ShowClock(0);
	clockTmr.stop();
	clock.setText("");
}

ShowClock(int state)
{
	if (state)
	{
		clockTmr.start();
		clock.setTargetA(255);
		clock.setTargetSpeed(0.5);
		clock.goToTarget();
		time.setTargetA(0);
		time.setTargetSpeed(0.5);
		time.goToTarget();
	}
	else
	{
		clock.setTargetA(0);
		clock.setTargetSpeed(0.5);
		clock.goToTarget();
		time.setTargetA(255);
		time.setTargetSpeed(0.5);
		time.goToTarget();
	}
}