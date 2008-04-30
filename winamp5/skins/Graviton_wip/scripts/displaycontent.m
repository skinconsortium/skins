#include "../../../lib/std.mi"
#include "defines.m"

Global Layout disp, dispshade;
Global Text newtimer, newtimershadow, newalbum, info, shadetimer;
Global Timer songInfoTimer, timertmr;
Global String SongInfoString;
Global Boolean MinusIsOn;

Function string tokenizeSongInfo(String tkn, String sinfo);
Function getSonginfo(String SongInfoString);
Function checkTimer(int MinusIsOn);
Function String oldTimer(int pos);

system.onScriptLoaded() {	
	disp = getContainer("main").getLayout("normal");
	dispshade = getContainer("main").getLayout("winshade");

	newtimer = disp.findObject("timer");
	//newtimershadow = disp.findObject("timershadow");
	newalbum = disp.findObject("songalbum");
	info = disp.findObject("songinfo");

	shadetimer = dispshade.findobject("songtimer");

	if(getPlayItemMetaDataString("album") != "")
		newalbum.setText("Album: " + getPlayItemMetaDataString("album"));
	else 
		newalbum.setText("Unknown Album");

	MinusIsOn = getPrivateInt("Settings", "Minus", 0);

	songInfoTimer = new Timer;
	songInfoTimer.setDelay(1000);

	timertmr = new Timer;
	timertmr.setDelay(40);
//	timertmr.start();
timertmr.stop();
/*
	if (MinusIsOn) 
	{
		newtimer.setText(oldTimer(getPlayItemLength()-getPosition()));
		newtimershadow.setText(oldTimer(getPlayItemLength()-getPosition()));
		shadetimer.setText(oldTimer(getPlayItemLength()-getPosition()));
	} 
	else 
	{
		newtimer.setText(oldTimer(getPosition()));
		newtimershadow.setText(oldTimer(getPosition()));
		shadetimer.setText(oldTimer(getPosition()));
	}
*/
	if (getStatus() == 1) {
		String sit = getSongInfoText();
		if (sit != "") 
		{
			getSonginfo(sit);
		}
		else 
		{
			songInfoTimer.setDelay(50); // goes to 1000 once info is available
			songInfoTimer.start();
			//timertmr.start();

		}
	} 
	else if (getStatus() == -1) 
	{
		getSonginfo(getSongInfoText());
		//timertmr.start();
		
	}
}

System.onScriptUnloading(){
	delete songInfoTimer;
	timertmr.stop();
	delete timertmr;
}

System.onPlay(){
	String sit = getSongInfoText();
	if (sit != "") getSonginfo(sit);
	else songInfoTimer.setDelay(50); // goes to 2000 once info is available
	songInfoTimer.start();
	
	
}

System.onStop(){
	songInfoTimer.stop();
	//timertmr.stop();
	
	info.setText("");
	//newtimer.setText("00:00");
	//newtimershadow.setText("00:00");
	//shadetimer.setText("00:00");
	
}

System.onResume(){
	String sit = getSongInfoText();
	if (sit != "") getSonginfo(sit);
	else songInfoTimer.setDelay(50); // goes to 1000 once info is available
	songInfoTimer.start();
}

System.onPause(){
	songInfoTimer.stop();
}

System.onTitleChange(String newtitle) {
	newalbum.setText("Album: " + getPlayItemMetaDataString("album"));
}

songInfoTimer.onTimer(){
	String sit = getSongInfoText();
	if (sit == "") return;
	songInfoTimer.setDelay(2000);
	getSonginfo(sit);
}

String tokenizeSongInfo(String tkn, String sinfo){
	int searchResult;
	String rtn;
	if (tkn=="Bitrate"){
		for (int i = 0; i < 5; i++) {
			rtn = getToken(sinfo, " ", i);
			searchResult = strsearch(rtn, "kbps");
			if (searchResult>0) return StrMid(rtn, 0, searchResult);
		}
		return "";
	}

	if (tkn=="hannel"){
		for (int i = 0; i < 5; i++) {
			rtn = getToken(sinfo, " ", i);
			searchResult = strsearch(rtn, "tereo");
			if (searchResult>0) return "stereo";
			searchResult = strsearch(rtn, "ono");
			if (searchResult>0) return "mono";
		}
		return "";
	}

	if (tkn=="Frequency"){
		for (int i = 0; i < 5; i++) {
			rtn = getToken(sinfo, " ", i);
			searchResult = strsearch(strlower(rtn), "khz");
			if (searchResult>0) {
				String r = StrMid(rtn, 0, searchResult);
				int dot = StrSearch(r, ".");
				if (dot != -1) return StrMid(r, 0, dot);
				return r;
			}

		}
		return "";
	}
	else return "";
}

getSonginfo(String SongInfoString) {
	String tkn1;
	String tkn2;

	tkn1 = tokenizeSongInfo("Bitrate", SongInfoString);
	tkn2 = tokenizeSongInfo("Frequency", SongInfoString);

	if(tkn1 != "" && tkn2 != "") {
		info.setText(tkn1+"kbps "+tkn2+"khz");
	} else if(tkn1 != "") {
		info.setText(tkn1+"kbps");
	} else if(tkn2 != "") {
		info.setText(tkn2+"khz");
	} else {
		info.setText("");
	}
}

/*
//checkTimer(int MinusIsOn)
timertmr.onTimer()
{
	if (MinusIsOn) {
		newtimer.setText(oldTimer(getPlayItemLength()-getPosition()));
		newtimershadow.setText(oldTimer(getPlayItemLength()-getPosition()));
		shadetimer.setText(oldTimer(getPlayItemLength()-getPosition()));
	} else {
		newtimer.setText(oldTimer(getPosition()));
		newtimershadow.setText(oldTimer(getPosition()));
		shadetimer.setText(oldTimer(getPosition()));
	}
}

newtimer.onLeftButtonDown(int x, int y) {
  if (MinusIsOn) MinusIsOn=0;
  else MinusIsOn=1;
  setPrivateInt("Settings","Minus", MinusIsOn);

}


shadetimer.onLeftButtonDown(int x, int y) {
  if (MinusIsOn) MinusIsOn=0;
  else MinusIsOn=1;
  setPrivateInt("Settings","Minus", MinusIsOn);
  
}
*/


String oldTimer(int pos) {
  String SpecTmr = integerToTime(pos);
  String Temp = integerToString(pos);
  int TempLen = strlen(Temp);

  if (strlen(SpecTmr)==4) SpecTmr = "0" + SpecTmr;

  if (MinusIsOn) SpecTmr = "-" + SpecTmr + " ";

  return SpecTmr;
}
