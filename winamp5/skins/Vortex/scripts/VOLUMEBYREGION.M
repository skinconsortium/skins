/* Note: a decompiler is no invitation to steal code.
   Please respect the the copyright */

#include "../../../lib/std.mi"
Global Layer Layer2;
Global Map Map3;
Global Map Map4;
Global Text Text5;
Global Boolean Boolean7;

Function func306(Int 0);
Function func518(Int 0, Int 0);

System.onScriptLoaded()
{
Group Group8;
Group8 = System.getScriptGroup();
Layer2 = Group8.findObject(( "VolumeAnim"));
Text5 = Group8.findObject(( "SongTicker"));
Map3 = ( new Map);
Map3.loadMap(( "dominator.normal.SliderMap"));
Map4 = ( new Map);
Map4.loadMap(( "dominator.normal.SliderMap2"));
func306(System.getVolume());
return Null;
}

System.onVolumeChanged(int newvol)
{
Int Int18;
func306(newvol);
Int18 = ( ( newvol * 100) / 255);
Text5.sendAction("setText", "Volume: " + System.integerToString(Int18) + "%", 0, 0, 0, 0);
return Null;
}

func306(Int Int21)
{
Region Region22;
Region22 = ( new Region);
Region22.loadFromMap(Map4, Int21, 1);
Layer2.setRegion(Region22);
delete Region22;
return Null;
}

Layer2.onLeftButtonDown(int x, int y)
{
Boolean7 = 1;
func518(x, y);
return Null;
}

Layer2.onLeftButtonUp(int x, int y)
{
if(Boolean7) {
Boolean7 = 0;
func518(x, y);
}
return Null;
}

Layer2.onMouseMove(int x, int y)
{
if(Boolean7) {
func518(x, y);
}
return Null;
}

func518(Int Int31, Int Int32)
{
Int Int33;
Int33 = Map3.getValue(( Int31 - Layer2.getLeft()), ( Int32 - Layer2.getTop()));
if(Map3.inRegion(( Int31 - Layer2.getLeft()), ( Int32 - Layer2.getTop()))) {
System.setVolume(Int33);
}
return Null;
}

System.onScriptUnloading()
{
delete Map3;
delete Map4;
return Null;
}


