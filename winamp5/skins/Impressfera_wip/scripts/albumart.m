#include <lib/std.mi>
#include "attribs.m"

Global Container albumart;
Global Layout albumartLay;

System.onScriptLoaded()
{
	initAttribs();
	albumart = System.getContainer("impress.albumart");
	albumartLay = albumart.getLayout("normal");
	//albumart_visible_attrib.onDataChanged();
}

albumart_visible_attrib.onDataChanged ()
{
	if (getData() == "1")
	{
		albumart.show();
	}
	else
	{
		albumart.close();
	}
}

System.onKeyDown(String key)
{
	if (key == "alt+a")
	{
		if (albumart_visible_attrib.getData() == "0")
				albumart_visible_attrib.setData("1");
		else
				albumart_visible_attrib.setData("0");
		complete;
	}
}

System.onShowLayout(Layout _layout){
	if(_layout==albumartLay) if(albumart_visible_attrib.getData()!="1") albumart_visible_attrib.setData("1");
}
System.onHideLayout(Layout _layout){
	if(_layout==albumartLay) if(albumart_visible_attrib.getData()!="0") albumart_visible_attrib.setData("0");
}
