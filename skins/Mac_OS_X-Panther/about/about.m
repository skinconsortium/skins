/*---------------------------------------------------
Filename:	about.m

Type:		maki/source
Version:	skin version 1.2
Date:		01.Jan.2005 - 11:15
Author:		Martin P. aka Deimos
E-Mail:		martin.deimos@gmx.de
Internet:	www.martin.deimos.de.vu

Content:	Titan Aboutbox
---------------------------------------------------*/

#include "../../../lib/std.mi"

Function Fade(string l1, string l2, string l3, string l4);

Global Text t_1, t_2, t_3, t_4;
Global Timer tmr;
Global Int i = 0;
Global Group txt;

Global String l1, l2;

System.onScriptLoaded()	{
	Group g = getScriptGroup();
	t_1 = g.findObject("text1");
	t_2 = g.findObject("text2");
	t_3 = g.findObject("text3");
	t_4 = g.findObject("text4");
	txt = g.findObject("txt");

	tmr = new Timer;
	tmr.setDelay(2500);
	tmr.start();
}

tmr.onTimer() {
	i++;
	if (i == 2) {
		Fade("Main Idea:", "Martin Poehlmann", "", "");
	}
	if (i == 4) {
		Fade("Graphics:", "KoL (original Windows Theme)", "http://www.studiotwentyeight.com", "converted by Martin Poehlmann");
	}
	if (i == 6) {
		Fade("XML & MAKI:", "Martin Poehlmann", "R. Peter Clark (CoverSearch via Amazon.com)", "");
	}
	if (i == 8) {
		i = 10;
	}
	if (i == 10) {
		Fade("Contact:", "martin@skinconsortium.com", "", "");
	}
	if (i == 12) {
		Fade("Homepage:", "http://www.martin.deimos.de.vu", "http://www.skinconsortium.com", "http://www.studiotwentyeight.com");
	}
	if (i == 15) {
		Fade("Thank You", "for using my skin!", "", "");
	}
	if (i == 17) {
		Fade("Copyright:", "2005 - 2006 by Martin Poehlmann aka Deimos", "", "");
		i = 0;
	}
}

Fade(string l1, string l2, string l3, string l4) {
	txt.setTargetA(0);
	txt.setTargetSpeed(0.5);
	txt.gotoTarget();
}

txt.onTargetReached() {
	t_1.setText(l1);
	t_2.setText(l2);
	t_3.setText(l3);
	t_4.setText(l4);
	txt.setTargetA(255);
	txt.setTargetSpeed(0.5);
	txt.gotoTarget();
}