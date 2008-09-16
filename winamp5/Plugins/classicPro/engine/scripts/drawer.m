#include <lib/std.mi>

Function openDrawer(int drawerNo);
Function gotoPrevDrawer();
Function gotoNextDrawer();

Global Layout myLayout;
Global Group myGroup;
Global Group drawer_equalizer, drawer_savedpl, drawer_tagviewer, drawer_avs, drawer_ct, drawer_skinchooser;
Global PopUpMenu popMenu, widgetmenu;
Global Button but_drawerGoto;
Global GuiObject cpro_sui, gad_Grid, gad_Grid2;
Global Layer ct_fakeLayer;
Global Boolean gotThemes, mouse_but_drawerGoto, cuseqbg;

Global ComponentBucket dummyBuck;
Global GuiObject customObj;

System.onScriptLoaded() {
	myLayout = getContainer("main").getLayout("normal");

	myGroup = getScriptGroup();
	but_drawerGoto = myGroup.findObject("drawer.menulist");
	drawer_equalizer = myGroup.findObject("drawer.equalizer");
	drawer_tagviewer = myGroup.findObject("drawer.tagviewer");
	drawer_savedpl = myGroup.findObject("drawer.savedpl");
	drawer_avs = myGroup.findObject("drawer.avs");
	drawer_ct = myGroup.findObject("drawer.colortheme");
	drawer_skinchooser = myGroup.findObject("drawer.skinchooser");
	ct_fakeLayer = myGroup.findObject("drawer.ct.fakelayer");
	gad_Grid = myGroup.findObject("centro.gadget.grid");
	gad_Grid2 = myGroup.findObject("centro.gadget.grid2");
	
	cpro_sui = getContainer("main").getLayout("normal").findObject("cpro.sui");

	dummyBuck = myGroup.findObject("widget.loader");
	customObj = myGroup.findObject("widget.holder");

	gotThemes = ct_fakeLayer.isInvalid();
	//if(!ct_fakeLayer.isInvalid()) gotThemes=true;

	Map myMap = new Map;
	myMap.loadMap("read.suiframe.png");
	if(myMap.getWidth()>=272) cuseqbg=true;
	else  cuseqbg=false;
	delete myMap;

	//Saved Settings
	openDrawer(getPublicInt("cPro.lastDrawer", 0));
}


but_drawerGoto.onleftClick(){
	popMenu = new PopUpMenu;

	popMenu.addCommand("Equalizer", 0, 0, 0);
	popMenu.addCommand("Tag Viewer", 1, 0, 0);
	popMenu.addCommand("Visualization", 3, 0, 0);
	popMenu.addCommand("Color Themes", 5, 0, gotThemes);
	popMenu.addCommand("Saved Playlists", 2, 0, 0);
	popMenu.addCommand("Skin Chooser", 4, 0, 0);

	widgetmenu = new PopUpMenu;

	int count = 0;
	for (int x = 0; x < dummyBuck.getNumChildren(); x++) {//**
		GuiObject gr = dummyBuck.enumChildren(x);
		widgetmenu.addCommand(gr.getXMLparam("name"), 100+x, getPublicInt("cPro.lastDrawer", 0) == 100+x, 0);
		count++;
	}

	if (count == 0) widgetmenu.addCommand("No widgets found for this view!", -1, 0, 1);
	popMenu.addSubMenu(widgetmenu, "Widgets");


	popMenu.addSeparator();
	popMenu.addCommand("Close drawer", -2, 0, 0);//** Item code changed to -2 to support widgets.

	popMenu.checkCommand(getPublicInt("cPro.lastDrawer", 0), 1);

	int result = popMenu.popAtXY(clientToScreenX(but_drawerGoto.getLeft()), clientToScreenY(but_drawerGoto.getTop() + but_drawerGoto.getHeight()));

	if(result>=0) openDrawer(result);
	else if(result == -2){
		setPublicInt("cPro.draweropened", 0);
		myGroup.hide();
	}

	delete popMenu;
	delete widgetmenu;
	complete;
}

openDrawer(int drawerNo){
	//Safety check to see if the widgets is still there ;)
	if(drawerNo>=100){
		if(dummyBuck.getNumChildren()<drawerNo-99) drawerNo=0;
	}

	drawer_equalizer.hide();
	drawer_tagviewer.hide();
	drawer_savedpl.hide();
	drawer_avs.hide();
	drawer_ct.hide();
	drawer_skinchooser.hide();
	customObj.hide();

	if(cuseqbg){
		if(drawerNo==0){
			gad_Grid.hide();
			gad_Grid2.show();
		}
		else{
			gad_Grid2.hide();
			gad_Grid.show();
		}
	}

	if(drawerNo==1) drawer_tagviewer.show();
	else if(drawerNo==2) drawer_savedpl.show();
	else if(drawerNo==3){
		if(getPublicInt("cPro.lastMini", 0)==2){
			cpro_sui.sendAction ("switch_to_mini", "", 0, 0, 0, 0);
		}
		if(getPublicInt("cPro.lastComponentPage", 0)==2){
			cpro_sui.sendAction ("switch_to_tab", "", 0, 0, 0, 0);
		}
		drawer_avs.show();
	}
	else if(drawerNo==4) drawer_skinchooser.show();
	else if(drawerNo==5 && !gotThemes) drawer_ct.show();
	else if(drawerNo >= 100) {
		GuiObject gr = dummyBuck.enumChildren(drawerNo-100);
		String id = gr.getXMLparam("userdata");
		customObj.setXmlParam("groupid", id);
		customObj.show();
	}
	else{
		drawerNo=0;
		drawer_equalizer.show();
	}

	setPublicInt("cPro.lastDrawer", drawerNo);
}

myGroup.onAction (String action, String param, int x, int y, int p1, int p2, GuiObject source){
	if (strlower(action) == "switch_to_drawer") openDrawer(x);
}

but_drawerGoto.onEnterArea(){
	mouse_but_drawerGoto=true;
}
but_drawerGoto.onLeaveArea(){
	mouse_but_drawerGoto=false;
}

myLayout.onMouseWheelUp(int clicked , int lines){
	if(mouse_but_drawerGoto){
		gotoNextDrawer();
		return 1;
	}
}

myLayout.onMouseWheelDown(int clicked , int lines){
	if(mouse_but_drawerGoto){
		gotoPrevDrawer();
		return 1;
	}
}

gotoPrevDrawer(){
	int pos = getPublicInt("cPro.lastDrawer", 0);
	pos--;
	
	if(pos==3) pos--; //we dont toggle to the visualizer because its slows it down & loose focus ;)
	if(pos==99)	pos=5-gotThemes;
	if(pos<0) pos=dummyBuck.getNumChildren()+99;
	openDrawer(pos);
}
gotoNextDrawer(){
	int pos = getPublicInt("cPro.lastDrawer", 0);
	pos++;
	
	if(pos==3) pos++; //we dont toggle to the visualizer because its slows it down & loose focus ;)
	if(pos==6-gotThemes) pos=100;
	openDrawer(pos);
}