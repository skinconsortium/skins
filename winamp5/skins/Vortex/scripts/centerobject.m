/*************************************************************

  centerobject.m
  by Leechbite

  Centers object to parent group.
  
  param = "objID,cenX,cenY"
  
  objID = ID of object to center
  cenX = 1 or 0. if 1, centers object on x-axis
  cenY = 1 or 0. if 1, centers object on y-axis

*************************************************************/

#include <lib/std.mi>

function centerObject(guiObject obj, boolean centx, boolean centy);

Global group scriptGroup;
Global guiObject cenObject;
Global boolean notcenterx = false, notcentery = false;

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

scriptGroup.onResize(int x, int y, int w, int h) {
  if (cenObject) centerObject(cenObject, !notcenterx, !notcentery);
}

// centers guiobjects depending on parent group/layout
centerObject(guiObject obj, boolean centx, boolean centy) {

  guiObject parentobj = obj.getParent();

  int x, y;

  if (centx) 
    x = (parentobj.getWidth() - obj.getWidth())/2;
  else
    x = obj.getGuiX();
  if (centy) 
    y = (parentobj.getHeight() - obj.getHeight())/2;
  else
    y = obj.getGuiY();

  obj.setXMLParam("x", integerToString(x));
  obj.setXMLParam("y", integerToString(y));

}

