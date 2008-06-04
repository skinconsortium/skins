#include <lib/std.mi>

#define CODE_MARTIN //

Function openDrawer(int drawerNo);

Global Group myGroup;
Global Group drawer_equalizer, drawer_savedpl, drawer_tagviewer, drawer_avs, drawer_skinchooser;
Global PopUpMenu popMenu;
Global Button but_drawerGoto;
Global GuiObject cpro_sui;

CODE_MARTIN start
Global ComponentBucket dummyBuck;
Global GuiObject customObj;
CODE_MARTIN end

System.onScriptLoaded() {
	myGroup = getScriptGroup();
	but_drawerGoto = myGroup.findObject("drawer.menulist");
	drawer_equalizer = myGroup.findObject("drawer.equalizer");
	drawer_tagviewer = myGroup.findObject("drawer.tagviewer");
	drawer_savedpl = myGroup.findObject("drawer.savedpl");
	drawer_avs = myGroup.findObject("drawer.avs");
	drawer_skinchooser = myGroup.findObject("drawer.skinchooser");
	
	cpro_sui = getContainer("main").getLayout("normal").findObject("cpro.sui");

	CODE_MARTIN start
	dummyBuck = myGroup.findObject("widget.loader");
	customObj = myGroup.findObject("widget.holder");
	CODE_MARTIN end

	//Saved Settings
	openDrawer(getPublicInt("cPro.lastDrawer", 0));
}


but_drawerGoto.onleftClick(){
	popMenu = new PopUpMenu;

	popMenu.addCommand("Equalizer", 0, 0, 0);
	popMenu.addCommand("Tag Viewer", 1, 0, 0);
	popMenu.addCommand("Saved Playlists", 2, 0, 0);
	popMenu.addCommand("Visualizer", 3, 0, 0);
	popMenu.addCommand("Skin Chooser", 4, 0, 0);

  //** Widgets code start
  PopUpMenu widgetmenu;
  widgetmenu = new PopUpMenu;

 CODE_MARTIN start
   //int u = 0;
   int count = 0;
  /* old code
  for (int x = 0; x < myGroup.getNumObjects(); x++) {//**
    GuiObject gr = myGroup.enumObject(x);
    if (strsearch(gr.getId(),"entro.widget") != -1) {
      u++;
      if (strsearch(getToken(gr.getXMLparam("name"),"|",1),"rawer") != -1) { widgetmenu.addCommand(getToken(gr.getXMLparam("name"),"|",0), 100+u-1, getPrivateInt(getSkinName(), "lastDrawer", 0) == 100+u-1, 0); count++; }
    }
  }
  */
	for (int x = 0; x < dummyBuck.getNumChildren(); x++) {//**
		GuiObject gr = dummyBuck.enumChildren(x);
	      widgetmenu.addCommand(gr.getXMLparam("name"), 100+x, getPublicInt("cPro.lastDrawer", 0) == 100+x, 0);
	      count++;
	}
CODE_MARTIN end

  if (count == 0) widgetmenu.addCommand("No widgets found for this view!", -1, 0, 1);
  popMenu.addSubMenu(widgetmenu, "Widgets");
  //** Widgets code end

	popMenu.addSeparator();
	popMenu.addCommand("Close drawer", -2, 0, 0);//** Item code changed to -2 to support widgets.

	popMenu.checkCommand(getPublicInt("cPro.lastDrawer", 0), 1);

	int result = popMenu.popAtXY(clientToScreenX(but_drawerGoto.getLeft()), clientToScreenY(but_drawerGoto.getTop() + but_drawerGoto.getHeight()));

	// Old code. Rewritten to support widgets below.
  /*if(result>=0 && result<4){
		openDrawer(result);
	}
	else if(result>3){
		myGroup.hide(); //Centro:SUI will autoclose/open the drawer on hide/show :)
	}*/
  
  //** Widgets code start
	if(result>=0)	openDrawer(result);
	else if(result == -2){
		setPublicInt("cPro.draweropened", 0);
		myGroup.hide();
	}
	//** Widgets code end

  delete popMenu;
  delete widgetmenu;//** Widgets code
	complete;
}

openDrawer(int drawerNo){

	drawer_equalizer.hide();
	drawer_tagviewer.hide();
	drawer_savedpl.hide();
	drawer_avs.hide();
	drawer_skinchooser.hide();

CODE_MARTIN start
/* not needed anymore
  //** Widgets code start
  int firstwidgetnum = 0;
  for (int x = 0; x < myGroup.getNumObjects(); x++) {//** Will hide all "miniex" groups.
    GuiObject gr = myGroup.enumObject(x);
    if (strsearch(gr.getId(),"entro.widget") != -1) {
      gr.hide();
      if(firstwidgetnum == 0) firstwidgetnum = x;
    }
  }
  //** Widgets code end
*/
	customObj.hide();
CODE_MARTIN end

	if(drawerNo==0){
		drawer_equalizer.show();
	}
	else if(drawerNo==1){
		drawer_tagviewer.show();
	}
	else if(drawerNo==2){
		drawer_savedpl.show();
	}
	else if(drawerNo==3){
		if(getPublicInt("cPro.lastMini", 0)==2){
			cpro_sui.sendAction ("switch_to_mini", "", 0, 0, 0, 0);
		}
		if(getPublicInt("cPro.lastComponentPage", 0)==2){
			cpro_sui.sendAction ("switch_to_tab", "", 0, 0, 0, 0);
		}
		drawer_avs.show();
	}
	else if(drawerNo==4){
		drawer_skinchooser.show();
	}

  //** Widgets code start
  else if(drawerNo >= 100) {
 CODE_MARTIN start
    //GuiObject gr = myGroup.enumObject(firstwidgetnum+drawerNo-100);
    //gr.Show();
    GuiObject gr = dummyBuck.enumChildren(drawerNo-100);
    String id = gr.getXMLparam("userdata");
    customObj.setXmlParam("groupid", id);
    customObj.show();
  }
  //** Widgets code end
	setPublicInt("cPro.lastDrawer", drawerNo);
}

myGroup.onAction (String action, String param, int x, int y, int p1, int p2, GuiObject source)
{
	// Switch to new tab
	if (strlower(action) == "switch_to_drawer"){
		openDrawer(x);
	}
}