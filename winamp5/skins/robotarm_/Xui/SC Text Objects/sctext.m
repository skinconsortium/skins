#include <lib/std.mi>

Function updateTitle(String newTxt);
Function String replaceString(string baseString, string toreplace, string replacedby);

Global Group XUIGroup;
Global Text mainText, vidInfo;
Global String workWithThis;
Global Timer waitForReturn;

System.onScriptLoaded() {
	XUIGroup = getScriptGroup();
	mainText = XUIGroup.findObject("sc.main.text");
	vidInfo = XUIGroup.findObject("sc.main.text.vid.info");
	waitForReturn = new Timer;
	waitForReturn.setDelay(100);
}


System.onSetXuiParam(String param, String value) {
	if(strlower(param) == "mytext"){
		workWithThis = value;
		waitForReturn.start();
		System.debugString(value,9);
	}

	if (strlower(param) == "ttip")
	{
		mainText.setXMLParam("tooltip",Value);
	}

	System.debugString(param+" - "+value,9);

}

System.onTitleChange(String newtxt){
	if(XUIGroup.isVisible()){
		updateTitle(newtxt);
	}
}

vidInfo.onTextChanged(String newtxt){
	if(XUIGroup.isVisible()){
		updateTitle(getPlayItemDisplayTitle());
	}
}

XUIGroup.onSetVisible(Boolean onOff){
	if(onOff){
		updateTitle(getPlayItemDisplayTitle());
	}
	else{
		waitForReturn.stop();
	}
}

waitForReturn.onTimer(){
	updateTitle(getPlayItemDisplayTitle());
}

updateTitle(String newTxt){
	int temp = System.getPlayItemLength();
	String work = workWithThis;

	work = replaceString(work, "%artist%", getPlayItemMetaDataString("artist"));
	work = replaceString(work, "%album%", getPlayItemMetaDataString("album"));
	
	if(getPlayItemMetaDataString("year")==""){
		work = replaceString(work, "%(year)%", "");
	}
	else{
		work = replaceString(work, "%(year)%", "("+getPlayItemMetaDataString("year")+")");
	}
	work = replaceString(work, "%year%", getPlayItemMetaDataString("year"));
	work = replaceString(work, "%genre%", getPlayItemMetaDataString("genre"));
	work = replaceString(work, "%track%", getPlayItemMetaDataString("track"));
	work = replaceString(work, "%composer%", getPlayItemMetaDataString("composer"));
	work = replaceString(work, "%comment%", getPlayItemMetaDataString("comment"));
	work = replaceString(work, "%albumartist%", getPlayItemMetaDataString("albumartist"));

	work = replaceString(work, "%numsamples%", getPlayItemMetaDataString("numsamples"));
	work = replaceString(work, "%postgap%", getPlayItemMetaDataString("postgap"));
	work = replaceString(work, "%pregap%", getPlayItemMetaDataString("pregap"));
	work = replaceString(work, "%publisher%", getPlayItemMetaDataString("publisher"));
	work = replaceString(work, "%encoder%", getPlayItemMetaDataString("encoder"));
	work = replaceString(work, "%conductor%", getPlayItemMetaDataString("conductor"));
	work = replaceString(work, "%disc%", getPlayItemMetaDataString("disc"));

	work = replaceString(work, "%bitrate%", getPlayItemMetaDataString("bitrate"));

	work = replaceString(work, "%length.longtime%", integerToLongTime(temp));
	work = replaceString(work, "%length.time%", integerToTime(temp));
	work = replaceString(work, "%length.sec%", integerToString(temp/1000));

	work = replaceString(work, "%filesize%", floatToString( stringtointeger(getPlayItemMetaDataString("bitrate")) * 125.45 * (getPlayItemLength()/1000)/1024/1024,2));


	if(strsearch(vidInfo.getText(), "DShow (MPEG)")==0){
		work = replaceString(work, "%video.res%", getToken(vidInfo.getText(), " ", 3));
		work = replaceString(work, "%video.fps%", getToken(getToken(vidInfo.getText(), " ", 12),"fps", 0));
		work = replaceString(work, "%video.vid.bitrate%", getToken(getToken(getToken(vidInfo.getText(), " ", 4),"kbps", 0),"(",1));
		work = replaceString(work, "%video.aud.bitrate%", getToken(getToken(getToken(vidInfo.getText(), " ", 9),"kbps", 0),"(",1));
		work = replaceString(work, "%video.aud.khz%", getToken(getToken(vidInfo.getText(), " ", 6),"khz", 0));
		work = replaceString(work, "%video.aud.ch%", getToken(vidInfo.getText(), " ", 8));

	}
	else if(strsearch(vidInfo.getText(), "DShow (AVI)")==0){
		work = replaceString(work, "%video.res%", getToken(vidInfo.getText(), " ", 3));
		work = replaceString(work, "%video.fps%", getToken(getToken(vidInfo.getText(), " ", 10),"fps", 0));
		work = replaceString(work, "%video.vid.bitrate%", "?");
		work = replaceString(work, "%video.aud.bitrate%", "?");
		work = replaceString(work, "%video.aud.khz%", getToken(getToken(vidInfo.getText(), " ", 5),"khz", 0));
		work = replaceString(work, "%video.aud.ch%", getToken(vidInfo.getText(), " ", 7));
	}
	else if(strsearch(vidInfo.getText(), "Windows Media")==0){
		work = replaceString(work, "%video.res%", getToken(vidInfo.getText(), " ", 2));
		work = replaceString(work, "%video.fps%", "?");
		work = replaceString(work, "%video.vid.bitrate%", "?");
		work = replaceString(work, "%video.aud.bitrate%", "?");
		work = replaceString(work, "%video.aud.khz%", "?");
		work = replaceString(work, "%video.aud.ch%", "?");

	}
	else{
		if(strsearch(work, "%video.res%")!=-1){
			work="";
		}
		if(strsearch(work, "%video.fps%")!=-1){
			work="";
		}
		if(strsearch(work, "%video.vid.bitrate%")!=-1){
			work="";
		}
		if(strsearch(work, "%video.aud.bitrate%")!=-1){
			work="";
		}
		if(strsearch(work, "%video.aud.khz%")!=-1){
			work="";
		}
		if(strsearch(work, "%video.aud.ch%")!=-1){
			work="";
		}
	}
		
	if(getPlayItemMetaDataString("title")=="" && getPlayItemMetaDataString("artist")==""){
		work = replaceString(work, "%title%", newTxt);
		//debugString("a",9);
	}
	else{
		work = replaceString(work, "%title%", getPlayItemMetaDataString("title"));
		//debugString("b",9);
	}


	if(work=="0 kbit" || work==" kbit"){
		work="";
	}

	mainText.setText(work);

	String sit = getSongInfoText();
	if (sit != ""){
		waitForReturn.stop();
	}
	else if(waitForReturn.isRunning()==false){
		waitForReturn.start();
	}

}

/* ======== Thanks to martin.deimos =========
*/
String replaceString(string baseString, string toreplace, string replacedby) {
	if (toreplace == "") return baseString;
	string sf1 = strupper(baseString);
	string sf2 = strupper(toreplace);
	int i = strsearch(sf1, sf2);
	if (i == -1) return baseString;
	string left = "", right = "";
	if (i != 0) left = strleft(baseString, i);
	if (strlen(basestring) - i - strlen(toreplace) != 0) {
		right = strright(basestring, strlen(basestring) - i - strlen(toreplace));
	}
	return left + replacedby + right;
}