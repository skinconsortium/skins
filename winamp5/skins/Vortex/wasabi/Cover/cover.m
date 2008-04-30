 /*---------------------------------------------------
-----------------------------------------------------
Filename:	cover.m
Version:	CoverSearch 1.5

Type:		maki/source
Date:		10:11 30.08.2004
Author:		Martin P. alias Deimos
E-Mail:		martin.deimos@gmx.de
Internet:	www.martin.deimos.de.vu
-----------------------------------------------------
---------------------------------------------------*/

#include "../../../../lib/std.mi"
#include "../../../../lib/exd.mi"
#include "../../scripts/attribs.m"

#define FILENAME "cover.m"
#include "../ripprotection.mi"

#include "../mspp/msppver.m"

#define ENSURE_MSPP getPrivateInt("mspp", neededMSPP_Version(), 0) != 0
#define MSPP_PATH getPrivateString("mspp", "Path", "")

#define PIP cover_dirs_pip_attrib.getData() == "1"
#define ACP cover_dirs_acp_attrib.getData() == "1"
#define WEB cover_web_attrib.getData() == "1"
#define SLD cover_dirs_sld_attrib.getData() == "1"

#define PLAYITEMDIR strright(getPath(getPlayitemString()), strlen(getPath(getPlayitemString())) - 7)

Function UpdateCover(Boolean nowebresult);
Function Int CoverSearch(string __path);
Function Boolean FileSearch(string __path, string __file);
Function Smooth(Layer Fx);
Function StartWebSearch();
Function fitBrowser(Boolean visible);
Function fitClayers(Layer l, String pic);
Function Boolean fs(string s, string u);
Function ProcessMenuResult(int a);
Function getImageH(string pic);
Function getImageW(string pic);

Global Layer fx;
Global Double rp, dp, tp, ap;
Global Int ef;
Global Layer Next;
Global Layer Cover, Cover2, c_status, c_bg;
Global Map Dummy;
Global String covername;

Global Group XUIGroup;
Global Browser coverbrowser;
Global String str_url, str_path;

Global Boolean b_isNotifier = 0;
Global Boolean b_resizewnd = 0;
Global Boolean cover2isbehind = 1;
Global Boolean haswebresult = 0;

Global PopupMenu menu_Cover;
Global int addh, addw;

Global Layout coverwnd;
Global String defaultbg;
Global Group clayers;

Global int count = 0;

Global Layer trigger;

Global browser brw;
Global String covers;
Global timer tmr;
Global int Count = 1, max = 1, ready = 1;
Global string lastpath;

System.onScriptLoaded() {
	initAttribs();

	XUIGroup = getScriptGroup();

	clayers = XUIGroup.findObject("coverart.layers");

	Cover = clayers.findObject("cover.layer");
	Cover2 = clayers.findObject("cover.layer2");
	trigger = clayers.findObject("trigger");
	c_status = XUIGroup.findObject("cover.status");
	c_bg = XUIGroup.findObject("cover.background");
	defaultbg = c_bg.getXMLParam("image");

	c_bg.setXMLParam("image", defaultbg);
	if (cover_notfound_owngfx_attrib.getData() == "1") {
		c_bg.setXMLParam("image", getPrivateString("Deimos/CoverSearch/", "picPath", ""));
	}

	coverbrowser = XUIGroup.findObject("browser.cdcover");
	lastpath = PLAYITEMDIR;
	brw = XUIGroup.findObject("brw");

	tmr = new Timer;
	tmr.setDelay(5000);

	ready = 1;


//	str_url = getPrivateString("Deimos/CoverSearch/", "amazon.com_htmlpath_1.4", "");
//	str_url = "http://home.arcor.de/martin.deimos/CoverSearch";

//	str_url = "file:///" + str_url;

	menu_Cover = new PopupMenu;
	menu_Cover.addCommand("Cover Search", 666, 0, 1);
	menu_Cover.addSeparator();
	menu_Cover.addCommand("Reload Cover", 1, 0, 0);
	menu_Cover.addCommand("Open Cover Directory", 2, 0, 0);
	menu_Cover.addCommand("Preferences...",3, 0, 0);
	menu_Cover.addSeparator();
	menu_Cover.addCommand("Open Playitemfolder", 100, 0, 0);
	menu_Cover.addCommand("Open Cover", 101, 0, 0);
/*	if (b_resizewnd) {

	}*/
	

//	cover_web_attrib.onDataChanged();
	cover_notfound_owngfx_tile_attrib.onDataChanged();
	UpdateCover(0);
	ripProtection();

}

System.onScriptUnloading() {
	coverbrowser.navigateURl("about:blank");
	delete menu_Cover;
}

System.onSetXuiParam(String stringParam, String stringValue) {
	if (strlower(stringParam) == "notifier") b_isNotifier = stringToInteger(stringValue);
	if (strlower(stringParam) == "resizewindow") {
		b_resizewnd = stringToInteger(getToken(stringValue, ";", 0));
		if (b_resizewnd) {
			addw = stringToInteger(getToken(stringValue, ";", 1));
			addh = stringToInteger(getToken(stringValue, ";", 2));
			coverwnd = cover.getParentLayout();
			menu_Cover.addSeparator();
			menu_Cover.addCommand("Resize Width 1:1", 4, 0, 0);
			menu_Cover.addCommand("Resize Height 1:1",5, 0, 0);
			menu_Cover.addCommand("Default Size (160px)",6, 0, 0);
		}
	}
}

System.onTitleChange(String strNewTitle) {
	if (lastpath == PLAYITEMDIR) return;
	lastpath = PLAYITEMDIR;
	UpdateCover(0);
}

coverbrowser.onRightButtonUp(int x, int y) {
	if (b_isNotifier) return;
	ProcessMenuResult(menu_Cover.popAtMouse());
	complete;
}

trigger.onRightButtonUp(int x, int y) {
	if (b_isNotifier) return;
	ProcessMenuResult(menu_Cover.popAtMouse());
	complete;
}
trigger.onLeftButtonDblClk(int x, int y) {
	if (covername != "NULL") navigateUrl(covername);
	else navigateUrl(getPath(getPlayItemString()));
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
		if (a == 4) {
			int guiH = coverwnd.getGuiH();
			int guiW = guiH - addh + addw;
			coverwnd.resize(coverwnd.getGuiX(), coverwnd.getGuiY(), guiW ,guiH);
		}
		if (a == 5) {
			int guiW = coverwnd.getGuiW();
			int guiH = guiW - addw + addh;
			coverwnd.resize(coverwnd.getGuiX(), coverwnd.getGuiY(), guiW ,guiH);
		}
		if (a == 6) {
			int guiW = 160 + addw;
			int guiH = 160 + addh;
			coverwnd.resize(coverwnd.getGuiX(), coverwnd.getGuiY(), guiW ,guiH);
		}
		if (a == 100) {
		    	navigateUrl(getPath(getPlayItemString()));
		}
		if (a == 101) {
			if (covername != "NULL") navigateUrl(covername);
		}
	}
}

cover_dirs_pip_attrib.onDataChanged() {
	UpdateCover(0);
}
cover_dirs_acp_attrib.onDataChanged() {
	UpdateCover(0);
}
cover_dirs_sld_attrib.onDataChanged() {
	UpdateCover(0);
}
cover_quality_attrib.onDataChanged() {
	UpdateCover(0);
}
cover_web_attrib.onDataChanged() {
	UpdateCover(0);
}
cover_smooth_attrib.onDataChanged() {
	if (b_isNotifier) return;
	if (Dummy.getWidth() == Cover.getWidth() || Dummy.getWidth() == 0) return;
	Cover.fx_setEnabled(stringToInteger(getData()));
	UpdateCover(0);
}
notifier_aa_smooth.onDataChanged() {
	if (!b_isNotifier) return;
	if (Dummy.getWidth() == Cover.getWidth() || Dummy.getWidth() == 0) return;
	Cover.fx_setEnabled(stringToInteger(getData()));
	UpdateCover(0);
}


cover_notfound_owngfx_attrib.onDataChanged() {
	if (getData() == "1") {
		c_bg.setXMLParam("image", getPrivateString("Deimos/CoverSearch/", "picPath", ""));

	} else 	c_bg.setXMLParam("image", defaultbg);
}
cover_notfound_owngfx_tile_attrib.onDataChanged() {
	if (cover_notfound_owngfx_attrib.getData() == "0") {
		c_bg.setXMLParam("tile", "0");
	} else c_bg.setXMLParam("tile", getData());
}

XUIGroup.onSetVisible(int isv) {
	UpdateCover(0);
}


System.onPlay() {
	UpdateCover(0);
}

Int CoverSearch(string __path) {
	tmr.stop();
	string rem = __path;
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

	__path = rem;

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

	if (SLD && ENSURE_MSPP && !b_isNotifier) {
		if (ready) {
			ready = 0;
		//	messageBox(lastpath ,"",1,"");
			brw.navigateURL(MSPP_PATH + "\CoverSearch\getFileList.html?mspp|" + PLAYITEMDIR + "|*.jpg");
			return 3;
		}
	}
	if (WEB && ENSURE_MSPP) {
		startWebSearch();
		return 2;
	}			
	else return 0;
}

brw.onDocumentComplete(String url) {
	if (strsearch(url, "?return|") != -1) {
		ready = 1;
		covers = getToken(url, "?return|", 1);
		for ( int i = 0; i < 666; i++ ) {	
			if (strsearch(covers, "%20") != -1) {
				covers = replaceString(covers, "%20", " ");
				i = 0;
			} else i = 666;
		}
		for ( int i = 0; i < 666; i++ ) {	
			if (strsearch(covers, "%") != -1) {
				covers = replaceString(covers, "%", " ");
				i = 0;
			} else i = 666;
		}
		max = countSubString(covers, "|");
		if (covers == "return|") {
			tmr.stop();
			if (WEB && ENSURE_MSPP) {
				startWebSearch();
			}
			Cover.setXMLParam("image", "clear");
			Cover2.setXMLParam("image", "clear");
			return;
		}
		cover.show();
		tmr.start();
		count = 1;
		
		string str_path = lastpath + "/" + getToken(covers, "|", count);

		if (cover2isbehind) {
			if (str_path == Cover.getXmlParam("image")) return 1;
			Cover2.fx_setEnabled(0);
			fitClayers(Cover2,str_path);
			Cover2.setXMLParam("image", str_path);
			Cover.setTargetA(0);
			Cover.setTargetX(Cover.getGuiX());
			Cover.setTargetY(Cover.getGuiY());
			Cover.setTargetH(Cover.getGuiH());
			Cover.setTargetW(Cover.getGuiW());
			Cover.setTargetSpeed(0.5);
			Cover.gotoTarget();
			//if (Dummy.getWidth() == Cover2.getWidth()) return 1;
			if (!b_isNotifier && cover_smooth_attrib.getData() == "1") Smooth(Cover2);		
		} else if (!cover2isbehind) {
			if (str_path == Cover2.getXmlParam("image")) return 1;
			Cover.fx_setEnabled(0);
			fitClayers(Cover,str_path);
			Cover.setXMLParam("image", str_path);
			Cover2.setTargetA(0);
			Cover2.setTargetX(Cover2.getGuiX());
			Cover2.setTargetY(Cover2.getGuiY());
			Cover2.setTargetH(Cover2.getGuiH());
			Cover2.setTargetW(Cover2.getGuiW());
			Cover2.setTargetSpeed(0.5);
			Cover2.gotoTarget();
			//if (Dummy.getWidth() == Cover.getWidth()) return 1;
			if (!b_isNotifier && cover_smooth_attrib.getData() == "1") Smooth(Cover);		
		}
	}
}

tmr.onTimer() {
	count++;
	if (count > max) count = 1;
		string str_path = lastpath + "/" + getToken(covers, "|", count);

		if (cover2isbehind) {
			if (str_path == Cover.getXmlParam("image")) return 1;
			Cover2.fx_setEnabled(0);
			fitClayers(Cover2,str_path);
			Cover2.setXMLParam("image", str_path);
			Cover.setTargetA(0);
			Cover.setTargetX(Cover.getGuiX());
			Cover.setTargetY(Cover.getGuiY());
			Cover.setTargetH(Cover.getGuiH());
			Cover.setTargetW(Cover.getGuiW());
			Cover.setTargetSpeed(0.5);
			Cover.gotoTarget();
			//if (Dummy.getWidth() == Cover2.getWidth()) return 1;
			if (!b_isNotifier && cover_smooth_attrib.getData() == "1") Smooth(Cover2);		
		} else if (!cover2isbehind) {
			if (str_path == Cover2.getXmlParam("image")) return 1;
			Cover.fx_setEnabled(0);
			fitClayers(Cover,str_path);
			Cover.setXMLParam("image", str_path);
			Cover2.setTargetA(0);
			Cover2.setTargetX(Cover2.getGuiX());
			Cover2.setTargetY(Cover2.getGuiY());
			Cover2.setTargetH(Cover2.getGuiH());
			Cover2.setTargetW(Cover2.getGuiW());
			Cover2.setTargetSpeed(0.5);
			Cover2.gotoTarget();
			//if (Dummy.getWidth() == Cover.getWidth()) return 1;
			if (!b_isNotifier && cover_smooth_attrib.getData() == "1") Smooth(Cover);		
		}
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
		}		
	}
	
	/*Dummy.setXMLParam("image", __path + "/" + __file);
	messagebox( dummy.getxmlparam("image"), "", 0, "");
	if (Dummy.getLength() == 0) return 0;*/
	Dummy = new map;
	Dummy.loadMap( __path + "/" + __file);
	int ret = Dummy.getHeight();
	if (ret == 0 || ret == 64) return 0;
	else {
	//messagebox( integerToString(ret), "", 0, "");
		str_path = __path + "/" + __file;
		covername = str_path;
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
			fitClayers(Cover2,str_path);
			Cover2.setXMLParam("image", str_path);
			Cover.setTargetA(0);
			Cover.setTargetX(Cover.getGuiX());
			Cover.setTargetY(Cover.getGuiY());
			Cover.setTargetH(Cover.getGuiH());
			Cover.setTargetW(Cover.getGuiW());
			Cover.setTargetSpeed(0.5);
			Cover.gotoTarget();
			if (Dummy.getWidth() == Cover2.getWidth()) return 1;
			if (!b_isNotifier && cover_smooth_attrib.getData() == "1") Smooth(Cover2);
			return 1;		
		} else if (!cover2isbehind) {
			if (str_path == Cover2.getXmlParam("image")) return 1;
			Cover.fx_setEnabled(0);
			fitClayers(Cover,str_path);
			Cover.setXMLParam("image", str_path);
			Cover2.setTargetA(0);
			Cover2.setTargetX(Cover2.getGuiX());
			Cover2.setTargetY(Cover2.getGuiY());
			Cover2.setTargetH(Cover2.getGuiH());
			Cover2.setTargetW(Cover2.getGuiW());
			Cover2.setTargetSpeed(0.5);
			Cover2.gotoTarget();
			if (Dummy.getWidth() == Cover.getWidth()) return 1;
			if (!b_isNotifier && cover_smooth_attrib.getData() == "1") Smooth(Cover);
			return 1;		
		}
	}
}

Cover.onTargetReached() {
	Cover.setXMLParam("image", "clear");
	cover2isbehind = 0;
	Cover2.bringToFront();
	Cover.setAlpha(255);
}
Cover2.onTargetReached() {
	Cover2.setXMLParam("image", "clear");
	cover2isbehind = 1;
	Cover.bringToFront();
	Cover2.setAlpha(255);
}

startWebSearch() {
	c_status.setXMLParam("image", "cover.html.connecting");
	Cover.setXMLParam("image", "clear");
	Cover2.setXMLParam("image", "clear");
	haswebresult = 0;
	String strQuery = "";
	String strArtist = System.getPlayitemMetaDataString("artist");
	String strAlbum = System.getPlayitemMetaDataString("album");
	
	if (strArtist != "") strQuery += strArtist + " ";
	if (strAlbum != "") strQuery += strAlbum;

	fitBrowser(0);
	coverbrowser.show();
	str_url = MSPP_PATH + "/CoverSearch";
//	str_url = getPrivateString("Deimos/CoverSearch/", "amazon.com_htmlpath_1.4", "");
	str_url = "file:///" + str_url;
	string q = strlower(cover_quality_attrib.getData());
	//messagebox(str_url + "/coversearch_small.html?" + System.urlEncode(strQuery),"",0,"");
	if (b_isNotifier) coverbrowser.navigateURL(str_url + "/coversearch_small.html?" + System.urlEncode(strQuery));
	else coverbrowser.navigateURL(str_url + "/coversearch_" + q + ".html?" + System.urlEncode(strQuery));
}

coverbrowser.onDocumentComplete(String strURL) {
//	messagebox(strurl,"",0,"");
	if (System.strSearch(strURL, "RETURN___NO_MATCHES") > -1) {
		c_status.setXMLParam("image", "cover.html.nomatches");
		UpdateCover(1);
	} else if (System.strSearch(strURL, "RETURN___NO_CONNECTION") > -1) {
		//messagebox("hide","",0,"");
		c_status.setXMLParam("image", "cover.html.noconnection");
		UpdateCover(1);
	} else if (System.strSearch(strURL, ".html?load+") > -1) {
		haswebresult = 1;
		if (cover_notfound_owngfx_hide_attrib.getData() == "1") c_bg.setAlpha(0);
		fitBrowser(1);
	}
}

UpdateCover(Boolean nowebresult) {
	covername = "NULL";
	c_status.show();
	c_bg.setAlpha(255);
	if (nowebresult) {
		Cover.setXMLParam("image", "clear");
		Cover2.setXMLParam("image", "clear");
		return;
	}

	c_status.setXMLParam("image", "cover.notfound");

	string path = getPath(getPlayItemString());
	string rpath = strright(path, strlen(path) - 7);

	int res = CoverSearch(rpath);
	if (res != 2) coverbrowser.hide();
	if (res == 1) {
		if (cover_notfound_owngfx_hide_attrib.getData() == "1") c_bg.setAlpha(0);
		c_status.hide();
		return;
	} if (res == 0) {
		Cover.setXMLParam("image", "clear");
		Cover2.setXMLParam("image", "clear");

	}
}

cover_notfound_owngfx_hide_attrib.onDataChanged() {
	if (cover_notfound_owngfx_attrib.getData() == "0") return;
	if (getData() == "0") c_bg.setAlpha(255);
	else {
		if (haswebresult) c_bg.setAlpha(0);
		else UpdateCover(0);
	}
}

	

XUIGroup.onResize(int x, int y, int w, int h) {
	string pic = cover.getXMLParam("image");
	if (pic != "blank") fitClayers(cover, pic);
	pic = cover2.getXMLParam("image");
	if (pic != "blank") fitClayers(cover2, pic);
	if (!haswebresult) return;
	fitBrowser(coverbrowser.isvisible());
}

cover_browserration_attrib.onDataChanged() {
	if (!haswebresult) return;
	if (getData() == "0") {
		coverbrowser.setXMLParam("x", integerToString(0));
		coverbrowser.setXMLParam("y", integerToString(0));
		coverbrowser.setXMLParam("h", integerToString(0));
		coverbrowser.setXMLParam("w", integerToString(0));
		coverbrowser.setXmlParam("relath", "1");
		coverbrowser.setXmlParam("relatw", "1");
	} else fitBrowser(coverbrowser.isvisible());
}

cover_imageration_attrib.onDataChanged() {
	string pic = cover.getXMLParam("image");
	if (pic != "") fitClayers(cover, pic);
	pic = cover2.getXMLParam("image");
	if (pic != "") fitClayers(cover2, pic);
}

cover_enlarge_attrib.onDataChanged() {
	string pic = cover.getXMLParam("image");
	if (pic != "") fitClayers(cover, pic);
	pic = cover2.getXMLParam("image");
	if (pic != "") fitClayers(cover2, pic);
}

cover_shrink_attrib.onDataChanged() {
	string pic = cover.getXMLParam("image");
	if (pic != "") fitClayers(cover, pic);
	pic = cover2.getXMLParam("image");
	if (pic != "") fitClayers(cover2, pic);
}

fitBrowser(Boolean visible) {
	if (!visible) {
		coverbrowser.setXMLParam("x", integerToString(0));
		coverbrowser.setXMLParam("y", integerToString(0));
		coverbrowser.setXMLParam("h", integerToString(0));
		coverbrowser.setXMLParam("w", integerToString(0));
		coverbrowser.setXmlParam("relath", "0");
		coverbrowser.setXmlParam("relatw", "1");
	} else {
		c_status.hide();
		if (cover_browserration_attrib.getData() == "0" || b_isNotifier) coverbrowser.setXmlParam("relath", "1");
		else {
			if (b_isNotifier) return;
			int w = XUIGroup.getWidth();
			int h = XUIGroup.getHeight();
			if (w > h) {
				int x = (w - h) / 2;
				int y = 0;
				w = h;
				coverbrowser.setXmlParam("relath", "0");
				coverbrowser.setXmlParam("relatw", "0");
				coverbrowser.setXMLParam("x", integerToString(x));
				coverbrowser.setXMLParam("y", integerToString(y));
				coverbrowser.setXMLParam("h", integerToString(h));
				coverbrowser.setXMLParam("w", integerToString(w));
			}
			else if (h > w) {
				int y = (h - w) / 2;
				int x = 0;
				h = w;
				coverbrowser.setXmlParam("relath", "0");
				coverbrowser.setXmlParam("relatw", "0");
				coverbrowser.setXMLParam("x", integerToString(x));
				coverbrowser.setXMLParam("y", integerToString(y));
				coverbrowser.setXMLParam("h", integerToString(h));
				coverbrowser.setXMLParam("w", integerToString(w));
			} else {
				coverbrowser.setXMLParam("x", integerToString(0));
				coverbrowser.setXMLParam("y", integerToString(0));
				coverbrowser.setXMLParam("h", integerToString(0));
				coverbrowser.setXMLParam("w", integerToString(0));
				coverbrowser.setXmlParam("relath", "1");
				coverbrowser.setXmlParam("relatw", "1");
			}			
		}
	}
}

fitClayers(Layer l, String pic) {
	c_status.hide();
	if (b_isNotifier) return;
	int w = getImageW(pic);
	int h = getImageH(pic);
	//messagebox(integertostring(w), integerToString(h), 0, "");
	int xuiw = XUIGroup.getWidth();
	int xuih = XUIGroup.getHeight();
	if (cover_imageration_attrib.getData() == "0") {
		l.setXMLParam("x", integerToString(0));
		l.setXMLParam("y", integerToString(0));
		l.setXMLParam("h", integerToString(0));
		l.setXMLParam("w", integerToString(0));
		l.setXmlParam("relath", "1");
		l.setXmlParam("relatw", "1");
		if (cover_smooth_attrib.getData() == "1") {
			if (w != xuiw && h != xuih) Smooth(l);
		}
	} else {
		if (xuih == 0 || h == 0) return;
		double r = w/h;
		double xuir = xuiw/xuih;
		if (xuir > r) {
			int sw = xuih * r;
			int sh = xuih;
			int x = (xuiw - sw) / 2;
			int y = 0;
			l.setXmlParam("relath", "0");
			l.setXmlParam("relatw", "0");
			l.setXMLParam("x", integerToString(x));
			l.setXMLParam("y", integerToString(y));
			l.setXMLParam("h", integerToString(sh));
			l.setXMLParam("w", integerToString(sw));
		}
		else if (r > xuir) {
			int sw = xuiw;
			int sh = xuiw / r;
			int y = (xuih - sh) / 2;
			int x = 0;
			l.setXmlParam("relath", "0");
			l.setXmlParam("relatw", "0");
			l.setXMLParam("x", integerToString(x));
			l.setXMLParam("y", integerToString(y));
			l.setXMLParam("h", integerToString(sh));
			l.setXMLParam("w", integerToString(sw));
		} else {
			l.setXMLParam("x", integerToString(0));
			l.setXMLParam("y", integerToString(0));
			l.setXMLParam("h", integerToString(0));
			l.setXMLParam("w", integerToString(0));
			l.setXmlParam("relath", "1");
			l.setXmlParam("relatw", "1");
		}
		if (cover_smooth_attrib.getData() == "1") {
			if (w != xuiw && h != xuih) Smooth(l);
		}
	}
	if (cover_enlarge_attrib.getData() == "1") {
		if (xuih > h || xuiw > w) {
			if (xuih < h || xuiw < w && cover_imageration_attrib.getData() == "1") NULL;
			else {
				int sw = w;
				int sh = h;
				int y = (xuih - sh) / 2;
				int x = (xuiw - sw) / 2;
				l.setXmlParam("relath", "0");
				l.setXmlParam("relatw", "0");
				l.setXMLParam("x", integerToString(x));
				l.setXMLParam("y", integerToString(y));
				l.setXMLParam("h", integerToString(sh));
				l.setXMLParam("w", integerToString(sw));
			}			
		}		
	}
	if (cover_shrink_attrib.getData() == "1") {
		if (xuih < h || xuiw < w) {
			int sw = w;
			int sh = h;
			int y = 0;
			int x = 0;
			l.setXmlParam("relath", "0");
			l.setXmlParam("relatw", "0");
			l.setXMLParam("x", integerToString(x));
			l.setXMLParam("y", integerToString(y));
			l.setXMLParam("h", integerToString(sh));
			l.setXMLParam("w", integerToString(sw));			
		}
		
	}
	
}

int getImageW(string pic) {
	/*Dummy.setXMLParam("image", pic);
	int w = Dummy.getLength();
	return w;*/
	map m = new map;
	m.loadMap(pic);
	int ret = m.getWidth();
	delete m;
	return ret;
}
int getImageH(string pic) {
	/*Dummy.setXMLParam("image", pic);
	int w = Dummy.getLength();
	Dummy.setXMLParam("w", integerToString(w));
	int h = Dummy.getLength();
	Dummy.setXMLParam("w", "0");
//	messageBox(integerToString(w) + ";" + integerTostring(h) , "ERROR", 12, "");
	return h;*/
	map m = new map;
	m.loadMap(pic);
	int ret = m.getHeight();
	delete m;
	return ret;
	/*Dummy.setXMLParam("image", pic);
	int h = Dummy.getGuiH();
	int w = Dummy.getGuiW();
	messageBox(integerToString(w) + ";" + integerTostring(h) , "ERROR", 12, "");
	return h;*/
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

