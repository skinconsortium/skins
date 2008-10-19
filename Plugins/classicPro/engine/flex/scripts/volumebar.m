/**
 * volumebar.m
 *
 * Manages custom volume fillbar.
 *
 * @package	com.skinconsortium.cpro.flex
 * @author	mpdeimos
 * @date	11/10/01
 * @param	layerID;mapBitmapID
 */

#include <lib/std.mi>
#include <lib/com/fillbar.m>

Function updateVolume();

Global FillBar volumeBar;

System.onScriptLoaded ()
{
	Layer tmp = getScriptGroup().findObject(getToken(getParam(), ",", 0));
	volumeBar = FillBar_construct(tmp, getToken(getParam(), ",", 1));
	volumeBar.dragable = TRUE;

	FillBar_setPosition(volumeBar, System.getVolume());
}

System.onScriptUnloading ()
{
	 FillBar_destruct(volumeBar);
}

System.onVolumeChanged (int newvol)
{
	FillBar_setPosition(volumeBar, newvol);
}

/*
 * Dragging Callbacks
 */

boolean FillBar_onDrag(Fillbar fb, int pos)
{
	System.setVolume(pos);
	return TRUE; 
}

boolean FillBar_onEndDrag(Fillbar fb, int pos)
{
	System.setVolume(pos);
	return TRUE; 
}