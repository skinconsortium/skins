#include <lib/std.mi>

#define i_info 40 
#define i_playback 30 

Function buildSkin();
Function fullScreen(boolean onOff);
Function readFrameHeight();

Global Group g, g_screen, g_info, g_playback, g_sui;
Global Container player;
Global Layout normal;
Global Layer l_frame1, l_frame2, l_frame3, l_frame4, l_frame5, l_frame6, l_frame7, l_frame8, l_frame9;
Global int i_titlebar;

System.onScriptLoaded() {

	player = System.getContainer("main");
	normal = player.getLayout("normal");

	g = getScriptGroup();
	g_screen = g.getObject("two.screen");
	g_info = g_screen.getObject("two.info");
	g_playback = g_screen.getObject("two.playback");
	g_sui = g.getObject("two.suiframe");
	
	l_frame1 = g.getObject("two.frame.1");
	l_frame2 = g.getObject("two.frame.2");
	l_frame3 = g.getObject("two.frame.3");
	l_frame4 = g.getObject("two.frame.4");
	l_frame5 = g.getObject("two.frame.5");
	l_frame6 = g.getObject("two.frame.6");
	l_frame7 = g.getObject("two.frame.7");
	l_frame8 = g.getObject("two.frame.8");
	l_frame9 = g.getObject("two.frame.9");
	
	readFrameHeight();
	
	g.setXmlParam("minimum_h",integerToString(i_titlebar+i_info+i_playback+8));
	buildSkin();
	//fullScreen(true);
}

System.onScriptUnloading(){
}

buildSkin(){
	String temp = integerToString(i_titlebar+i_info+i_playback);
	l_frame4.setXmlParam("y", temp);
	l_frame6.setXmlParam("y", temp);
	
	temp = integerToString(-i_titlebar-i_info-i_playback-8);

	temp = integerToString(i_titlebar);
	l_frame4.setXmlParam("y", temp);
	l_frame5.setXmlParam("y", temp);
	l_frame6.setXmlParam("y", temp);
	g_screen.setXmlParam("y", integerToString(i_titlebar));

	temp = integerToString(-i_titlebar-8);
	l_frame4.setXmlParam("h", temp);
	l_frame5.setXmlParam("h", temp);
	l_frame6.setXmlParam("h", temp);

	g_screen.setXmlParam("h", integerToString(i_info + i_playback));
}

fullScreen(boolean onOff){
	if(onOff){
		g_sui.setXmlParam("x", "0");
		g_sui.setXmlParam("y", integerToString(i_titlebar+i_info+i_playback));
		g_sui.setXmlParam("w", "0");
		g_sui.setXmlParam("h", integerToString(-(i_titlebar+i_info+i_playback)));
		g_screen.setXmlParam("x", "0");
		g_screen.setXmlParam("w", "0");
		l_frame1.setXmlParam("image", "frame.topleft.fs");
		l_frame2.setXmlParam("image", "frame.top.fs");
		l_frame2.setXmlParam("x", "138");
		l_frame2.setXmlParam("w", "-276");
		l_frame3.setXmlParam("image", "frame.topright.fs");
		l_frame3.setXmlParam("x", "-138");
		l_frame4.hide();
		l_frame5.setXmlParam("x", "0");
		l_frame5.setXmlParam("y", integerToString(i_titlebar));
		l_frame5.setXmlParam("w", "0");
		l_frame5.setXmlParam("h", integerToString(-i_titlebar));
		l_frame6.hide();
		l_frame7.hide();
		l_frame8.hide();
		l_frame9.hide();

		double newscalevalue = normal.getScale();
		normal.resize(getViewPortLeftfromGuiObject(normal), getViewPortTopfromGuiObject(normal), getViewPortWidthfromGuiObject(normal)/newscalevalue, getViewPortHeightfromGuiObject(normal)/newscalevalue);

	}
}

readFrameHeight(){
	Map m = new Map;
	if(true){
		m.loadMap("frame.top");
	}
	else{
		m.loadMap("frame.top.fs");
	}
	i_titlebar = m.getHeight();
	delete m;
}