/**
 * Manager for Widgets
 * Handles showing of a external window
 *
 * @author mpdeimos
 * @date 2009/04/28
 */

#include <lib/std.mi>

#define NUM_WIDGET_PLACES 1

Global Layout main_normal;
Global Layout manager_normal;
Class Group WidgetPlace;
Member String WidgetPlace.name;

Global List widgetPlaces;
Global int done;

Global GroupList grplst;
Global Slider vscroll;
Global String widgetPath;

System.onScriptLoaded ()
{
	main_normal = getContainer("main").getLayout("normal");
	manager_normal = getContainer("widgets.manager").getLayout("normal");
	grplst = manager_normal.findObject("grplst");
	grplst.setRedraw(1);
	vscroll = manager_normal.findObject("vscroll");
	widgetPath = getParam();
	widgetPlaces = new List;
	done = 0;
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
		Group g = grplst.instantiate("widgets.manager.listitem", 1);
		Group source = _source;
		g.setXmlParam("widgetname", getToken(source.getXmlParam("name"), ";", 0));
		g.setXmlParam("widgetposition", wp.name);
		g.setXmlParam("widgetid", param);
		g.setXmlParam("userdata", integertostring(x));

		GuiObject data = NULL;
		data = source.getObject("@author");
		if (data)
			g.setXmlParam("widgetauthor", data.getXmlParam("userdata"));

		data = NULL;
		data = source.getObject("@version");
		if (data)
			g.setXmlParam("widgetversion", data.getXmlParam("userdata"));

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
		if (done == NUM_WIDGET_PLACES)
		{
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
