/**
 * A simple implementation of a Window with a menubar.
 * Inherits from PositionedWindow.
 * 
 * @author mpdeimos
 */

module com.skinconsortium.d.dfl.MenuWindow;

import com.skinconsortium.d.dfl.PositionedWindow;
import dfl.application;
import dfl.form;
import dfl.menu;
import dfl.event;

class MenuWindow: PositionedWindow
{
	/** Window shown while clicking on about in the menubar. Defaulted to null. */
	protected Form aboutWindow = null;
	
	/** MENU POSITIONS */
	public static const int MENU_FILE_IDX = 5; 
	public static const int MENU_ABOUT_IDX = 100; 
	
	this()
	{
		super();
		initializeMenu();
	}
	
	protected void initializeMenu()
	{
		MenuItem mmenu;
		MenuItem mi;
		
		this.menu = new MainMenu;
		
		/// File ///
		with (mmenu = new MenuItem)
		{
			mmenu.text = "&File";
			mmenu.index = MENU_FILE_IDX;
			this.menu.menuItems.add(mmenu);
			
			/// - New
			mi = new MenuItem;
			mi.text = "&New";
			mi.click ~= &menuFileNew;
			mmenu.menuItems.add(mi);
		
			/// - Open
			mi = new MenuItem;
			mi.text = "&Open...";
			mi.click ~= &menuFileOpen;
			mmenu.menuItems.add(mi);

			/// - Save
			mi = new MenuItem;
			mi.text = "&Save";
			mi.click ~= &menuFileSave;
			mmenu.menuItems.add(mi);
			
			/// - Save As
			mi = new MenuItem;
			mi.text = "Save &As...";
			mi.click ~= &menuFileSaveAs;
			mmenu.menuItems.add(mi);			
			
			/// ---
			mi = new MenuItem;
			mi.text = "-";
			mmenu.menuItems.add(mi);
			
			/// - Exit
			mi = new MenuItem;
			mi.text = "E&xit";
			mi.click ~= &menuFileExit;
			mmenu.menuItems.add(mi);
		}
		
		/// About ///
		with (mmenu = new MenuItem)
		{
			mmenu = new MenuItem;
			mmenu.index = MENU_ABOUT_IDX;
			mmenu.text = "&About";
			mmenu.click ~= &menuAbout;
			this.menu.menuItems.add(mmenu);
		}		
	}
	
	/** handling menu actions */	
	protected
	{
		void menuFileExit(Object sender, EventArgs ea)
		{
			Application.exitThread();
		}
		
		void menuFileNew(Object sender, EventArgs ea)
		{
		}
		
		void menuFileOpen(Object sender, EventArgs ea)
		{
		}
		
		void menuFileSave(Object sender, EventArgs ea)
		{
		}

		void menuFileSaveAs(Object sender, EventArgs ea)
		{
		}
		
		void menuAbout(Object sender, EventArgs ea)
		{
			if (aboutWindow !is null)
				aboutWindow.showDialog(this);
		}		
	}
}