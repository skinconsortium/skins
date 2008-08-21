#include <lib/std.mi>
#include "attribs.m"

Global Container eqcontainer;
Global Layout eqLay;

System.onScriptLoaded()
{
	initAttribs();
	eqcontainer = System.getContainer("eq");
	eqLay = eqcontainer.getLayout("normal");
	//eq_visible_attrib.onDataChanged();
}

eq_visible_attrib.onDataChanged ()
{
	if (getData() == "1"){
		eqcontainer.show();
	}
	else{
		eqcontainer.close();
	}
}

System.onKeyDown(String key)
{
	if (key == "alt+g")
	{
		if (eq_visible_attrib.getData() == "0")
				eq_visible_attrib.setData("1");
		else
				eq_visible_attrib.setData("0");
		complete;
	}
}

System.onShowLayout(Layout _layout){
	if(_layout==eqLay) if(eq_visible_attrib.getData()!="1") eq_visible_attrib.setData("1");
}
System.onHideLayout(Layout _layout){
	if(_layout==eqLay) if(eq_visible_attrib.getData()!="0") eq_visible_attrib.setData("0");
}