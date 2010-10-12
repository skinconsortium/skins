#include <lib/std.mi>

Function int getChannels (); // returning 1 for mono, 2 for stereo, more for multichannel (e.g. 6), -1 for no info available
Function String getBitrate();
Function String getFrequency();
Function updateInfo();
Function int getNumOfSeps();

Global Group g, g_seeker, g_texttime, g_seekertext; //, g_textother
Global Text t_trackTime, t_totalTime, t_timeEvent;
Global Text t_nameTop, t_nameBottom;
Global Text t_info1;
//Global Text t_kbps, t_size, t_hz;
Global Timer waitForReturn, recheck;
Global int i_info;
Global Guiobject t_songticker;
Global Boolean twoline;

System.onScriptLoaded() {
	g = getScriptGroup();
	
	
	
	//g_textother = g.getObject("two.info.text.other");
	//t_kbps = g_textother.getObject("two.info.text.other.kbps");
	//t_size = g_textother.getObject("two.info.text.other.size");
	//t_hz = g_textother.getObject("two.info.text.other.hz");
	
	g_seeker = g.getObject("two.info.seeker");
	g_seekertext = g_seeker.getObject("two.info.seeker.text");
	t_nameTop = g_seekertext.getObject("two.info.text.title");
	t_nameBottom = g_seekertext.getObject("two.info.text.artist");
	t_info1 = g_seekertext.getObject("two.info.text.info.1");
	//t_songticker = g_seekertext.getObject("two.info.text.songticker");

	g_texttime = g_seekertext.getObject("two.info.text.time");
	t_trackTime = g_texttime.getObject("two.info.text.tracktime");
	t_totalTime = g_texttime.getObject("two.info.text.totaltime");
	t_timeEvent = g_texttime.getObject("two.info.text.trackevent");
	
	if(t_totalTime==NULL) debug("ble");


	twoline=true;
	/*Map m = new Map;
	m.loadMap("info.bg.seeker.0");
	i_info = m.getHeight();
	delete m;
	if(i_info>30){
		t_nameTop.setXMLParam("fontsize", integerToString(i_info/2));
		t_nameBottom.setXMLParam("fontsize", integerToString(i_info/2.5));
		t_trackTime.setXMLParam("fontsize", integerToString(i_info/1.8));
		t_totalTime.setXMLParam("fontsize", integerToString(i_info/2.5));
		t_nameTop.show();
		t_nameBottom.show();
		t_totalTime.show();
		twoline=true;
	}
	else{
		t_songticker.setXMLParam("fontsize", integerToString(i_info/1.4));
		t_trackTime.setXMLParam("fontsize", integerToString(i_info/1.2));
		t_trackTime.setXMLParam("h", "100");
		t_songticker.show();
	}*/
	recheck = new Timer;
	recheck.setDelay(2000);
	
	waitForReturn = new Timer;
	waitForReturn.setDelay(100);
	updateInfo();
	
	//if(System.getStatus() != STATUS_STOPPED) g_textother.show();
	
	//debugint(stringToInteger("Phil Collins"));
}

System.onscriptunloading(){
	delete waitForReturn;
	delete recheck;
}

t_timeEvent.onTextChanged(String newtxt){
	t_trackTime.setText(newtxt);
	t_totalTime.setText("/ "+System.integerToTime(System.getPlayItemLength()));
	t_totalTime.setXmlParam("x", integerToString(t_trackTime.getTextWidth()-4));
	t_totalTime.setXmlParam("w", integerToString(t_totalTime.getTextWidth()));
	t_trackTime.setXmlParam("w", integerToString(t_trackTime.getTextWidth()));
	
	g_texttime.setXmlParam("x", integerToString(-(t_trackTime.getWidth()+t_totalTime.getWidth()-5)));
	g_texttime.setXmlParam("w", integerToString(t_trackTime.getWidth()+t_totalTime.getWidth()-5));
	
	//t_totalTime.setText(System.integerToTime(System.getPlayItemLength()));
}

System.onTitleChange(String newtitle){
	updateInfo();
}


System.onStop(){
	recheck.stop();
	//g_textother.hide();
}
System.onPlay(){
	recheck.start();
	//g_textother.show();
}
System.onPause(){
	recheck.stop();
}
System.onResume(){
	recheck.start();
}
recheck.onTimer(){
	updateInfo();
}
waitForReturn.onTimer(){
	recheck.stop();
	updateInfo();
}

int getNumOfSeps(){
	int i = 0;
	while(true){
		if(System.getToken(System.getPlayItemDisplayTitle(), "- ", i)=="") return i;
		else i++;
	}
}

updateInfo(){
	String top = System.getPlayItemMetaDataString("title");
	String bottom = System.getPlayItemMetaDataString("artist");
	String s_info = "";
	
	if(top=="" || bottom==""){
		int sep = getNumOfSeps();
		if(top==""){
			if(sep>0) top = System.getToken(System.getPlayItemDisplayTitle(), "-", sep-1);
			else top = System.getToken(System.getPlayItemDisplayTitle(), "-", 0);
		}
		
		if(bottom==""){
			if(sep>0) bottom = System.getToken(System.getPlayItemDisplayTitle(), "-", sep-2);
			else bottom = "Unknown Artist";
		}
	}

	t_nameTop.setText(top);
	t_nameBottom.setText(bottom);

	/*float rawsize = System.getFileSize(strmid(System.getPlayItemString(), 7, strlen(System.getPlayItemString())-7));
	String sizeType = "mb";
	if(rawsize<1024*1024){
		rawsize=rawsize/1024;
		sizeType = "kb";
	}
	else if(rawsize<1024*1024*1024){
		rawsize=rawsize/1024/1024;
	}
	else{
		rawsize=rawsize/1024/1024/1024;
		sizeType = "gb";
	}*/
	//t_size.setText(floatToString(rawsize,1)+sizeType);

	//t_kbps.setText(getBitrate()+"k");
	//t_hz.setText(getFrequency()+"hz");
	
	s_info += getBitrate() + "kbps" + "  ";
	//s_info += getFrequency() + "k"+"Hz";
	s_info += getFrequency() + "kHz";
	t_info1.setText(s_info);
	
	//Refresh if NA
	if(System.getStatus() != STATUS_PLAYING) return;
	
	String sit = getSongInfoText();
	if (sit != ""){
		waitForReturn.stop();
		recheck.start();
	}
	else if(waitForReturn.isRunning()==false){
		waitForReturn.start();
	}
}

/*
Generic Functions - Move to .mi at some stage
*/

Int getChannels ()
{
	if (strsearch(getSongInfoText(), "tereo") != -1)
	{
		return 2;
	}
	else if (strsearch(getSongInfoText(), "ono") != -1)
	{
		return 1;
	}
	else if (strsearch(getSongInfoText(), "annels") != -1)
	{
		int pos = strsearch(getSongInfoText(), "annels");
		return stringToInteger(strmid(getSongInfoText(), pos - 4, 1));
	}
	else
	{
		return -1;
	}
}
String getBitrate(){
	string sit = getSongInfoText();
	if (sit != "")
	{
		string rtn;
		int searchresult;
		for (int i = 0; i < 5; i++) {
			rtn = getToken(sit, " ", i);
			searchResult = strsearch(rtn, "kbps");
			if (searchResult>0){
				if(stringToInteger(StrMid(rtn, 0, searchResult))>99999){
					return "99999";
				}
				return StrMid(rtn, 0, searchResult);
			}
		}
		return "";
	}
	else
	{
		return "";
	}
}
String getFrequency(){
	String sit = getSongInfoText();
	if (sit != "")
	{
		String rtn;
		int searchresult;
		for (int i = 0; i < 5; i++) {
			rtn = getToken(sit, " ", i);
			searchResult = strsearch(strlower(rtn), "kh");
			//debugString(sit+" - "+ strlower(rtn)+" - "+integerToString(searchResult),9);
			if (searchResult>0){
				
			
				return StrMid(rtn, 0, searchResult);
			}
		}
		return "";
	}
	else
	{
		return "";
	}
}