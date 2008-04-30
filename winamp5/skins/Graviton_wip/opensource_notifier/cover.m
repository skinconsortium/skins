#include "../../../lib/std.mi"
#include "../scripts/attribs.m"

#define DEBUG

Function UpdateCDCover();
Function String GetSkinPath(String strRaw);

Global Browser objBrowser;
Global String strSkinHTMLPath, mediatype;
Global string sitest;
Global boolean localfound;
Global layer localCover;
Global int iCoverTypeNet;

#ifdef DEBUG
Function debug(String debugStr);
debug(String debugStr) {
	messageBox(debugStr, getSkinName() +" :Debug Message", 0, "");
}
#endif


System.onScriptLoaded() {
initAttribs();
	Group notifier = system.getScriptGroup();
	objBrowser = notifier.findObject("browser.cdcover");
	localCover = notifier.findObject("local.cdcover");
	strSkinHTMLPath = System.getPath(objBrowser.getXMLParam("url"));

	iCoverTypeNet = system.getPrivateInt("OpenNote","CoverType",0);

	if (System.getPlayItemString() != "") UpdateCDCover();
	
	localCover.setXMLParam("image","cdcover.noimage");
	
}

System.onTitleChange(String strNewTitle) {
	UpdateCDCover();
}



myattr_cdcovertype.onDataChanged() {

	if(getData()=="net")
	{
		iCoverTypeNet=1;	
	}
	else
	{
		iCoverTypeNet=0;
	}

}


updateCDCover() {
//debug(integertostring(iCoverTypeNet));
	if (iCoverTypeNet==1) 
	{
		String strQuery = "",strQuery2 = "";
		String strArtist = System.getPlayitemMetaDataString("artist");
		String strAlbum = System.getPlayitemMetaDataString("album");
		String strTitle = System.getPlayitemMetaDataString("title");
		
		if (strArtist != "") strQuery += strArtist + " ";
		strQuery2 = strQuery;
		if (strAlbum != "") strQuery += strAlbum;
		if (strTitle != "") strQuery2 += strTitle;
	
		objBrowser.navigateURL(strSkinHTMLPath + "\cdcover.maki?" + System.urlEncode(strQuery));
	} 
	else 
	{
		

		string filenames = "cover.jpg,coverart.jpg,folder.jpg,front.jpg";
		string mediaPath = System.getPlayItemString();
		mediaPath = getPath(mediaPath);
		mediaPath = strRight(mediaPath, strLen(mediaPath) - (strSearch(mediaPath, "//") + 2));

		int ctr = 0;
		localfound = false;
		
		map fileload = new Map;
		
		string currFileName = getToken(filenames, ",", ctr);
		
		while ((currFileName!="") && (!localfound)) 
		{
			
			fileload.loadMap(mediaPath+chr(92)+currFileName);
			localfound = (fileload.getWidth() != 64) && (fileload.getWidth() > 0);
			if (!localfound) {
				ctr++;
				currFileName = getToken(filenames, ",", ctr);
			}
		}
		
		delete fileload;
		
		if (localfound) 
		{
			localCover.setXMLParam("image",mediaPath+chr(92)+currFileName);
		}
		else
		{
			localCover.setXMLParam("image","cdcover.noimage");
		}
	 		
	}
}

