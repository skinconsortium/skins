/*************************************************************

  KameleonDUI - centerobject.m
  by Leechbite

  Centers object to parent group.

*************************************************************/

#include <lib/std.mi>

function centerObject(guiObject obj, boolean centx, boolean centy);

Global group scriptGroup;
Global guiObject cenObject;
Global boolean notcenterx = FALSE, notcentery = FALSE;

System.onScriptLoaded() {
  scriptGroup = getScriptGroup();
  string param = getParam();

  cenObject = scriptGroup.getObject(getToken(param,",",0));

  notcenterx = (getToken(param,",",1)=="0");
  notcentery = (getToken(param,",",2)=="0");

  scriptGroup.onResize(0,0,0,0);
}

System.onScriptUnloading() {
  return;
}

// centers guiobjects depending on parent group/layout
centerObject(guiObject obj, boolean centx, boolean centy) {

  guiObject parentobj = obj.getParent();

  int x, y;

  if (centx) {
	if (x < 0) x = 0;
	x = (parentobj.getWidth() - obj.getWidth())/2;
	obj.setXMLParam("x", integerToString(x));
  }
  
  if (centy) {
    y = (parentobj.getHeight() - obj.getHeight())/2;
	if (y < 0) y = 0;
	obj.setXMLParam("y", integerToString(y));
  }

}

scriptGroup.onResize(int x, int y, int w, int h) {
  if (cenObject) centerObject(cenObject, !notcenterx, !notcentery);
}

