#include <lib/std.mi>
#include "../scripts/attribs/init_vis.m"

Function UpdateCDCover();
Function String GetSkinPath(String strRaw);
Function Cover_getLocal();
Function getMediaPath();

Global boolean localfound;
Global layer localCover;
Global int iGotLocal;
Global layout MainMode;

#define DEBUG

#ifdef DEBUG

Function debug(String debugStr);
debug(String debugStr) 
{
	system.debugstring("Debug Message:" + debugStr, 0);
}
#endif


System.onScriptLoaded() 
{
initAttribs_vis();
	//Group cover = system.getScriptGroup();

	MainMode = getContainer("main").getLayout("full");	
	//localCover = MainMode.findObject("local.cdcover");
	localCover = MainMode.findObject("aafull");
	
	//localCover.setXMLParam("image","");
	
		
	if (System.getPlayItemString() != "") UpdateCDCover();	
	//localCover.setXMLParam("image","cdcover.noimage");
	
	if(globalmyattr_SCCoverEnabled.getData()=="1")
	{		
		if(myattr_SCCubeVisEnabled.getData()=="1")
		{
			//localCover.setXMLParam("image","cdcover.noimage");
			UpdateCDCover();
			
		}
		else
		{
			//localCover.setXMLParam("image","");
			localCover.hide();
		}
		 
		if(globalmyattr_SC90DegVisEnabled.getData()=="1")
		{
			//localCover.setXMLParam("image","cdcover.noimage");
			UpdateCDCover();
			
		}
		else
		{
			//localCover.setXMLParam("image","");
			localCover.hide();
		}
		
	}
	else
	{
		//localCover.setXMLParam("image","");
		localCover.hide();
	}
	
	
}

MainMode.onSetVisible(Boolean on)
{
	if(on)
	{	
		//localCover.setXMLParam("image","");
		UpdateCDCover();
	}

}


globalmyattr_SCCoverEnabled.onDataChanged()
{

	//localCover.setXMLParam("image","");
	localCover.hide();
	UpdateCDCover();
	if(getData()=="0")
	{
		//localCover.setXMLParam("image","");
		localCover.hide();
		
		#ifdef DEBUG
			debug("globalmyattr_SCCoverEnabled.getData=" + getData());
		#endif
		
	}
	
}



System.onTitleChange(String strNewTitle) 
{
	UpdateCDCover();

}

system.onPlay()
{

	UpdateCDCover();

}

system.onResume()
{

	UpdateCDCover();

}

System.onPause()
{

	UpdateCDCover();

}

System.onStop()
{

	UpdateCDCover();

}


/*localCover.onLeftButtonDblClk(int x, int y)
{
	System.navigateUrl(getPath(getPlayItemMetaDataString("filename")));
}*/

getMediaPath()
{
	String sMediaPath = System.getPlayItemString();
	sMediaPath = getPath(sMediaPath);
	sMediaPath = strRight(sMediaPath, strLen(sMediaPath) - (strSearch(sMediaPath, "//") + 2));
	return sMediaPath;	
}	
	

Cover_getLocal()
{
	if(globalmyattr_SCCoverEnabled.getData()=="1")
	{	
		string filenames = "album.jpg,cover.jpg,coverart.jpg,folder.jpg,front.jpg,cover.png,coverart.png,folder.png,front.png,%artist% - [Cover] - %album%.jpg,%artist% - %album%.jpg,albumartsmall.jpg,albumartmedium.jpg,albumartlarge.jpg";	
		
		//string mediaPath = System.getPlayItemString();
		//mediaPath = getPath(mediaPath);
		//mediaPath = strRight(mediaPath, strLen(mediaPath) - (strSearch(mediaPath, "//") + 2));
		string mediaPath = getMediaPath();
		
		//debug(mediaPath);
		int ctr = 0;
		localfound = 0;

		map fileload = new Map;

		string currFileName = getToken(filenames, ",", ctr);

		while ((currFileName!="") && (!localfound)) 
		{
			fileload.loadMap(mediaPath+chr(92)+currFileName);
			localfound = (fileload.getWidth() != 64) && (fileload.getWidth() > 0);
			if (!localfound)
			{
				ctr++;
				currFileName = getToken(filenames, ",", ctr);
			}
		}

		delete fileload;

		
		#ifdef DEBUG
			debug("localfound=" + integertostring(localfound));	
			debug(mediaPath+chr(92)+currFileName);
		#endif
		
		if (localfound>0) 
		{
			//localCover.setXMLParam("image",mediaPath+chr(92)+currFileName);
			
		}
		else
		{
			if(globalmyattr_SC90DegVisEnabled.getData()=="0" || globalmyattr_SCCubeVisEnabled.getData()=="0")
			{
				//localCover.setXMLParam("image","cdcover.noimage");
			}
			else
			{
				//localCover.setXMLParam("image","");
			}

			
		}
	}
	else
	{
		//localCover.setXMLParam("image","");
	}
	

}

updateCDCover() 
{	
	
	if(globalmyattr_SCCoverEnabled.getData()=="1")
	{
		//Cover_getLocal();
		localCover.show();
	}
	else
	{
		//localCover.setXMLParam("image","");
		localCover.hide();
	}

		
}

