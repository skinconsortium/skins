#include <lib/std.mi>
#include attribs/init_Autoresize.m

Global Group frameGroup;
Global Button goBig, goSmall;
Global Layer topLayer;
Global boolean doubleClick, docked;

Global Container player;
Global Layout normal;

System.onScriptLoaded() {
	initAttribs_Autoresize();

	player = System.getContainer("main");
	normal = player.getLayout("normal");

	frameGroup = getScriptGroup();
	goBig = frameGroup.findObject("main.goBig");
	goSmall = frameGroup.findObject("main.goSmall");
	topLayer = frameGroup.findObject("doubleclick");
	doubleClick=false;

	double newscalevalue = normal.getScale();
	normal.setXmlParam("maximum_w", integerToString(getViewPortWidthfromGuiObject(normal)/newscalevalue));
	normal.setXmlParam("maximum_h", integerToString(getViewPortHeightfromGuiObject(normal)/newscalevalue));
	
	if(getPublicInt("cPro.maximized", 0)==0){
		goBig.show();
		goSmall.hide();
		frameGroup.setXmlParam("lockminmax", "0");
	}
	else{
		goBig.hide();
		goSmall.show();
		frameGroup.setXmlParam("lockminmax", "1");
	}
}

normal.onScale (Double newscalevalue){
	if (normal != player.getCurLayout()) return;
	normal.setXmlParam("maximum_w", integerToString(getViewPortWidthfromGuiObject(normal)/newscalevalue));
	normal.setXmlParam("maximum_h", integerToString(getViewPortHeightfromGuiObject(normal)/newscalevalue));
	
	if(getPublicInt("cPro.maximized", 0)==1){
		normal.resize(getViewPortLeftfromGuiObject(normal), getViewPortTopfromGuiObject(normal), getViewPortWidthfromGuiObject(normal)/newscalevalue, getViewPortHeightfromGuiObject(normal)/newscalevalue);
	}
}

goBig.onLeftClick(){
	if(docked) return;

	setPublicInt("cPro.playerX", normal.getLeft());
	setPublicInt("cPro.playerY", normal.getTop());
	setPublicInt("cPro.playerW", normal.getWidth());
	setPublicInt("cPro.playerH", normal.getHeight());
	goBig.hide();
	goSmall.show();
	
	double newscalevalue = normal.getScale();
	normal.resize(getViewPortLeftfromGuiObject(normal), getViewPortTopfromGuiObject(normal), getViewPortWidthfromGuiObject(normal)/newscalevalue, getViewPortHeightfromGuiObject(normal)/newscalevalue);

	setPublicInt("cPro.maximized", 1);
	frameGroup.setXmlParam("lockminmax", "1");
}

goSmall.onLeftClick(){
	if(docked) return;

	goBig.show();
	goSmall.hide();
	frameGroup.resize (getPublicInt("cPro.playerX", 50), getPublicInt("cPro.playerY", 50), getPublicInt("cPro.playerW", 50), getPublicInt("cPro.playerH", 50));
	setPublicInt("cPro.maximized", 0);
	frameGroup.setXmlParam("lockminmax", "0");
}

topLayer.onLeftButtonUp(int x, int y){
	if(doubleClick){
		if(titlebar_dblclk_max_attib.getData() == "1"){
			if(goBig.isVisible()){
				goBig.leftClick();
			}
			else{
				goSmall.leftClick();
			}
		}
		else{
			player.switchToLayout("shade");
		}
	}
	doubleClick=false;
}

topLayer.onLeftButtonDblClk(int x, int y){
	doubleClick=true;
}


/*
pjn - martin here is the new stuff ;)
This is because I dont want the button to work when docked.
*/
normal.onDock(){
	docked=true;
}

normal.onUndock(){
	docked=false;
}