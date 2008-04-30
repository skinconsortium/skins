/*---------------------------------------------------
Filename:	about.m

Type:		maki/source
Version:	skin version 1.2
Date:		01.Jan.2005 - 11:15
Author:		Martin P. aka Deimos
E-Mail:		martin.deimos@gmx.de
Internet:	www.martin.deimos.de.vu

Content:	Vortex Aboutbox
---------------------------------------------------*/

#include "../../../lib/std.mi"

Global Timer tmr, vist;
Global Int i = 0;
Global Group g;

Global Layer glow, deimos, slob, ralph, rohan, hammer, leech;


Class Group Buddy;
Global Buddy gdeimos, ghelix, gleech, gslob, ghammer, grohan;

Global Int warp = 0;

System.onScriptLoaded()	{
	g = getScriptGroup();

	glow = g.findObject("glow");

	gdeimos = g.findObject("g.deimos");
	ghelix = g.findObject("g.quadhelix");
	gleech = g.findObject("g.leechbite");
	gslob = g.findObject("g.slob");
	ghammer = g.findObject("g.hammerhead");
	grohan = g.findObject("g.rohan2kool");

	deimos = g.findObject("deimos");
	slob = g.findObject("slob");
	ralph = g.findObject("ralph");
	rohan = g.findObject("rohan");
	hammer = g.findObject("hammer");
	leech = g.findObject("leech");

	vist = new Timer;
	vist.setDelay(20);

	tmr = new Timer;
	tmr.setDelay(2500);
}

g.onSetVisible(int v) {
	if (v) {
		  deimos.setTargetX(random(332));
		  deimos.setTargetY(random(256));
		  deimos.setTargetSpeed((300-getLeftVUMeter())*2/300);
		  deimos.gotoTarget();

		  slob.setTargetX(random(332));
		  slob.setTargetY(random(256));
		  slob.setTargetSpeed((300-getLeftVUMeter())*2/300);
		  slob.gotoTarget();

		  ralph.setTargetX(random(332));
		  ralph.setTargetY(random(256));
		  ralph.setTargetSpeed((300-getLeftVUMeter())*2/300);
		  ralph.gotoTarget();

		  rohan.setTargetX(random(332));
		  rohan.setTargetY(random(256));
		  rohan.setTargetSpeed((300-getLeftVUMeter())*2/300);
		  rohan.gotoTarget();

		  hammer.setTargetX(random(332));
		  hammer.setTargetY(random(256));
		  hammer.setTargetSpeed((300-getLeftVUMeter())*2/300);
		  hammer.gotoTarget();

		  leech.setTargetX(random(332));
		  leech.setTargetY(random(256));
		  leech.setTargetSpeed((300-getLeftVUMeter())*2/300);
		  leech.gotoTarget();

		  vist.start();
  		  tmr.start();
	} else {
		vist.stop();
		tmr.stop();
	}
}
deimos.onTargetReached() {
		if (!isvisible()) return;
		warp = 0;
		setTargetX(random(332));
		setTargetY(random(256));
		setTargetSpeed((300-getLeftVUMeter())*2/300);
		gotoTarget();

}
slob.onTargetReached() {
		if (!isvisible()) return;
		setTargetX(random(332));
		setTargetY(random(256));
		setTargetSpeed((300-getLeftVUMeter())*2/300);
		gotoTarget();

}
ralph.onTargetReached() {
		if (!isvisible()) return;
		setTargetX(random(332));
		setTargetY(random(256));
		setTargetSpeed((300-getLeftVUMeter())*2/300);
		gotoTarget();

}
rohan.onTargetReached() {
		if (!isvisible()) return;
		setTargetX(random(332));
		setTargetY(random(256));
		setTargetSpeed((300-getLeftVUMeter())*2/300);
		gotoTarget();

}

hammer.onTargetReached() {
		if (!isvisible()) return;
		setTargetX(random(332));
		setTargetY(random(256));
		setTargetSpeed((300-getLeftVUMeter())*2/300);
		gotoTarget();

}

leech.onTargetReached() {
		if (!isvisible()) return;
		setTargetX(random(332));
		setTargetY(random(256));
		setTargetSpeed((300-getLeftVUMeter())*2/300);
		gotoTarget();

}

vist.onTimer() {
	glow.setAlpha(getLeftVUMeter());
	if (getStatus() && warp == 0 && getLeftVUMeter() > 220) {
		  warp = 1;

		  deimos.cancelTarget();
		  deimos.setTargetX(random(332));
		  deimos.setTargetY(random(256));
		  deimos.setTargetSpeed(45*2/300);
		  deimos.gotoTarget();

		  slob.cancelTarget();
		  slob.setTargetX(random(332));
		  slob.setTargetY(random(256));
		  slob.setTargetSpeed(45*2/300);
		  slob.gotoTarget();

		  ralph.cancelTarget();
		  ralph.setTargetX(random(332));
		  ralph.setTargetY(random(256));
		  ralph.setTargetSpeed(45*2/300);
		  ralph.gotoTarget();

		  rohan.cancelTarget();
		  rohan.setTargetX(random(332));
		  rohan.setTargetY(random(256));
		  rohan.setTargetSpeed(45*2/300);
		  rohan.gotoTarget();

		  hammer.cancelTarget();
		  hammer.setTargetX(random(332));
		  hammer.setTargetY(random(256));
		  hammer.setTargetSpeed(45*2/300);
		  hammer.gotoTarget();

		  leech.cancelTarget();
		  leech.setTargetX(random(332));
		  leech.setTargetY(random(256));
		  leech.setTargetSpeed(45*2/300);
		  leech.gotoTarget();
	} 
}



tmr.onTimer() {
	i++;
	if (i == 2) {
		ghelix.setTargetX(-400);
		ghelix.setTargetSpeed(0.5);
		ghelix.gotoTarget();

		gdeimos.setTargetX(10);
		gdeimos.setTargetSpeed(0.5);
		gdeimos.gotoTarget();
	}
	if (i == 4) {
		gdeimos.setTargetX(-400);
		gdeimos.setTargetSpeed(0.5);
		gdeimos.gotoTarget();

		gslob.setTargetX(10);
		gslob.setTargetSpeed(0.5);
		gslob.gotoTarget();
	}
	if (i == 6) {
		gslob.setTargetX(-400);
		gslob.setTargetSpeed(0.5);
		gslob.gotoTarget();

		grohan.setTargetX(10);
		grohan.setTargetSpeed(0.5);
		grohan.gotoTarget();
	}
	if (i == 8) {
		grohan.setTargetX(-400);
		grohan.setTargetSpeed(0.5);
		grohan.gotoTarget();

		gleech.setTargetX(10);
		gleech.setTargetSpeed(0.5);
		gleech.gotoTarget();
	}
	if (i == 10) {
		gleech.setTargetX(-400);
		gleech.setTargetSpeed(0.5);
		gleech.gotoTarget();

		ghammer.setTargetX(10);
		ghammer.setTargetSpeed(0.5);
		ghammer.gotoTarget();
	}
	if (i == 12) {
		ghammer.setTargetX(-400);
		ghammer.setTargetSpeed(0.5);
		ghammer.gotoTarget();

		ghelix.setTargetX(10);
		ghelix.setTargetSpeed(0.5);
		ghelix.gotoTarget();
		i = 0;
	}
}

Buddy.onTargetReached() {
	if (getGuiX() == -400) Buddy.setXMLParam("x", "400");
}