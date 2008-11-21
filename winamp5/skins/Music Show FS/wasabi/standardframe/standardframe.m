/*---------------------------------------------------
-----------------------------------------------------
Filename:	standardframe.m
Version:	1.0

Type:		maki
Date:		13. Sep. 2006 - 00:16 
Author:		Martin Poehlmann aka Deimos
Modified By:	SLoB 30/05/2007 fix a few things
E-Mail:		martin@skinconsortium.com
Internet:	www.skinconsortium.com
		www.martin.deimos.de.vu
		

Known Bugs:
		windowtitles
		cannot show sysmenu
-----------------------------------------------------
---------------------------------------------------*/

#include <lib/std.mi>
#include "../../scripts/attribs/init_general.m"

// *** modified by leechbite -- removed some properties that i think should not be changed "on-the-fly"
#define LAYOUT_PROPS "alpha,linkwidth,layout,linkheight,taskbar,appbar,minimum_h,minimum_w,maximum_h,maximum_w,h,w,nme,lockminmax,default_visible,default_w,default_h"

Function syncFrame();
Function syncContent();
Function setNewGroup(String groupid);
Function CopyProperties();

Class layer Resizer;

Global Group scriptGroup, content;
Global Layout comp_layout, frame_layout;
Global Container frame_cont;
Global String x, y, w, h, rx, ry, rw, rh;
Global Button Sysmenu, Close;
Global GuiObject mousetrap;
Global Boolean bypass, r_bypass;
Global timer sync, delay, delayclose, delayfocus;
Global Resizer left, right, bottomright, bottom, bottomleft;
Global Layer top, topleft, topright;
Global Text comptitle, comptitle_na, comptitle_dummy;
Global int frame_alpha, comp_alpha;

Global togglebutton buttonFocus;

System.onScriptLoaded()
{
	initAttribs_general();

	scriptGroup = getScriptGroup();
	comp_layout = scriptGroup.getParentLayout();
	comptitle_dummy = comp_layout.findObject("wasabi.titlebar");
	
	//if (comp_layout.isVisible()) {
		frame_cont = newDynamicContainer("wasabi.alphaframe");
		
		frame_layout = frame_cont.getLayout("def");
		
		mousetrap = frame_layout.getObject("mousetrap");
		topleft = frame_layout.getObject("window.topleft");
		top = frame_layout.getObject("window.top");
		topright = frame_layout.getObject("window.topright");
		left = frame_layout.getObject("window.left");
		right = frame_layout.getObject("window.right");
		bottomleft = frame_layout.getObject("window.bottomleft");
		bottom = frame_layout.getObject("window.bottom");
		bottomright = frame_layout.getObject("window.bottomright");
		comptitle = frame_layout.getObject("window.titl");
		comptitle.setText(comptitle_dummy.getText());
	
		frame_alpha = frame_layout.getAlpha();
		comp_alpha = comp_layout.getAlpha();
	
		desktopalpha_enabled_attrib.onDataChanged();
	
		Close = frame_layout.getObject("Close");
	//}
	

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
	
	layout mainlay = getContainer("main").getLayout("normal");
	buttonFocus = mainlay.findObject("main.button.focus");
	
	if (comp_layout.isVisible()) buttonFocus.onActivate(buttonFocus.getActivated());
		


}

buttonFocus.onActivate(int on) {
	if (on) {
		delayfocus.start();
	}

}

delayfocus.onTimer() {
	stop();
	
	if (frame_layout) frame_layout.setFocus();
	if (comp_layout) comp_layout.setFocus();
}

System.onScriptUnloading ()
{
	buttonFocus = NULL;
	
	sync.stop();
	delete sync;
	
	delay.stop();
	delete delay;
	
	delete delayclose;
	delete delayfocus;
}


comptitle_dummy.onTextChanged (String newtxt)
{
	comptitle.setText(comptitle_dummy.getText());	
}


System.onSetXuiParam(String param, String value)
{
	if (param == "content")
	{
		setNewGroup(value);
	}
	if (param == "forcenoresize" && value == "1")
	{
		if (frame_layout) {
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
		}
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
		frame_layout.resize(comp_layout.getLeft(), comp_layout.getTop(), comp_layout.getWidth(), comp_layout.getHeight());
}

comp_layout.onSetVisible (Boolean on)
{
	if (on)
	{
		if (!comp_layout.getContainer().isDynamic()) system.onScriptLoaded();
		if (frame_layout) frame_layout.show();
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
	if (!frame_layout) return;
	frame_layout.setfocus();
	comp_layout.setfocus();
	syncFrame();	
}

// the next function one is needed cause you can click on pledit and frame isn't set focused, and it will also redirect the focus to the component
sync.onTimer ()
{	if (!frame_layout) return;

	// ***** modified by leechbite
	if (!bypass) {
		if (comp_layout.isActive() || frame_layout.isActive()) {
			frame_layout.setfocus();
			comp_layout.setfocus();
			bypass = true;
		}
	}
	
	if (!frame_layout.isActive() && !comp_layout.isActive()) { // if at some point both layout is not focused, remove bypass
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

copyProperties()
{
	if (!frame_layout) return;
	
	for (Int i = 0; i <= 19; i++)
	{
		if (frame_layout.getXMLParam(System.getToken(LAYOUT_PROPS,",",i)) != comp_layout.getXMLParam(System.getToken(LAYOUT_PROPS,",",i)))
			frame_layout.SetXMLParam(System.getToken(LAYOUT_PROPS,",",i),comp_layout.getXMLParam(System.getToken(LAYOUT_PROPS,",",i)));
	}
}

/** Synchronize comp_layout **/

syncContent ()
{
	if (!frame_layout) return;
	if (comp_layout)
		comp_layout.resize(frame_layout.getLeft(), frame_layout.getTop(), frame_layout.getWidth(), frame_layout.getHeight());
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
	if (frame_layout.getWidth() < 250 && frame_layout.getHeight() < 250)
	{
		frame_layout.resize(comp_layout.getLeft()+1, comp_layout.getTop()+1, 250, 250);
		frame_layout.resize(comp_layout.getLeft()-1, comp_layout.getTop()-1, 250, 250);
	
	}
	
	if (frame_layout.getWidth() < 250)
	{
		frame_layout.resize(comp_layout.getLeft()+1, comp_layout.getTop()+1, 250, h);
		frame_layout.resize(comp_layout.getLeft()-1, comp_layout.getTop()-1, 250, h);
	}
	
	if (frame_layout.getHeight() < 250)
	{
		frame_layout.resize(comp_layout.getLeft()+1, comp_layout.getTop()+1, w, 250);
		frame_layout.resize(comp_layout.getLeft()-1, comp_layout.getTop()-1, w, 250);
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
	if (frame_layout) frame_layout.setScale(newscalevalue);
	syncFrame();	
	nocallback = false;
}

/** Sync dta on/off **/

desktopalpha_enabled_attrib.onDataChanged ()
{
	if (!frame_layout) return;
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
	else
	{
		topleft.setXMLParam("image", "wasabi.frame.topleft.na");
		top.setXMLParam("image", "wasabi.frame.top.na");
		topright.setXMLParam("image", "wasabi.frame.topright.na");
		left.setXMLParam("image", "wasabi.frame.left.na");
		right.setXMLParam("image", "wasabi.frame.right.na");
		bottomleft.setXMLParam("image", "wasabi.frame.bottomleft.na");
		bottom.setXMLParam("image", "wasabi.frame.bottom.na");
		bottomright.setXMLParam("image", "wasabi.frame.bottomright.na");
	}	
}