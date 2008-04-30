#include "../../../../lib/std.mi"

Function fillSkinList();
Function checkForSkin();

Global GuiList List_skins, List_skins_d;
Global Button btn_skiswi, btn_skidel;
Global Group tb_skins;

System.onScriptLoaded() {

	tb_skins = getScriptGroup();

	List_skins = tb_Skins.findObject("list.skins");

	btn_skiswi = tb_Skins.findObject("switch");
	btn_skidel = tb_Skins.findObject("skindel");

	List_skins.setAutoSort(0);
	List_skins.setPreventMultipleSelection(1);

	List_skins.insertItem(0, "Winamp Modern");
	List_skins.insertItem(1, "Winamp Classic");

	List_skins_d = tb_Skins.findObject("list.skins.d");

	List_skins_d.setAutoSort(0);
	List_skins_d.setPreventMultipleSelection(1);

	List_skins_d.insertItem(0, "");
	List_skins_d.insertItem(1, "");
	
	checkForSkin();
	fillSkinList();

}

checkForSkin() {
	int i_numberOfSkins = getPrivateInt("Deimos/Skins/", "NumberOfSkins", 0);
	if (i_numberOfSkins == 0) {
		setPublicString("Deimos/Skins/MyInstalledSkins/_1", getSkinName());
		setPublicString("Deimos/Skins/MyInstalledSkins/_1.Path", getParam());	
		setPublicInt("Deimos/Skins/_NumberOfSkins", 1);
	} else {
		int i_skinnumber = 0;
		for ( int i = 1; i <= i_numberOfSkins; i++ ) {
			string str_name = getPrivateString("Deimos/Skins/MyInstalledSkins/", integerToString(i), "");
			if (str_name == getSkinName()) {
				i_skinnumber = i;
				i = i_numberOfSkins;
			}
		}
		if (i_skinnumber == 0) {
			i_numberOfSkins++;
			setPublicString("Deimos/Skins/MyInstalledSkins/_" + integerToString(i_numberOfSkins), getSkinName());
			setPublicString("Deimos/Skins/MyInstalledSkins/_" + integerToString(i_numberOfSkins) + ".Path", getParam());
			setPublicInt("Deimos/Skins/_NumberOfSkins", i_numberOfSkins);
		}
	}
}

fillSkinList() {
	int i_numberOfSkins = getPrivateInt("Deimos/Skins/", "NumberOfSkins", 0);
	if (i_numberOfSkins == 0) checkForSkin();
	for ( int i = 1; i <= i_numberOfSkins; i++ ) {
		string str_name = getPrivateString("Deimos/Skins/MyInstalledSkins/", integerToString(i), "");
		List_skins.insertItem(i+1, str_name);
		string str_name = getPrivateString("Deimos/Skins/MyInstalledSkins/", integerToString(i) + ".Path", "");
		List_skins_d.insertItem(i+1, str_name);
	}
}

List_Skins.onItemSelection(Int itemnum, Int selected) {
	string str_skin = getItemLabel(itemnum, 0);
	string str_skinp = List_skins_d.getItemLabel(itemnum, 0);
	Layer l_info = tb_Skins.findObject("Infobox").findObject("info");
	AnimatedLayer l_Dummy = tb_Skins.findObject("Infobox").findObject("info.dummy");
	Text t_Skinfo = tb_Skins.findObject("Infobox").findObject("description");
	
/*	l_Dummy.setXMLParam("image", "/../" + str_skin + "/skinfo.png");
	int i_len = l_Dummy.getLength();
	if (i_len > 0) {
		l_info.setXMLParam("image", "/../" + str_skin + "/skinfo.png");
		return;
	} else {*/
		l_Dummy.setXMLParam("image", str_skinp + "skinfo.png");
		int i_len = l_Dummy.getLength();
		if (i_len == 0 || str_skinp == "") {
			l_info.setXMLParam("image", "");
			t_Skinfo.setText("No info available for this skin!");
		} else l_info.setXMLParam("image", str_skinp + "skinfo.png");
	//}
}	

List_skins.onDoubleClick(int itemnum) {
	string str_skin = getItemLabel(itemnum, NULL);
	if (str_skin == getSkinName()) {
		messageBox("The skin you want to switch to is your current skin!" , "", 1, "");
		return;
	}
	switchSkin(str_skin);
}

btn_skiswi.onLeftClick() {
	string str_skin = List_skins.getItemLabel(List_skins.getItemFocused(), NULL);
	if (str_skin == getSkinName()) {
		messageBox("The skin you want to switch to is your current skin!" , "", 1, "");
		return;
	}
	switchSkin(str_skin);
}
btn_skidel.onLeftClick() {
	int i_answer = messageBox("Do you really want to clear your Skinlist?" , "Clear skinlist", 12, "");

	if (i_answer == 4 ) {

		setPublicInt("Deimos/Skins/_NumberOfSkins", 0);

		List_skins.deleteAllItems();
		List_skins_d.deleteAllItems();
		List_skins.insertItem(0, "Winamp Modern");
		List_skins.insertItem(1, "Winamp Classic");
		List_skins_d.insertItem(0, "");
		List_skins_d.insertItem(1, "");
		checkForSkin();
		fillSkinList();
	}
}
