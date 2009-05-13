#include <lib/std.mi>
#include "attribs/init_vis.m"


//SLoB - quick hack to rotate vis 90 degrees
Function ProcessVizMenuResult(int a);



global container contvis;
global layout fullvis;
global layer lyrFx, vislocalCover;
global double dblSmidge;
global vis ActualVis;
global popupmenu VizCover, VizSubMenu_Pattern, VizSubMenu_Style;
global int iVizDirection, iStdVizMode, iVisRotation;
Global GuiObject AlbumArt;



system.onscriptloaded()
{
initAttribs_vis();
	
	contvis = getContainer("main");
	fullvis = contvis.getLayout("full");
	ActualVis = fullvis.findobject("newvis");
	lyrFx = fullvis.findobject("vis");
	//vislocalCover = fullvis.findobject("local.cdcover");
	vislocalCover = fullvis.findobject("aafull");
		
	lyrFx.fx_setBgFx(1);
  	lyrFx.fx_setWrap(0);
  	lyrFx.fx_setBilinear(1);
  	lyrFx.fx_setGridSize(1,1);
  	lyrFx.fx_setRect(1);
	lyrFx.fx_setClear(1);
  	lyrFx.fx_setLocalized(1);
  	lyrFx.fx_setRealtime(1);
  	lyrFx.fx_setSpeed(30);
  	dblSmidge = 0;

	iVizDirection = system.getPrivateInt("Ebonite","VizDirection",0);
	iVisRotation = system.getPrivateInt("Ebonite","VizRotation",1);
	
	
	//on startup
	//vislocalCover.setXMLParam("image","");
	vislocalCover.hide();
	
	lyrFx.fx_setEnabled(0);
	ActualVis.setMode(0);
	iStdVizMode = system.getPrivateInt("Ebonite","stdVizMode",1);
	
	//if (System.getStatus()!=STATUS_PLAYING) 
	//{
		if(globalmyattr_SC90DegVisEnabled.getData()=="0")
		{
			lyrFx.fx_setEnabled(0);
			ActualVis.setMode(0);
		}
	//}
	//else
	//{
		if(globalmyattr_SC90DegVisEnabled.getData()=="1")
		{
			lyrFx.fx_setEnabled(1);
			ActualVis.setMode(1);
			//vislocalCover.setXMLParam("image","");
			vislocalCover.hide();
			myattr_SC90DegVisRotation.setData(integertostring(iVisRotation));
			//myattr_SCCubeVisEnabled.setData("0");
		}
		
		if(globalmyattr_SC90DegVisEnabled.getData()=="2")
		{
			lyrFx.fx_setEnabled(1);
			ActualVis.setMode(2);
			myattr_SC90DegVisRotation.setData(integertostring(iVisRotation));
			//vislocalCover.setXMLParam("image","");
			vislocalCover.hide();
			
			//myattr_SCCubeVisEnabled.setData("0");
		}
		
	//}

}

/*
myattr_SC90DegVisEnabled.onDataChanged()
{
	if(getData()=="1")
	{
		//myattr_SCCubeVisEnabled.setData("0");
		vislocalCover.setXMLParam("image","");
		myattr_SCCoverEnabled.setData("0");

		lyrFx.fx_setEnabled(1);
		ActualVis.setMode(1);
		
	}
	else
	{
		lyrFx.fx_setEnabled(0);
		ActualVis.setMode(0);
	}
}		
*/

globalmyattr_SC90DegVisEnabled.onDataChanged()
{
	if(getData()=="1")
	{
		//vislocalCover.setXMLParam("image","");
		lyrFx.fx_setEnabled(1);
		ActualVis.setMode(iStdVizMode);		
	}
	else if(getData()=="2")
	{
		//vislocalCover.setXMLParam("image","");
		lyrFx.fx_setEnabled(1);
		ActualVis.setMode(iStdVizMode);
	}	
	else
	{
		lyrFx.fx_setEnabled(0);
		ActualVis.setMode(0);
	}
}



lyrFx.onrightbuttonup(int x, int y)
{
	complete;
}


lyrFx.onrightbuttondown(int x, int y)
{
	VizCover = 	new PopupMenu;
	VizSubMenu_Pattern = 	new PopupMenu;
	VizSubMenu_Style = 	new PopupMenu;
	
	//sub menus
	VizSubMenu_Pattern.addCommand("Zig-Zag - Horizontal", 200, vis_mode_Pattern_attrib.getData() == "1",0);
	VizSubMenu_Pattern.addCommand("Zig-Zag - Vertical", 201, vis_mode_Pattern_attrib.getData() == "2",0);
	VizSubMenu_Pattern.addCommand("Striped - Horizontal", 202, vis_mode_Pattern_attrib.getData() == "3",0);
	VizSubMenu_Pattern.addCommand("Striped - Vertical", 203, vis_mode_Pattern_attrib.getData() == "4",0);
	VizSubMenu_Pattern.addCommand("Spiral - OutsideIn", 204, vis_mode_Pattern_attrib.getData() == "5",0);
	VizSubMenu_Pattern.addCommand("Spiral - InsideOut", 205, vis_mode_Pattern_attrib.getData() == "6",0);		
	VizSubMenu_Pattern.addCommand("Diagonal", 206, vis_mode_Pattern_attrib.getData() == "7",0);		
	
	VizSubMenu_Style.addCommand("Levels", 100, vis_mode_style_attrib.getData() == "1", 0);
	VizSubMenu_Style.addCommand("Fill Depth", 101, vis_mode_style_attrib.getData() == "2", 0);
	VizSubMenu_Style.addCommand("Pins", 102, vis_mode_style_attrib.getData() == "3", 0);
	
	//main menus
	VizCover.addCommand("Ebonite Cover/Vis", -1, 0, 1);
	VizCover.addSeparator();
	VizCover.addCommand("Toggle Cover", 1, myattr_SCCoverEnabled.getData() == "1", 0);
	VizCover.addSeparator();
	VizCover.addCommand("90 degree Vis", -1, 0, 1);
	VizCover.addCommand("Toggle Viz", 2, myattr_SC90DegVisEnabled.getData() == "1", 0);
	VizCover.addCommand("Toggle Scope", 3, myattr_SC90DegVisEnabled.getData() == "2", 0);
	VizCover.addCommand("Toggle Viz Direction", 4, myattr_SC90DegVisDirection.getData() == "1", 0);
	VizCover.addCommand("Toggle Viz Rotation", 5, myattr_SC90DegVisRotation.getData() == "1", 0);
	VizCover.addSeparator();
	
	//add submenus
	VizCover.addCommand("4*4 Cube TimeLine Vis", -1, 0, 1);
	VizCover.addSubMenu(VizSubMenu_Style, "Cube Style");	
	VizCover.addSubMenu(VizSubMenu_Pattern, "Display Pattern");	
	VizCover.addCommand("Enable Viz", 900, myattr_SCCubeVisEnabled.getData() == "1", 0);
				
	//add album art
	VizCover.addSeparator();
	VizCover.addCommand("Album Art", -1, 0, 1);
	VizCover.addCommand("Get Album Art", 301, 0, 0);
	VizCover.addCommand("Refresh Album Art", 302, 0, 0);	
	VizCover.addCommand("Open Folder", 303, 0, 0);
	
		
	int iCatchVizMenu = VizCover.popAtMouse();
	delete VizCover;
	delete VizSubMenu_Pattern;
	delete VizSubMenu_Style;
	ProcessVizMenuResult(iCatchVizMenu);
	
}
		
//NB patterns are done in cube file as thats where the main set of code is, processed by ATTRIB value!!		

ProcessVizMenuResult(int a) 
{
	if(a < 1) return;
	
	if(a == 1) 
	{	
	
		if (myattr_SCCoverEnabled.getData() == "1") myattr_SCCoverEnabled.setData("0");
		else myattr_SCCoverEnabled.setData("1");
	}
	
	if(a == 2) 
	{	
		iStdVizMode = 1;
		if (myattr_SC90DegVisEnabled.getData() == "1") myattr_SC90DegVisEnabled.setData("0");
		else myattr_SC90DegVisEnabled.setData("1");
	}

	if(a == 3) 
	{				
		iStdVizMode = 2;
		if (myattr_SC90DegVisEnabled.getData() == "2") myattr_SC90DegVisEnabled.setData("0");
		else myattr_SC90DegVisEnabled.setData("2");		
	}
	
	if(a == 4) 
	{		
		if (myattr_SC90DegVisDirection.getData() == "1") myattr_SC90DegVisDirection.setData("0");
		else myattr_SC90DegVisDirection.setData("1");
	}

	if(a == 5) 
	{		
		if (myattr_SC90DegVisRotation.getData() == "1") myattr_SC90DegVisRotation.setData("0");
		else myattr_SC90DegVisRotation.setData("1");
	}
	
		
	//new
	if(a == 100) 
	{
		vis_mode_style_attrib.setData("1");			
	}

	if(a == 101) 
	{
		vis_mode_style_attrib.setData("2");			
	}	
	
	if(a == 102) 
	{
		vis_mode_style_attrib.setData("3");			
	}
	

	if(a == 200) 
	{
		vis_mode_Pattern_attrib.setData("1");			
	}
	
	if(a == 201) 
	{
		vis_mode_Pattern_attrib.setData("2");			
	}

	if(a == 202) 
	{
		vis_mode_Pattern_attrib.setData("3");			
	}
	
	if(a == 203) 
	{
		vis_mode_Pattern_attrib.setData("4");			
	}
		
	if(a == 204) 
	{
		vis_mode_Pattern_attrib.setData("5");			
	}
	
	if(a == 205) 
	{
		vis_mode_Pattern_attrib.setData("6");			
	}
	
	if(a == 206) 
	{
		vis_mode_Pattern_attrib.setData("7");			
	}
	
	//album art
	if (a == 301)
	{
		if (system.getAlbumArt(system.getPlayItemString()) > 0)
		{
			//AlbumArt.setXmlParam("notfoundimage", getXmlParam("notfoundimage")); // a nesty refresh - isn't it?
			vislocalCover.setXmlParam("notfoundimage", vislocalCover.getXmlParam("cover.notfound"));
		}
	}
	else if (a == 302)
	{
		//AlbumArt.setXmlParam("notfoundimage", getXmlParam("notfoundimage")); // a nesty refresh - isn't it?
		vislocalCover.setXmlParam("notfoundimage", vislocalCover.getXmlParam("cover.notfound"));
	}
	else if (a == 303)
	{
		System.navigateUrl(getPath(getPlayItemMetaDataString("filename")));
	}
	
	
	if(a == 900) 
	{
		if (myattr_SCCubeVisEnabled.getData() == "1") myattr_SCCubeVisEnabled.setData("0");
			else myattr_SCCubeVisEnabled.setData("1");				
	}
	
	
}


myattr_SCCoverEnabled.onDataChanged()
{
	if(getData()=="1")
	{
		myattr_SC90DegVisEnabled.setData("0");
		myattr_SCCubeVisEnabled.setData("0");
		
		globalmyattr_SCCoverEnabled.setData("1");
		globalmyattr_SC90DegVisEnabled.setData("0");
		globalmyattr_SCCubeVisEnabled.setData("0");		
	}
	else
	{
		globalmyattr_SCCoverEnabled.setData("0");
	}
	
	
}



/*
myattr_SCCubeVisEnabled.onDataChanged()
{	
	//if turning cube vis on, disable 90degvis if its on, also get rid of cover
	if (myattr_SCCubeVisEnabled.getdata()=="1")
	{
		if(myattr_SC90DegVisEnabled.getData()=="1")
		{
			myattr_SC90DegVisEnabled.setData("0");			
		}
		
		vislocalCover.setXMLParam("image","");
		myattr_SCCoverEnabled.setData("0");		
	}
}
*/



myattr_SC90DegVisRotation.onDataChanged()
{
	if(getdata()=="1")
	{
		iVisRotation = 1;
		if(globalmyattr_SC90DegVisEnabled.getdata()=="1")
		{
			lyrFx.fx_setEnabled(1);
		}
	}
	else
	{
		iVisRotation = 0;
		if(globalmyattr_SC90DegVisEnabled.getdata()=="1")
		{
			lyrFx.fx_setEnabled(0);
		}
	}
}	

// TODO (mpdeimos) no idea when this one is changed :P
myattr_SC90DegVisDirection.onDataChanged()
{
	if(getdata()=="1")
	{
		iVizDirection = 1;
	}
	else
	{
		iVizDirection = 0;
	}

}

lyrFx.fx_onFrame() {

	if(dblSmidge == 0.000001) 
	{
		dblSmidge = 0;
	}
	else
	{
		dblSmidge = 0.000001;
	}

}

lyrFx.fx_onGetPixelX(double r, double d, double x, double y) {
	
	return y + dblSmidge;

}


lyrFx.fx_onGetPixelY(double r, double d, double x, double y) 
{
	if(iVizDirection==0)
		return -x + dblSmidge;
	else
		return x + dblSmidge;
}

System.onStop()
{
	//lyrFx.fx_setEnabled(0);
	
}

System.onPlay()
{
	if(globalmyattr_SC90DegVisEnabled.getData()=="1")
	{
		lyrFx.fx_setEnabled(1);
		//vislocalCover.setXMLParam("image","");
		vislocalCover.hide();
	}
	else
	{
		lyrFx.fx_setEnabled(0);
		ActualVis.setMode(0);
	}
  	
}

System.onPause()
{
	//lyrFx.fx_setEnabled(0);
	
}

System.onresume()
{
	if(globalmyattr_SC90DegVisEnabled.getData()=="1")
	{
		lyrFx.fx_setEnabled(1);
		ActualVis.setMode(iStdVizMode);
		//vislocalCover.setXMLParam("image","");
		vislocalCover.hide();
	}
	else
	{
		lyrFx.fx_setEnabled(0);
		ActualVis.setMode(0);
	}
	
}

system.onscriptunloading()
{
	delete VizCover;
	system.setPrivateInt("Ebonite","VizDirection",iVizDirection);
	system.setPrivateInt("Ebonite","stdVizMode",iStdVizMode);
	system.setPrivateInt("Ebonite","VizRotation",iVisRotation);

}