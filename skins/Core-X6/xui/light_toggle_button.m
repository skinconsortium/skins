#include </lib/std.mi>
#include </lib/config.mi>

// Change PRESSSPEED to change the animation speed

#define PRESSSPEED 0.2

Global Button Background;
Global Layer Foreground;
Global Layer DImage;
Global int Lightness;
Global Boolean noactivate;

System.onScriptLoaded() {
	Lightness = 255;
	Group sg = System.getScriptGroup();
	Background = sg.getObject("background");
	DImage = sg.getObject("down");
	Foreground = sg.getObject("light");
}

System.onSetXuiParam(String param, String value)
{
	if (System.strlower(param) == "dimage")
	{
		DImage.setXMLParam("image",value);
	}
	if (System.strlower(param) == "foreimage")
	{
		Foreground.setXMLParam("image",value);	
	}
	if (System.strlower(param) == "ttip")
	{
		Background.setXMLParam("tooltip", value);	
	}
	
	if (System.strlower(param) == "noactivate")
	{
		noactivate = false;
		if (value == "1" || value == "true")
		{
			noactivate = true;
			Foreground.setXMLParam("Alpha","255");
		}
	}


}

Background.onLeftButtonDown(int x, int y)
{
	DImage.setTargetA(255);
	DImage.setTargetSpeed(PRESSSPEED);
	Foreground.setTargetA(Lightness/2);
	Foreground.setTargetSpeed(PRESSSPEED);
	DImage.goToTarget();
	Foreground.goToTarget();
}
Background.onLeftButtonUp(int x, int y)
{
	DImage.setTargetA(0);
	DImage.setTargetSpeed(PRESSSPEED);
	DImage.goToTarget();
	if (noactivate)
	{
		Foreground.setTargetA(Lightness);
		Foreground.setTargetSpeed(PRESSSPEED);
		Foreground.goToTarget();		
	}
}


Background.onActivate(int activated){
	if (!noactivate)
	{
		Lightness = 150 + (activated*155);
		Foreground.setTargetA(Lightness);
		Foreground.setTargetSpeed(PRESSSPEED);
		Foreground.goToTarget();		
	}
}

System.onScriptUnLoading() {
}