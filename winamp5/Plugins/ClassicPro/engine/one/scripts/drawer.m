#include <lib/std.mi>

Function openDrawer(int drawerNo);
Function gotoPrevDrawer();
Function gotoNextDrawer();
Function setDrawerBG(int mode); //0=normal, 1=tagview, 2=neweq

Class Group CProWidget;
// {
	Member boolean CProWidget.scrollSkip;
	Member boolean CProWidget.disabled;
	Member int CProWidget.custombg;
	Member boolean CProWidget.hideVis;
// }

#define userWidgetOffset 100
Global int numUserWidgets = 0;
Global int numInternalWidgets = 0;

Global Layout myLayout;
Global Group myGroup;
Global CProWidget drawer_equalizer, drawer_savedpl, drawer_tagviewer, drawer_avs, drawer_ct, drawer_skinchooser;
Global PopUpMenu popMenu, widgetmenu;
Global Button but_drawerGoto;
Global GuiObject cpro_sui, gad_Grid, gad_GridEQ;
Global Layer ct_fakeLayer;
Global Boolean gotThemes, mouse_but_drawerGoto, cuseqbg;

Global ComponentBucket dummyBuck;
Global GuiObject customObj;
Global List internalWidgets;

System.onScriptLoaded() {
	internalWidgets = new List;

	myLayout = getContainer("main").getLayout("normal");

	myGroup = getScriptGroup();
	but_drawerGoto = myGroup.findObject("drawer.menulist");

	drawer_equalizer = myGroup.findObject("drawer.equalizer");
	drawer_equalizer.custombg = 2;
	internalWidgets.addItem(drawer_equalizer);

	drawer_tagviewer = myGroup.findObject("drawer.tagviewer");
	drawer_tagviewer.custombg = 1;
	internalWidgets.addItem(drawer_tagviewer);

	drawer_avs = myGroup.findObject("drawer.avs");
	drawer_avs.scrollSkip = TRUE;
	drawer_avs.hideVis = TRUE;
	internalWidgets.addItem(drawer_avs);
	//internalWidgets.addItem(drawer_avs);

	drawer_ct = myGroup.findObject("drawer.colortheme");
	ct_fakeLayer = myGroup.findObject("drawer.ct.fakelayer");
	drawer_ct.disabled = ct_fakeLayer.isInvalid();
	internalWidgets.addItem(drawer_ct);

	drawer_savedpl = myGroup.findObject("drawer.savedpl");
	internalWidgets.addItem(drawer_savedpl);

	drawer_skinchooser = myGroup.findObject("drawer.skinchooser");
	internalWidgets.addItem(drawer_skinchooser);

	numInternalWidgets = internalWidgets.getNumItems();

	gad_Grid = myGroup.findObject("centro.gadget.grid");
	gad_GridEQ = myGroup.findObject("centro.gadget.grid.eq");
	
	cpro_sui = getContainer("main").getLayout("normal").findObject("cpro.sui");

	dummyBuck = myGroup.findObject("widget.loader");
	customObj = myGroup.findObject("widget.holder");

	numUserWidgets = dummyBuck.getNumChildren();

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

	// Faster to load it once!
	int cur = getPublicInt("cPro.lastDrawer", 0);

	for ( int i = 0; i < numInternalWidgets; i++ )
	{
		CProWidget gr = internalWidgets.enumItem(i);
		popMenu.addCommand(gr.getXMLparam("name"), i, cur == i, gr.disabled);
	}

	widgetmenu = new PopUpMenu;

	int x;
	for (x = 0; x < numUserWidgets; x++) {
		GuiObject gr = dummyBuck.enumChildren(x);
		widgetmenu.addCommand(gr.getXMLparam("name"), userWidgetOffset+x, cur == userWidgetOffset+x, 0);
	}

	if (x == 0) widgetmenu.addCommand("No widgets found for this view!", -1, 0, 1);
	popMenu.addSubMenu(widgetmenu, "Widgets");


	popMenu.addSeparator();
	popMenu.addCommand("Close drawer", -2, 0, 0);//** Item code changed to -2 to support widgets.

	//popMenu.checkCommand(getPublicInt("cPro.lastDrawer", 0), 1);

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
	if(drawerNo>=userWidgetOffset){
		if (drawerNo - userWidgetOffset > dummyBuck.getNumChildren()-1)
		{
			drawerNo=0;
		}
		
	}
	
	for ( int i = 0; i < numInternalWidgets; i++ )
	{
		CProWidget gr = internalWidgets.enumItem(i);
		gr.hide();
	}
	customObj.hide();

	// We have to show an Internal Widget
	if (drawerNo < userWidgetOffset)
	{
		CProWidget gr = internalWidgets.enumItem(drawerNo);

		if (gr.disabled == TRUE)
		{
		drawerNo = 0;
			gr = internalWidgets.enumItem(drawerNo); // Load Default Widget
		}

		setDrawerBG(gr.custombg);
		/*if(cuseqbg){
		if(gr.custombg==0){
				gad_Grid.hide();
				gad_Grid2.show();
			}
			else{
				gad_Grid2.hide();
				gad_Grid.show();
		}
		}*/

		/*if (gr.hideVis == TRUE)
		{
			// TODO
			// it seems that it is a prob that vis is now id=2 and not id=3
			// I've located the stuff in controsui: ll 550, 661, 723, 1085 -- it is just comparing w/ the id!!!
			// but ideally we should handle this completely another way!
			// i would send cpro_sui.sendAction ("release", "vis", 0, 0, 0, 0);
			// then any widget or centrosui catches this even and should hide 'his' vis group and perform retabbing actions
			// after this has happened we can open the vis again in the new area

			if(getPublicInt("cPro.lastMini", 0)==2){
				cpro_sui.sendAction ("switch_to_mini", "", 0, 0, 0, 0);
			}
			if(getPublicInt("cPro.lastComponentPage", 0)==2){
				cpro_sui.sendAction ("switch_to_tab", "", 0, 0, 0, 0);
			}
			
			pjn: just changed the centrosui stuff from 3 to 2.
			Current method works great and if the above is implemented it wont improve anything since the drawer and centrosui is 
			still very dependant on each other either way.
			
			Centro still needs to know what drawer is openned because it must see where the vis plugin is trying to open..
			so the above might not be so easy.. but just had a quick look tbh.
			
			-----
			tbh would like to have a centro v2 thats integrate the drawer and make use of the internal widgets to load the drawers like eq for example.
			Then the drawer can register itself as a guid owner so if its openned and that guid comes along the sui system leave the call.
			Then add a new xui thats just for tabs with on the fly creating and nice animated moves... and support right click menu's...
			then we'll have a real winner ;)
		}*/

		gr.show();
	}
	else
	{
		setDrawerBG(0); //martin.. this must be custom set by widget
		GuiObject gr = dummyBuck.enumChildren(drawerNo-userWidgetOffset);
		String id = gr.getXMLparam("userdata");
		customObj.setXmlParam("groupid", id);
		customObj.show();
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
		gotoPrevDrawer();
		return 1;
	}
}
myLayout.onMouseWheelDown(int clicked , int lines){
	if(mouse_but_drawerGoto){
		gotoNextDrawer();
		return 1;
	}
}

System.onKeyDown(String key){
	if(key=="f7") gotoPrevDrawer();
	else if(key=="f8") gotoNextDrawer();
}

gotoPrevDrawer(){ //wheelup
	int pos = getPublicInt("cPro.lastDrawer", 0);

	if (pos == userWidgetOffset)
	{
		pos = numInternalWidgets;
	}
	if (pos == 0)
	{
		pos = userWidgetOffset + numUserWidgets;
	}
	pos--;
	if (pos < userWidgetOffset)
	{
		CProWidget gr = internalWidgets.enumItem(pos);
		if (gr.scrollSkip || gr.disabled)
		{
			setPublicInt("cPro.lastDrawer", pos);
			gotoPrevDrawer();
			return;
		}
	}

	openDrawer(pos);
}
gotoNextDrawer(){ //wheelDown
	int pos = getPublicInt("cPro.lastDrawer", 0);

	pos++;
	if (pos == userWidgetOffset + numUserWidgets)
	{
		pos = 0;
	}
	if (pos == numInternalWidgets)
	{
		pos = userWidgetOffset;
	}

	if (pos < userWidgetOffset)
	{
		CProWidget gr = internalWidgets.enumItem(pos);
		if (gr.scrollSkip || gr.disabled)
		{
			setPublicInt("cPro.lastDrawer", pos);
			gotoNextDrawer();
			return;
		}
	}
	openDrawer(pos);
}

setDrawerBG(int mode){
	if(mode==0){
		gad_GridEQ.hide();
		gad_Grid.setXmlParam("bottomleft", "player.gframe.7");
		gad_Grid.show();
	}
	else if(mode==1){
		gad_GridEQ.hide();
		gad_Grid.setXmlParam("bottomleft", "player.gframe.7.alt");
		gad_Grid.show();
	}
	else if(mode==2){
		if(!cuseqbg){
			setDrawerBG(0);
			return;
		}
		gad_Grid.hide();
		gad_GridEQ.show();
	}
}