#include "../../../../lib/std.mi"

Global Button hp;
System.onScriptLoaded() {

  hp = getScriptGroup().findObject("url");

}


hp.onleftclick() { System.navigateUrl("http://www.studiotwentyeight.com"); }

