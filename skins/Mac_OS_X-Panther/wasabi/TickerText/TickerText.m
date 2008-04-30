/*--TickerText v1.1----------------------------------
-----------------------------------------------------
Filename:	TickerText.m

Type:		maki/source
Version:	skin version 1.2
Date:		20:30 24.09.2004
Author:		Martin P. alias Deimos
E-Mail:		martin.deimos@gmx.de
Internet:	www.martin.deimos.de.vu
-----------------------------------------------------
--------------------INCLUDES-------------------------
-Cover Art
-----------------------------------------------------
----------------------NOTE---------------------------
I've written all the script on my own. I was only
inspired by other ones, but I never copied a whole
script or parts of it! 'Cause everyone has to learn
or inspire I implement the source files too.
But if you use parts or the entire script, mail me:
Give me your name, write a little text about your
skin and a skinshot! Then leave my header in the .m
file and implement it in your skin and leave credit
to my name, email and homepage where credit is done!
THX! Deimos
-----------------------------------------------------
---------------------------------------------------*/

#include "../../../../lib/std.mi"
#include "../../../../lib/config.mi"

#define FILENAME "TickerText.m"
#include "../../../../lib/ripprotection.mi"

Function addText(string old);

Global Text _Text, songticker;
Global ConfigAttribute ca_scrolling;
Global Boolean b_add = 0;
Global Boolean b_first = 0;
Global String _right, _left;
Global Timer SongtickerTimer;

System.onScriptLoaded() {
	Group XUIGroup = getScriptGroup();

	_Text = XUIGroup.findObject("tickertext");
	songticker = XUIGroup.findObject("songticker.txt");

	ca_scrolling = Config.getItemByGuid("{7061FDE0-0E12-11D8-BB41-0050DA442EF3}").getAttribute("Enable Songticker scrolling");
	ca_scrolling.onDataChanged();

	SongTickerTimer = new Timer;
	SongTickerTimer.setDelay(1000);

	ripProtection("tristania");

}

SongTickerTimer.onTimer() {
	if (b_add) _Text.setText(_left + songticker.getText() + _right);
	SongTickerTimer.stop();
}

System.onSetXuiParam(String param, String value) {
	if (param == "adjustSongticker") {
		b_add = 1;
		_left = getToken(value,";",0);
		_right = getToken(value,";",1);
	}
}

_Text.onSetVisible(int v) {
	if (v) ca_scrolling.onDataChanged();
	addText(_Text.getText());
}

ca_scrolling.onDataChanged() {
	_Text.setXMLParam("ticker", getData());
}


System.onTitleChange(String newtxt) {
	if (b_add) _Text.setText(_left + newtxt + _right);
	complete;
}

songticker.onTextChanged(String newtxt) {
	if (b_add) _Text.setText(_left + newtxt + _right);
	complete;
}

addText(string old) {
	if (b_add) _Text.setText(_left + old + _right);
	_Text.setXmlParam("display", "");
	complete;
}

_Text.onAction(String action, String param, Int x, int y, int p1, int p2, GuiObject source) {
	if (action == "setText") {
			SongTickerTimer.start();
			_Text.setText(param);
	}
}