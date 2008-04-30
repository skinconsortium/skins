#include "../../../lib/std.mi"
#include "../../../lib/config.mi"

#define GET_HOVER_MODE stringToInteger(ca_gbmode.getData())

Function causeGlow(int mode, boolean reverse);

Global Button genericButton;
Global layer hoverLayer;
Global ConfigAttribute ca_gbmode;
Global Group genericGroup;
Global Boolean hideonplay = 0;

System.onScriptLoaded() {
	hideonplay = 0;
	genericGroup=getScriptGroup();
	ca_gbmode = Config.getItemByGuid("{E9C2D926-53CA-400f-9A4D-85E31755A4CF}").getAttribute("Vortex_Glowmode");
	genericButton=genericGroup.getObject("generic.button");
	hoverLayer=genericGroup.getObject("hover.layer");
}

System.onSetXuiParam(String param, String value) {
	param = strlower(param);
	if(param=="hideonplay") {
		hideonplay = 1;
		if (System.getStatus() == 1)
		{
			genericGroup.hide();
		}
	}
	if(param=="bimage") {
		genericButton.setXMLParam("image", value);
	} else if(param=="bimaged") {
		genericButton.setXMLParam("downimage", value);
	} else if(param=="bimageh") {
		genericButton.setXMLParam("hoverimage", value);
	} else if(param=="bimagea") {
		genericButton.setXMLParam("activeimage", value);
	} else if(param=="action") {
		genericButton.setXMLParam("action", value);
	} else if(param=="param"){ 
		genericButton.setXMLParam("param", value);
	} else if(param=="rectrgn") {
		genericButton.setXMLParam("rectrgn", value);
		hoverLayer.setXMLParam("rectrgn", value);
	} else if(param=="himage") {
		hoverlayer.setXMLParam("image", value);
	} else if(param=="region") {
		hoverLayer.setXMLParam("region", value);
	} else if(param="adjustX") {
		hoverLayer.setXMLParam("x", integerToString(stringToInteger(hoverLayer.getXMLParam("x")) + stringToInteger(value)));
	} else if(param="adjustY") {
		hoverLayer.setXMLParam("y", integerToString(stringToInteger(hoverLayer.getXMLParam("y")) + stringToInteger(value)));
	} else if(param=="tooltip") {
		genericButton.setXMLParam("tooltip", value);
		hoverLayer.setXMLParam("tooltip", value);
	}

	hoverLayer.setXMLParam("ghost", "1");
}

System.onPlay ()
{
	if (hideonplay == 1) genericGroup.hide();
}
System.onPause ()
{
	if (hideonplay == 1) genericGroup.show();
}
System.onStop ()
{
	if (hideonplay == 1) genericGroup.show();
}
System.onResume ()
{
	if (hideonplay == 1) genericGroup.hide();
}


hoverLayer.onEnterArea() {causeGlow(GET_HOVER_MODE, 0);}   //;
hoverLayer.onLeaveArea() {causeGlow(GET_HOVER_MODE, 1);}   //;

genericButton.onEnterArea() {causeGlow(GET_HOVER_MODE, 0);} //;
genericButton.onLeaveArea() {causeGlow(GET_HOVER_MODE, 1);} //;

causeGlow(int mode, boolean reverse) {
	if(mode==0) return;
	if(mode==1) {
		if(reverse) {
			hoverLayer.cancelTarget();
			hoverLayer.setTargetA(0);
			hoverLayer.setTargetSpeed(1);
			hoverLayer.gotoTarget();
		} else {
			hoverLayer.cancelTarget();
			hoverLayer.setAlpha(255);
		}
	} else if(mode==2) {
		if(reverse) {
			hoverLayer.cancelTarget();
			hoverLayer.setTargetA(0);
			hoverLayer.setTargetSpeed(0.5);
			hoverLayer.gotoTarget();
		} else {
			hoverLayer.cancelTarget();
			hoverLayer.setTargetA(255);
			hoverLayer.setTargetSpeed(0.5);
			hoverLayer.gotoTarget();
		}
	} else if(mode==3) {
		if(reverse) {
			hoverLayer.cancelTarget();
			hoverLayer.setAlpha(0);
		} else {
			hoverLayer.cancelTarget();
			hoverLayer.setTargetA(255);
			hoverLayer.setTargetSpeed(0.5);
			hoverLayer.gotoTarget();
		}
	}
}