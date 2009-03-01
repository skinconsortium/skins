/*
SC:NowPlaying XUI Object
also incorporates nested SC:FadeText

pjn123, Quadhelix, SLoB

2008
this is a wip, please do not rip it without giving proper credit
*/

#include <lib/std.mi>

Function setAllTags();
Function resizeToThis(int x, int y, int w, int h);
Function FadeGroup(Group FadeGrp, Int AlphaValue);

Function checkOptionalGrphx();

Global Group XUIGroup, cdbox, cdboxref, cdboxHolder, ratings, BGCol;
Global GuiObject line1, line2, line3, BFColRect, shadow;
Global int xs, ys, ws, hs;
Global int xc, yc, wc, hc;
Global layer lyrFx, lyrFxFG, lyrFxBGRef, cboxfg;
global double dblSmidge;
Global int reflectionheight, noreflect;


System.onScriptLoaded(){
	XUIGroup = getScriptGroup();
	ratings = XUIGroup.findObject("sc.nowplaying.ratings");
	cdbox = XUIGroup.findObject("sc.nowplaying.cdbox");
	shadow = XUIGroup.findObject("sc.nowplaying.shadow");
	cdboxref = XUIGroup.findObject("sc.nowplaying.cdbox.reflection"); 
	cdboxref.hide();
	
	cdboxHolder = XUIGroup.findObject("sc.nowplaying.cdbox.holder");
	lyrFx = XUIGroup.findObject("main.albumart.reflection");
	lyrFxFG = XUIGroup.findObject("cdbox.fg.reflection");
	cboxfg = XUIGroup.findObject("cdbox.fg");
	lyrFxBGRef = XUIGroup.findObject("cdbox.bg.reflection");
	line1 = XUIGroup.findObject("sc.nowplaying.line1");
	line2 = XUIGroup.findObject("sc.nowplaying.line2");
	line3 = XUIGroup.findObject("sc.nowplaying.line3");
	
	BGCol = XUIGroup.findObject("sc.nowplaying.bg.ref");
	BFColRect = BGCol.getObject("sc.nowplaying.bg.ref.base");
	//CDBoxFade = XUIGroup.findObject("cdbox.fg.fademask");
	
	checkOptionalGrphx();
	
	lyrFx.fx_setBgFx(0);
  	lyrFx.fx_setWrap(0);
  	lyrFx.fx_setBilinear(1);
	lyrFx.fx_setAlphaMode(1);
  	lyrFx.fx_setGridSize(8,8);
  	lyrFx.fx_setRect(1);
	lyrFx.fx_setClear(0); //left as zero as cover is a static image and we dont need to redraw
  	lyrFx.fx_setLocalized(1);
  	lyrFx.fx_setRealtime(0);
	
	lyrFxFG.fx_setBgFx(0);
  	lyrFxFG.fx_setWrap(0);
  	lyrFxFG.fx_setBilinear(1);
	lyrFxFG.fx_setAlphaMode(1);
  	lyrFxFG.fx_setGridSize(8,8);
  	lyrFxFG.fx_setRect(1);
	lyrFxFG.fx_setClear(0); //left as zero as cover sheen is a static image and we dont need to redraw
  	lyrFxFG.fx_setLocalized(1);
  	lyrFxFG.fx_setRealtime(0);
  	
  	lyrFxBGRef.fx_setBgFx(0);
  	lyrFxBGRef.fx_setWrap(0);
  	lyrFxBGRef.fx_setBilinear(1);
	lyrFxBGRef.fx_setAlphaMode(1);
  	lyrFxBGRef.fx_setGridSize(8,8);
  	lyrFxBGRef.fx_setRect(1);
	lyrFxBGRef.fx_setClear(0); //left as zero as cover sheen is a static image and we dont need to redraw
  	lyrFxBGRef.fx_setLocalized(1);
  	lyrFxBGRef.fx_setRealtime(0);
	
  	dblSmidge = 0;
	
	reflectionheight=50;
}

system.onScriptUnloading()
{
	XUIGroup = NULL;
}

checkOptionalGrphx() {

	map filecheck = new map;
	filecheck.loadmap("sc.cdbox.bg.optional");
	if (filecheck.getWidth() > 64) {
		cdbox.setXMLParam("background","sc.cdbox.bg.optional");
		lyrFxBGRef.setXMLParam("image","sc.cdbox.bg.optional");
	}
	
	filecheck.loadmap("sc.cdbox.fg.optional");
	if (filecheck.getWidth() > 64) {
		cboxfg.setXMLParam("image","sc.cdbox.fg.optional");
		lyrFxFG.setXMLParam("image","sc.cdbox.fg.optional");
	}

	delete filecheck;
}

System.onSetXuiParam(String param, String value)
{
	if(strlower(param) == "bgcolor")
	{
		string sbgcol = strlower(value);
		BFColRect.setXMLParam("color", sbgcol);
	}
	else if(strlower(param) == "reflectiontransparency")
	{
		string sreftrans = strlower(value);
		cdboxref.setXMLParam("alpha", sreftrans);
	}
	//just default for the now is needed
	else if(strlower(param) == "reflectionheightpercentage")
	{
		//default to 50
		if(stringtointeger(value)>100 || stringtointeger(value)<0 || value=="")
		{
			reflectionheight = 50;
		}
		else
		{
			reflectionheight = stringtointeger(value);
		}
	} else if (param=="noreflection") {
		noreflect = stringtointeger(value);
		if (noreflect) {
			cdboxref.hide();
		}
	}
	
}

FadeGroup(Group FadeGrp, Int AlphaValue)
{	
	FadeGrp.setTargetA(AlphaValue);
  	FadeGrp.setTargetSpeed(0.5);
  	FadeGrp.gotoTarget();
	complete;	
}

lyrFx.fx_onFrame()
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

lyrFx.fx_onGetPixelY(double r, double d, double x, double y)
{
	return -y-dblSmidge;
}

lyrFxFG.fx_onGetPixelY(double r, double d, double x, double y)
{
	return -y-dblSmidge;
}

lyrFxBGRef.fx_onGetPixelY(double r, double d, double x, double y)
{
	return -y-dblSmidge;
}

lyrFx.fx_onGetPixelA(double r, double d, double x, double y)
{
	double ret = 1-(y+1)*0.67;
	if (ret < 0) ret = 0;
	return ret;
}

lyrFxFG.fx_onGetPixelA(double r, double d, double x, double y)
{
	double ret = 1-(y+1)*0.67;
	if (ret < 0) ret = 0;
	return ret;
}

lyrFxBGRef.fx_onGetPixelA(double r, double d, double x, double y)
{
	double ret = 1-(y+1)*0.67;
	if (ret < 0) ret = 0;
	return ret;
}

XUIGroup.onSetVisible(boolean onOff)
{
	if(onOff) 
	{
		lyrFx.fx_setEnabled(1);
		lyrFxFG.fx_setEnabled(1);
		lyrFxBGRef.fx_setEnabled(1);
		
		setAllTags();	
	}
}

XUIGroup.onResize(int x, int y, int w, int h){
	ratings.setXmlParam("x", integerToString((w-ratings.getguiw())/2));
}

cdboxHolder.onResize(int x, int y, int w, int h)
{
	xs = x;
	ys = y;
	ws = w;
	hs = h*(200-reflectionheight)/200;
	
	resizeToThis(xs, ys, ws, hs);
}

cdboxHolder.onSetVisible(int on) {
	if (on) {
		lyrFx.fx_setEnabled(0);
		lyrFxFG.fx_setEnabled(0);
		lyrFxBGRef.fx_setEnabled(0);
		
		setAllTags();
	}
}

resizeToThis(int x, int y, int w, int h)
{
	//this has to be here, if below this value then album art resizes itself stupid, do not alter this value - SLoB
	if(h<100) h=100;
	
	int x1, y1, w1, h1;
	
	xc = x; yc=y; wc= h; hc=h/2;

	if(w<h*529/488){
		w1 = w;
		h1 = w1*488/529;
		x1 = (w-w1)/2;
		y1 = (h-h1)/2;
	}
	else{
		h1 = h;
		y1 = (h-h1)/2;
		w1 = h1*529/488;
		x1 = (w-w1)/2;
	}

	cdbox.setXmlParam("x", integerToString(x1));
	cdbox.setXmlParam("y", integerToString(y1));
	cdbox.setXmlParam("w", integerToString(w1));
	cdbox.setXmlParam("h", integerToString(h1));
	
	shadow.setXmlParam("x", integerToString(x1-w1*0.2));
	shadow.setXmlParam("y", integerToString(y1+h1/2));
	shadow.setXmlParam("w", integerToString(w1*1.4));
	shadow.setXmlParam("h", integerToString(h1));
	
	cdboxref.setXmlParam("x", integerToString(x1));
	cdboxref.setXmlParam("y", integerToString(y1+h1*0.96));
	cdboxref.setXmlParam("w", integerToString(w1));
	//dont want to resize the reflection, just the mask, otherwise album art resizes width due to no stretch param till 5.54
	cdboxref.setXmlParam("h", integerToString(h1*(reflectionheight/100)));
	
	BGCol.setXmlParam("x", integerToString(x1));
	BGCol.setXmlParam("y", integerToString(y1+h1*0.96));
	BGCol.setXmlParam("w", integerToString(w1));
	BGCol.setXmlParam("h", integerToString(h1*(reflectionheight/100)));

	/*cdboxrefmask.setXmlParam("x", integerToString(x1));
	cdboxrefmask.setXmlParam("y", integerToString(y1+h1));
	cdboxrefmask.setXmlParam("w", integerToString(w1));
	cdboxrefmask.setXmlParam("h", integerToString(h1*(reflectionheight/100)));*/

				
	lyrFx.fx_update();
	lyrFxFG.fx_update();
	lyrFxBGRef.fx_update();

}

System.onTitleChange(String newTitle)
{
	lyrFx.fx_setEnabled(0);
	lyrFxFG.fx_setEnabled(0);
	lyrFxBGRef.fx_setEnabled(0);
	
	//could fade the album art in?
	//cdboxHolder.setAlpha(0);
	
	setAllTags();
}

setAllTags(){
	if(XUIGroup.isVisible()==false) return;
	
	String year = System.getPlayItemMetaDataString("YEAR");
	String album = System.getPlayItemMetaDataString("ALBUM");
	if (strLen(year)<4) year="";
	else year="("+year+")";
	if(album=="") album="Unknown Album";
	line1.setXmlParam("text", album +" "+year);

	String myartist = System.getPlayItemMetaDataString("ARTIST");
	if(myartist==""){
		if(strsearch(getPlayItemDisplayTitle(), "-")== -1){
			myartist = "Unknown Artist";
		}
		else{
			myartist = getToken(getPlayItemDisplayTitle(), "- ",  0);
		}
	}
	line2.setXmlParam("text", "by " + strupper(myartist));
	
	String mytitle = System.getPlayItemMetaDataString("TITLE");
	if(mytitle==""){
		if(strsearch(getPlayItemDisplayTitle(), "-")== -1){
			mytitle = getPlayItemDisplayTitle();
		}
		else{
			mytitle = getToken(getPlayItemDisplayTitle(), "- ",  1);
		}
	}
	line3.setXmlParam("text", mytitle);
	
	lyrFx.fx_setEnabled(1);
	lyrFxFG.fx_setEnabled(1);
	lyrFxBGRef.fx_setEnabled(1);
	lyrFx.fx_restart();
	lyrFxFG.fx_restart();
	lyrFxBGRef.fx_restart();
	
	if (!cdboxref.isVisible() && !noreflect) cdboxref.show();
	
	//for fading the album in
	//FadeGroup(cdboxHolder, 255);
	
	
}