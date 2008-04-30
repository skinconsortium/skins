//SLoB, media source moved here and changed to work with more formats other than file extension
#include <lib/std.mi>


function setSourceImg();

Global Group frameGroupSI;
global layer lyrMediaSource;


System.onScriptLoaded(){

	frameGroupSI = getScriptGroup();
	lyrMediaSource = frameGroupSI.findObject("mediasource");

}


System.onScriptUnloading(){

	frameGroupSI = NULL; // clears all events
}


setSourceImg() { 
//the whole source thing is a bit dodgy, this is probably the best its gonna get 
            String TempStr = getPlayItemString(); 
            String TempStrPath = System.getPath(TempStr); 
  
            TempStr = strlower(strLeft(TempStrPath, 3)); 
            
            //path can be cda on left 3 
            if (TempStr == "cda") { 
                        lyrMediaSource.setXMLParam("image", "main.media.cd"); 
            } 
            else 
            { 
                        TempStr = strlower(strLeft(TempStrPath, 4)); 
  
                        if (System.strsearch(System.strlower(TempStr), "vox") > 0 || System.strlower(TempStr) == "http") {

                                    lyrMediaSource.setXMLParam("image", "main.media.www"); 
                        } 
                        else 
                        { 
                                    //double check as file can also be cda right 3 
                                    if (strlower(strRight(TempStrPath, 3)) == "cda") { 
                                                //debug 
                                                //FadeMainText("1" + strlower(strRight(TempStrPath, 3)), 255, 1.0); 
                                                lyrMediaSource.setXMLParam("image", "main.media.cd"); 
                                    } 
                                    else 
                                    { 
                                                lyrMediaSource.setXMLParam("image", "main.media.file"); 
                                    } 
                        } 
            } 
    
            complete; 
} 


System.onTitleChange(string sNewTitle)
{
	setSourceImg();
}

