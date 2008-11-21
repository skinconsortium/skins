/*---------------------------------------------------
-----------------------------------------------------
Filename:	windowmodebutton.m

Version:	1.0
Date:		17. Feb. 2006 - 15:49 
Author:		Martin Poehlmann alias Deimos
E-Mail:		martin@skinconsortium.com
Internet:	www.skinconsortium.com
		www.martin.deimos.de.vu
modified:	SLoB - quick code to incorporate last x,y pos for the 3 main modes so they each remember where they were position for switchtolayout
-----------------------------------------------------
-----------------------------------------------------
Usage:		See windowmodebutton.xml
-----------------------------------------------------
---------------------------------------------------*/

#include <lib/std.mi>

Function ProcessMenuResult(int a);
Function Int countSubString(string str, string substr);

//#define DEBUGWINDOWMODE

#ifdef DEBUGWINDOWMODE
Function DEBUGWINDOW(String debugStr);
DEBUGWINDOW(String debugStr) {
	system.debugstring("Debug Message:" + debugStr, 0);
}
#endif

Function resizeLayout(layout newlayout);

Global Button btn;

Global String _container = "this";
Global PopupMenu menu_Layouts;
Global int nLayouts = 0, bGotContainer = 0;
Global String layoutstring, gotLayoutString;
Global String rclick = "null";
Global String lclick = "null";
Global layout n, s, m, v, mv;
Global int nX, nY, sX, sY, mX, mY, vX, vY, mvX, mvY, iMode;
Global timer tmrDelay;

System.onScriptLoaded() 
{


	Group XUIGroup = getScriptGroup();

	btn = XUIGroup.findObject("btn");

	menu_Layouts = new PopupMenu;
	menu_Layouts.addCommand("Window Modes (alt+q)", 0, 0, 1);
	menu_Layouts.addSeparator();

//	set defaults regardless, should cut down on mysterious vert mode vanishing from all existance
	nX = 0;
	nY = 0;
	sX = 0;
	sY = 0;
	mX = 0;
	mY = 0;
	mvX = 0;
	mvY = 0;
	//vX = 0;
	vX = system.getViewPortWidth()-198; //default to right if not set
	vY = 0;
	
	tmrDelay = new timer;
	tmrDelay.setdelay(700);

	iMode = 1;
}

System.onScriptUnloading() {
	delete menu_Layouts;
	delete tmrDelay;
}

System.onSetXuiParam(String stringParam, String stringValue) {
	if (strlower(stringParam) == "switch") _container = stringValue;
	if (strlower(stringParam) == "layoutids") { 
		layoutstring = stringValue;
		nLayouts = countSubString(layoutstring, ";");
	}
	if (strlower(stringParam) == "rclick") rclick = stringValue;
	if (strlower(stringParam) == "lclick") lclick = stringValue;
	if (strlower(stringParam) == "menuentry") {
		for ( int i = 0; i <= nLayouts; i++ ) {
			string s = getToken(stringValue, ";", i);
			menu_Layouts.addCommand(s, i + 1, 0, 0);
		}
	}
}

btn.onLeftButtonUp(int x, int y) {
bGotContainer = 0;
	if (strsearch(strlower(lclick), "switchto:") >= 0) {
		container c;
		if (_container == "this") c = btn.getParentLayout().getContainer();
		else c = System.getContainer(_container);
		if (c) 
		{
			c.switchToLayout(getToken(lclick, ":", 1));
			bGotContainer = -1;
						
			gotLayoutString = getToken(lclick, ":", 1);

			if(gotLayoutString=="full")
			{
				n = c.getLayout(gotLayoutString);	
				resizeLayout(n);
			}
			if(gotLayoutString=="compact")
			{
				s = c.getLayout(gotLayoutString);
				resizeLayout(s);
			}
			if(gotLayoutString=="stick")
			{
				m = c.getLayout(gotLayoutString);
				resizeLayout(m);
			}
			if(gotLayoutString=="mini")
			{
				v = c.getLayout(gotLayoutString);
				resizeLayout(v);
			}

			if(gotLayoutString=="minivert")
			{
				mv = c.getLayout(gotLayoutString);
				resizeLayout(mv);
			}
			
			
			


		}

		
	} else if (strlower(rclick) != "menu") {
		return;
	} else {
		ProcessMenuResult(menu_Layouts.popAtMouse());
		complete;
	}

}

btn.onRightButtonUp(int x, int y) {
	if (strsearch(strlower(rclick), "switchto:") >= 0) {
		container c;
		if (_container == "this") c = btn.getParentLayout().getContainer();
		else c = System.getContainer(_container);
		if (c) c.switchToLayout(getToken(lclick, ":", 1));
		
	} else if (strlower(rclick) != "menu") {
		return;
	} else {
		ProcessMenuResult(menu_Layouts.popAtMouse());
		complete;
	}

}

ProcessMenuResult(int a) {
bGotContainer = 0;
	if(a > 0) 
	{

		container c;
		if (_container == "this") c = btn.getParentLayout().getContainer();
		else c = System.getContainer(_container);

		if (c)
		{
			bGotContainer = -1;
			c.switchToLayout(getToken(layoutstring, ";", a-1));
			
			gotLayoutString = getToken(layoutstring, ";", a-1);
	
			if(gotLayoutString=="full")
			{
				n = c.getLayout(gotLayoutString);	
				resizeLayout(n);
				return;
			}
			if(gotLayoutString=="compact")
			{
				s = c.getLayout(gotLayoutString);
				resizeLayout(s);
				return;
			}
			if(gotLayoutString=="stick")
			{
				m = c.getLayout(gotLayoutString);
				resizeLayout(m);
				return;
			}
			if(gotLayoutString=="mini")
			{
				v = c.getLayout(gotLayoutString);
				resizeLayout(v);
				return;
			}
			if(gotLayoutString=="minivert")
			{
				mv = c.getLayout(gotLayoutString);
				resizeLayout(mv);
				return;
			}

		}
	
	}
	complete;
}


resizeLayout(layout newlayout)
{
  if (bGotContainer == -1)
  {
	
	if(gotLayoutString=="full")
	{
		nX = getPrivateInt(getSkinName(), "n_X", 0);
		nY = getPrivateInt(getSkinName(), "n_Y", 0);
		newlayout.resize(nX, nY, newlayout.getWidth(), newlayout.getHeight());
		return;
	}

	if(gotLayoutString=="compact")
	{
		sX = getPrivateInt(getSkinName(), "s_X", 0);
		sY = getPrivateInt(getSkinName(), "s_Y", 0);
		newlayout.resize(sX, sY, newlayout.getWidth(), newlayout.getHeight());
		return;
	}

	if(gotLayoutString=="stick")
	{
		mX = getPrivateInt(getSkinName(), "m_X", 0);
		mY = getPrivateInt(getSkinName(), "m_Y", 0);
		newlayout.resize(mX, mY, newlayout.getWidth(), newlayout.getHeight());
		//system.getViewPortHeight()-40
		return;
	}
	
	if(gotLayoutString=="mini")
	{
		vX = getPrivateInt(getSkinName(), "v_X", 100);
		vY = getPrivateInt(getSkinName(), "v_Y", 100);
		newlayout.resize(vX, vY, 198, newlayout.getHeight());
		//is it a bug? catch vert mode as have found it to go awol when switched from mini mode on the odd occasion, normally if values have not been set
		if (vX > (system.getViewPortWidth()-198))
		{
			newlayout.resize(100, 100, 198, newlayout.getHeight());
		}
		//system.getViewPortHeight()-40
		return;
	}

	if(gotLayoutString=="minivert")
	{
		mvX = getPrivateInt(getSkinName(), "mv_X", 100);
		mvY = getPrivateInt(getSkinName(), "mv_Y", 100);
		newlayout.resize(mvX, mvY, 52, 198);
		//is it a bug? catch vert mode as have found it to go awol when switched from mini mode on the odd occasion, normally if values have not been set
		if (mvX > (system.getViewPortWidth()-52))
		{
			newlayout.resize(100, 100, 52, 198);
		}
		return;
	}
	
	
  }

}

n.onEndMove() {
  if (n.isVisible()) {
    setPrivateInt(getSkinName(), "n_X", n.getLeft());
    setPrivateInt(getSkinName(), "n_Y", n.getTop());
  }
}

s.onEndMove() {
  if (s.isVisible()) {
    setPrivateInt(getSkinName(), "s_X", s.getLeft());
    setPrivateInt(getSkinName(), "s_Y", s.getTop());
  }
}

m.onEndMove() {
  if (m.isVisible()) {
    setPrivateInt(getSkinName(), "m_X", m.getLeft());
    setPrivateInt(getSkinName(), "m_Y", m.getTop());
  }
}

mv.onEndMove() {
  if (mv.isVisible()) {
    setPrivateInt(getSkinName(), "mv_X", mv.getLeft());
    setPrivateInt(getSkinName(), "mv_Y", mv.getTop());
  }
}


v.onEndMove() {
  if (v.isVisible()) {
    setPrivateInt(getSkinName(), "v_X", v.getLeft());
    setPrivateInt(getSkinName(), "v_Y", v.getTop());
  }
}

int countSubString(string str, string substr) {
	int n = 0;
	for ( int i = 0; i < 1000; i++ ) {
		int r = strSearch(str, substr);
//#ifdef DEBUG
//		debug(integerToString(r));
//#endif
		if (r == -1) i = 1000;
		else {
			str = strright(str, strlen(str) - (r + 1));
			n++;
		}
	}
	return n;
}

tmrDelay.onTimer()
{
	tmrDelay.stop();
	ProcessMenuResult(iMode); 		

	  	#ifdef DEBUGWINDOWMODE
				DEBUGWINDOW("iMode=" + integertostring(iMode) + " vx=" + integertostring(vX) + " " + integertostring(system.getViewPortWidth()-200));
		#endif
}
System.onKeyDown(string key) 
{ 
  	if(key == "alt+q") 
	{ 
		tmrDelay.start();
		iMode = iMode + 1;
		
		if (iMode>5)
		{
			iMode=1;
		}
  	} 
}
