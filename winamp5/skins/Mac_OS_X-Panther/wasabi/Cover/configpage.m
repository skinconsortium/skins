/*---------------------------------------------------
-----------------------------------------------------
Filename:	configpage.m

Type:		maki/source
Version:	skin version 1.2
Date:		10:11 30.08.2004
Author:		Martin P. alias Deimos
E-Mail:		martin.deimos@gmx.de
Internet:	www.martin.deimos.de.vu
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
#include "../../../../lib/config.mi"

#define FILENAME "configpage.m"
#include "../ripprotection.mi"

#define NOTAV "CoverSearch via Amazon.com isn't available!"
#define AV "CoverSearch via Amazon.com is available!"
#define WRONGPATH "Invalid Path - CoverSearch via Amazon.com isn't available!"

/* Part of exd.mi */

Function String replaceString(string baseString, string toreplace, string replacedby);

/**
 replaceString()

 Returns the class name for the object.

 @param  baseString    The String which you want to modify.
 @param  toreplace     The String you want to be replaced.
 @param  replacedby    The String instead of 'toreplace'.
 @ret                  The replaced string.
*/

String replaceString(string baseString, string toreplace, string replacedby) {
	if (toreplace == "") return baseString;
	int i = strsearch(baseString, toreplace);
	if (i == -1) return baseString;
	string left = "", right = "";
	if (i != 0) left = strleft(baseString, i);

	if (strlen(basestring) - i - strlen(toreplace) != 0) {
		right = strright(basestring, strlen(basestring) - i - strlen(toreplace));
	}
	return left + replacedby + right;
}

Function prepareRList();
Function readRList();
Function Boolean FileSearch(string __path, string __file);

Global Edit e_cover, e_pixpath;

Global Button btn_notes, btn_pid, btn_acd;

Global ConfigAttribute ca, ca_web;

Global Edit e_cstr, e_crepstr;
Global GuiList List_cRep;
Global Button btn_crAdd, btn_crRem, btn_csfolder, btn_more, m1, m2;
Global Button btn_apply;
Global Edit e_htmlpath;
Global AnimatedLayer Dummy;
Global Text statustxt;
Global Layer ad;
Global button cubtn;


System.onScriptLoaded() {
	Group XUIGroup = getScriptGroup();
	
	if (getParam() == "1") {
		e_cover = XUIGroup.findObject("coverpath").findObject("filename");
		e_cover.setAutoEnter(1);
		e_cover.setText(getPrivateString("Deimos/CoverSearch/", "additionalPath", ""));

		btn_csfolder = XUIGroup.findObject("opendir");
		btn_pid = XUIGroup.findObject("pid");
		btn_acd = XUIGroup.findObject("acd");
		btn_more = XUIGroup.findObject("more");

		m1 = XUIGroup.findObject("m1");
		m2 = XUIGroup.findObject("m2");


	} else if (getParam() == "5") {

		e_pixpath = XUIGroup.findObject("pixpath").findObject("filename");
		ca = Config.getItem("CoverSearch").getAttribute("Custom Background");

		e_pixpath.setAutoEnter(1);
		e_pixpath.setText(getPrivateString("Deimos/CoverSearch/", "picPath", ""));
	
	} else if (getParam() == "2") {
		e_cstr = XUIGroup.findObject("str");
		e_crepstr = XUIGroup.findObject("rstr");

		btn_notes = XUIGroup.findObject("notes");
		btn_pid = XUIGroup.findObject("pid");
		btn_acd = XUIGroup.findObject("acd");

		btn_crAdd = XUIGroup.findObject("add");
		btn_crRem = XUIGroup.findObject("rem");
		List_cRep = XUIGroup.findObject("rep");

		List_cRep.setAutoSort(0);
		List_cRep.setPreventMultipleSelection(1);
		List_cRep.setColumnLabel(0, "");
		List_cRep.setColumnWidth(0, 115);
		List_cRep.addColumn("", 120, 1);

		prepareRList();
	} else if (getParam() == "3") {
		e_cover = XUIGroup.findObject("coverpath");
		e_cover.setAutoEnter(1);
		e_cover.setText(getPrivateString("Deimos/CoverSearch/", "additionalPath", ""));

		btn_csfolder = XUIGroup.findObject("opendir");
	} else if (getParam() == "4") {
		e_htmlpath = XUIGroup.findObject("path");
		ca_web = Config.getItem("CoverSearch").getAttribute("Search via Amazon.com");
		e_htmlpath.setAutoEnter(0);
		e_htmlpath.setText(getPrivateString("Deimos/CoverSearch/", "amazon.com_htmlpath_1.4", "C:\DpW-Addons\CoverSearch 1.4"));

		btn_apply = XUIGroup.findObject("apply");
		Dummy = XUIGroup.findObject("config.cover.amazon.status").findObject("cover.dummy");
		ad = XUIGroup.findObject("config.cover.amazon.status").findObject("ad");
		statustxt = XUIGroup.findObject("statustxt");
		if (getPrivateString("Deimos/CoverSearch/", "amazon.com_htmlpath_1.4", "") == "") {
			statustxt.setText(NOTAV);
		} else {
			boolean b = FileSearch(e_htmlpath.getText(), "CoverSearch1.4.jpg");
			if (b) {
				ad.setXMLParam("image", e_htmlpath.getText() + "/CoverSearch1.4.jpg");
				ad.show();
				statustxt.setText(AV);
				setPublicString("Deimos/CoverSearch/_amazon.com_htmlpath_1.4", e_htmlpath.getText());
			} else {
				ad.hide();
				statustxt.setText(WRONGPATH);
				messageBox("Your folder doesn't contain the CoverSearch files!\nPlease check it again!" , "Error", 1, "");
				setPublicString("Deimos/CoverSearch/_amazon.com_htmlpath_1.4", "");
			}
		}
	}

	ripprotection();
}

System.onScriptUnloading() {
	if (getParam() == "1") {
		e_cover.enter();
	}
	if (getParam() == "5") {
		e_pixpath.enter();
	}
}

e_cover.onEditUpdate() {
	string s = getText();
	string rs = s;
	/* ensure that there are no "%" in the string */
	for ( int i = 0; i < 666; i++ ) {	
		if (strsearch(s, "%20") != -1) {
			s = replaceString(s, "%20", " ");
			i = 0;
		} else i = 666;
	}
	for ( int i = 0; i < 666; i++ ) {	
		if (strsearch(s, "%") != -1) {
			s = replaceString(s, "%", "");
			i = 0;
		} else i = 666;
	}
	if (rs == s) { //cannot input % anymore
		setPublicString("Deimos/CoverSearch/_additionalPath", s);
	} else {
		e_cover.setText(s);
	}
}

e_pixpath.onEditUpdate() {
	string s = getText();
	string rs = s;
	/* ensure that there are no "%" in the string */
	for ( int i = 0; i < 666; i++ ) {	
		if (strsearch(s, "%20") != -1) {
			s = replaceString(s, "%20", " ");
			i = 0;
		} else i = 666;
	}
	for ( int i = 0; i < 666; i++ ) {	
		if (strsearch(s, "%") != -1) {
			s = replaceString(s, "%", "");
			i = 0;
		} else i = 666;
	}
	if (rs == s) { //cannot input % anymore
		setPublicString("Deimos/CoverSearch/_picPath", s);
	} else {
		e_pixpath.setText(s);
	}
}

e_pixpath.onEnter() {
	if (!ca) return;
	if (ca.getData() == "1") {
		ca.setData("0");
		ca.setData("1");
	} else {
		ca.setData("1");
		ca.setData("0");
	}
}

m1.onLeftClick() {
	GuiTree _tree = System.getContainer("config").getLayout("normal").findObject("wasabi.preferences.group").findObject("wasabi.preferences.tree.embedded").findObject("mylist");
	_tree.sendAction("switchToItem", "MSPP Info", 0, 0, 0, 0);
}

m2.onLeftClick() {
	GuiTree _tree = System.getContainer("config").getLayout("normal").findObject("wasabi.preferences.group").findObject("wasabi.preferences.tree.embedded").findObject("mylist");
	_tree.sendAction("switchToItem", "MSPP Info", 0, 0, 0, 0);
}

btn_csfolder.onLeftClick() {
   	navigateUrl(getPrivateString("Deimos/CoverSearch/", "additionalPath", ""));
}

ca_web.onDataChanged() {
	if (getData() == "1") {
		if (FileSearch(e_htmlpath.getText(), "CoverSearch1.4.jpg")) return;
		else setData("0");		
	}
}

btn_apply.onLeftClick() {
	boolean b = FileSearch(e_htmlpath.getText(), "CoverSearch1.4.jpg");
	if (b) {
		ad.setXMLParam("image", e_htmlpath.getText() + "/CoverSearch1.4.jpg");
		ad.show();
		statustxt.setText(AV);
		setPublicString("Deimos/CoverSearch/_amazon.com_htmlpath_1.4", e_htmlpath.getText());
		ca_web.setData("1");
	} else {
		ad.hide();
		statustxt.setText(WRONGPATH);
		messageBox("Your folder doesn't contain the CoverSearch files!\nPlease check it again!" , "Error", 1, "");
		setPublicString("Deimos/CoverSearch/_amazon.com_htmlpath_1.4", "");
	}
}

btn_notes.onLeftClick() {
	int i = messageBox("To show a CoverArt you MUST have a jpg-file that agrees with one of the given filenames!" , "General", 32, "");
	int i = messageBox("You CAN tag your covers with or without a space (' ') before and after dashes ('-')." , "Tagging", 33, "");
	int i = messageBox("The SearchEngine CANNOT view CoverArts stored in the ID3v2 Tag of mp3s yet.\nFor ID3v2 CoverSearch please install:\nJ.Richter's Cover and Tag Plugin (http://fire.prohosting.com/richter)" , "ID3 Search", 1, "");
}

btn_pid.onLeftClick() {
	int i = messageBox("1. cover.jpg,    2. cdcover.jpg,    3. coverart.jpg,    4. folder.jpg,    5. front.jpg,\n6. |album|.jpg,    7. |artist| - |album|.jpg    8. |artist| - |title|.jpg\n9. |filename|.jpg    10. |title|.jpg" , "", 1, "");
}

btn_acd.onLeftClick() {
	int i = messageBox("1. |album|.jpg,    2. |artist| - |album|.jpg    3. |artist| - |title|.jpg\n4. |filename|.jpg    5. |title|.jpg" , "", 1, "");
}

btn_more.onLeftClick() {
	int i = messageBox("This CoverSearch runs via ActiveX!\nIt may ask you if you want to load\na html page with ActiveX content.\nClick on YES to proceed!\n\nNOTES:\n  This popup may come up each time\n  CoverSearch 1.5 searches in a new folder\n\n  Requires by MSPP to run!\n" + "  Click on the <+> logo to install MSPP" , "", 1, "");
}

prepareRList() {
	int nitems = getPrivateInt("Deimos/CoverSearch/StringReplace/", "nitems", 1);

	for ( int i = 0; i < nitems; i++ ) {
		string itemstring = getPrivateString("Deimos/CoverSearch/StringReplace/Items/", "String" + integerToString(i), "AC/DC");
		string replacestring = getPrivateString("Deimos/CoverSearch/StringReplace/Items/", "ReplaceString" + integerToString(i), "ACDC");

		List_cRep.insertItem(i, itemstring);
		List_cRep.setSubItem(i, 1, replacestring);
	}
}

btn_crAdd.onLeftClick() {
	int i = List_cRep.getNumItems();
	string str = e_cstr.getText();
	if (str == "") {
		messageBox("You must define a string in the first editbox!" , "ERROR", 1, "");
		return;
	}
	string rstr = e_crepstr.getText();
	if (rstr == "") {
		int i_answer = messageBox("Do you really want to replace '" + str + "' by ' ' ?" , "ERROR", 12, "");
		if (i_answer != 4) return;

	}
	string vorbidden = "\,/,:,*,?,<,>";
	for ( int r = 0; r < 7; r++ ) {
		string s = getToken(vorbidden, ",", r);
		if (strsearch(rstr, s) != -1) {
			messageBox("You can't use a '" + s + "' for a replacement!" , "ERROR", 1, "");
			return;
		}
	}
	List_cRep.insertItem(i, str);
	List_cRep.setSubItem(i, 1, rstr);
	readRList();
}

btn_crRem.onLeftClick() {
	int i = List_cRep.getFirstItemSelected();
	string str = List_cRep.getItemLabel(i, 0);
	string rstr = List_cRep.getItemLabel(i, 1);

	if (str == "") {
		messageBox("You must select an item in the list!" , "ERROR", 1, "");
		return;
	}

	int i_answer = messageBox("Do you really want to delete '" + str + "' -> '" + rstr + "' ?" , "ERROR", 12, "");
	if (i_answer != 4) return;

	List_cRep.deletebyPos(i);
	readRList();
}

readRList() {
	int nitems = List_cRep.getNumItems();
	setPublicInt("Deimos/CoverSearch/StringReplace/_nitems", nitems);

	string itemstring = "";
	string replacestring = "";

	for ( int i = 0; i < nitems; i++ ) {
		itemstring = List_cRep.getItemLabel(i, 0);
		replacestring = List_cRep.getItemLabel(i, 1);
		setPublicString("Deimos/CoverSearch/StringReplace/Items/_String" + integerToString(i), itemstring);
		setPublicString("Deimos/CoverSearch/StringReplace/Items/_ReplaceString" + integerToString(i), replacestring);
	}
}

Boolean FileSearch(string __path, string __file) {
	if (strsearch(__path + "/" + __file, "%") != -1) return 0;
	Dummy.setXMLParam("image", __path + "/" + __file);
	if (Dummy.getLength() == 0) return 0;
	else return 1;
}