#include <lib/std.mi>

#define i_playback 30 

Function buildSkin();
Function fullScreen(boolean onOff);
Function readFrameHeight();
Function readFrameHeight();
Function saveSkinPos();

Global Group g, g_screen, g_info, g_playback, g_sui, g_frameBut, g_frameButFS;
Global Container player;
Global Layout normal;
Global Layer l_frame1, l_frame2, l_frame3, l_frame4, l_frame5, l_frame6, l_frame7, l_frame8, l_frame9;
Global int i_titlebar, i_info;
Global Button b_goBig, b_goSmall;
Global Boolean fullscreen;

System.onScriptLoaded() {

	player = System.getContainer("main");
	normal = player.getLayout("normal");
	//normal.setRedrawOnResize(0);

	g = getScriptGroup();
	g_screen = g.getObject("two.screen");
	g_info = g_screen.getObject("two.info");
	g_playback = g_screen.getObject("two.playback");
	g_sui = g.getObject("cpro.sui");
	g_frameBut = g.getObject("two.frame.buttons");
	g_frameButFS = g.getObject("two.frame.buttons.fs");
	
	b_goBig = g_frameBut.getObject("two.frame.goBig");
	b_goSmall = g_frameButFS.getObject("two.frame.goSmall");
	
	l_frame1 = g.getObject("two.frame.1");
	l_frame2 = g.getObject("two.frame.2");
	l_frame3 = g.getObject("two.frame.3");
	l_frame4 = g.getObject("two.frame.4");
	l_frame5 = g.getObject("two.frame.5");
	l_frame6 = g.getObject("two.frame.6");
	l_frame7 = g.getObject("two.frame.7");
	l_frame8 = g.getObject("two.frame.8");
	l_frame9 = g.getObject("two.frame.9");
	
	//read screen height
	Map m = new Map;
	m.loadMap("info.bg.seeker.0");
	i_info = m.getHeight();
	delete m;

	readFrameHeight();
	
	
	g.setXmlParam("minimum_h",integerToString(i_titlebar+i_info+i_playback+8));
	buildSkin();

	fullscreen = getPublicInt("cPro2.fs",false);
	readFrameHeight();
	fullScreen(fullscreen);
}

System.onScriptUnloading(){
	saveSkinPos();
}

buildSkin(){
	String temp = integerToString(i_titlebar+i_info+i_playback);
	l_frame4.setXmlParam("y", temp);
	l_frame6.setXmlParam("y", temp);
	
	temp = integerToString(-i_titlebar-i_info-i_playback-8);

	temp = integerToString(i_titlebar);
	l_frame4.setXmlParam("y", temp);
	//l_frame5.setXmlParam("y", temp);
	l_frame6.setXmlParam("y", temp);
	//g_screen.setXmlParam("y", integerToString(i_titlebar));

	temp = integerToString(-i_titlebar-8);
	l_frame4.setXmlParam("h", temp);
	//l_frame5.setXmlParam("h", temp);
	l_frame6.setXmlParam("h", temp);

	g_playback.setXmlParam("y", integerToString(i_info));
	g_info.setXmlParam("h", integerToString(i_info));
	g_screen.setXmlParam("h", integerToString(i_info + i_playback));

}

saveSkinPos(){
	if(!fullscreen){
		setPublicInt("cPro2.x", normal.getLeft());
		setPublicInt("cPro2.y", normal.getTop());
		setPublicInt("cPro2.w", normal.getWidth());
		setPublicInt("cPro2.h", normal.getHeight());
	}

	setPublicInt("cPro2.fs", fullscreen);
}

fullScreen(boolean onOff){
	normal.hide();
	if(onOff){
		g_frameBut.hide();
		g_screen.setXmlParam("x", "0");
		g_screen.setXmlParam("w", "0");
		g_screen.setXmlParam("y", integerToString(i_titlebar));
		//g_screen.resize(0,55,0,i_info + i_playback);
		
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
		//l_frame5.resize(0,i_titlebar,0,-i_titlebar);
		l_frame6.hide();
		l_frame7.hide();
		l_frame8.hide();
		l_frame9.hide();
		g_frameButFS.show();

		double newscalevalue = normal.getScale();
		normal.resize(getViewPortLeftfromGuiObject(normal), getViewPortTopfromGuiObject(normal), getViewPortWidthfromGuiObject(normal)/newscalevalue, getViewPortHeightfromGuiObject(normal)/newscalevalue);
		normal.setXmlParam("move", "0");
		
		//Do this last because it takes resources.. must sometime try to clean sui area resize resource hogs
		g_sui.setXmlParam("x", "0");
		g_sui.setXmlParam("y", integerToString(i_titlebar+i_info+i_playback));
		g_sui.setXmlParam("w", "0");
		g_sui.setXmlParam("h", integerToString(-(i_titlebar+i_info+i_playback)));
		//g_sui.resize(0,i_titlebar+i_info+i_playback,0,-(i_titlebar+i_info+i_playback));
	}
	else{
		g_frameButFS.hide();
		g_screen.setXmlParam("x", "8");
		g_screen.setXmlParam("w", "-16");
		g_screen.setXmlParam("y", integerToString(i_titlebar));
		//g_screen.resize(8,55,-16,i_info + i_playback);

		l_frame1.setXmlParam("image", "frame.topleft");
		l_frame2.setXmlParam("image", "frame.top");
		l_frame2.setXmlParam("x", "105");
		l_frame2.setXmlParam("w", "-240");
		l_frame3.setXmlParam("image", "frame.topright");
		l_frame3.setXmlParam("x", "-135");
		l_frame4.show();
		l_frame5.setXmlParam("x", "8");
		l_frame5.setXmlParam("y", integerToString(i_titlebar));
		l_frame5.setXmlParam("w", "-16");
		l_frame5.setXmlParam("h", integerToString(-i_titlebar-8));
		//l_frame5.resize(8,i_titlebar,(-16),(-i_titlebar-8));
		l_frame6.show();
		l_frame7.show();
		l_frame8.show();
		l_frame9.show();
		g_frameBut.show();

		normal.resize (getPublicInt("cPro2.x", 50), getPublicInt("cPro2.y", 50), getPublicInt("cPro2.w", 50), getPublicInt("cPro2.h", 50));
		normal.setXmlParam("move", "1");
	
		//Do this last because it takes resources.. must sometime try to clean sui area resize resource hogs
		g_sui.setXmlParam("x", "8");
		g_sui.setXmlParam("y", integerToString(i_titlebar+i_info+i_playback));
		g_sui.setXmlParam("w", "-16");
		g_sui.setXmlParam("h", integerToString(-(i_titlebar+i_info+i_playback+8)));
		//g_sui.resize(8,i_titlebar+i_info+i_playback,-16,-(i_titlebar+i_info+i_playback+8));
	}
	normal.show();

}

readFrameHeight(){
	Map m = new Map;
	if(fullscreen){
		m.loadMap("frame.top.fs");
	}
	else{
		m.loadMap("frame.top");
	}
	i_titlebar = m.getHeight();
	delete m;
}

b_goBig.onLeftClick(){
	saveSkinPos();

	fullscreen=true;
	readFrameHeight();
	fullScreen(fullscreen);
}
b_goSmall.onLeftClick(){
	fullscreen=false;
	readFrameHeight();
	fullScreen(fullscreen);
}