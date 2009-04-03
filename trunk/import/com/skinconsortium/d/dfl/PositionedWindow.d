/**
 * Creates a Panel that remembers it's window position.
 * 
 * @author mpdeimos
 */

module com.skinconsortium.d.dfl.PositionedWindow;

import dfl.form;
import dfl.base;
import com.skinconsortium.d.commons.ConfigFile;

class PositionedWindow: dfl.form.Form
{
	protected int defaultWidth = 500;
	protected int defaultHeight = 300;
	
	this ()
	{
		restoreWindowPosition();
	}
	
	protected void restoreWindowPosition()
	{
		if (ConfigFile.getValue("windowPosX", int.min) != int.min)
		{
			startPosition = dfl.form.FormStartPosition.MANUAL;
			left = ConfigFile.getValue("windowPosX", 0);
			top = ConfigFile.getValue("windowPosY", 0);
			width = ConfigFile.getValue("windowPosW", defaultWidth);
			height = ConfigFile.getValue("windowPosH", defaultHeight);
			switch (ConfigFile.getValue("windowState", FormWindowState.NORMAL))
			{
			case FormWindowState.MAXIMIZED:
				windowState = FormWindowState.MAXIMIZED;
				break;
			default:
				windowState = FormWindowState.NORMAL;
				break;
			}
		}		
	}

	override protected void onClosing(CancelEventArgs cea)
	{
		saveWindowPosition();
	}	
	
	protected void saveWindowPosition()
	{

		ConfigFile.setValue("windowState", windowState);
		if (windowState != FormWindowState.NORMAL)
		{
			visible = false;
			windowState = FormWindowState.NORMAL;
		}		
		ConfigFile.setValue("windowPosX", left);
		ConfigFile.setValue("windowPosY", top);
		ConfigFile.setValue("windowPosW", width);		
		ConfigFile.setValue("windowPosH", height);

	}
}
