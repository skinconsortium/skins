#include <lib/std.mi>
Global Layer outl, fill, back;
Global int rating;
System.onScriptLoaded ()
{
	back = getScriptGroup().findObject("rate.back");
	outl = getScriptGroup().findObject("rate.outl");
	fill = getScriptGroup().findObject("rate.fill");
	rating = System.getCurrentTrackRating();
	fill.setXmlParam("w", System.integerToString(rating*10));
}
back.OnEnterArea ()
{
	outl.setAlpha(127);
	fill.setAlpha(63);
}
back.OnLeaveArea ()
{
	outl.setAlpha(63);
	fill.setAlpha(31);
}
back.onLeftButtonUp (int x, int y)
{
	x -= back.getLeft() + 1;
	y -= back.getTop();
	if (x >= 0) if (y >= 0) if ((x+1) <= back.getWidth()) if (y <= back.getHeight())
	{
		rating = (x)/10+1;
		fill.setXmlParam("w", System.integerToString(rating*10));
		System.setCurrentTrackRating(rating);
	}
	//fill.setXmlParam("w", System.integerToString(x));
}
System.onTitleChange(String newtitle)
{
	rating = System.getCurrentTrackRating();
	fill.setXmlParam("w", System.integerToString(rating*10));
}
System.onCurrentTrackRated(int nrating)
{
	rating = nrating;
	fill.setXmlParam("w", System.integerToString(rating*10));
}