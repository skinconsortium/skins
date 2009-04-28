/**
 * Handles Widget Manager Items
 *
 * @author mpdeimos
 * @date 2009/04/28
 */

#include <lib/std.mi>

Global Text name, author, version, position;
Global Layer thumbnail;
Global String thumbnailImg;

System.onScriptLoaded ()
{
	Group sg = getScriptGroup();

	author = sg.getObject("author");
	version = sg.getObject("version");
	name = sg.getObject("name");
	position = sg.getObject("position");
	thumbnail = sg.getObject("thumbnail");
	thumbnailImg = thumbnail.getXmlParam("image");
}

system.onSetXuiParam (String param, String value)
{
	if (strlower(param) == "widgetname")
	{
		name.setText(value);
	}
	else if (strlower(param) == "widgetposition")
	{
		position.setText(value);
	}
	else if (strlower(param) == "widgetauthor")
	{
		author.setText(value);
	}
	else if (strlower(param) == "widgetversion")
	{
		version.setText(value);
	}
	else if (strlower(param) == "widgetid")
	{
		thumbnail.setXmlParam("image", value+".thumbnail");
		if (thumbnail.isInvalid())
		{
			thumbnail.setXmlParam("image", thumbnailImg);
		}
		
	}
}

