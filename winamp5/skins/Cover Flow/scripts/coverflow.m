/********************************************************\
**  Filename:	coverflow.m				**
**  Version:	1.0					**
**  Date:	20. Nov. 2007 - 15:25			**
**********************************************************
**  Type:	winamp.wasabi/maki			**
**  Project:	Cover Flow				**
**********************************************************
**  Author:	Martin Poehlmann aka Deimos		**
**  E-Mail:	martin@skinconsortium.com		**
**  Internet:	http://www.skinconsortium.com		**
**		http://home.cs.tum.edu/~poehlman	**
\********************************************************/


#include <lib/std.mi>
#include <lib/pldir.mi>

Function update();

Class Layer AlbumCover;

Global AlbumCover prev2, prev1, curr, next1, next2;

Global Layer prev1sd;

System.onScriptLoaded ()
{
	group sg = getScriptGroup();

	prev2 = sg.getObject("aa.prev2");
	prev1 = sg.getObject("aa.prev1");
	prev1sd = sg.getObject("aa.prev1.sd");
	curr = sg.getObject("aa.curr");
	next1 = sg.getObject("aa.next1");
	next2 = sg.getObject("aa.next2");

	prev1sd.fx_setBgFx(1);
	prev1sd.fx_setGridSize(2,2);
	prev1sd.fx_setRealtime(1);
	prev1sd.fx_setRect(1);
	prev1sd.fx_setWrap(0);
	prev1sd.fx_setSpeed(1000000);
	prev1sd.fx_setEnabled(0);
	prev1sd.fx_setAlphaMode(1);
	prev1sd.fx_setBilinear(1);

	update();
}

System.onTitleChange (String newtitle)
{
	update();
}

update ()
{
	int cur = PlEdit.getCurrentIndex();
	int max = PlEdit.getNumTracks();

	if (cur > 1) 
	{
		prev2.setXmlParam("source", PlEdit.getFileName(cur-2));
		prev2.show();
	}
	else	prev2.hide();

	if (cur > 0)
	{
		prev1.setXmlParam("source", PlEdit.getFileName(cur-1));
		prev1.show();
	}
	else	prev1.hide();
	
	if (cur < max-2) 
	{
		next2.setXmlParam("source", PlEdit.getFileName(cur+2));
		next2.show();
	}
	else	next2.hide();

	if (cur < max-1)
	{
		next1.setXmlParam("source", PlEdit.getFileName(cur+1));
		next1.show();
	}
	else	next1.hide();
	prev1sd.fx_setEnabled(0);
	prev1sd.fx_setEnabled(1);
	prev1sd.fx_restart();
}

Global double dblSmidge;
prev1sd.fx_onGetPixelX(double r, double d, double x, double y)
{
	return x;
}
prev1sd.fx_onGetPixelY(double r, double d, double x, double y)
{
	if (y < 0)
	{
		return y;
	}
	
	return -y+dblSmidge;
}

prev1sd.fx_onGetPixelA(double r, double d, double x, double y)
{
	if (y < 0)
	{
		return 0+dblSmidge;
	}
	else
	{
		return (1-y+dblSmidge)*0.7;
	}
	
	
}


prev1sd.fx_onFrame()
{
	if(dblSmidge == 0.000001) 
	{
		dblSmidge = 0;
	}
	else
	{
		dblSmidge = 0.000001;
	}
}


