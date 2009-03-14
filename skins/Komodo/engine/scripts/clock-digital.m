/*************************************************************

  Komodo - clock-digital.m
  by Leechbite

  - this script controls the digital-clock display.

*************************************************************/

#include <lib/std.mi>

Global group frameGroup;
Global text timehour, timemin, timedate, timewday, timecolon;
Global timer clockrefresh;
Global boolean colonon;
Global int lasttime, widhour, widcolon;

System.onScriptLoaded() {

	frameGroup = getScriptGroup();
	
	timehour = frameGroup.findObject("time.hour");
	timemin = frameGroup.findObject("time.min");
	timecolon = frameGroup.findObject("time.colon");
	//timedate = frameGroup.findObject("time.date");
	//timewday = frameGroup.findObject("time.wday");
	
	widhour = timehour.getAutoWidth();
	widcolon = timecolon.getAutoWidth();
	
	timehour.setXMLParam("w", integerToString(widhour));
	timecolon.setXMLParam("x", integerToString(widhour));
	timemin.setXMLParam("x", integerToString((widhour+widcolon)*1));
	
	clockrefresh = new timer;
	clockrefresh.setDelay(500);
	clockrefresh.onTimer();
}

system.onScriptUnloading() {
	frameGroup = NULL; // clears all events
	delete clockrefresh;
}

frameGroup.onSetVisible(boolean onoff) {
	if (onoff) {
		if (!clockrefresh.isRunning()) {
			clockrefresh.onTimer(); // freshes the clock display immediately
			clockrefresh.start();
		}
	} else {
		clockrefresh.stop(); // stop clock if not visible.
	}
}

clockrefresh.onTimer() {
  int timeint, diff, c;
  string di, timetxt, hour, min, sec, ampm;
  string month, year, day, wday;

  if (colonon) {
    colonon=0;
    timecolon.show();
  } else  {
    colonon=1;
    timecolon.hide();
  }

  timeint = getTimeOfDay();
  int diff = timeint-lasttime;
  if ((diff < 1000) && (diff > 0)) return; // last then one sec, dont bother updating.
  lasttime = timeint;

  ampm = " AM";
  if (timeint >= 43200000) {
    ampm = " PM";
    if (timeint >= 46800000)
      timeint = timeint -  43200000;
  } else if (timeint < 3600000) {
    timeint = timeint + 43200000;
  }

  timetxt = integerToLongTime(timeint);

  hour = getToken(timetxt, ":", 0);
  min = getToken(timetxt, ":", 1);
  sec = getToken(timetxt, ":", 2);
  
  if (strlen(hour) < 2) hour = " "+hour;

  if (timehour) timehour.setText(hour);
  if (timemin) timemin.setText(min+ampm);

  
/*  
	timeint = getDate();
	c = getDateMonth(timeint);
	if (c==0) month = "Jan";
	else if (c==1) month = "Feb";
	else if (c==2) month = "Mar";
	else if (c==3) month = "Apr";
	else if (c==4) month = "May";
	else if (c==5) month = "Jun";
	else if (c==6) month = "Jul";
	else if (c==7) month = "Aug";
	else if (c==8) month = "Sep";
	else if (c==9) month = "Oct";
	else if (c==10) month = "Nov";
	else if (c==11) month = "Dec";
	
	c = getDateDow(timeint);
	if (c==0) wday = "Sun";
	else if (c==1) wday = "Mon";
	else if (c==2) wday = "Tue";
	else if (c==3) wday = "Wed";
	else if (c==4) wday = "Thu";
	else if (c==5) wday = "Fri";
	else if (c==6) wday = "Sat";

	if (timewday) timewday.setText(wday);
  	if (timedate) timedate.setText(integerToString(getDateDay(timeint))+"-"+month + "-"+integerToString(getDateYear(timeint)+1900));
  */
}
