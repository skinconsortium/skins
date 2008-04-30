/*---------------------------------------------------
-----------------------------------------------------
Filename:	own-seek.m

Type:		maki/source
Version:	skin version 1.1
Date:		16.Apr.2004 - 23:19
Author:		Martin P. alias Deimos
E-Mail:		martin.deimos@gmx.de
Internet:	www.martin.deimos.tk
-----------------------------------------------------
--------------------INCLUDES-------------------------
-Seek Map
-----------------------------------------------------
----------------------NOTE---------------------------
I've written all the scripts on my own. I was only
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

Function setSeekAnim(int newpos);
Function updateSeekAnim(int x, int y);

Global Map SeekMap, SeekOverMap;
Global Layer sa_pnn;
Global Layer l_pauseanim;

Global Int CurrPos, ARrate;
Global Boolean Seeking, Over;
Global Int oldsetpos;

unload_seek() {

	delete SeekMap;

}

load_seek() {
	sa_pnn = PlayerDisplay.findObject("seek");
	l_pauseanim = PlayerDisplay.findObject("seek.pause");

	SeekMap = new Map;
	SeekMap.loadMap("player.display.seekmap");

	SeekOverMap = new Map;
	SeekOverMap.loadMap("player.display.seekovermap");

	CurrPos = System.getPosition();
	setSeekAnim(CurrPos);
}

setSeekAnim(int newpos) {
	Region seekreg = new Region;
	seekreg.loadFromMap(SeekMap, newpos, 1);
	sa_pnn.setRegion(seekreg);
	delete seekreg;
}

sa_pnn.onLeftButtonDown(int x, int y) {
	int val = SeekOverMap.getValue(x - sa_pnn.getLeft(), y - sa_pnn.getTop());
	if ( val == 255 ) {
	   // messageBox(integerToString(val) + MC_TARGET, "Error", 1, "");
		Seeking = 1;
		updateSeekAnim(x, y);
	}
}

sa_pnn.onMouseMove(int x, int y) {
	if (Seeking && sa_pnn.isMouseOverRect()) {
		oldsetpos = getPosition();
		updateSeekAnim(x, y);
	}
}

sa_pnn.onLeftButtonUp(int x, int y) {
	if ( Seeking && sa_pnn.isMouseOverRect()) {
		Seeking = 0;
		updateSeekAnim(x, y);
	}
	if ( Seeking && !sa_pnn.isMouseOverRect()) {
		Seeking = 0;
		seekTo(oldsetpos);
	}
}

updateSeekAnim(int x, int y) {
	int newVal = SeekMap.getValue(x - sa_pnn.getLeft(), y - sa_pnn.getTop());
	if (System.getPlayItemLength() >= 0) {
		int p = (newVal * 100) / 255;
		int s = (newVal * System.getPlayItemLength()) / 255;
		if (!Seeking) {
			System.seekTo(s);
		}
		if (seeking) {
			Float f;
			f = p;
			Float len = getPlayItemLength();
			if (len != 0) {
				int np = len * f / 100;
				SOngticker.sendAction("setText", "SEEK: " + integerToTime(np) + "/" + integerToTime(len) + " (" + integerToString(f) + "%) ", 0, 0, 0, 0);
			}
		}
		setSeekAnim(255 * s / System.getPlayItemLength());
	}
}