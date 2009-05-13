#include <lib/std.mi>
#include "attribs.m"
/*
Date:-		12/05/2007
Script:-		SC quick Clock script
Description:-	Shows a Clock(even24hr) when player stopped in timer ticker

Author:		TheElusiveMelon - original script
Modified:-		SLoB - made script more generic, refined, added attribs for multiple layouts
Modified:-		

*/


Function ProcessMenu(int iC);

Global Text timerTicker;
Global Timer clockTmr;
Global PopupMenu clockMenu;
Global Int clockon,clock24,clock0s, tempClockChoice, temp;
Global String timerText, temp_hours, temp_mins;

System.onScriptLoaded()
{
	initAttribs();
	
	Group mainGrp = getScriptGroup();

	timerTicker = mainGrp.findObject("timer");

	clockTmr = new Timer;
	clockTmr.setDelay(100);

	clockon = getPrivateInt(getSkinName(),"clockon",0);
	clock24 = getPrivateInt(getSkinName(),"clock24",1);
	clock0s = getPrivateInt(getSkinName(),"clock0s",1);
	
	clockon = getPrivateInt(getSkinName(),"clockON",stringtointeger(configAttribute_clock_showwhenstopped.getData()));
	

	if (clockon == 1)
	{
		if (getStatus() == 0)
		{
			clockTmr.start();
		}
	}
}

System.onScriptUnloading()
{
	delete clockTmr;
	setPrivateInt(getSkinName(),"clockon",clockon);
	setPrivateInt(getSkinName(),"clock24",clock24);
	setPrivateInt(getSkinName(),"clock0s",clock0s);
	
	setPrivateInt(getSkinName(),"clockON",stringtointeger(configAttribute_clock_showwhenstopped.getData()));
	
}



timerTicker.onRightButtonDown(int x,int y)
{
	clockMenu = New PopupMenu;

	clockMenu.addCommand("Clock Menu", 0, 0, 1);
	clockMenu.addSeparator();
	clockMenu.addCommand("Show Clock When Stopped", 1, (configAttribute_clock_showwhenstopped.getData() == "1"), 0);
	clockMenu.addCommand("24 Hour Mode", 2, (configAttribute_clock_show24hr.getData() == "1"), 0);
	clockMenu.addCommand("Add Leading 0",3, (configAttribute_clock_showleadingzero.getData() == "1"), 0);

	tempClockChoice = clockMenu.popAtMouse();
	
	ProcessMenu(tempClockChoice);
	
}

timerTicker.onRightButtonUp(int x,int y)
{
	delete clockMenu;
	complete;
}


ProcessMenu(int iC)
{
	if (iC == 1)
	{
		if (configAttribute_clock_showwhenstopped.getData() == "1") configAttribute_clock_showwhenstopped.setData("0");
		else configAttribute_clock_showwhenstopped.setData("1");
	}

	if (iC == 2)
	{
		if (configAttribute_clock_show24hr.getData() == "1") configAttribute_clock_show24hr.setData("0");
		else configAttribute_clock_show24hr.setData("1");		
	}

	if (iC == 3)
	{
		if (configAttribute_clock_showleadingzero.getData() == "1") configAttribute_clock_showleadingzero.setData("0");
		else configAttribute_clock_showleadingzero.setData("1");		
	}

}



clockTmr.onTimer()
{
	if ((getStatus() == 0) && (clockon))
	{
        timerText = integertoLongTime(getTimeOfDay());

		temp_hours = getToken(timerText,":",0);
		temp_mins = getToken(timerText,":",1);

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

	    timerTicker.setText(temp_hours + ":" + temp_mins);
	}
}

System.onStop()
{
	if(clockon)
	{
		clockTmr.start();
	}
}

System.onPlay()
{
	clockTmr.stop();
	timerTicker.setText("");
}

configAttribute_clock_showwhenstopped.onDataChanged() 
{
	if(getData()=="1")
	{
		clockon=1;
		clockTmr.start();
	}
	else
	{
		clockon=0;
		clockTmr.stop();
		timerTicker.setText("");
	}
}

configAttribute_clock_show24hr.onDataChanged() 
{
	if(getData()=="1")
	{
		clock24=1;
	}
	else
	{
		clock24=0;
	}
}

configAttribute_clock_showleadingzero.onDataChanged() 
{
	if(getData()=="1")
	{
		clock0s=1;
	}
	else
	{
		clock0s=0;
	}
}

