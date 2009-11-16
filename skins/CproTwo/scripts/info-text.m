#include <lib/std.mi>

Function int getChannels (); // returning 1 for mono, 2 for stereo, more for multichannel (e.g. 6), -1 for no info available
Function String getBitrate();
Function String getFrequency();
Function updateInfo();

Global Group g, g_seeker;
Global Text t_trackTime, t_totalTime, t_timeEvent;
Global Text t_nameTop, t_nameBottom;
Global Text t_kbps, t_size, t_hz;
Global Timer waitForReturn, recheck;

System.onScriptLoaded() {
	g = getScriptGroup();
	t_trackTime = g.getObject("two.info.text.tracktime");
	t_totalTime = g.getObject("two.info.text.totaltime");
	t_timeEvent = g.getObject("two.info.text.trackevent");
	
	t_kbps = g.getObject("two.info.text.other.kbps");
	t_size = g.getObject("two.info.text.other.size");
	t_hz = g.getObject("two.info.text.other.hz");
	
	g_seeker = g.getObject("two.info.seeker");
	t_nameTop = g_seeker.getObject("two.info.text.title");
	t_nameBottom = g_seeker.getObject("two.info.text.artist");

	recheck = new Timer;
	recheck.setDelay(1000);
	
	waitForReturn = new Timer;
	waitForReturn.setDelay(100);
	updateInfo();
}

System.onscriptunloading(){
	delete waitForReturn;
	delete recheck;
}

t_timeEvent.onTextChanged(String newtxt){
	t_trackTime.setText(newtxt);
	t_totalTime.setText("/ "+System.integerToTime(System.getPlayItemLength()));
}

System.onTitleChange(String newtitle){
	updateInfo();
}


System.onStop(){
	recheck.stop();
}
System.onPlay(){
	recheck.start();
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
updateInfo(){
	t_nameTop.setText(System.getPlayItemMetaDataString("title"));
	t_nameBottom.setText("by " + System.getPlayItemMetaDataString("artist"));

	float rawsize = System.getFileSize(strmid(System.getPlayItemString(), 7, strlen(System.getPlayItemString())-7));
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
	}
	t_size.setText(floatToString(rawsize,1)+sizeType);

	t_kbps.setText(getBitrate()+"k");
	t_hz.setText(getFrequency()+"hz");
	
	//Refresh if NA
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
	string sit = getSongInfoText();
	if (sit != "")
	{
		string rtn;
		int searchresult;
		for (int i = 0; i < 5; i++) {
			rtn = getToken(sit, " ", i);
			searchResult = strsearch(strlower(rtn), "khz");
			if (searchResult>0) return StrMid(rtn, 0, searchResult);
		}
		return "";
	}
	else
	{
		return "";
	}
}