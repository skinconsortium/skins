/*---------------------------------------------------
-----------------------------------------------------
Filename:	tickertext.m

Type:		maki
Version:	1.2
Date:		18. Jul. 2006 - 23:12 
Author:		Martin Poehlmann aka Deimos
E-Mail:		martin@skinconsortium.com
Internet:	www.skinconsortium.com
		www.martin.deimos.de.vu
-----------------------------------------------------
---------------------------------------------------*/

#include "../../../../lib/std.mi"
#include "../../../../lib/exd.mi"
#include "../../scripts/attribs.m"

Global Text _Text;
Global Boolean atf;
Global Timer _switch;
Global int count;
Global Timer SongtickerTimer;

Function formatSongticker(string ATFsource);
Function String setFrequency();
Function String setChannels();
Function String loadPreset(int which);

System.onScriptLoaded() {
	initAttribs();
	Group XUIGroup = getScriptGroup();

	_Text = XUIGroup.findObject("tickertext");

	SongTickerTimer = new Timer;
	SongTickerTimer.setDelay(1000);

	songticker_scrolling_enabled_attrib.onDataChanged();

}

System.onSetXUIParam(string param, string value) {
	if (strlower(Param) == "atf") {	
		atf = stringToInteger(Value);
		_switch = new Timer;
		_switch.setDelay((stringToInteger(atf_time_attrib.getData())+1)*1000);
		if (atf) formatSongticker(loadPreset(1));
	}

}

_Text.onSetVisible(int v) {
	if (v) songticker_scrolling_enabled_attrib.onDataChanged();
}

songticker_scrolling_enabled_attrib.onDataChanged() {
	_Text.setXMLParam("ticker", getData());
}

System.onPlay() {
	if (atf) formatSongticker(loadPreset(1));
}

System.onTitleChange(String newtitle) {
	if (atf) formatSongticker(loadPreset(1));
}

atfset_toggle_attrib.onDataChanged() {
	if (atf) formatSongticker(loadPreset(1));
}

atf_time_attrib.onDataChanged() {
	if (!_switch) return;
	_switch.setDelay((stringToInteger(atf_time_attrib.getData())+1)*1000);
}
formatSongticker(string ATFsource) {
	for ( int i = 0; i < 666; i++ ) {	
		if (strsearch(strlower(ATFsource), "%songticker%") != -1) {
			ATFsource = replaceString(ATFsource, "%songticker%", getPlayItemDisplayTitle());
			i = 0;
		} else i = 666;
	}
	for ( int i = 0; i < 666; i++ ) {	
		if (strsearch(strlower(ATFsource), "%songinfo%") != -1) {
			ATFsource = replaceString(ATFsource, "%songinfo%", getSongInfoText());
			i = 0;
		} else i = 666;
	}
	for ( int i = 0; i < 666; i++ ) {	
		if (strsearch(strlower(ATFsource), "%filename%") != -1) {
			ATFsource = replaceString(ATFsource, "%filename%", removePath(getPlayItemMetaDataString("Filename")));
			i = 0;
		} else i = 666;
	}
	for ( int i = 0; i < 666; i++ ) {	
		if (strsearch(strlower(ATFsource), "%tracknumber%") != -1) {
			ATFsource = replaceString(ATFsource, "%tracknumber%", "Track " + getPlayItemMetaDataString("track"));
			i = 0;
		} else i = 666;
	}
	for ( int i = 0; i < 666; i++ ) {	
		if (strsearch(strlower(ATFsource), "%bitrate%") != -1) {
			ATFsource = replaceString(ATFsource, "%bitrate%", getPlayItemMetaDataString("bitrate") + " KBPS");
			i = 0;
		} else i = 666;
	}
	for ( int i = 0; i < 666; i++ ) {	
		if (strsearch(strlower(ATFsource), "%frequency%") != -1) {
			ATFsource = replaceString(ATFsource, "%frequency%", setFrequency());
			i = 0;
		} else i = 666;
	}
	for ( int i = 0; i < 666; i++ ) {	
		if (strsearch(strlower(ATFsource), "%channels%") != -1) {
			ATFsource = replaceString(ATFsource, "%channels%", setChannels());
			i = 0;
		} else i = 666;
	}
	for ( int i = 0; i < 666; i++ ) {	
		if (strsearch(strlower(ATFsource), "%extension%") != -1) {
			ATFsource = replaceString(ATFsource, "%extension%", getExtension(getPlayItemMetaDataString("Filename")));
			i = 0;
		} else i = 666;
	}
	for ( int i = 0; i < 666; i++ ) {	
		if (strsearch(strlower(ATFsource), "%path%") != -1) {
			ATFsource = replaceString(ATFsource, "%path%", getPath(getPlayItemString()));
			i = 0;
		} else i = 666;
	}
	for ( int i = 0; i < 666; i++ ) {	
		if (strsearch(strlower(ATFsource), "%artist%") != -1) {
			ATFsource = replaceString(ATFsource, "%artist%", getPlayItemMetaDataString("artist"));
			i = 0;
		} else i = 666;
	}
	for ( int i = 0; i < 666; i++ ) {	
		if (strsearch(strlower(ATFsource), "%title%") != -1) {
			ATFsource = replaceString(ATFsource, "%title%", getPlayItemMetaDataString("title"));
			i = 0;
		} else i = 666;
	}
	for ( int i = 0; i < 666; i++ ) {	
		if (strsearch(strlower(ATFsource), "%album%") != -1) {
			ATFsource = replaceString(ATFsource, "%album%", getPlayItemMetaDataString("album"));
			i = 0;
		} else i = 666;
	}
	for ( int i = 0; i < 666; i++ ) {	
		if (strsearch(strlower(ATFsource), "%year%") != -1) {
			ATFsource = replaceString(ATFsource, "%year%", getPlayItemMetaDataString("year"));
			i = 0;
		} else i = 666;
	}
	for ( int i = 0; i < 666; i++ ) {	
		if (strsearch(strlower(ATFsource), "%genre%") != -1) {
			ATFsource = replaceString(ATFsource, "%genre%", getPlayItemMetaDataString("genre"));
			i = 0;
		} else i = 666;
	}
	for ( int i = 0; i < 666; i++ ) {	
		if (strsearch(strlower(ATFsource), "%length%") != -1) {
			ATFsource = replaceString(ATFsource, "%length%", integerToTime(stringToInteger(getPlayItemMetaDataString("length"))));
			i = 0;
		} else i = 666;
	}
	for ( int i = 0; i < 666; i++ ) {	
		if (strsearch(strlower(ATFsource), "%comment%") != -1) {
			ATFsource = replaceString(ATFsource, "%comment%", getPlayItemMetaDataString("comment"));
			i = 0;
		} else i = 666;
	}
	/** formatting **/
	for ( int i = 0; i < 666; i++ ) {
		int p1 = strsearch(strlower(ATFsource), "$upper(");
		if (p1 != -1) {
			string s1 = strright(ATFsource, strlen(ATFsource) - p1 - strlen("$upper("));
			int p2 = strsearch(strlower(s1), ")$");
			if (p2 != -1) {
				string s2 = strleft(s1, p2);
//				messagebox(s2, s1, 0, "");
				if (s2 != ")$") {			
					ATFsource = replaceString(ATFsource, "$upper(" + s2 + ")$", strupper(s2));
					i = 0;
				} else {
					ATFsource = replaceString(ATFsource, "$upper()$", "");
					i = 0;
				}
			} else i = 666;
		} else i = 666;
	}
	for ( int i = 0; i < 666; i++ ) {
		int p1 = strsearch(strlower(ATFsource), "$lower(");
		if (p1 != -1) {
			string s1 = strright(ATFsource, strlen(ATFsource) - p1 - strlen("$lower("));
			int p2 = strsearch(strlower(s1), ")$");
			if (p2 != -1) {
				string s2 = strleft(s1, p2);
				if (s2 != ")$") {			
				ATFsource = replaceString(ATFsource, "$lower(" + s2 + ")$", strlower(s2));
				i = 0;
				} else {
					ATFsource = replaceString(ATFsource, "$lower()$", "");
					i = 0;
				}
				ATFsource = replaceString(ATFsource, "$lower(" + s2 + ")$", strlower(s2));
				i = 0;
			} else i = 666;
		} else i = 666;
	}
	_Text.setText(ATFsource);
	if (getPrivateInt(getSkinName() + "/ATF/", "NumberOfPresets", 1) > 1 && !_switch.isRunning()) {
		count = 1;
		_switch.start();
	} else if (getPrivateInt(getSkinName() + "/ATF/", "NumberOfPresets", 1) == 1) {
		_switch.stop();
	}

}

_switch.onTimer() {
	setDelay((stringToInteger(atf_time_attrib.getData())+1)*1000);
	count++;
	if (count > getPrivateInt(getSkinName() + "/ATF/", "NumberOfPresets", 1)) count = 1;
	formatSongticker(loadPreset(count));
}

String setFrequency() {
	string trkn;
	string infotxt = getSongInfoText();
	string xi = strright(infotxt, 7);
	return xi;
}

String setChannels() {
	int trkn;
	string infotxt = getSongInfoText();
	int serres = strsearch(infotxt, "stereo");
	int serress = strsearch(infotxt, "mono");
	if ( serres != -1 ) {
		return "2 (stereo)";
	}
	if ( serress != -1 ) {
		return "1 (mono)";
	}
}

_Text.onAction(String action, String param, Int x, int y, int p1, int p2, GuiObject source) {
	if (action == "setText") {
			SongTickerTimer.start();
			_switch.stop();
			_Text.setText(param);
	}
}

SongTickerTimer.onTimer() {
	if (atf) formatSongticker(loadPreset(1));
	else _Text.setText("");
	SongTickerTimer.stop();
}

String loadPreset(int which) {
	return getPrivateString(getSkinName() + "/ATF/ATFPresets/", integerToString(which), "%songticker%");
}