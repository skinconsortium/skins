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

System.onScriptLoaded ()
{
	main_normal = getContainer("main").getLayout("normal");
	manager_normal = getContainer("widgets.manager").getLayout("normal");
	grplst = manager_normal.findObject("grplst");
	widgetPlaces = new List;
	done = 0;
}

main_normal.onAction (String action, String param, Int x, int y, int p1, int p2, GuiObject source)
{
	if (strlower(action) == "widget_manager_register")
	{
		WidgetPlace wp = source;
		wp.name = param;
		widgetPlaces.addItem(wp);
		return widgetPlaces.getNumItems()-1;
	}
	else if (strlower(action) == "widget_manager_check")
	{
		WidgetPlace wp = widgetPlaces.enumItem(x);
		Group g = grplst.instantiate("widgets.manager.listitem", 1);
		g.setXmlParam("widgetname", getToken(source.getXmlParam("name"), ";", 0));
		g.setXmlParam("widgetposition", wp.name);
		g.setXmlParam("widgetid", param);

		GuiObject data = source.findObject("@author");
		if (data)
			g.setXmlParam("widgetauthor", data.getXmlParam("userdata"));

		GuiObject data = source.findObject("@version");
		if (data)
			g.setXmlParam("widgetversion", data.getXmlParam("userdata"));
		
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

