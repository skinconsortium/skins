/* Note: a decompiler is no invitation to steal code.
   Please respect the the copyright */

#include "std.mi"
Global Button Button2;
Global AnimatedLayer AnimatedLayer3;
Global Layer Layer4;
Global Int Int5;
Global Int Int6;
Global Int Int7;


System.onScriptLoaded()
{
Group Group8;
Group8 = System.getScriptGroup();
AnimatedLayer3 = Group8.findObject(( "animationlayer"));
Button2 = Group8.findObject(( "animationbutton"));
Layer4 = Group8.findObject(( "animinfo"));
Int6 = System.StringToInteger(Layer4.getXmlParam(( "x")));
Int7 = System.StringToInteger(Layer4.getXmlParam(( "y")));
Int5 = 0;
return Null;
}

Button2.onLeftButtonUp(int x, int y)
{
if(( ( Int5 == 1) && AnimatedLayer3.isStopped())) {
Int5 = 0;
AnimatedLayer3.setStartFrame(Int6);
AnimatedLayer3.setEndFrame(Int7);
AnimatedLayer3.play();
} else {
if(( ( Int5 == 0) && AnimatedLayer3.isStopped())) {
Int5 = 1;
AnimatedLayer3.setStartFrame(Int7);
AnimatedLayer3.setEndFrame(Int6);
AnimatedLayer3.play();
}
}
return Null;
}


