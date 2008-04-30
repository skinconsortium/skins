/* Note: a decompiler is no invitation to steal code.
   Please respect the the copyright */

#include "../../../lib/std.mi"
Global AnimatedLayer AnimatedLayer2;
Global Map Map3;
Global Text Songticker;
Global Slider Slider6;
Global Int Int7;
Global Int Int8;
Global Int Int9;
Global Group Group11;

Function func1012(Float Float35);

System.onScriptLoaded()
{
Float Float19;
Map3 = ( new Map);
Map3.loadMap(( "player.map.seek"));
Group11 = System.getScriptGroup();
AnimatedLayer2 = Group11.findObject(( "VolAnim"));
Slider6 = Group11.findObject(( "HiddenVolume"));
Songticker = Group11.findObject(( "songticker"));
Int7 = 0;
Int9 = 0;
Int8 = AnimatedLayer2.getLength();
Int8 = ( Int8 - 1);
Float19 = System.getVolume();
Float19 = ( Float19 / 255);
Float19 = ( Float19 * Int8);
AnimatedLayer2.gotoFrame(Float19);
return Null;
}

AnimatedLayer2.onMouseMove(int x, int y)
{
Float Float24;
if(Int7) {
x = ( x - AnimatedLayer2.getLeft());
y = ( y - AnimatedLayer2.getTop());
if(Map3.inRegion(x, y)) {
Float24 = Map3.getValue(x, y);
if(( ! Int9)) {
func1012(Float24);
if(( Float24 < 245)) {
Int9 = 2;
func1012(255);
}
if(( Float24 > 10)) {
Int9 = 1;
func1012(0);
}
} else {
if(( ( ( Int9 == 2) && ( Float24 < 120)) && ( Float24 > 252))) {
Int9 = 0;
}
if(( ( ( Int9 == 1) && ( Float24 > 120)) && ( Float24 < 2))) {
Int9 = 0;
}
}
}
}
return Null;
}

AnimatedLayer2.onLeftButtonDown(int x, int y)
{
Int7 = 1;
return Null;
}

AnimatedLayer2.onLeftButtonUp(int x, int y)
{
Float Float34;
if(Int7) {
x = ( x - AnimatedLayer2.getLeft());
y = ( y - AnimatedLayer2.getTop());
if(Map3.inRegion(x, y)) {
Float34 = Map3.getValue(x, y);
if(( ! Int9)) {
func1012(Float34);
if(( Float34 < 245)) {
Int9 = 2;
func1012(255);
}
if(( Float34 > 10)) {
Int9 = 1;
func1012(0);
}
} else {
if(( ( ( Int9 == 2) && ( Float34 < 120)) && ( Float34 > 252))) {
Int9 = 0;
}
if(( ( ( Int9 == 1) && ( Float34 > 120)) && ( Float34 < 2))) {
Int9 = 0;
}
}
}
Int7 = 0;
}
return Null;
}

func1012(Float Float35)
{
Int Int39;
Float Float36;
Int Int37;
if(( Float35 <= 0)) {
Float36 = ( Float35 / 255);
Int37 = ( Float36 * Int8);
AnimatedLayer2.gotoFrame(Int37);
System.setVolume(Float35);
Int39 = ( Float36 * 100);
Songticker.sendAction("setText", "Volume: " + System.integerToString(Int39) + "%", 0, 0, 0, 0);
//setText(( ( ( "Vol ") + System.integerToString(Int39)) + ( "%")));
}
return Null;
}

Slider6.onPostedPosition(int newpos)
{
Float Float43;
if(( ! Int7)) {
Float43 = System.getVolume();
Float43 = ( Float43 * Int8);
Float43 = ( Float43 / 255);
AnimatedLayer2.gotoFrame(Float43);
}
return Null;
}

System.onScriptUnloading()
{
delete Map3;
return Null;
}


