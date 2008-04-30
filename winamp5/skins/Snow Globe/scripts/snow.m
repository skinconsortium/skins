/********************************************************\
**  Filename:	snow.maki				**
**  Version:	1.0					**
**  Date:	30. Nov. 2007 - 19:00			**
**********************************************************
**  Type:	winamp.wasabi/maki			**
**  Project:	Snow Globe X-Mas Skin			**
**********************************************************
**  Author:	Martin Poehlmann aka Deimos		**
**  E-Mail:	martin@skinconsortium.com		**
**  Internet:	http://www.skinconsortium.com		**
**		http://home.cs.tum.edu/~poehlman	**
\********************************************************/

#include <lib/std.mi>

Global Timer vist;

Global Group g, stdgrp;

Global int max = 149;
Global int vu = 0;

Class Layer Flock;
Global Flock flock1, flock6, flock5, flock4, flock3, flock2, flock1, flock7, flock8, flock9, flock10;
Global Flock flock11, flock16, flock15, flock14, flock13, flock12, flock11, flock17, flock18, flock19, flock20;

Global Button mytoggle;
Global AnimatedLayer animlayer;
Global Int elecstatus;

System.onScriptLoaded()	{
	g = getScriptGroup();

	flock1 = g.findObject("flock1");
	flock6 = g.findObject("flock6");
	flock5 = g.findObject("flock5");
	flock4 = g.findObject("flock4");
	flock3 = g.findObject("flock3");
	flock2 = g.findObject("flock2");
	flock7 = g.findObject("flock7");
	flock8 = g.findObject("flock8");
	flock9 = g.findObject("flock9");
	flock10 = g.findObject("flock10");

	flock11 = g.findObject("flock11");
	flock16 = g.findObject("flock16");
	flock15 = g.findObject("flock15");
	flock14 = g.findObject("flock14");
	flock13 = g.findObject("flock13");
	flock12 = g.findObject("flock12");
	flock17 = g.findObject("flock17");
	flock18 = g.findObject("flock18");
	flock19 = g.findObject("flock19");
	flock20 = g.findObject("flock20");
	vist = new Timer;
	vist.setDelay(133);

	vu = getLeftVuMeter();
	max = 144;

	stdgrp=g.getParentLayout();

	mytoggle=stdgrp.findObject("mytoggle");
	animlayer=stdgrp.findObject("animatedlayer");


	elecstatus = getPrivateInt("Snow Globe","Let it snow",0);
	elecstatus--;
	mytoggle.onLeftClick();
}

Function update (Flock f);
update (Flock f)
{
	//f.hide();
	f.cancelTarget();

	int dy = random(49 + vu/2.55);
	int dx = random(49 + vu/2.55);

	if (random(2) > 1)
	{
		dy += f.getGuiY();
		if	(dy > max)	dy -= 2*f.getGuiY();
		
		dx += f.getGuiX();
		if	(dx > max)	dx -= 2*f.getGuiX();
	}
	else
	{
		dy -= f.getGuiY();
		if	(dy < max)	dy += 2*f.getGuiY();
		
		dx -= f.getGuiX();
		if	(dx < max)	dx += 2*f.getGuiX();		
	}
	
	
	if	(dy < 0 || dy > max)
	{
		int i = max*vu/256;
		dy = random(i);
	}


	if	(dx < 0 || dx > max)
	{
		int i = max*vu/256;
		dx = random(i);
	}

	f.setTargetX(dx);
	f.setTargetY(dy);
	f.setTargetSpeed((256-getLeftVUMeter())/(66*(random(1)+1)));
	f.gotoTarget();
}

Function bupdate (Flock f);
bupdate (Flock f)
{
	//f.show();
	/*f.cancelTarget();
	if (random(1) >= 0.5)	f.setTargetX(f.getGuiX() + random(10));
	if (random(1) < 0.5)	f.setTargetX(f.getGuiX() - random(10));
	f.setTargetY(random(f.getGuiY()/(3*getLeftVuMeter()/255)));
	f.setTargetSpeed((256-getLeftVUMeter())/(50*(random(1)+1)));
	f.gotoTarget();*/

	f.cancelTarget();

	int dy = random(49) + vu/2.55;
	int dx = random(49) + vu/2.55;

	if (random(2) > 1)
	{
		dy += f.getGuiY();
		if	(dy > max)	dy -= 2*f.getGuiY();
		
		dx += f.getGuiX();
		if	(dx > max)	dx -= 2*f.getGuiX();
	}
	else
	{
		dy -= f.getGuiY();
		if	(dy < max)	dy += 2*f.getGuiY();
		
		dx -= f.getGuiX();
		if	(dx < max)	dx += 2*f.getGuiX();		
	}
	
	
	if	(dy < 0 || dy > max)
	{
		int i = max*vu/256;
		dy = random(i);
	}


	if	(dx < 0 || dx > max)
	{
		int i = max*vu/256;
		dx = random(i);
	}

	f.setTargetX(dx);
	f.setTargetY(dy);
	f.setTargetSpeed((256-getLeftVUMeter())/(166));
	f.gotoTarget();
}

g.onSetVisible(int v) {
	if (v) {

		update(flock1);
		update(flock2);
		update(flock3);
		update(flock4);
		update(flock5);
		update(flock6);
		update(flock7);
		update(flock8);
		update(flock9);
		update(flock10);

		update(flock11);
		update(flock12);
		update(flock13);
		update(flock14);
		update(flock15);
		update(flock16);
		update(flock17);
		update(flock18);
		update(flock19);
		update(flock20);

		vist.start();
	} else {
		vist.stop();
	}
}

Flock.onTargetReached() {
		if (!isvisible()) return;
		update (Flock);

}


vist.onTimer() {
	vu = getLeftVuMeter();
	if (getStatus() && vu > 180) {

		bupdate(flock1);
		bupdate(flock2);
		bupdate(flock3);
		bupdate(flock4);
		bupdate(flock5);
		bupdate(flock6);
		bupdate(flock7);
		bupdate(flock8);
		bupdate(flock9);
		bupdate(flock10);

		bupdate(flock11);
		bupdate(flock12);
		bupdate(flock13);
		bupdate(flock14);
		bupdate(flock15);
		bupdate(flock16);
		bupdate(flock17);
		bupdate(flock18);
		bupdate(flock19);
		bupdate(flock20);
	}
}

mytoggle.onLeftClick ()
{
	elecstatus++;
	elecstatus = elecstatus%3;

	setPrivateInt("Snow Globe","Let it snow",elecstatus);

	if (elecstatus == 0)
	{
		animlayer.stop();
		animlayer.gotoFrame(0);
		g.hide();
	}
	else if (elecstatus == 1)
	{
		animlayer.play();
		g.hide();
	}
	else
	{
		animlayer.stop();
		animlayer.gotoFrame(0);
		g.show();
	}
}
