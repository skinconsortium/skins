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
#define DISPATCH
#include dispatch_codes.m

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

	//Stimulating a doubled linked list
	Member GuiObject Tab.left;
	Member GuiObject Tab.right;
// }

Function moveLeft (Tab t);
Function moveRight (Tab t);
Function moveTo (Tab g, int x);
Function updateTabWidth(Tab t);
Function alignFull(Tab t);
Function alignByResize();

Global Tab firstTab, lastTab;
Global ToggleButton lastActive;
Global Group sg, tabHolder, CproSUI;
Global int totalTabWidth;

Global boolean aligned;

System.onScriptLoaded ()
{
	sg = getScriptGroup();
	tabHolder = sg.findObject("cprotabs.buttons");
	setDispatcher(tabHolder);

	CproSUI = getScriptGroup().getParent().getParent().getParent().getParent();

	//TODO> use stringtables
	List internalNames = new List;
	internalNames.addItem("Media Library");
	internalNames.addItem("Playlist");
	internalNames.addItem("Video");
	internalNames.addItem("Visualization");
	internalNames.addItem("Browser");
	internalNames.addItem("@ALL@");

	/** Create ordered list of all saved tabs */

	Bitlist isInternal = new BitList;
	List orderedTabs = new List;

	int n = getPrivateInt("ClassicPro", "TabOrder_nItems", 0);
	if (n == 0) // First start, we need to init!
	{
		isInternal.setSize(internalNames.getNumItems());
		for ( int i = 0; i < internalNames.getNumItems(); i++ )
		{
			isInternal.setItem(i, true);
			orderedTabs.addItem(i);
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
				isInternal.setItem(i, false);
				orderedTabs.addItem(ids);
			}
		}
	}
	

	/** Bring ordered tabs into action */
	
	int initPos = 0;

	GuiObject pre = NULL;

	for ( int i = 0; i < orderedTabs.getNumItems(); i++ )
	{
		Tab tabI = newGroup("cpro.tab");
		tabI.setXmlParam("x", integerToString(totalTabWidth));
		tabI.setXmlParam("y", "0");

		if (isInternal.getItem(i)) // internal tab?
		{
			tabI.ID = orderedTabs.enumItem(i); //?
			//debugInt(orderedTabs.enumItem(i));
			tabI.isInternal = true;
		}
		else
		{
			tabI.isInternal = false;
		}
	
		tabI.pos = i;
		tabI.left = pre;
		tabI.right = NULL;

		if (pre != NULL)
		{
			Tab l = pre;
			l.right = tabI;	
		}
		tabI.init(tabHolder);

		text t = tabI.findObject("cpro.tab.text");
		if (tabI.isInternal)
		{
			t.setXmlParam("text", internalNames.enumItem(tabI.ID));	
		}
		updateTabWidth(tabI);
		totalTabWidth += tabI.w; // use dispatcher
		pre = tabI;
	}
	aligned = true;
	lastActive = firstTab = tabHolder.enumObject(0);
	lastTab = pre;

	delete internalNames;
	delete isInternal;
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
			//debugInt(t.ID);
		}
		else
		{
			setPrivateString("ClassicPro", "TabOrder_item_" + integerToString(n), t.IDS);
		}
		
		n++;
		t = t.right;
	}

	setPrivateInt("ClassicPro", "TabOrder_nItems", n);
}


tabHolder.onResize (int x, int y, int w, int h)
{
	if (w <= 0)
	{
		return;
	}
	

	if (w < totalTabWidth)
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
		if (t.moving)
		{
			moveTo(t, t.initX);
		}
		
		t.moving = false;

		return SUCCESS;
	}
	else if (message == ON_MOUSE_MOVE)
	{
		if (t.moving)
		{
			int newPos = i0 - t.lastX + t.getGuiX();

			if (newPos < 0 || newPos > tabHolder.getWidth() - t.w)
			{
				return;
			}
			
		
			t.lastX = i0;	

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
		lastActive.setActivated(0);
		CproSUI.sendAction ("show_tab", "", t.ID, 0, 0, 0);
		lastActive = t;
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
}
moveTo (Tab g, int x)
{
	g.cancelTarget();
	g.setTargetX(x);
	g.setTargetW(g.w);
	g.setTargetSpeed(0.4);
	g.gotoTarget();
}

/**
 * Call this one everytime the tab text has changed. also aligns the tabs to the right
 */
updateTabWidth (Tab t)
{
	//totalTabWidth -= t.w;
	t.w = t.findObject("cpro.tab.text").getAutoWidth() +14;
	//totalTabWidth += t.w;
	t.maxW = t.w;
	t.mid = t.w/2;
	t.setXmlParam("w", integerToString(t.w));
	/*

	if (sg.getWidth() < totalTabWidth)
	{
		//alignByResize();
	}
	else
	{
		//align(t.right);	
	}*/
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
	
}

sg.onAction (String action, String param, Int x, int y, int p1, int p2, GuiObject source)
{
	if(strlower(action) == "select_tab")
	{
		Tab t = lastActive;
		//if(t.ID != x)
		{
			lastActive.setActivated(0);
			t = firstTab;
			while (t != NULL)
			{
				if (t.ID == x)
				{
					lastActive = t;
					lastActive.setActivated(1);
					break;
				}
				
				t = t.right;
			}
			
		}
	}
}
