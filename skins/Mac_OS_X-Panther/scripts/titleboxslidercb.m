#include <lib/std.mi>
#include <lib/config.mi>

Global Slider slidercb;
Global Text titletext;
Global String prefix, one, many;
Global Group pgroup;
Global GuiObject targetbase;
Global ConfigAttribute ca_slider;
Global Boolean nocfgval;

System.onScriptLoaded() {

  // we only run in groups!
  pgroup = getScriptGroup();
  if (pgroup == NULL) return;

  String par = getParam();

  String gid = getToken(par, ";", 0);

  // if the base group isnt there or doesn't have a titlebox.text object, abort
  targetbase = pgroup.findObject(gid);
  if (targetbase == NULL) {
    messageBox("titleboxslidercm.make : targetbase not found (param 0 = " + gid + ")", "Error", 0, "");
    return;
  }

  titletext = targetbase.findObject("titlebox.text");
  if (titletext == NULL) {
    messageBox("titleboxslidercm.make : titlebox.text not found", "Error", 0, "");
    return;
  }

  String id = getToken(par, ";", 1);
  prefix = getToken(par, ";", 2);
  one = getToken(par, ";", 3);
  many = getToken(par, ";", 4);
  if (many == "") many = one;

  slidercb = targetbase.findObject(id);
  if (slidercb == NULL) {
    messageBox("titleboxslidercm.make : slidercb not found (param 1 = " + id + ")", "Error", 0, "");
    return;
  }

  slidercb.onSetPosition(slidercb.getPosition());
  
  string canstr = "";
  canstr = getToken(par, ";", 5);
 
  if (canstr != "") {
  	ca_slider = Config.getItemByGuid(getToken(canstr, "|", 0)).getAttribute(getToken(canstr, "|", 1));
	nocfgval = 0;
  } else {
    ca_slider = Config.getItemByGuid("{F1239F09-8CC6-4081-8519-C2AE99FCB14C}").getAttribute("Crossfade time");
    nocfgval = 1;
  }
}

ca_slider.onDataChanged() {
  if (nocfgval) {
  	return;
  }
  slidercb.onSetPosition(stringToInteger(getData()));
}

slidercb.onSetPosition(int val) {
  String s = prefix + IntegerToString(val);
  if (val > 1) s = s + many; else s = s + one;
  targetbase.setXmlParam("suffix", s);
}
