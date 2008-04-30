#include <lib/std.mi>

Global ToggleButton mytoggle;
Global AnimatedLayer animlayer;
Global Boolean elecstatus;
Global Group stdgrp;

System.onScriptLoaded()
{
stdgrp=getScriptGroup();

mytoggle=stdgrp.findObject("mytoggle");
animlayer=stdgrp.findObject("animatedlayer");


elecstatus = getPrivateInt("Venom","toggle_electricity",0);
mytoggle.setActivated(elecstatus);
mytoggle.onToggle(elecstatus);
}

mytoggle.onToggle(Boolean t)
{
setPrivateInt("Venom","toggle_electricity",t);

if(t){
animlayer.play();

}else{
animlayer.stop();
animlayer.gotoFrame(0);
}
}