/**
 * Manager for Widgets
 * Handles showing of a external window
 *
 * @author mpdeimos
 * @date 2009/04/28
 */

#include <lib/std.mi>

#define NUM_WIDGET_PLACES 3

Global Layout main_normal;
Global Layout manager_normal;
Class Group WidgetPlace;
Member String WidgetPlace.name;

Global List widgetPlaces;
Global int done;

Global GroupList grplst, grplstN;
Global Slider vscroll, vscrollN;
Global String widgetPath;

Global Group grpAll, grpNew;
Global Button newW, allW;

Global Boolean newWidgetInstalled;

System.onScriptLoaded ()
{
	main_normal = getContainer("main").getLayout("normal");
	manager_normal = getContainer("widgets.manager").getLayout("normal");
	grpNew = manager_normal.findObject("widgets.manager.content.new");
	grpAll = manager_normal.findObject("widgets.manager.content.all");

	grplst = grpAll.findObject("grplst");
	grplst.setRedraw(1);
	grplstN = grpNew.findObject("grplst");
	grplstN.setRedraw(1);
	vscroll = grpAll.findObject("vscroll");
	vscrollN = grpNew.findObject("vscroll");
	newW = manager_normal.findObject("newW");
	allW = manager_normal.findObject("allW");
	widgetPath = getParam();
	widgetPlaces = new List;
	done = 0;
	newWidgetInstalled = false;
}

main_normal.onAction (String action, String param, Int x, int y, int p1, int p2, GuiObject _source)
{
	if (strlower(action) == "widget_manager_register")
	{
		WidgetPlace wp = _source;
		wp.name = param;
		widgetPlaces.addItem(wp);
		return widgetPlaces.getNumItems()-1;
	}
	else if (strlower(action) == "widget_manager_check")
	{
		WidgetPlace wp = widgetPlaces.enumItem(x);

		Group source = _source;
		GuiObject data = NULL;
		String version = "";
		data = source.getObject("@version");

		if (data != null)
			version = data.getXmlParam("userdata");

		if (getPrivateString("cpro.widget-manager.check", integerToString(x)+param, "") != version)
		{
			setPrivateString("cpro.widget-manager.check", integerToString(x)+param, version);
			newWidgetInstalled = true;

			Group g = grplstN.instantiate("widgets.manager.listitem", 1);
			g.setXmlParam("widgetname", getToken(source.getXmlParam("name"), ";", 0));
			g.setXmlParam("widgetposition", wp.name);
			g.setXmlParam("widgetid", param);
			g.setXmlParam("userdata", integertostring(x));

			data = NULL;
			data = source.getObject("@author");
			if (data)
				g.setXmlParam("widgetauthor", data.getXmlParam("userdata"));

			g.setXmlParam("widgetversion", version);

			data = NULL;
			data = source.getObject("@uninstaller");
			if (data)
				g.setXmlParam("widgetuninstaller", widgetPath + data.getXmlParam("userdata"));

			data = NULL;
			data = source.getObject("@support");
			if (data)
				g.setXmlParam("widgetsupport", data.getXmlParam("userdata"));
		}		

		Group g = grplst.instantiate("widgets.manager.listitem", 1);
		g.setXmlParam("widgetname", getToken(source.getXmlParam("name"), ";", 0));
		g.setXmlParam("widgetposition", wp.name);
		g.setXmlParam("widgetid", param);
		g.setXmlParam("userdata", integertostring(x));

		data = source.getObject("@author");
		if (data)
			g.setXmlParam("widgetauthor", data.getXmlParam("userdata"));

		g.setXmlParam("widgetversion", version);

		data = NULL;
		data = source.getObject("@uninstaller");
		if (data)
			g.setXmlParam("widgetuninstaller", widgetPath + data.getXmlParam("userdata"));

		data = NULL;
		data = source.getObject("@support");
		if (data)
			g.setXmlParam("widgetsupport", data.getXmlParam("userdata"));
	}
	else if (strlower(action) == "widget_manager_done")
	{
		done++;
		if (done == NUM_WIDGET_PLACES && newWidgetInstalled == true)
		{
			newW.onLeftClick();
			manager_normal.show();
		}
		
	}
}

manager_normal.onAction (String action, String param, Int x, int y, int p1, int p2, GuiObject source)
{
	if (strlower(action) == "show_widget")
	{
		WidgetPlace wp = widgetPlaces.enumItem(x);
		wp.sendAction("show_widget", param, 0,0,0,0);
	}
	
}

vscroll.onSetPosition(int newpos)
{
	int percent = 99-newpos;
	//grplst.setXmlParam("y", integertostring(-newpos));
	grplst.scrolltopercent(percent);
	grplst.setRedraw(percent);
}

vscrollN.onSetPosition(int newpos)
{
	int percent = 99-newpos;
	//grplst.setXmlParam("y", integertostring(-newpos));
	grplstN.scrolltopercent(percent);
	grplstN.setRedraw(percent);
}

newW.onLeftClick ()
{
	grpAll.hide();
	grpNew.show();
}

allW.onLeftClick ()
{
	grpNew.hide();
	grpAll.show();
}