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

#define VIS_ATTRIBS_MGR

#include "../../../../lib/std.mi"
#include "../../scripts/attribs.m"

#define FILENAME "configpage.m"
#include "../../../../lib/ripprotection.mi"

Function int getImageWidth(AnimatedLayer al_dummy, string s_imageXmlParam);

Global GuiList List_vis;
Global Int mychange;

Global Boolean b_presettog = 0;

Global Button btn_ovp_ins, btn_ovp_del;
Global Edit e_ovp_name, e_ovp_path;
Global Int i_nvl;

Global AnimatedLayer al_visdummy;

System.onScriptLoaded() {
	Group XUIGroup = getScriptGroup();
	initAttribs();

	List_vis = XUIGroup.findObject("list.vis");
	btn_ovp_ins = XUIGroup.findObject("insert");
	btn_ovp_del = XUIGroup.findObject("delete");
	al_visdummy = XUIGroup.findObject("dummy");
	e_ovp_name = XUIGroup.findObject("ovp.name");
	e_ovp_path = XUIGroup.findObject("ovp.path");

	List_vis.setAutoSort(0);
	List_vis.setPreventMultipleSelection(1);
//	List_vis.setWantAutoDeselect(0);
	List_vis.setColumnLabel(0, "");
	List_vis.addColumn("", 150, 1);
	List_vis.setColumnWidth(0, 37);


	i_nvl = 0;
	List_vis.insertItem(i_nvl, ";-(");
	List_vis.setSubItem(i_nvl, 1, "No Visualization");
	i_nvl++;
	List_vis.insertItem(i_nvl, "Wa2");
	List_vis.setSubItem(i_nvl, 1, "Spectrum Analyzer");
	i_nvl++;
	List_vis.insertItem(i_nvl, "Wa2");
	List_vis.setSubItem(i_nvl, 1, "Oscilliscope");
	i_nvl++;
	List_vis.insertItem(i_nvl, "Skin ");
	List_vis.setSubItem(i_nvl, 1, "4D Spectrum");
	i_nvl++;
	List_vis.insertItem(i_nvl, "Skin ");
	List_vis.setSubItem(i_nvl, 1, "4D Oscilliscope");
	i_nvl++;
	List_vis.insertItem(i_nvl, "Skin ");
	List_vis.setSubItem(i_nvl, 1, "Circle");
	i_nvl++;
	List_vis.insertItem(i_nvl, "Skin ");
	List_vis.setSubItem(i_nvl, 1, "SemiOrbit");
	i_nvl++;
	List_vis.insertItem(i_nvl, "Skin ");
	List_vis.setSubItem(i_nvl, 1, "Lighting Bolt");
	i_nvl++;
	List_vis.insertItem(i_nvl, "Skin ");
	List_vis.setSubItem(i_nvl, 1, "Rockin' Llamas");
	i_nvl++;
	List_vis.insertItem(i_nvl, "Skin ");
	List_vis.setSubItem(i_nvl, 1, "Dots");

	if (vis_own1_attrib.getData() != "nix") {
		i_nvl++;
		List_vis.insertItem(i_nvl, "Own");
		List_vis.setSubItem(i_nvl, 1, getToken(vis_own1_attrib.getData(), ";", 0));
	}
	if (vis_own2_attrib.getData() != "nix") {
		i_nvl++;
		List_vis.insertItem(i_nvl, "Own");
		List_vis.setSubItem(i_nvl, 1, getToken(vis_own2_attrib.getData(), ";", 0));
	}
	if (vis_own3_attrib.getData() != "nix") {
		i_nvl++;
		List_vis.insertItem(i_nvl, "Own");
		List_vis.setSubItem(i_nvl, 1, getToken(vis_own4_attrib.getData(), ";", 0));
	}
	if (vis_own4_attrib.getData() != "nix") {
		i_nvl++;
		List_vis.insertItem(i_nvl, "Own");
		List_vis.setSubItem(i_nvl, 1, getToken(vis_own4_attrib.getData(), ";", 0));
	}
	if (vis_own5_attrib.getData() != "nix") {
		i_nvl++;
		List_vis.insertItem(i_nvl, "Own");
		List_vis.setSubItem(i_nvl, 1, getToken(vis_own5_attrib.getData(), ";", 0));
	}
	if (vis_own6_attrib.getData() != "nix") {
		i_nvl++;
		List_vis.insertItem(i_nvl, "Own");
		List_vis.setSubItem(i_nvl, 1, getToken(vis_own6_attrib.getData(), ";", 0));
	}
	if (vis_own7_attrib.getData() != "nix") {
		i_nvl++;
		List_vis.insertItem(i_nvl, "Own");
		List_vis.setSubItem(i_nvl, 1, getToken(vis_own7_attrib.getData(), ";", 0));
	}
	if (vis_own8_attrib.getData() != "nix") {
		i_nvl++;
		List_vis.insertItem(i_nvl, "Own");
		List_vis.setSubItem(i_nvl, 1, getToken(vis_own8_attrib.getData(), ";", 0));
	}
	if (vis_own9_attrib.getData() != "nix") {
		i_nvl++;
		List_vis.insertItem(i_nvl, "Own");
		List_vis.setSubItem(i_nvl, 1, getToken(vis_own9_attrib.getData(), ";", 0));
	}
	if (vis_own10_attrib.getData() != "nix") {
		i_nvl++;
		List_vis.insertItem(i_nvl, "Own");
		List_vis.setSubItem(i_nvl, 1, getToken(vis_own10_attrib.getData(), ";", 0));
	}
	vis_mode_attrib.onDataChanged();
	

	ripprotection("panther");
}

List_vis.onItemSelection(Int itemnum, Int selected) {
	vis_mode_attrib.setData(getItemLabel(itemnum, 1));
}
/*
ConfigVisAttribute.onDataChanged() {
	int i_items = List_Vis.getNumItems() - 1;
	for ( int i = 0; i <= i_items; i++ ) {
		if (getAttributeName() == List_Vis.getItemLabel(i, 1)) { List_Vis.deselectAll(); List_Vis.setItemFocused(i); }
	}
}
*/
btn_ovp_ins.onLeftClick() {
	if (e_ovp_name.getText() == "") {
		messageBox("You must type a name for your preset in the upper edit!" , "Error", 1, "");
		return;
	}
	if (e_ovp_path.getText() == "") {
		messageBox("You must type a path for your preset in the upper edit!" , "Error", 1, "");
		return;
	}
	if (getImageWidth(al_visdummy, e_ovp_path.getText()) == 0) {
		messageBox("You havn't typed a valid path to your image!\nShould be something like that: C:\dance.png" , "Error", 1, "");
		return;
	}
	float f_nframes = (getImageWidth(al_visdummy, e_ovp_path.getText())) / 108;
	int i_nframes = (getImageWidth(al_visdummy, e_ovp_path.getText())) / 108;
	if (f_nframes != i_nframes) {
		messageBox("Your Image hasn't these dimensions:\nHeight: 51px\nWidth: 108px * n (n = number of frames)" , "Error", 1, "");
		return;
	}
	if (vis_own1_attrib.getData() == "nix") {
		i_nvl++;
		vis_own1_attrib.setData(e_ovp_name.getText() + ";" + e_ovp_path.getText());
		List_vis.insertItem(i_nvl, "Own");
		List_vis.setSubItem(i_nvl, 1, getToken(vis_own1_attrib.getData(), ";", 0));
		return;
	}
	if (vis_own2_attrib.getData() == "nix") {
		i_nvl++;
		vis_own2_attrib.setData(e_ovp_name.getText() + ";" + e_ovp_path.getText());
		List_vis.insertItem(i_nvl, "Own");
		List_vis.setSubItem(i_nvl, 1, getToken(vis_own2_attrib.getData(), ";", 0));
		return;
	}
	if (vis_own3_attrib.getData() == "nix") {
		i_nvl++;
		vis_own3_attrib.setData(e_ovp_name.getText() + ";" + e_ovp_path.getText());
		List_vis.insertItem(i_nvl, "Own");
		List_vis.setSubItem(i_nvl, 1, getToken(vis_own3_attrib.getData(), ";", 0));
		return;
	}
	if (vis_own4_attrib.getData() == "nix") {
		i_nvl++;
		vis_own4_attrib.setData(e_ovp_name.getText() + ";" + e_ovp_path.getText());
		List_vis.insertItem(i_nvl, "Own");
		List_vis.setSubItem(i_nvl, 1, getToken(vis_own4_attrib.getData(), ";", 0));
		return;
	}
	if (vis_own5_attrib.getData() == "nix") {
		i_nvl++;
		vis_own5_attrib.setData(e_ovp_name.getText() + ";" + e_ovp_path.getText());
		List_vis.insertItem(i_nvl, "Own");
		List_vis.setSubItem(i_nvl, 1, getToken(vis_own5_attrib.getData(), ";", 0));
		return;
	}
	if (vis_own6_attrib.getData() == "nix") {
		i_nvl++;
		vis_own6_attrib.setData(e_ovp_name.getText() + ";" + e_ovp_path.getText());
		List_vis.insertItem(i_nvl, "Own");
		List_vis.setSubItem(i_nvl, 1, getToken(vis_own6_attrib.getData(), ";", 0));
		return;
	}
	if (vis_own7_attrib.getData() == "nix") {
		i_nvl++;
		vis_own7_attrib.setData(e_ovp_name.getText() + ";" + e_ovp_path.getText());
		List_vis.insertItem(i_nvl, "Own");
		List_vis.setSubItem(i_nvl, 1, getToken(vis_own7_attrib.getData(), ";", 0));
		return;
	}
	if (vis_own8_attrib.getData() == "nix") {
		i_nvl++;
		vis_own8_attrib.setData(e_ovp_name.getText() + ";" + e_ovp_path.getText());
		List_vis.insertItem(i_nvl, "Own");
		List_vis.setSubItem(i_nvl, 1, getToken(vis_own8_attrib.getData(), ";", 0));
		return;
	}
	if (vis_own9_attrib.getData() == "nix") {
		i_nvl++;
		vis_own9_attrib.setData(e_ovp_name.getText() + ";" + e_ovp_path.getText());
		List_vis.insertItem(i_nvl, "Own");
		List_vis.setSubItem(i_nvl, 1, getToken(vis_own9_attrib.getData(), ";", 0));
		return;
	}
	if (vis_own10_attrib.getData() == "nix") {
		i_nvl++;
		vis_own10_attrib.setData(e_ovp_name.getText() + ";" + e_ovp_path.getText());
		List_vis.insertItem(i_nvl, "Own");
		List_vis.setSubItem(i_nvl, 1, getToken(vis_own10_attrib.getData(), ";", 0));
		return;
	}
	messageBox("You can only store up to 10 VisualizationPresets!\nDelete one to store a new one!" , "Error", 1, "");
}

btn_ovp_del.onLeftClick() {
	int i_selit = List_Vis.getItemFocused();
	if (i_selit == -1) { messageBox("Hey monkey,\nyou havn't selected a preset!\nYou must select an 'Own' preset to delete it", "Error", 1, ""); return; }
	if (List_Vis.getItemLabel(i_selit,0) != "Own") { messageBox("You CANNOT delete given presets!\nYou must select an 'Own' preset to delete it", "Error", 1, ""); return; }
	else {
		vis_mode_4dosci_attrib.setData("1");
		i_nvl--;
		string str_il = List_Vis.getItemLabel(i_selit,1);
		List_Vis.deleteByPos(i_selit);
		if (getToken(vis_own1_attrib.getData(), ";", 0) == str_il) { vis_own1_attrib.setData("nix"); vis_mode_4dosci_attrib.setData("1"); }
		if (getToken(vis_own2_attrib.getData(), ";", 0) == str_il) { vis_own2_attrib.setData("nix"); vis_mode_4dosci_attrib.setData("1"); }
		if (getToken(vis_own3_attrib.getData(), ";", 0) == str_il) { vis_own3_attrib.setData("nix"); vis_mode_4dosci_attrib.setData("1"); }
		if (getToken(vis_own4_attrib.getData(), ";", 0) == str_il) { vis_own4_attrib.setData("nix"); vis_mode_4dosci_attrib.setData("1"); }
		if (getToken(vis_own5_attrib.getData(), ";", 0) == str_il) { vis_own5_attrib.setData("nix"); vis_mode_4dosci_attrib.setData("1"); }
		if (getToken(vis_own6_attrib.getData(), ";", 0) == str_il) { vis_own6_attrib.setData("nix"); vis_mode_4dosci_attrib.setData("1"); }
		if (getToken(vis_own7_attrib.getData(), ";", 0) == str_il) { vis_own7_attrib.setData("nix"); vis_mode_4dosci_attrib.setData("1"); }
		if (getToken(vis_own8_attrib.getData(), ";", 0) == str_il) { vis_own8_attrib.setData("nix"); vis_mode_4dosci_attrib.setData("1"); }
		if (getToken(vis_own9_attrib.getData(), ";", 0) == str_il) { vis_own9_attrib.setData("nix"); vis_mode_4dosci_attrib.setData("1"); }
		if (getToken(vis_own10_attrib.getData(), ";", 0) == str_il) { vis_own10_attrib.setData("nix"); vis_mode_4dosci_attrib.setData("1"); }
	}
}

Int getImageWidth(AnimatedLayer al_dummy, string s_imageXmlParam) {
	if (strsearch(s_imageXmlParam, "%") != -1) return 0;
	al_dummy.setXMLParam("image", s_imageXmlParam);
	return al_dummy.getLength();
}