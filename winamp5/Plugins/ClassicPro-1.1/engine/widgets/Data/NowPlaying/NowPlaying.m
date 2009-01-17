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

Global Group XUIGroup, cdbox, cdboxref, cdboxHolder, ratings, cdbox_2;
Global GuiObject line1, line2, line3, BGCol, CDBoxFade;
Global Timer delayMyResize;
Global int xs, ys, ws, hs;
Global int xc, yc, wc, hc;
Global layer lyrFx, lyrFxFG; //, CDBoxFade2;
global double dblSmidge;
Global int reflectionheight;


System.onScriptLoaded(){
	XUIGroup = getScriptGroup();
	ratings = XUIGroup.findObject("sc.nowplaying.ratings");
	
	cdbox = XUIGroup.findObject("sc.nowplaying.cdbox.holder.top");
	cdbox_2 = XUIGroup.findObject("sc.nowplaying.cdbox.holder.bottom");
	
	cdboxref = XUIGroup.findObject("sc.nowplaying.cdbox.reflection"); 
	
	cdboxHolder = XUIGroup.findObject("sc.nowplaying.cdbox.holder");
	lyrFx = XUIGroup.findObject("main.albumart.reflection");
	lyrFxFG = XUIGroup.findObject("cdbox.fg.reflection");
	line1 = XUIGroup.findObject("sc.nowplaying.line1");
	line2 = XUIGroup.findObject("sc.nowplaying.line2");
	line3 = XUIGroup.findObject("sc.nowplaying.line3");
	
	BGCol = XUIGroup.findObject("sc.nowplaying.bg");
	CDBoxFade = XUIGroup.findObject("cdbox.fg.fademask");
	//CDBoxFade2 = XUIGroup.findObject("cdbox.fg.fademask2");

	/*if (!CDBoxFade2.isInvalid())
	{
		CDBoxFade.hide();
		CDBoxFade2.show();
	}*/

	// Reader for albumart gradient (remove later... just keep here to see what code was used)... this will be done inside the widget from v1.1
	Map myMap = new Map;
	myMap.loadMap("wasabi.list.background");
	XUIGroup.setXmlParam("bgcolor", integerToString(myMap.getARGBValue(0,0,2))+","+integerToString(myMap.getARGBValue(0,0,1))+","+integerToString(myMap.getARGBValue(0,0,0)));
	delete myMap;
	
	delayMyResize = new Timer;
	delayMyResize.setDelay(100);
	
	lyrFx.fx_setBgFx(0);
  	lyrFx.fx_setWrap(0);
  	lyrFx.fx_setBilinear(1);
	lyrFx.fx_setAlphaMode(0);
  	lyrFx.fx_setGridSize(1,1);
  	lyrFx.fx_setRect(1);
	lyrFx.fx_setClear(0); //left as zero as cover is a static image and we dont need to redraw
  	lyrFx.fx_setLocalized(1);
  	lyrFx.fx_setRealtime(1);
  	lyrFx.fx_setSpeed(2000); //slow timer as we dont really need to redraw much
	
	lyrFxFG.fx_setBgFx(0);
  	lyrFxFG.fx_setWrap(0);
  	lyrFxFG.fx_setBilinear(1);
	lyrFxFG.fx_setAlphaMode(0);
  	lyrFxFG.fx_setGridSize(1,1);
  	lyrFxFG.fx_setRect(1);
	lyrFxFG.fx_setClear(0); //left as zero as cover sheen is a static image and we dont need to redraw
  	lyrFxFG.fx_setLocalized(1);
  	lyrFxFG.fx_setRealtime(1);
  	lyrFxFG.fx_setSpeed(2000); //slow timer as we dont really need to redraw much
	
  	dblSmidge = 0;
	//default half height - remove ability to resize for the now
	reflectionheight=50;
	//cdboxHolder.Resize(0, 0, 190, 190);
	
		
}

system.onScriptUnloading()
{
	XUIGroup = NULL;
	delete delayMyResize;
}

System.onSetXuiParam(String param, String value)
{
	if(strlower(param) == "bgcolor")
	{
		string sbgcol = strlower(value);
		BGCol.setXMLParam("color", sbgcol);

		//gradient fade to mask the reflection from image to background ie fade it to nothing
		CDBoxFade.setXMLParam("points", "0.0=" + sbgcol + ",50;1.0=" + sbgcol + ",255"); //pjn mix
		
	}
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
	}
	
}

FadeGroup(Group FadeGrp, Int AlphaValue)
{	
	FadeGrp.setTargetA(AlphaValue);
  	FadeGrp.setTargetSpeed(1.3);
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

//reflection, needs dblSmidge to activate, its on a slow timer without clear as its a static image and doesnt need to be cleared every frame
//Wow.. what a mouthful.. (that's what she said)
lyrFx.fx_onGetPixelY(double r, double d, double x, double y)
{
	return -y-dblSmidge;
}

lyrFxFG.fx_onGetPixelY(double r, double d, double x, double y)
{
	return -y-dblSmidge;
}

XUIGroup.onSetVisible(boolean onOff)
{
	if(onOff) 
	{
		lyrFx.fx_setEnabled(1);
		lyrFxFG.fx_setEnabled(1);
		
		setAllTags();
		delayMyResize.start();	
	}
	else{
		lyrFx.fx_setEnabled(0);
		lyrFxFG.fx_setEnabled(0);
	}
}

XUIGroup.onResize(int x, int y, int w, int h){
	ratings.setXmlParam("x", integerToString(w/2-31));
}

cdboxHolder.onResize(int x, int y, int w, int h)
{
	xs = x;
	ys = y;
	ws = w;
	hs = h;
	
	if(XUIGroup.isVisible()) delayMyResize.start();
}

resizeToThis(int x, int y, int w, int h)
{
	//We don't like it too small (that's what she said)
	if(h<100) h=100;
	
	int x1, w1, h1;
	
	xc = x; yc=y; wc= w; hc=h;

	//we want to keep the ratio of the art+reflection... and remember the variable reflection xui param!
	double ratio = 529/(488*(1+(reflectionheight/100))); // r=w/h... dws... w=r*h .....h=w/r
	if(w<ratio*h){
		w1 = w;
		h1 = w/ratio;
	}
	else{
		h1 = h;
		w1 = h1*ratio;
	}
	x1 = w/2 - w1/2;

	cdbox.setXmlParam("x", integerToString(x1));
	cdbox.setXmlParam("w", integerToString(w1));
	cdbox.setXmlParam("h", integerToString(h1*100/(reflectionheight+100)));
	
	/*cdbox_2.setXmlParam("x", integerToString(x1));
	cdbox_2.setXmlParam("y", integerToString(h1*100/(reflectionheight+100)));
	cdbox_2.setXmlParam("w", integerToString(w1));
	cdbox_2.setXmlParam("h", integerToString(h1*reflectionheight/(reflectionheight+100)));*/
	
	cdbox_2.setXmlParam("x", integerToString(x1));
	cdbox_2.setXmlParam("y", integerToString(h1*100/(reflectionheight+100)));
	cdbox_2.setXmlParam("w", integerToString(w1));
	cdbox_2.setXmlParam("h", integerToString(h1*reflectionheight/(reflectionheight+100)));
	
	cdboxref.setXmlParam("h", integerToString(h1*100/(reflectionheight+100)));
	
	lyrFx.fx_update();
	lyrFxFG.fx_update();
}

//timer needed otherwise crap fatal error
delayMyResize.onTimer(){

	resizeToThis(xs, ys, ws, hs);
	
	if(xc==xs && yc==ys && wc==ws && hc==hs) delayMyResize.stop();
}

System.onTitleChange(String newTitle)
{
	lyrFx.fx_setEnabled(0);
	lyrFxFG.fx_setEnabled(0);
	
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
	line2.setXmlParam("text", "by " + myartist);
	
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
	lyrFx.fx_restart();
	lyrFxFG.fx_restart();
	
	//for fading the album in
	//FadeGroup(cdboxHolder, 255);
	
	
}