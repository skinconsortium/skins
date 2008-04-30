#include "../../../lib/std.mi"
#include "../../../lib/config.mi"

#define GET_HOVER_MODE stringToInteger(ca_gbmode.getData())

Function causeGlow(int mode, boolean reverse);

Global toggleButton genericButton;
Global layer hoverLayer;
Global ConfigAttribute ca_gbmode;

System.onScriptLoaded() {
	Group genericGroup=getScriptGroup();
	ca_gbmode = Config.getItemByGuid("{E9C2D926-53CA-400f-9A4D-85E31755A4CF}").getAttribute("Vortex_Glowmode");
	genericButton=genericGroup.getObject("generic.button");
	hoverLayer=genericGroup.getObject("hover.layer");
}

System.onSetXuiParam(String param, String value) {
	if(param=="bImage") {
		genericButton.setXMLParam("image", value);
	}

	if(param=="bImageD") {
		genericButton.setXMLParam("downimage", value);
	}

	if(param=="bImageH") {
		genericButton.setXMLParam("hoverimage", value);
	}

	if(param=="bImageA") {
		genericButton.setXMLParam("activeimage", value);
	}

	if(param=="action") {
		genericButton.setXMLParam("action", value);
	}

	if(param=="param"){ 
		genericButton.setXMLParam("param", value);
	}

	if(param=="rectrgn") {
		genericButton.setXMLParam("rectrgn", value);
		hoverLayer.setXMLParam("rectrgn", value);
	}

	if(param=="hImage") {
		hoverlayer.setXMLParam("image", value);
	}

	if(param=="region") {
		hoverLayer.setXMLParam("region", value);
	}

	if(param="adjustX") {
		hoverLayer.setXMLParam("x", integerToString(stringToInteger(hoverLayer.getXMLParam("x")) + stringToInteger(value)));
	}

	if(param="adjustY") {
		hoverLayer.setXMLParam("y", integerToString(stringToInteger(hoverLayer.getXMLParam("y")) + stringToInteger(value)));
	}

	if(param=="tooltip") {
		genericButton.setXMLParam("tooltip", value);
		hoverLayer.setXMLParam("tooltip", value);
	}

	if(param=="cfgattrib") {
		genericButton.setXMLParam("cfgattrib", value);
	}

	if(param=="cfgval") {
		genericButton.setXMLParam("cfgval", value);
	}

	hoverLayer.setXMLParam("ghost", "1");
}

hoverLayer.onEnterArea() {causeGlow(GET_HOVER_MODE, 0); }   //;
hoverLayer.onLeaveArea() {causeGlow(GET_HOVER_MODE, 1); }   //;

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
		} else if(!reverse) {
			hoverLayer.setAlpha(255);
		}
	} else if(mode==2) {
		if(reverse) {
			hoverLayer.cancelTarget();
			hoverLayer.setTargetA(0);
			hoverLayer.setTargetSpeed(0.5);
			hoverLayer.gotoTarget();
		} else if(!reverse) {
			hoverLayer.cancelTarget();
			hoverLayer.setTargetA(255);
			hoverLayer.setTargetSpeed(0.5);
			hoverLayer.gotoTarget();
		}
	} else if(mode==3) {
		if(reverse) {
			hoverLayer.setAlpha(0);
		} else if(!reverse) {
			hoverLayer.cancelTarget();
			hoverLayer.setTargetA(255);
			hoverLayer.setTargetSpeed(0.5);
			hoverLayer.gotoTarget();
		}
	}
}