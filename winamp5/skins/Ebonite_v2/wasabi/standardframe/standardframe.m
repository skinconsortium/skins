/*---------------------------------------------------
-----------------------------------------------------
Filename:	standardframe.m
Version:	1.0

Type:		maki
Date:		13. Sep. 2006 - 00:16 
Author:		Martin Poehlmann aka Deimos
Modified By:	SLoB 30/05/2007 fix a few things
Modified By:	SLoB 27/12/2007 fix resize/sync bug, force dta on always to fix duplicate frame bug if changing dta or F5 refresh
						Add RGB - hmm classes on dynamic container does not want to play ball
E-Mail:		martin@skinconsortium.com
Internet:	www.skinconsortium.com
		www.martin.deimos.de.vu
		

Known Bugs:
		windowtitles
		cannot show sysmenu
		on start without dta
-----------------------------------------------------
---------------------------------------------------*/

#include <lib/std.mi>
#include "../../scripts/attribs_rgb.m"

#define LAYOUT_PROPS "alpha,linkwidth,layout,linkheight,taskbar,appbar,minimum_h,minimum_w,maximum_h,maximum_w,h,w,nme,lockminmax,default_visible,default_w,default_h"
Class Layer Resizer;

Function syncFrame();
Function syncContent();
Function setNewGroup(String groupid);
Function CopyProperties();

Function setSC_RGB_Red(int iRed);
Function setSC_RGB_Green(int iGreen);
Function setSC_RGB_Blue(int iBlue);


Global Resizer left, right, bottomright, bottom, bottomleft;

Global Group scriptGroup, content;
Global Layout comp_layout, frame_layout;
Global Container frame_cont;
Global String x, y, w, h, rx, ry, rw, rh;
Global Button Sysmenu, Close;
Global GuiObject mousetrap;
Global Boolean bypass, r_bypass;
Global timer sync, delay, delayclose, delayfocus;

Global Layer top, topleft, topright;
Global Text comptitle, comptitle_na, comptitle_dummy;
Global int frame_alpha, comp_alpha;
Global Layer rightresizer, leftresizer, windowdisableresize;

//pretty pants that cannot adjust alpha with either setAlpha or setXMLParam on a derived class, only hope its fixed so that we do not have to go through shed loads of code for future RGB implementations!!
//Class Layer SCRed; //only hookable events such as button presses work, needs above implementing really so its a proper derived class and works as intended

Global Layer rtopleft, rtop, rtopright, rleft, rright, rbottomright, rbottom, rbottomleft;
Global Layer gtopleft, gtop, gtopright, gleft, gright, gbottomright, gbottom, gbottomleft;
Global Layer btopleft, btop, btopright, bleft, bright, bbottomright, bbottom, bbottomleft;

System.onScriptLoaded()
{
	initRGBAttribs(); //RGB
	
	scriptGroup = getScriptGroup();
	
	frame_cont = newDynamicContainer("sc.alphaframe");
	frame_layout = frame_cont.getLayout("scdef");
	
	comp_layout = scriptGroup.getParentLayout();
	comptitle_dummy = comp_layout.findObject("wasabi.titlebar");
	//debug(comptitle_dummy.getText());
	
	
	mousetrap = frame_layout.findObject("mousetrap");
	topleft = frame_layout.findObject("window.topleft");
	top = frame_layout.findObject("window.top");
	topright = frame_layout.findObject("window.topright");
	left = frame_layout.findObject("window.left");
	right = frame_layout.findObject("window.right");
	bottomleft = frame_layout.findObject("window.bottomleft");
	bottom = frame_layout.findObject("window.bottom");
	bottomright = frame_layout.findObject("window.bottomright");
	comptitle = frame_layout.findObject("window.titl");
	comptitle.setText(comptitle_dummy.getText());
	
	rightresizer = frame_layout.findObject("window.resizer");
	leftresizer = frame_layout.findObject("window.resizel");
	windowdisableresize = frame_layout.findObject("window.resize.disabler");
	
	//RGB
	rtopleft = frame_layout.findObject("window.topleft.red");
	rtop = frame_layout.findObject("window.top.red");
	rtopright = frame_layout.findObject("window.topright.red");
	rleft = frame_layout.findObject("window.left.red");
	rright = frame_layout.findObject("window.right.red");
	rbottomleft = frame_layout.findObject("window.bottomleft.red");
	rbottom = frame_layout.findObject("window.bottom.red");
	rbottomright = frame_layout.findObject("window.bottomright.red");

	gtopleft = frame_layout.findObject("window.topleft.green");
	gtop = frame_layout.findObject("window.top.green");
	gtopright = frame_layout.findObject("window.topright.green");
	gleft = frame_layout.findObject("window.left.green");
	gright = frame_layout.findObject("window.right.green");
	gbottomleft = frame_layout.findObject("window.bottomleft.green");
	gbottom = frame_layout.findObject("window.bottom.green");
	gbottomright = frame_layout.findObject("window.bottomright.green");
	
	btopleft = frame_layout.findObject("window.topleft.blue");
	btop = frame_layout.findObject("window.top.blue");
	btopright = frame_layout.findObject("window.topright.blue");
	bleft = frame_layout.findObject("window.left.blue");
	bright = frame_layout.findObject("window.right.blue");
	bbottomleft = frame_layout.findObject("window.bottomleft.blue");
	bbottom = frame_layout.findObject("window.bottom.blue");
	bbottomright = frame_layout.findObject("window.bottomright.blue");
	
	
	frame_alpha = frame_layout.getAlpha();
	comp_alpha = comp_layout.getAlpha();

	desktopalpha_enabled_attrib.onDataChanged();

	Close = frame_layout.getObject("Close");
	

	String param = getParam();
	x = getToken(param, ",", 0);
	y = getToken(param, ",", 1);
	w = getToken(param, ",", 2);
	h = getToken(param, ",", 3);
	rx = getToken(param, ",", 4);
	ry = getToken(param, ",", 5);
	rw = getToken(param, ",", 6);
	rh = getToken(param, ",", 7);
	sysmenu = scriptGroup.findObject("sysmenu");

	if (desktopalpha_enabled_attrib.getData() == "0") desktopalpha_enabled_attrib.setData("1");
	//else desktopalpha_enabled_attrib.setData("1");
	
	setSC_RGB_Red(getPrivateInt(getSkinName(),"redbg", 0));
	setSC_RGB_Green(getPrivateInt(getSkinName(),"greenbg", 0));
	setSC_RGB_Blue(getPrivateInt(getSkinName(),"bluebg", 0));
	
	// **** modified by leechbite -- added check if timer has already been created
	//		this protects on second init on non-dynamic containers
	if (!sync) {
		sync = new Timer;
		sync.setDelay(70);
	}


	if (!delay) {
		delay = new Timer;
		delay.setDelay(1);
	}
	
	if (!delayclose) {
		delayclose = new Timer;
		delayclose.setDelay(1);
	}
	if (!delayfocus) {
		delayfocus = new Timer;
		delayfocus.setDelay(100);
	}

}

delayfocus.onTimer() {
	stop();
	
	if (frame_layout) frame_layout.setFocus();
	if (comp_layout) comp_layout.setFocus();
}

System.onScriptUnloading ()
{
	sync.stop();
	delete sync;
	
	delay.stop();
	delete delay;
	
	delete delayclose;
	delete delayfocus;
}

myattrib_stdfrmBGREDColor.onDataChanged()
{
	//setAlpha/setXMLParam seems borked with derived classes atm, make do with long workaround
	//SCRed.setXMLParam("alpha", myattrib_stdfrmBGREDColor.getData());	
	if(myattrib_stdfrmBGEnabled.getData()=="1" && frame_cont != null)
	{
		setSC_RGB_Red(stringtointeger(myattrib_stdfrmBGREDColor.getData()));
	}
}

myattrib_stdfrmBGGREENColor.onDataChanged()
{
	//setAlpha/setXMLParam seems borked with derived classes atm, make do with long workaround
	//SCGreen.setXMLParam("alpha", myattrib_stdfrmBGGREENColor.getData());
	if(myattrib_stdfrmBGEnabled.getData()=="1" && frame_cont != null)
	{
		setSC_RGB_Green(stringtointeger(myattrib_stdfrmBGGREENColor.getData()));
	}
}

myattrib_stdfrmBGBLUEColor.onDataChanged()
{
	//setAlpha/setXMLParam seems borked with derived classes atm, make do with long workaround
	//SCBlue.setXMLParam("alpha", myattrib_stdfrmBGBLUEColor.getData());
	if(myattrib_stdfrmBGEnabled.getData()=="1" && frame_cont != null)
	{
		setSC_RGB_Blue(stringtointeger(myattrib_stdfrmBGBLUEColor.getData()));
	}		
}

setSC_RGB_Red(int iRed)
{
	rtopleft.setAlpha(iRed);
	rtop.setAlpha(iRed);
	rtopright.setAlpha(iRed);
	rleft.setAlpha(iRed);
	rright.setAlpha(iRed);
	rbottomright.setAlpha(iRed);
	rbottom.setAlpha(iRed);
	rbottomleft.setAlpha(iRed);
}

setSC_RGB_Green(int iGreen)
{
	gtopleft.setAlpha(iGreen);
	gtop.setAlpha(iGreen);
	gtopright.setAlpha(iGreen);
	gleft.setAlpha(iGreen);
	gright.setAlpha(iGreen);
	gbottomright.setAlpha(iGreen);
	gbottom.setAlpha(iGreen);
	gbottomleft.setAlpha(iGreen);
}
setSC_RGB_Blue(int iBlue)
{
	btopleft.setAlpha(iBlue);
	btop.setAlpha(iBlue);
	btopright.setAlpha(iBlue);
	bleft.setAlpha(iBlue);
	bright.setAlpha(iBlue);
	bbottomright.setAlpha(iBlue);
	bbottom.setAlpha(iBlue);
	bbottomleft.setAlpha(iBlue);
}

comptitle_dummy.onTextChanged (String newtxt)
{
	comptitle.setText(comptitle_dummy.getText());	
}


System.onSetXuiParam(String param, String value)
{
	

	mousetrap = frame_layout.findObject("mousetrap");
	topleft = frame_layout.findObject("window.topleft");
	top = frame_layout.findObject("window.top");
	topright = frame_layout.findObject("window.topright");
	left = frame_layout.findObject("window.left");
	right = frame_layout.findObject("window.right");
	bottomleft = frame_layout.findObject("window.bottomleft");
	bottom = frame_layout.findObject("window.bottom");
	bottomright = frame_layout.findObject("window.bottomright");
	comptitle = frame_layout.findObject("window.titl");
	comptitle.setText(comptitle_dummy.getText());
	
	//rightresizer = frame_layout.findObject("window.resizer");
	//leftresizer = frame_layout.findObject("window.resizel");
	//windowdisableresize = frame_layout.findObject("window.resize.disabler");
	
	
	if (param == "content")
	{
		setNewGroup(value);
	}
	
	if (param == "forcenoresize" && value == "1")
	{	
//		windowdisableresize.setXMLParam("visible", "1");
		left.setXMLParam("resize", "0");
		right.setXMLParam("resize", "0");
		bottomleft.setXMLParam("resize", "0");
		bottom.setXMLParam("resize", "0");
		bottomright.setXMLParam("resize", "0");
		left.setXMLParam("move", "1");
		right.setXMLParam("move", "1");
		bottomleft.setXMLParam("move", "1");
		bottom.setXMLParam("move", "1");
		bottomright.setXMLParam("move", "1");
//		rightresizer.setXMLParam("alpha", "0");
//		leftresizer.setXMLParam("alpha", "0");
		
	}
}


// backward compatibility for prerelease notify trick
scriptGroup.onNotify(String cmd, String param, int a, int b)
{
	String _command = getToken(cmd, ",", 0);
	String _param = getToken(cmd, ",", 1);
	if (_command == "content") {
		onSetXuiParam(_command, _param);
	}
}


setNewGroup(String groupid)
{
	content = newGroup(groupid);
	if (content == NULL)
	{
		messagebox("group \"" + groupid + "\" not found", "ButtonGroup", 0, "");
		return;
	}
	
	
	content.setXmlParam("x", x);
	content.setXmlParam("y", y);
	content.setXmlParam("w", w);
	content.setXmlParam("h", h);
	content.setXmlParam("relatx", rx);
	content.setXmlParam("relaty", ry);
	content.setXmlParam("relatw", rw);
	content.setXmlParam("relath", rh);
	comp_layout.setXMLParam("nodock", "1"); // needed for smoother window draging
	content.init(scriptGroup);
	copyProperties();
}

Sysmenu.onLeftClick()
{
	LayoutStatus _status = scriptGroup.findObject("sysmenu.status");
	_status.callme("{system}");
}

/**** Alpha Synchronizer ****/

/** Synchronize frame_layout **/

syncFrame ()
{
	if (frame_layout)
	{
		frame_layout.resize(comp_layout.getLeft(), comp_layout.getTop(), comp_layout.getWidth(), comp_layout.getHeight());
	}
}

comp_layout.onSetVisible (Boolean on)
{
	if (on)
	{
		if (!comp_layout.getContainer().isDynamic()) system.onScriptLoaded();
		frame_layout.show();
		syncFrame();
		sync.start();

	}
	else
	{
		// *** portion modified by leechbite
		
		sync.stop();
		if (frame_layout) {
			frame_cont.close(); // kill frame container, this is will be reinitiated on re-show of comp
		}
			frame_cont = NULL;
			frame_layout = NULL;
		
		
	}
	
}

comp_layout.onMove ()
{
	syncFrame();
}

comp_layout.onResize (int x, int y, int w, int h)
{
	if (frame_layout)
	{
		frame_layout.setfocus();
	}
	
	if (comp_layout)
	{
		comp_layout.setfocus();
	}
	syncFrame();	
}

// the next function one is needed cause you can click on pledit and frame isn't set focused, and it will also redirect the focus to the component
sync.onTimer ()
{
	
	// ***** modified by leechbite
	if (!bypass)
	{
		if (comp_layout.isActive() || frame_layout.isActive())
		{
			frame_layout.setfocus();
			comp_layout.setfocus();
			bypass = true;
		}
	}
	
	if (!frame_layout.isActive() && !comp_layout.isActive())
	{ // if at some point both layout is not focused, remove bypass
		bypass = false;
	}
	/** synchronize alpha **/
	if (comp_layout.getAlpha() != frame_layout.getAlpha())
	{
		if (frame_alpha != frame_layout.getAlpha())
		{
			comp_layout.setAlpha(frame_layout.getAlpha());
		}
		else if (comp_alpha != comp_layout.getAlpha())
		{
			frame_layout.setAlpha(comp_layout.getAlpha());
		}
		frame_alpha = frame_layout.getAlpha();
		comp_alpha = comp_layout.getAlpha();
	}
	
		
}

/** synchronize max_w etc. **/

CopyProperties()
{
	for (Int i = 0; i <= 16; i++)
	{
		if (frame_layout.getXMLParam(System.getToken(LAYOUT_PROPS,",",i)) != comp_layout.getXMLParam(System.getToken(LAYOUT_PROPS,",",i)))
			frame_layout.SetXMLParam(System.getToken(LAYOUT_PROPS,",",i),comp_layout.getXMLParam(System.getToken(LAYOUT_PROPS,",",i)));
	}
}

/** Synchronize comp_layout **/

syncContent ()
{
	if (comp_layout)
	{
		comp_layout.resize(frame_layout.getLeft(), frame_layout.getTop(), frame_layout.getWidth(), frame_layout.getHeight());
	}
}

close.onLeftClick () {
	delayclose.start();
}

delayclose.onTimer() {
	stop();
	comp_layout.getContainer().close();
}

frame_layout.onMove ()
{
	r_bypass = false;
	syncContent();
}

frame_layout.onUserResize (int x, int y, int w, int h)
{
	r_bypass = false;
	frame_layout.setfocus();
	comp_layout.setfocus();
	delay.start();
	
	//resize as below threshold
	if (frame_layout.getWidth() < 258 && frame_layout.getHeight() < 258)
	{
		frame_layout.resize(comp_layout.getLeft()+1, comp_layout.getTop()+1, 258, 258);
		frame_layout.resize(comp_layout.getLeft()-1, comp_layout.getTop()-1, 258, 258);
	
	}
	
	if (frame_layout.getWidth() < 258)
	{
		frame_layout.resize(comp_layout.getLeft()+1, comp_layout.getTop()+1, 258, h);
		frame_layout.resize(comp_layout.getLeft()-1, comp_layout.getTop()-1, 258, h);
	}
	
	if (frame_layout.getHeight() < 258)
	{
		frame_layout.resize(comp_layout.getLeft()+1, comp_layout.getTop()+1, w, 258);
		frame_layout.resize(comp_layout.getLeft()-1, comp_layout.getTop()-1, w, 258);
	}
	
}

delay.onTimer ()
{
	delay.stop();
	syncContent();
}


mousetrap.onLeftButtonDown (int x, int y)
{
	r_bypass = false;
	syncContent();
	frame_layout.setfocus();
	comp_layout.setfocus();
}

mousetrap.onRightButtonUp (int x, int y)
{
	bypass = true;
	r_bypass = true;
	syncContent();
	frame_layout.setfocus();
	comp_layout.setfocus();
}

Resizer.onRightButtonUp (int x, int y)
{
	bypass = true;
	r_bypass = true;
	syncContent();
	frame_layout.setfocus();
	comp_layout.setfocus();
}

mousetrap.onRightButtonDown (int x, int y)
{
	bypass = true;
	r_bypass = true;
	syncContent();
	frame_layout.setfocus();
	comp_layout.setfocus();

}


Resizer.onRightButtonDown (int x, int y)
{
	bypass = true;
	r_bypass = true;
	syncContent();
	frame_layout.setfocus();
	comp_layout.setfocus();
}

Resizer.onLeftButtonDown (int x, int y)
{
	r_bypass = false;
	syncContent();
		comp_layout.setfocus();
}



/** Sync Scale **/

Global Boolean nocallback;

//always should sync scale, no need for return
frame_layout.onScale (Double newscalevalue)
{
	if (nocallback) return;
	nocallback = true;
	comp_layout.setScale(newscalevalue);
	syncContent();
	nocallback = false;
}

comp_layout.onScale (Double newscalevalue)
{
	if (nocallback) return;
	nocallback = true;
	frame_layout.setScale(newscalevalue);
	syncFrame();	
	nocallback = false;
}

/** Sync dta on/off **/

desktopalpha_enabled_attrib.onDataChanged ()
{
	if (getData() == "1")
	{
		topleft.setXMLParam("image", "wasabi.frame.topleft");
		top.setXMLParam("image", "wasabi.frame.top");
		topright.setXMLParam("image", "wasabi.frame.topright");
		left.setXMLParam("image", "wasabi.frame.left");
		right.setXMLParam("image", "wasabi.frame.right");
		bottomleft.setXMLParam("image", "wasabi.frame.bottomleft");
		bottom.setXMLParam("image", "wasabi.frame.bottom");
		bottomright.setXMLParam("image", "wasabi.frame.bottomright");
	}
	
	//its alpha or nothing, wierd issues of leaving multiple windows open if toggling dta, so dont give the option
}
