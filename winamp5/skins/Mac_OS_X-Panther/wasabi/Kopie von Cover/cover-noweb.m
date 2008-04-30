/*---------------------------------------------------
-----------------------------------------------------
Filename:	cover.m

Type:		maki/source
Version:	skin version 1.2
Date:		10:11 30.08.2004
Author:		Martin P. alias Deimos
E-Mail:		martin.deimos@gmx.de
Internet:	www.martin.deimos.de.vu
-----------------------------------------------------
--------------------INCLUDES-------------------------
-Cover Art
-----------------------------------------------------
----------------------NOTE---------------------------
I've written all the script on my own. I was only
inspired by other ones, but I never copied a whole
script or parts of it! 'Cause everyone has to learn
or inspire I implement the source files too.
But if you use parts or the entire script, mail me:
Give me your name, write a little text about your
skin and a skinshot! Then leave my header in the .m
file and implement it in your skin and leave credit
to my name, email and homepage where credit is done!
THX! Deimos
-----------------------------------------------------
---------------------------------------------------*/

#include "../../../../lib/std.mi"
#include "../../scripts/attribs.m"

#define FILENAME "cover.m"
#include "../../../../lib/ripprotection.mi"

#define PIP cover_dirs_pip_attrib.getData() == "1" &&
#define ACP cover_dirs_acp_attrib.getData() == "1" &&

Function UpdateCover();
Function Boolean CoverSearch(string __path);
Function Boolean FileSearch(string __path, string __file);
Function Smooth(Layer Fx);

Global Layer fx;
Global Double rp, dp, tp, ap;
Global Int ef;
Global Layer Next;
Global Layer Cover;
Global AnimatedLayer Dummy;
Global GuiList StatusList;
Global WindowHolder RHolder2;
Global WindowHolder RHolder2avs;
Global Group XUIGroup;

Global Boolean b_isNotifier = 0;

System.onScriptLoaded() {
	initAttribs();

	XUIGroup = getScriptGroup();

	Cover = XUIGroup.findObject("cover.layer");
	Dummy = XUIGroup.findObject("cover.dummy");

	if (!b_isNotifier) {
		RHolder2 = XUIGroup.findObject("holder.cover");
		RHolder2avs = XUIGroup.findObject("holder.avs");

		RHolder2.setXmlParam("autoopen", "1");
		RHolder2avs.setXmlParam("autoopen", "1");

			RHolder2.hide();
			RHolder2avs.hide();
			Cover.show();
	}
	UpdateCover();
	ripProtection("titan");

}

System.onSetXuiParam(String stringParam, String stringValue) {
	if (strlower(stringParam) == "notifier") b_isNotifier = stringToInteger(stringValue);
}

System.onTitleChange(String strNewTitle) {
	if (_2nddrawer_hold_attrib.getData() == "Titan CoverSearch") UpdateCover();
}

Cover.onLeftButtonDown(int x, int y) {
	if (b_isNotifier) return;
	UpdateCover();
	prefs_visible_attrib.setData("1");
	GuiTree _tree = System.getContainer("config").getLayout("normal").findObject("wasabi.preferences.group").findObject("wasabi.preferences.tree.embedded").findObject("mylist");
	_tree.sendAction("switch.to.item", "Drawer.CoverSearch", 0, 0, 0, 0);
}

cover_dirs_pip_attrib.onDataChanged() {
	if (_2nddrawer_hold_attrib.getData() == "Titan CoverSearch") UpdateCover();
}
cover_dirs_acp_attrib.onDataChanged() {
	if (_2nddrawer_hold_attrib.getData() == "Titan CoverSearch") UpdateCover();
}

cover_notfound_givengfx_attrib.onDataChanged() {
	if (_2nddrawer_hold_attrib.getData() == "Titan CoverSearch") UpdateCover();
}
cover_notfound_owngfx_attrib.onDataChanged() {
	if (_2nddrawer_hold_attrib.getData() == "Titan CoverSearch") UpdateCover();
}
cover_notfound_avs_attrib.onDataChanged() {
	if (_2nddrawer_hold_attrib.getData() == "Titan CoverSearch") UpdateCover();
}
cover_notfound_video_attrib.onDataChanged() {
	if (_2nddrawer_hold_attrib.getData() == "Titan CoverSearch") UpdateCover();
}
cover_smooth_attrib.onDataChanged() {
	if (b_isNotifier) return;
	if (Dummy.getLength() == Cover.getWidth() || Dummy.getLength() == 0) return;
	Cover.fx_setEnabled(stringToInteger(getData()));
	if (_2nddrawer_hold_attrib.getData() == "Titan CoverSearch") UpdateCover();
}
notifier_aa_smooth.onDataChanged() {
	if (!b_isNotifier) return;
	if (Dummy.getLength() == Cover.getWidth() || Dummy.getLength() == 0) return;
	Cover.fx_setEnabled(stringToInteger(getData()));
	UpdateCover();
}
XUIGroup.onSetVisible(int isv) {
	UpdateCover();
	if (!b_isNotifier) {
		RHolder2 = XUIGroup.findObject("holder.cover");
		RHolder2avs = XUIGroup.findObject("holder.avs");

		RHolder2.setXmlParam("autoopen", "1");
		RHolder2avs.setXmlParam("autoopen", "1");

		if (_2nddrawer_hold_attrib.getData() == "Video with Cover Plugin") {
			RHolder2avs.hide();
			RHolder2.show();
			Cover.hide();
		}
		if (_2nddrawer_hold_attrib.getData() == "Visualization Plugin") {
			RHolder2.hide();
			RHolder2avs.show();
			Cover.hide();
		}
		if (_2nddrawer_hold_attrib.getData() == "Titan CoverSearch") {
			RHolder2.hide();
			RHolder2avs.hide();
			Cover.show();
		}
	}

}
System.onPlay() {
	if (_2nddrawer_hold_attrib.getData() == "Titan CoverSearch") UpdateCover();
}

Boolean CoverSearch(string __path) {
	string str_artist = "x__y__z__";
	string str_album = "x__y__z__";
	string str_title = "x__y__z__";
	string str_fn = "x__y__z__.mp3";

//.STACKPROT
	if (getPlayItemString() == "file://") return 0;
	if (getPlayItemString() == "") return 0;
//	if (getStatus() == 0) return 0;

	str_artist = getPlayItemMetaDataString("artist");
	str_album = getPlayItemMetaDataString("album");
	str_title = getPlayItemMetaDataString("title");
	str_fn = removePath(getPlayItemMetaDataString("filename"));

	str_fn = strleft(str_fn, strlen(str_fn)-4);

	if (PIP FileSearch(__path, "cover.jpg")) return 1;
	if (PIP FileSearch(__path, "cdcover.jpg")) return 1;
	if (PIP FileSearch(__path, "coverart.jpg")) return 1;
	if (PIP FileSearch(__path, "folder.jpg")) return 1;
	if (PIP FileSearch(__path, "front.jpg")) return 1;
	if (PIP FileSearch(__path, str_album + ".jpg")) return 1;
	if (PIP FileSearch(__path, str_artist + " - " + str_album + ".jpg")) return 1;
	if (PIP FileSearch(__path, str_artist + "-" + str_album + ".jpg")) return 1;
	if (PIP FileSearch(__path, str_artist + " - " + str_title + ".jpg")) return 1;
	if (PIP FileSearch(__path, str_artist + "-" + str_title + ".jpg")) return 1;
	if (PIP FileSearch(__path, str_fn + ".jpg")) return 1;
	if (PIP FileSearch(__path, str_title + ".jpg")) return 1;

//please don't rename this private string - all skins including this script should use the same path!
	__path = getPrivateString("deimos", "CoverSearch.additionalPath", "");

	if (ACP FileSearch(__path, str_artist + " - " + str_album + ".jpg")) return 1;
	if (ACP FileSearch(__path, str_artist + "-" + str_album + ".jpg")) return 1;
	if (ACP FileSearch(__path, str_album + ".jpg")) return 1;
	if (ACP FileSearch(__path, str_artist + " - " + str_title + ".jpg")) return 1;
	if (ACP FileSearch(__path, str_artist + "-" + str_title + ".jpg")) return 1;
	if (ACP FileSearch(__path, str_fn + ".jpg")) return 1;
	if (ACP FileSearch(__path, str_title + ".jpg")) return 1;
	if (ACP FileSearch(__path, str_artist + ".jpg")) return 1;
	else return 0;
}

Boolean FileSearch(string __path, string __file) {
	if (strsearch(__path + "/" + __file, "%") != -1) return 1;
	Dummy.setXMLParam("image", __path + "/" + __file);
	if (Dummy.getLength() == 0) return 0;
	else {
		Cover.fx_setEnabled(0);
		Cover.setXMLParam("image", __path + "/" + __file);
		if (Dummy.getLength() == Cover.getWidth()) return 1;
		if (b_isNotifier && notifier_aa_smooth.getData() == "1") Smooth(Cover);
		if (!b_isNotifier && cover_smooth_attrib.getData() == "1") Smooth(Cover);
		return 1;
	}
}

UpdateCover() {
	string path = getPath(getPlayItemString());
	string rpath = strright(path, strlen(path) - 7);

	RHolder2avs.hide();
	RHolder2.hide();

	if (!CoverSearch(rpath)) {

		if (b_isNotifier) return;
		if (cover_notfound_givengfx_attrib.getData() == "1") Cover.setXMLParam("image", "");
		if (cover_notfound_owngfx_attrib.getData() == "1") Cover.setXMLParam("image", getPrivateString("deimos", "CoverSearch.pixPath", ""));
		if (cover_notfound_avs_attrib.getData() == "1") RHolder2avs.show();
		if (cover_notfound_video_attrib.getData() == "1") RHolder2.show();
	}
}

_2nddrawer_hold_attrib.onDataChanged() {
	if (b_isNotifier) return;
	RHolder2.setXmlParam("autoopen", "1");
	RHolder2avs.setXmlParam("autoopen", "1");
	if (getData() == "Video with Cover Plugin") {
		RHolder2avs.hide();
		RHolder2.show();
		Cover.hide();
	}
	if (getData() == "Visualization Plugin") {
		RHolder2.hide();
		RHolder2avs.show();
		Cover.hide();
	}
	if (getData() == "Titan CoverSearch") {
		RHolder2.hide();
		RHolder2avs.hide();
		Cover.show();
	}
}

Smooth(Layer Fx) {
  Fx.fx_setEnabled(1);
  Fx.fx_setBgFx(0);
  Fx.fx_setWrap(0);
  Fx.fx_setBilinear(1);
  Fx.fx_setAlphaMode(0);
  Fx.fx_setGridSize(1,1);
  Fx.fx_setRect(0);
  Fx.fx_setClear(0);
  Fx.fx_setLocalized(1);
  Fx.fx_setRealtime(0);
  Fx.fx_setSpeed(0);
}

