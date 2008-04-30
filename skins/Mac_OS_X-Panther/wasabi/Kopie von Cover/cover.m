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
#include "../../../../lib/exd.mi"
#include "../../scripts/attribs.m"

#define FILENAME "cover.m"
#include "../../../../lib/ripprotection.mi"

#define PIP cover_dirs_pip_attrib.getData() == "1"
#define ACP cover_dirs_acp_attrib.getData() == "1"
#define WEB cover_web_attrib.getData() == "1"

Function UpdateCover(Boolean nowebresult);
Function Int CoverSearch(string __path);
Function Boolean FileSearch(string __path, string __file);
Function Smooth(Layer Fx);
Function StartWebSearch();
Function fitBrowser(Boolean visible);
Function Boolean fs(string s, string u);
Function ProcessMenuResult(int a);

Global Layer fx;
Global Double rp, dp, tp, ap;
Global Int ef;
Global Layer Next;
Global Layer Cover, Cover2;
Global AnimatedLayer Dummy;
Global WindowHolder RHolder2;
Global WindowHolder RHolder2avs;
Global Group XUIGroup;
Global Browser coverbrowser;
Global String str_url, str_path;

Global Boolean b_isNotifier = 0;
Global Boolean cover2isbehind = 1;

Global PopupMenu menu_Cover;

System.onScriptLoaded() {
	initAttribs();

	XUIGroup = getScriptGroup();

	Cover = XUIGroup.findObject("cover.layer");
	Cover2 = XUIGroup.findObject("cover.layer2");
	Dummy = XUIGroup.findObject("cover.dummy");

	coverbrowser = XUIGroup.findObject("browser.cdcover");
	str_url = getPrivateString("Deimos/CoverSearch/", "amazon.com_htmlpath", "");
//	str_url = "http://home.arcor.de/martin.deimos/CoverSearch";

	menu_Cover = new PopupMenu;
	menu_Cover.addCommand("Cover Search", 666, 0, 1);
	menu_Cover.addSeparator();
	menu_Cover.addCommand("Reload Cover", 1, 0, 0);
	menu_Cover.addCommand("Open Cover Directory", 2, 0, 0);
	menu_Cover.addCommand("Preferences...",3, 0, 0);

	if (!b_isNotifier) {
		RHolder2 = XUIGroup.findObject("holder.cover");
		RHolder2avs = XUIGroup.findObject("holder.avs");

		RHolder2.setXmlParam("autoopen", "1");
		RHolder2avs.setXmlParam("autoopen", "1");

		Cover.show();
	}
	cover_web_attrib.onDataChanged();
	UpdateCover(0);
	ripProtection("panther");

}

System.onScriptUnloading() {
	coverbrowser.navigateURl("about:blank");
	delete menu_Cover;
}

System.onSetXuiParam(String stringParam, String stringValue) {
	if (strlower(stringParam) == "notifier") b_isNotifier = stringToInteger(stringValue);
}

System.onTitleChange(String strNewTitle) {
	UpdateCover(0);
}

Cover.onLeftButtonUp(int x, int y) {
	if (b_isNotifier) return;
	ProcessMenuResult(menu_Cover.popAtMouse());

}

Cover2.onLeftButtonUp(int x, int y) {
	if (b_isNotifier) return;
	ProcessMenuResult(menu_Cover.popAtMouse());

}

ProcessMenuResult(int a) {
	if(a > 0) {
		if (a == 1) {
			UpdateCover(0);
		}
		if (a == 2) {
			 navigateUrl(getPrivateString("Deimos/CoverSearch/", "additionalPath", ""));
		}
		if (a == 3) {
			prefs_visible_attrib.setData("1");
			GuiTree _tree = System.getContainer("config").getLayout("normal").findObject("wasabi.preferences.group").findObject("wasabi.preferences.tree.embedded").findObject("mylist");
			_tree.sendAction("switchToItem", "Cover Search", 0, 0, 0, 0);
		}
	}
}

cover_dirs_pip_attrib.onDataChanged() {
	UpdateCover(0);
}
cover_dirs_acp_attrib.onDataChanged() {
	UpdateCover(0);
}
cover_web_attrib.onDataChanged() {
	if (getPrivateString("Deimos/CoverSearch/", "amazon.com_htmlpath", "") == "" && getData() == "1") {
		int i_answer = messageBox("You haven't configured the CoverSearch via Amazon.com!\nWill you do this now?" , "ERROR", 12, "");
		if (i_answer = 4) {
			prefs_visible_attrib.setData("1");
			GuiTree _tree = System.getContainer("config").getLayout("normal").findObject("wasabi.preferences.group").findObject("wasabi.preferences.tree.embedded").findObject("mylist");
			_tree.sendAction("switchToItem", "Amazon.com Config", 0, 0, 0, 0);
		}
		setData("0");
		return;
	}
	UpdateCover(0);
}

cover_notfound_givengfx_attrib.onDataChanged() {
	UpdateCover(0);
}
cover_notfound_owngfx_attrib.onDataChanged() {
	UpdateCover(0);
}
cover_notfound_avs_attrib.onDataChanged() {
	UpdateCover(0);
}
cover_notfound_video_attrib.onDataChanged() {
	UpdateCover(0);
}
cover_smooth_attrib.onDataChanged() {
	if (b_isNotifier) return;
	if (Dummy.getLength() == Cover.getWidth() || Dummy.getLength() == 0) return;
	Cover.fx_setEnabled(stringToInteger(getData()));
	UpdateCover(0);
}
notifier_aa_smooth.onDataChanged() {
	if (!b_isNotifier) return;
	if (Dummy.getLength() == Cover.getWidth() || Dummy.getLength() == 0) return;
	Cover.fx_setEnabled(stringToInteger(getData()));
	UpdateCover(0);
}
XUIGroup.onSetVisible(int isv) {
	UpdateCover(0);
	if (!b_isNotifier) {
		RHolder2 = XUIGroup.findObject("holder.cover");
		RHolder2avs = XUIGroup.findObject("holder.avs");

		RHolder2.setXmlParam("autoopen", "1");
		RHolder2avs.setXmlParam("autoopen", "1");

		Cover.show();
	}

}
System.onPlay() {
	UpdateCover(0);
}

Int CoverSearch(string __path) {
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

	if (PIP) {
		if (FileSearch(__path, "cover.jpg")) return 1;
		if (FileSearch(__path, "cdcover.jpg")) return 1;
		if (FileSearch(__path, "coverart.jpg")) return 1;
		if (FileSearch(__path, "folder.jpg")) return 1;
		if (FileSearch(__path, "front.jpg")) return 1;
		if (FileSearch(__path, str_album + ".jpg")) return 1;
		if (FileSearch(__path, str_artist + " - " + str_album + ".jpg")) return 1;
		if (FileSearch(__path, str_artist + "-" + str_album + ".jpg")) return 1;
		if (FileSearch(__path, str_artist + " - " + str_title + ".jpg")) return 1;
		if (FileSearch(__path, str_artist + "-" + str_title + ".jpg")) return 1;
		if (FileSearch(__path, str_fn + ".jpg")) return 1;
		if (FileSearch(__path, str_title + ".jpg")) return 1;
	}
//please don't rename this private string - all skins including this script should use the same path!
	__path = getPrivateString("Deimos/CoverSearch/", "additionalPath", "");

	if (ACP) {
		if (FileSearch(__path, str_artist + " - " + str_album + ".jpg")) return 1;
		if (FileSearch(__path, str_artist + "-" + str_album + ".jpg")) return 1;
		if (FileSearch(__path, str_album + ".jpg")) return 1;
		if (FileSearch(__path, str_artist + " - " + str_title + ".jpg")) return 1;
		if (FileSearch(__path, str_artist + "-" + str_title + ".jpg")) return 1;
		if (FileSearch(__path, str_fn + ".jpg")) return 1;
		if (FileSearch(__path, str_title + ".jpg")) return 1;
		if (FileSearch(__path, str_artist + ".jpg")) return 1;
	}

	if (WEB) {
		startWebSearch();
		return 2;
	}			
	else return 0;
}

Boolean fs(string s, string u) {
	if (strsearch(s, u) == -1) {
		return 0;
	} else return 1;
}

Boolean FileSearch(string __path, string __file) {
	if (strsearch(__path + "/" + __file, "%") != -1) return 0;

	int nitems = getPrivateInt("Deimos/CoverSearch/StringReplace/", "nitems", 1);

	for ( int i = 0; i < nitems; i++ ) {
		string itemstring = getPrivateString("Deimos/CoverSearch/StringReplace/Items/", "String" + integerToString(i), "AC/DC");
		string replacestring = getPrivateString("Deimos/CoverSearch/StringReplace/Items/", "ReplaceString" + integerToString(i), "ACDC");

		if (fs(__file, itemstring)) {
			string strep = replacestring;
			__file = replaceString(__file, itemstring, strep);
			//messageBox(integerToString(nitems + i) + __file + strep, "Rip Protection", 1, "");
		}		
	}

	Dummy.setXMLParam("image", __path + "/" + __file);
	if (Dummy.getLength() == 0) return 0;
	else {
		str_path = __path + "/" + __file;
		if (b_isNotifier) {
			if (str_path == Cover.getXmlParam("image")) return 1;
			Cover.fx_setEnabled(0);
			Cover.setXMLParam("image", str_path);
			if (b_isNotifier && notifier_aa_smooth.getData() == "1") {
				Smooth(Cover);
				return 1;
			}
			return 1;
		}
		if (cover2isbehind) {
			if (str_path == Cover.getXmlParam("image")) return 1;
			Cover2.fx_setEnabled(0);
			Cover2.setXMLParam("image", str_path);
			Cover.setTargetA(0);
			Cover.setTargetSpeed(0.5);
			Cover.gotoTarget();
			if (Dummy.getLength() == Cover2.getWidth()) return 1;
			if (!b_isNotifier && cover_smooth_attrib.getData() == "1") Smooth(Cover2);
			return 1;		
		} else if (!cover2isbehind) {
			if (str_path == Cover2.getXmlParam("image")) return 1;
			Cover.fx_setEnabled(0);
			Cover.setXMLParam("image", str_path);
			Cover2.setTargetA(0);
			Cover2.setTargetSpeed(0.5);
			Cover2.gotoTarget();
			if (Dummy.getLength() == Cover.getWidth()) return 1;
			if (!b_isNotifier && cover_smooth_attrib.getData() == "1") Smooth(Cover);
			return 1;		
		}
	}
}

Cover.onTargetReached() {
	cover2isbehind = 0;
	Cover2.bringToFront();
	Cover.setAlpha(255);
}
Cover2.onTargetReached() {
	cover2isbehind = 1;
	Cover.bringToFront();
	Cover2.setAlpha(255);
}

startWebSearch() {
	String strQuery = "";
	String strArtist = System.getPlayitemMetaDataString("artist");
	String strAlbum = System.getPlayitemMetaDataString("album");
	
	if (strArtist != "") strQuery += strArtist + " ";
	if (strAlbum != "") strQuery += strAlbum;

	coverbrowser.show();
	fitBrowser(1);
	str_url = getPrivateString("Deimos/CoverSearch/", "amazon.com_htmlpath", "");
//	str_url = "http://home.arcor.de/martin.deimos/CoverSearch";
	if (b_isNotifier) coverbrowser.navigateURL(str_url + "\cdcover_notif.maki?" + System.urlEncode(strQuery));
	else coverbrowser.navigateURL(str_url + "\cdcover.maki?" + System.urlEncode(strQuery));
}

coverbrowser.onDocumentComplete(String strURL) {
	if (System.strSearch(strURL, ".maki?RETURN___NO_RESULTS") > -1) {
		fitBrowser(0);
		UpdateCover(1);
	}
}

UpdateCover(Boolean nowebresult) {
	if (nowebresult) {
		if (b_isNotifier) return;
		if (cover_notfound_givengfx_attrib.getData() == "1") {
/*			str_path = "";
			if (cover2isbehind) {
				if (Cover.getXmlParam("image") == "") return;
				Cover2.fx_setEnabled(0);
				Cover2.setXMLParam("image", "");
				Cover.setTargetA(0);
				Cover.setTargetSpeed(0.5);
				Cover.gotoTarget();
			} else if (!cover2isbehind) {
				if (Cover.getXmlParam("image") == "") return;
				Cover.fx_setEnabled(0);
				Cover.setXMLParam("image", "");
				Cover2.setTargetA(0);
				Cover2.setTargetSpeed(0.5);
				Cover2.gotoTarget();
			}*/
			Cover.setXMLParam("image", "");
			Cover2.setXMLParam("image", "");
		}
		if (cover_notfound_owngfx_attrib.getData() == "1") {
/*			str_path = getPrivateString("deimos", "CoverSearch.pixPath", "");
			if (cover2isbehind) {
				if (getPrivateString("deimos", "CoverSearch.pixPath", "") == Cover.getXmlParam("image")) return;
				Cover2.fx_setEnabled(0);
				Cover2.setXMLParam("image", getPrivateString("deimos", "CoverSearch.pixPath", ""));
				Cover.setTargetA(0);
				Cover.setTargetSpeed(0.5);
				Cover.gotoTarget();
			} else if (!cover2isbehind) {
				if (getPrivateString("deimos", "CoverSearch.pixPath", "") == Cover2.getXmlParam("image")) return;
				Cover.fx_setEnabled(0);
				Cover.setXMLParam("image", getPrivateString("deimos", "CoverSearch.pixPath", ""));
				Cover2.setTargetA(0);
				Cover2.setTargetSpeed(0.5);
				Cover2.gotoTarget();
			}*/
			Cover.setXMLParam("image", getPrivateString("Deimos/CoverSearch/", "pixPath", ""));
			Cover2.setXMLParam("image", getPrivateString("Deimos/CoverSearch/", "pixPath", ""));
		}
		if (cover_notfound_avs_attrib.getData() == "1") RHolder2avs.show();
		if (cover_notfound_video_attrib.getData() == "1") RHolder2.show();
		return;
	}

	string path = getPath(getPlayItemString());
	string rpath = strright(path, strlen(path) - 7);

	RHolder2avs.hide();
	RHolder2.hide();
	int res = CoverSearch(rpath);
	if (res != 2) coverbrowser.hide();
	if (res == 1) return;
	if (res == 0) {

		if (b_isNotifier) return;
		if (cover_notfound_givengfx_attrib.getData() == "1") {
/*			str_path = "";
			if (cover2isbehind) {
				if (Cover.getXmlParam("image") == "") return;
				Cover2.fx_setEnabled(0);
				Cover2.setXMLParam("image", "");
				Cover.setTargetA(0);
				Cover.setTargetSpeed(0.5);
				Cover.gotoTarget();
			} else if (!cover2isbehind) {
				if (Cover.getXmlParam("image") == "") return;
				Cover.fx_setEnabled(0);
				Cover.setXMLParam("image", "");
				Cover2.setTargetA(0);
				Cover2.setTargetSpeed(0.5);
				Cover2.gotoTarget();
			}*/
			Cover.setXMLParam("image", "");
			Cover2.setXMLParam("image", "");
		}
		if (cover_notfound_owngfx_attrib.getData() == "1") {
/*			str_path = getPrivateString("deimos", "CoverSearch.pixPath", "");
			if (cover2isbehind) {
				if (getPrivateString("deimos", "CoverSearch.pixPath", "") == Cover.getXmlParam("image")) return;
				Cover2.fx_setEnabled(0);
				Cover2.setXMLParam("image", getPrivateString("deimos", "CoverSearch.pixPath", ""));
				Cover.setTargetA(0);
				Cover.setTargetSpeed(0.5);
				Cover.gotoTarget();
			} else if (!cover2isbehind) {
				if (getPrivateString("deimos", "CoverSearch.pixPath", "") == Cover2.getXmlParam("image")) return;
				Cover.fx_setEnabled(0);
				Cover.setXMLParam("image", getPrivateString("deimos", "CoverSearch.pixPath", ""));
				Cover2.setTargetA(0);
				Cover2.setTargetSpeed(0.5);
				Cover2.gotoTarget();
			}*/
			Cover.setXMLParam("image", getPrivateString("Deimos/CoverSearch/", "pixPath", ""));
			Cover2.setXMLParam("image", getPrivateString("Deimos/CoverSearch/", "pixPath", ""));
		}
		if (cover_notfound_avs_attrib.getData() == "1") RHolder2avs.show();
		if (cover_notfound_video_attrib.getData() == "1") RHolder2.show();
	}
}

fitBrowser(Boolean visible) {
	if (b_isNotifier) return;
	if (!visible) {
		coverbrowser.setXmlParam("relath", "0");
		coverbrowser.setXmlParam("relatw", "0");
		coverbrowser.setXmlParam("h", "1");
		coverbrowser.setXmlParam("w", "1");
	} else {
		coverbrowser.setXmlParam("relath", "1");
		coverbrowser.setXmlParam("relatw", "1");
		coverbrowser.setXmlParam("h", "0");
		coverbrowser.setXmlParam("w", "0");
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

