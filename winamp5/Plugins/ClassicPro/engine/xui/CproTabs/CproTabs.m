/**
 * tabs.m
 *
 * Attention: the ID values for internal tabs are saved in studio.xnf incremented by one!
 *
 * @author mpdeimos
 * @date 08/11/11
 * @version 0.1
 */

#include <lib/std.mi>
#include <lib/config.mi>

#define DISPATCH
#include dispatch_codes.m

//#define DEBUG
#define debugTabs //

// this is the page that maps its items to the windows menu (aka View), you can add attribs or more pages (submenus)
#define CUSTOM_WINDOWSMENU_ITEMS "{6559CA61-7EB2-4415-A8A9-A2AEEF762B7F}"

Class GuiObject Tab;
// {
	Member Int Tab.mid;
	Member Int Tab.w;
	Member Int Tab.maxW;
	Member Int Tab.lastX;
	Member Int Tab.initX;
	Member Int Tab.pos;
	Member Boolean Tab.moving;
	Member Boolean Tab.isInternal;
	Member Int Tab.ID;
	Member String Tab.IDS;
	Member boolean Tab.removed;
	Member boolean Tab.statusbar;

	//Stimulating a doubled linked list
	Member GuiObject Tab.left;
	Member GuiObject Tab.right;
// }

#define WIDGET_TAB_ID -666

Function moveLeft (Tab t);
Function moveRight (Tab t);
Function moveTo (Tab g, int x);
Function updateTabWidth(Tab t);
Function forceAlign(Tab t);
Function align(Tab t); // uses one of the two methods below
Function alignFull(Tab t);
Function alignByResize();
Function removeTab(Tab t);
Function closeTab(tab t);

#ifdef DEBUG
Function debugTab (Tab t);
Function debugTabs ();
#endif

Global Tab firstTab, lastTab, lastActiveT;
Global ToggleButton lastActive;
Global Group sg, tabHolder, CproSUI, CproBrowser;
Global int totalTabWidth;
Global ComponentBucket widgetLoader;
Global boolean aligned, checkedBrowser; // @martin: remove this when done ;)
Global PopUpMenu popMenu;
Global List hiddenTabs;

Global ConfigItem custom_windows_page;
Class ConfigAttribute CproTabAtt;
	Member Int CproTabAtt.ID;
	Member String CproTabAtt.IDS;

Global CproTabAtt tabWinAtt;
Global ConfigAttribute sui_browser_attrib;

System.onScriptLoaded ()
{
	checkedBrowser = false;
	
	sg = getScriptGroup();
	tabHolder = sg.findObject("cprotabs.buttons");
	widgetLoader = sg.findObject("widget.loader");

	setDispatcher(tabHolder);

	CproSUI = getScriptGroup().getParent().getParent().getParent().getParent();

	//TODO> use stringtables
	List internalNames = new List;
	internalNames.addItem("Media Library");		//0
	internalNames.addItem("Playlist");			//1
	internalNames.addItem("Video");				//2
	internalNames.addItem("Visualization");		//3
	internalNames.addItem("Browser");			//4
	internalNames.addItem("@ALL@");				//5

	/** Create ordered list of all saved tabs */

	Bitlist isInternal = new BitList;
	hiddenTabs = new List;
	List orderedTabs = new List;
	List widgetNames = new List;
	Bitlist passedWidgets = new BitList;
	Bitlist skipWidget = new BitList;
	passedWidgets.setSize(widgetLoader.getNumChildren());
	// TODO maybe remove some lists :P

	int n = getPrivateInt("ClassicPro", "TabOrder_nItems", 0);
	skipWidget.setSize(n);
	if (n == 0) // First start, we need to init!
	{
		isInternal.setSize(internalNames.getNumItems());
		for ( int i = 0; i < internalNames.getNumItems(); i++ )
		{
			isInternal.setItem(i, true);
			orderedTabs.addItem(i);
		}

		for (int i = 0; i < widgetLoader.getNumChildren(); i++)
		{
			isInternal.setItem(internalNames.getNumItems()+i, false);
			GuiObject d = widgetLoader.enumChildren(i);
			orderedTabs.addItem(d.getXmlParam("userdata"));
			widgetNames.addItem(d.getXMLparam("name"));
		}
	}
	else
	{
		isInternal.setSize(n);
		for ( int i = 0; i < n; i++ )
		{
			String ids = getPrivateString("ClassicPro", "TabOrder_item_" + integerToString(i), "");
			int id = stringToInteger(ids);
			if (id)
			{
				isInternal.setItem(i, true);
				orderedTabs.addItem(id-1);
			}
			else
			{
				// IMPORTANT! We need to check if the widget has been removed
				if (!isInternal.getItem(i))
				{
					boolean found = false;
					for ( int j = 0; j < widgetLoader.getNumChildren(); j++ )
					{
						GuiObject d = widgetLoader.enumChildren(j);
						if (getToken(d.getXmlParam("userdata"), ";", 0) == ids)
						{
							passedWidgets.setItem(j, true); // Mark this widget to be inited
							widgetNames.addItem(d.getXMLparam("name"));
							isInternal.setItem(i, false);
							orderedTabs.addItem(ids);
							found = true;
							break;
						}
					}
					if (!found)// this means the widget must have been deleted!
					{
						skipWidget.setItem(i, true);
						orderedTabs.addItem(NULL);
					}
				}
			}
		}

		/** One last thing to do is that there might have been new widgets installed since last engine load */
		for ( int i = 0; i < passedWidgets.getSize(); i++ )
		{
			if (!passedWidgets.getItem(i))
			{
				isInternal.setSize(isInternal.getSize()+1);
				isInternal.setItem(isInternal.getSize()-1, false);
				GuiObject d = widgetLoader.enumChildren(i);
				orderedTabs.addItem(d.getXmlParam("userdata"));
				widgetNames.addItem(d.getXMLparam("name"));
			}
		}
	}


	/** Load Window menu */
	custom_windows_page = Config.getItem(CUSTOM_WINDOWSMENU_ITEMS);
	sui_browser_attrib = custom_windows_page.newAttribute("Web Browser\tAlt+X", "0");
	
	/** Bring ordered tabs into action */

	int initPos = 0;
	GuiObject pre = NULL;

	for ( int i = 0; i < orderedTabs.getNumItems(); i++ )
	{
		if (!skipWidget.getItem(i))
		{			
			Tab tabI = newGroup("cpro.tab");
			tabI.setXmlParam("x", integerToString(totalTabWidth));
			tabI.setXmlParam("y", "0");

			if (isInternal.getItem(i)) // internal tab?
			{
				tabI.ID = orderedTabs.enumItem(i);
				tabI.IDS = "";
				tabI.isInternal = true;
			}
			else
			{
				tabWinAtt = custom_windows_page.newAttribute(widgetNames.enumItem(0), "0");
				tabWinAtt.IDS = getToken(orderedTabs.enumItem(i), ";", 0);

				tabI.ID = WIDGET_TAB_ID;
				tabI.IDS = getToken(orderedTabs.enumItem(i), ";", 0);
				tabI.statusbar = stringToInteger(getToken(orderedTabs.enumItem(i), ";", 1));
				tabI.isInternal = false;
			}

			Boolean hideTab;
			if(tabI.ID==WIDGET_TAB_ID){
				hideTab = ((getPublicInt("Cpro.One.TabAutoClose."+tabI.IDS, 0)) && !(tabI.IDS==getPublicString("cPro.lastMainWidgetIDS", "") && getPublicInt("cPro.lastComponentPage", 0)==WIDGET_TAB_ID));
			}
			else hideTab = ((getPublicInt("Cpro.One.TabAutoClose."+integerToString(tabI.ID), 0) || tabI.ID == 5) && (tabI.ID != getPublicInt("cPro.lastComponentPage", 0)));

			if (!hideTab)
			{
				tabI.pos = i;
				tabI.left = pre;

				if (pre != NULL)
				{
					Tab l = pre;
					l.right = tabI;	
				}
				pre = tabI;
				tabI.right = NULL;
			}
			else
			{
				tabI.setXmlParam("visible", "0");
				hiddenTabs.addItem(tabI);
				tabI.removed = true;
			}
			

			tabI.init(tabHolder);

			text t = tabI.findObject("cpro.tab.text");
			if (tabI.isInternal)
			{
				t.setXmlParam("text", internalNames.enumItem(tabI.ID));	
			}
			else
			{
				t.setXmlParam("text", widgetNames.enumItem(0));
				widgetNames.removeItem(0);
			}
			
			updateTabWidth(tabI);
			if (hideTab)
			{
				totalTabWidth -= tabI.w;				
			}

		}
	}

	aligned = true;
	lastTab = pre;
	Tab t = pre;

	while (t.left != null)
	{
		t = t.left;
	}
	
	lastActive = lastActiveT = NULL;
	firstTab = t;

	debugTabs();

	delete internalNames;
	delete isInternal;
	delete widgetNames;
	delete skipWidget;
	delete passedWidgets;
}

System.onScriptUnloading ()
{
	/** save tab order */
	Tab t = firstTab;
	Int n;
	while (t != NULL)
	{
		if (t.isInternal)
		{
			setPrivateInt("ClassicPro", "TabOrder_item_" + integerToString(n), t.ID+1);
		}
		else
		{
			setPrivateString("ClassicPro", "TabOrder_item_" + integerToString(n), t.IDS);
		}
		
		n++;
		t = t.right;
	}

	setPrivateInt("ClassicPro", "TabOrder_nItems", n);

	/** save hidden tabs (we just concat the lists for now!)*/
	//TODO move to extra list in studio.xnf

	//n = 0;

	for ( int i = 0; i < hiddenTabs.getNumItems(); i++ )
	{
		t = hiddenTabs.enumItem(i);
		/*if (t.isInternal)
		{
			setPrivateInt("ClassicPro", "TabOrder_hiddenItem_" + integerToString(n), t.ID+1);
		}
		else
		{
			setPrivateString("ClassicPro", "TabOrder_hiddenItem_" + integerToString(n), t.IDS);
		}*/
		if (t.isInternal)
		{
			setPrivateInt("ClassicPro", "TabOrder_item_" + integerToString(n), t.ID+1);
		}
		else
		{
			setPrivateString("ClassicPro", "TabOrder_item_" + integerToString(n), t.IDS);
		}
		
		n++;
	}

	//setPrivateInt("ClassicPro", "TabOrder_nHiddenItems", n);
	setPrivateInt("ClassicPro", "TabOrder_nItems", n);

	delete hiddenTabs;
}


tabHolder.onResize (int x, int y, int w, int h)
{
	if (w <= 0)
	{
		return;
	}
	
	align(firstTab);
}

onMessage(int message, int i0, int i1, int i2, String s0, String s1, GuiObject obj)
{
	Tab t = obj;

	if (message == ON_LEFT_BUTTON_DOWN)
	{
		if (t.isGoingToTarget())
			return SUCCESS;

		t.lastX = i0;
		t.initX = t.getGuiX();
		t.bringToFront();
		t.moving = true;

		return SUCCESS;
	}
	if (message == ON_LEFT_BUTTON_UP)
	{
		if (t.isGoingToTarget())
			return SUCCESS;

		if (t.moving)
		{
			moveTo(t, t.initX);
			debugTabs();
		}
		
		t.moving = false;

		t.hide();
		t.show(); //so we update hover state

		return SUCCESS;
	}
	else if (message == ON_MOUSE_MOVE)
	{
		if (t.isGoingToTarget())
			return SUCCESS;

		if (t.moving)
		{
		t.bringToFront();
			int newPos = i0 - t.lastX + t.getGuiX();

			if (newPos < 0)
			{
				newPos = 0;
			}
			else if (newPos > tabHolder.getWidth() - t.w)
			{
				newPos = tabHolder.getWidth() - t.w;
			}
			else
			{
				t.lastX = i0;	
			}

			t.setXmlParam("x", integerToString(newPos));

			Tab left = t.left;
			if (left != null)
			{
				if (newPos < left.mid + left.getGuiX() && !left.isGoingToTarget())
				{
					moveLeft(t);
					return SUCCESS;
				}
			}
			Tab right = t.right;
			if (right != null)
			{
				if (newPos > right.mid + right.getGuiX() - t.getGuiW() && !right.isGoingToTarget())
				{
					moveRight(t);
				}
			}

			return SUCCESS;

		}
	}
	else if (message == ON_TAB_ACTIVATED)
	{
		closeTab(lastActiveT);
		CproSUI.sendAction ("show_tab", t.IDS, t.ID, 0, 0, 0);
		
		if(t.ID==WIDGET_TAB_ID){
			CproSUI.sendAction ("widget_statusbar", "", t.statusbar, 0, 0, 0);
		}
		lastActive = lastActiveT = t;
		t.moving = false;
	}
	else if (message == ON_RIGHT_BUTTON_UP)
	{
		int tabID = t.ID;
		String widID = t.IDS;
		popMenu = new PopUpMenu;
		
		if(tabID==0 || tabID==4 || tabID==5 || tabID==WIDGET_TAB_ID) popMenu.addCommand("Show Status Bar", 0, 0, 1);
		else popMenu.addCommand("Show Status Bar", 0, getPublicInt("Cpro.One.TabStatus."+integerToString(tabID), 1), 0);
		
		if(tabID==5) popMenu.addCommand("Auto Close Tab", 1, 1, 1);
		else if(tabID==WIDGET_TAB_ID) popMenu.addCommand("Auto Close Tab", 1, getPublicInt("Cpro.One.TabAutoClose."+widID, 0), 0);
		else popMenu.addCommand("Auto Close Tab", 1, getPublicInt("Cpro.One.TabAutoClose."+integerToString(tabID), 0), 0);
		// @martin here is the publicint set.. hide tab if int == 1... remember widgets cant hide... 
		//not going to add the previous submenu where you can enable things again..
		// must just add Web Browser to the View list in winamp now so that when its hidden the user can still open it via that  menu

		// The MediaLibrary tab must hide when its not installed (v1.04 already had this).. 
		//but forgot to not use MLIB as the default fallback tab when a tab close :P... will add this before 1.1 in centrosui

#ifdef DEBUG

		popMenu.addSeparator();

		if (t.left != NULL)
		{
			Tab d = t.left;
			popMenu.addCommand("LeftTab: " + d.findObject("cpro.tab.text").getXmlParam("text"), -1, 0, 1);
		}
		else
		{
			popMenu.addCommand("LeftTab: " + "~", -1, 0, 1);
		}

		if (t.right != NULL)
		{
			Tab d = t.right;
			popMenu.addCommand("RightTab: " + d.findObject("cpro.tab.text").getXmlParam("text"), -1, 0, 1);
		}
		else
		{
			popMenu.addCommand("RightTab: " + "~", -1, 0, 1);
		}

		popMenu.addSeparator();

		Tab d = firstTab;
		popMenu.addCommand("FirstTab: " + d.findObject("cpro.tab.text").getXmlParam("text"), -1, 0, 1);
		d = lastTab;
		popMenu.addCommand("LastTab: " + d.findObject("cpro.tab.text").getXmlParam("text"), -1, 0, 1);

		popMenu.addSeparator();

		for ( int i = 0; i < hiddenTabs.getNumItems(); i++ )
		{
			d = hiddenTabs.enumItem(i);
			popMenu.addCommand("Hidden: " + d.findObject("cpro.tab.text").getXmlParam("text"), -1, 0, 1);
		}
		

#endif
				
		int result = popMenu.popAtXY(i1,i2);
		delete popMenu;
		
		if(result!=-1)
		{
			if(result == 0)
			{
				setPublicInt("Cpro.One.TabStatus."+integerToString(tabID),!getPublicInt("Cpro.One.TabStatus."+integerToString(tabID), 1));
				CproSUI.sendAction ("refresh_tab_status", "", 0, 0, 0, 0);
			}
			else if(result == 1)
			{
				if(tabID==WIDGET_TAB_ID) setPublicInt("Cpro.One.TabAutoClose."+widID, !getPublicInt("Cpro.One.TabAutoClose."+widID, 0));
				else setPublicInt("Cpro.One.TabAutoClose."+integerToString(tabID), !getPublicInt("Cpro.One.TabAutoClose."+integerToString(tabID), 0));
				
				ToggleButton tg = t;
	
				if(!tg.getActivated()){ 
					if((tabID==WIDGET_TAB_ID && getPublicInt("Cpro.One.TabAutoClose."+widID, 0)) || (tabID!=WIDGET_TAB_ID && getPublicInt("Cpro.One.TabAutoClose."+integerToString(tabID), 0))){
						removeTab(t);
					}
				}
			}
		}
		complete;
	}
		
	// TODO
	/*else if (message == SET_TAB_W)
	{
		updateTabWidth (t);
		
		return SUCCESS;
	}*/
}

moveLeft (Tab t)
{
	Tab left = t.left;
	Tab left2 = left.left;
	Tab right = t.right;

	// Visual Moving
	int x = left.getGuiX();
	moveTo(left, x + t.w);
	t.initX = x;

	// Logical moving
	if (left2 != NULL)
	{
		left2.right = t;
	}
	else
	{
		firstTab = t;
	}
	
	t.left = left2;

	left.right = right;
	if (right != NULL)
	{
		right.left = left;		
	}
	else
	{
		lastTab = left;
	}
	

	left.left = t;
	t.right = left;

	debugTabs();
}

moveRight (Tab t)
{
	Tab left = t.left;
	Tab right = t.right;
	Tab right2 = right.right;

	// Visual Moving
	int x = right.getGuiX();
	moveTo(right, t.initX);
	t.initX += right.w;

	// Logical moving
	if (right2 != NULL)
	{
		right2.left = t;
	}
	else
	{
		lastTab = t;
	}
	t.right = right2;

	right.left = left;
	if (left != NULL)
	{
		left.right = right;		
	}
	else
	{
		firstTab = right;
	}
	

	right.right = t;
	t.left = right;

	debugTabs();
}

moveTo (Tab g, int x)
{
	g.cancelTarget();
	g.setTargetX(x);
	g.setTargetW(g.w);
	g.setTargetSpeed(0.4);
	g.gotoTarget();
}

removeTab(Tab t)
{
	if (t.removed)
	{
		return;
	}

	t.removed = true;
	
	t.hide();
	totalTabWidth -= t.maxW;

	Tab d = t.left;
	if (d != null)
	{
		d.right = t.right;
	}
	else
	{
		firstTab = t.right;
	}

	d = t.right;
	if (d != null)
	{
		d.left = t.left;
		d.setXmlParam("x", integerToString(t.getGuiX()));
		forceAlign(d);
	}
	else
	{
		lastTab = t.left;
	}
	

	//TODO align if tabs are not all visible!

	hiddenTabs.addItem(t);

	debugTabs();
}

/**
 * Call this one everytime the tab text has changed.
 */
updateTabWidth (Tab t)
{
	totalTabWidth -= t.maxW;
	t.w = t.findObject("cpro.tab.text").getAutoWidth() +14;
	t.maxW = t.w;
	totalTabWidth += t.maxW;
	t.mid = t.w/2;
	t.setXmlParam("w", integerToString(t.w));
}

forceAlign (Tab t)
{
	aligned = false;
	align(t);
}

align(Tab t)
{
	if (tabHolder.getWidth() < totalTabWidth)
	{
		aligned = false;
		alignByResize();
	}
	else if (!aligned)
	{		
		alignFull(firstTab);
		aligned = true;
	}
}

/**
 * Recursiv align of right hand side buttons
 */
alignFull (Tab t)
{
	if (t == NULL)
		return;

	t.w = t.maxW;
	t.mid = t.maxW/2;
	t.setXmlParam("w", integerToString(t.maxW));

	Tab right = t.right;
	if (right == NULL)
		return;
	right.setXmlParam("x", integerToString(t.maxW + t.getGuiX()));
	alignFull (right);
}

/**
 * Resizes tabs so we do not run out of space
 */
 
/* OLD CODE
alignByResize ()
{
	Tab t = firstTab;

	float ratio = tabHolder.getWidth()/totalTabWidth;
	int x = 0;

	while (t != NULL)
	{
		t.w = t.maxW*ratio;
		t.mid = t.w/2;
		
		t.setXmlParam("x", integerToString(x));
		t.setXmlParam("w", integerToString(t.w));
		x+=t.w;
		t = t.right;
	}
}*/
alignByResize ()
{
	Tab t = firstTab;
	
	/*
	Martin... please replace this peice of code...if possible... just used to count how many visible tabs are there... theres probably a better way to detect ;)
	*/
	int tabCountTemp = 0;
	while (t != NULL)	{
		tabCountTemp++;
		t = t.right;
	}
	t = firstTab;
	
	float ratio = (tabHolder.getWidth()-tabCountTemp*20)/(totalTabWidth-tabCountTemp*20);
	if(ratio<0) ratio=0;

	int x = 0;

	while (t != NULL)
	{
		t.w = (t.maxW-20)*ratio+20;
		t.mid = t.w/2;
		
		t.setXmlParam("x", integerToString(x));
		t.setXmlParam("w", integerToString(t.w));
		x+=t.w;
		t = t.right;
	}
}

closeTab (tab t)
{

	if (lastActive)
	{
		lastActive.setActivated(0);
		if(lastActiveT.ID == 5 || (getPublicInt("Cpro.One.TabAutoClose."+integerToString(t.ID), 0) && t.ID != WIDGET_TAB_ID) || (t.ID==WIDGET_TAB_ID && getPublicInt("Cpro.One.TabAutoClose."+t.IDS, 0)))
		{
			removeTab(t);
		}
	}
}

sg.onAction (String action, String param, int x, int y, int p1, int p2, GuiObject source)
{
	if(strlower(action) == "select_tab")
	{
		if(!checkedBrowser){
			CproBrowser = getContainer("main").getLayout("normal").findObject("centro.browser");
			//sui_browser_attrib.setData(integerToString(CproBrowser.isVisible())); //pjn123 - dont know why I put this here.. removed.. dont crash anymore
			checkedBrowser=true;
		}

		//Tab t; //pjn123 - changed this
		Tab t = firstTab;
		boolean found = false;

		if(t.ID != x)
		{
			closeTab(lastActiveT);
			//t = firstTab; //pjn123 - changed this
			while (t != NULL)
			{
				if (t.ID == x && ((x == WIDGET_TAB_ID && param == t.IDS) || x != WIDGET_TAB_ID))
				{
					lastActive = lastActiveT = t;
					lastActive.setActivated(1);
					found = true;
					break;
				}
				
				t = t.right;
			}
		}

		if (!found)
		{
			for ( int i = 0; i < hiddenTabs.getNumItems(); i++ )
			{
				t = hiddenTabs.enumItem(i);
				if (t.ID == x && ((x == WIDGET_TAB_ID && param == t.IDS) || x != WIDGET_TAB_ID))
				{
					lastActive = lastActiveT = t;
					lastActive.setActivated(1);

					t.left = lastTab;
					lastTab.right = t;
					t.right = null;

					t.setXmlParam("x", integerToString(lastTab.getGuiX() + lastTab.w));
					t.show();
					t.removed = false;

					lastTab = t;

					totalTabWidth += t.maxW;
					forceAlign(firstTab);

					hiddenTabs.removeItem(i);
					break;
				}			
			}
		}
	
		if(t.ID==WIDGET_TAB_ID)
		{
			CproSUI.sendAction ("widget_statusbar", "", t.statusbar, 0, 0, 0);
		}
	}
	else if(strlower(action) == "update_tabname")
	{			
		Tab tabI = firstTab;
		while (tabI != null)
		{
			if (tabI.isInternal)
			{
				if (tabI.ID == x)
				{
					text t = tabI.findObject("cpro.tab.text");
					t.setXmlParam("text", param);
					int oldTotalTabWidth = totalTabWidth;
					updateTabWidth(tabI);

					if (sg.getWidth() < totalTabWidth || sg.getWidth() < oldTotalTabWidth)
					{
						alignByResize();
					}
					else
					{
						align(tabI);	
					}
					return;
				}
			}
			tabI = tabI.right;
		}	
	}
	debugTabs();
}


CproTabAtt.onDataChanged(){
	if(CproTabAtt.getData()=="1")
	{
		CproSUI.sendAction ("switch_to_tab", CproTabAtt.IDS, WIDGET_TAB_ID, 0, 0, 0);
		CproTabAtt.setData("0");
	}
}

sui_browser_attrib.onDataChanged(){
	if(sui_browser_attrib.getData()=="1")
	{
		CproSUI.sendAction ("switch_to_tab", "", 4, 0, 0, 0);
	}
	else if(sui_browser_attrib.getData()=="0" && CproBrowser.isVisible()){
		CproSUI.sendAction ("switch_to_tab", "", 0, 0, 0, 0); // remember to add the planned future goto history tab here too! atm is just goto the lib
	}
}

CproBrowser.onSetVisible(boolean onOff){
	if(onOff) sui_browser_attrib.setData("1");
	else sui_browser_attrib.setData("0");
}
System.onKeyDown(String key) {
	if (key == "alt+x")
	{
		if (sui_browser_attrib.getData() == "0") sui_browser_attrib.setData("1");
		else sui_browser_attrib.setData("0");
		complete;
	}
}

#ifdef DEBUG

debugTabs()
{
	Tab t = firstTab;
	while (t != null)
	{
		debugTab(t);
		t = t.right;
	}
}

debugTab (Tab t)
{
	if (t.left != NULL)
	{
		Tab d = t.left;
		t.findObject("l").setXmlParam("text", (d.findObject("cpro.tab.text").getXmlParam("text")));
	}
	else
	{
		t.findObject("l").setXmlParam("text", "~");
	}

	if (t.right != NULL)
	{
		Tab d = t.right;
		t.findObject("r").setXmlParam("text", (d.findObject("cpro.tab.text").getXmlParam("text")));
	}
	else
	{
		t.findObject("r").setXmlParam("text", "~");
	}
}
#endif
