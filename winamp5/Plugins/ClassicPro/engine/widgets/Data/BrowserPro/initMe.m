/*
This file is used to do the job of the main.maki script when that script haven't been loaded yet.
The main.maki script have read the string on a previous run so this script just use that without loading
the widget again.

Basically a little work around ;)
*/

#include <lib/std.mi>
#include <lib/cprowidget.mi>
#include "convert_address.mi"

Function surfSelected();

Global Layout mainLayout;
Global GuiObject browserXUI;

System.onShowLayout(Layout _layout){
	mainLayout = getContainer("main").getLayout("normal");
	if(mainLayout==_layout && !getPublicInt("ClassicPro.BrowserPro.loaded", 0)){
		initWidget();
		browserXUI = mainLayout.findObject("cpro.browser");
		
		if(getPublicInt("cPro.lastComponentPage", 0)==3 && getPublicInt("ClassicPro.BrowserPro.enabled", 0)){
			surfSelected();
		}
	}
}

browserXUI.onSetVisible(boolean onOff){
	if(onOff && getPublicInt("ClassicPro.BrowserPro.enabled", 0) && !getPublicInt("ClassicPro.BrowserPro.loaded", 0)){
		surfSelected();
	}
}

surfSelected(){
	if(getContainer("main").getCurLayout() != mainLayout) return;
	cpro_sui = getContainer("main").getLayout("normal").findObject("cpro.sui");
	String myUrl = getPublicString("ClassicPro.BrowserPro.lastselected", "about:blank");
	gotoBrowserUrl(prepareCustomUrl(myUrl));
}

System.onTitleChange(String newtitle){
	if(getPublicInt("ClassicPro.BrowserPro.enabled", 0) && !getPublicInt("ClassicPro.BrowserPro.loaded", 0)){
		if(getPublicInt("ClassicPro.BrowserPro.opentab", 0)){
			surfSelected();
		}
		else if(getPublicInt("cPro.lastComponentPage", 0)==3){
			surfSelected();
		}
	}
}