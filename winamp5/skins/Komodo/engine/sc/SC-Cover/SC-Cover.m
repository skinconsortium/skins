#include <lib/std.mi>

Function setArt();
Function setSize();
Function layer setNoArtPic(boolean picTog);
Function animateCover(String type);
Function centerImage();
Function showShadow(Boolean onOff);
Function ProcessMenuResult(int a);
Function String replaceString(string baseString, string toreplace, string replacedby);

Global Group XUIGroup, groupImageHold1, groupImageHold2, groupImage1, groupImage2, centerThis, shadow1, shadow2;
Global Layer image1, image2, mousetrap, shadeA1, shadeA2, shadeA3, shadeA4, shadeA5, shadeB1, shadeB2, shadeB3, shadeB4, shadeB5;
Global int ArtW, ArtH, groupW, groupH;
Global boolean artToggle, firstCover;
Global Timer waitForReturn;
Global Popupmenu artPopup;

Global String cover_transition;
Global String cover_dbCAction;
Global String cover_musicImage;
Global String cover_videoImage;
Global String cover_cdImage;
Global String cover_picNames;
Global String cover_language;
Global float cover_transitionTime;
Global int cover_keepRatio;
Global int cover_strech;
Global int cover_strechnc;
Global int cover_shadow;
Global int cover_menu;

System.onScriptLoaded() {
	XUIGroup = getScriptGroup();
	groupImageHold1 = XUIGroup.findObject("group.image.hold.1");
	groupImageHold2 = XUIGroup.findObject("group.image.hold.2");
	groupImage1 = XUIGroup.findObject("group.image.1");
	groupImage2 = XUIGroup.findObject("group.image.2");
	image1 = XUIGroup.findObject("image.1");
	image2 = XUIGroup.findObject("image.2");
	mousetrap = XUIGroup.findObject("mousetrap");
	shadow1 = XUIGroup.findObject("group.image.1.shadow");
	shadow2 = XUIGroup.findObject("group.image.2.shadow");

	firstCover=true;
	artToggle = false;

	waitForReturn = new Timer;
	waitForReturn.setDelay(50);
	waitForReturn.start();

	// DEFAULT PARAMS
	cover_transition = "fade";
	cover_dbCAction = "dir";
	cover_picNames = "cover.jpg;coverart.jpg;folder.jpg;front.jpg;cover.png;coverart.png;folder.png;front.png;%artist% - [Cover] - %album%.jpg;%artist% - %album%.jpg";
	cover_language = "Explore Item Folder;Open Album Art;Dimensions"; // Default English Langauge for menu's
	cover_transitionTime = 1.0;
	cover_keepRatio = 1;
	cover_strech = 1;
	cover_strechnc = 0;
	cover_shadow = 0;
	cover_menu = 1;
}

System.onScriptUnloading(){
	delete waitForReturn;
}

System.onTitleChange(String newtxt){
	waitForReturn.start();
}

System.onSetXuiParam(String param, String value) {
	if(strlower(param) == "changemode"){
		cover_transition = strlower(value);
	}
	else if(strlower(param) == "changetime"){
		cover_transitionTime = stringToFloat(value);
	}
	else if(strlower(param) == "filelist"){
		cover_picNames = value;
		setArt();
	}
	else if(strlower(param) == "keepratio"){
		cover_keepRatio = stringToInteger(value);
	}
	else if(strlower(param) == "strech"){
		cover_strech = stringToInteger(value);
	}
	else if(strlower(param) == "strechnocover"){
		cover_strechnc = stringToInteger(value);
	}
	else if(strlower(param) == "musicimage"){
		cover_musicImage = value;
		setArt();
	}
	else if(strlower(param) == "videoimage"){
		cover_videoImage = value;
		//setArt();
	}
	else if(strlower(param) == "cdmusicimage"){
		cover_cdImage = value;
		//setArt();
	}
	else if(strlower(param) == "menu"){
		cover_menu = stringToInteger(value);
	}
	else if(strlower(param) == "dbclickaction"){
		cover_dbCAction = value;
	}
	else if(strlower(param) == "language"){
		cover_language = value;
	}
	else if(strlower(param) == "shadow"){
		if(value=="1"){
			cover_shadow=1;
		}
		else{
			cover_shadow=0;
		}
		setArt();
	}
	artToggle=!artToggle;
	centerImage();
	artToggle=!artToggle;
}

showShadow(Boolean onOff){
	if(onOff){
		image1.setXmlParam("w","-6");
		image1.setXmlParam("h","-6");
		image2.setXmlParam("w","-6");
		image2.setXmlParam("h","-6");
		shadow1.show();
		shadow2.show();
	}
	else{
		image1.setXmlParam("w","0");
		image1.setXmlParam("h","0");
		image2.setXmlParam("w","0");
		image2.setXmlParam("h","0");
		shadow1.hide();
		shadow2.hide();
	}
}

setArt(){
	String fullFileName = getPlayItemMetaDataString("filename");
	String protect = System.getToken(fullFileName, "%", 0);		// Filenames with a %-sign will crash Winamp... *Not anymore
	String temp = System.Strleft("\ ", 1);

	int picNum = 0;

	showShadow(cover_shadow);


	if(fullFileName != ""){		// && protect == fullFileName){
		while(true){

			/*		////////////////////////////////////////////////////////////
					Select which type of Picture to show (video, audioCD, cover)
					\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
			*/
			if(System.getToken(cover_picNames, ";", picNum)==""){
				showShadow(0);	//Don't shadow noCover pictures
				if(artToggle){
					if(System.isVideo()==1){
						image2.setXmlParam ("image", cover_videoImage);
					}
					else if(getSongInfoText() == "1411kbps stereo 44.0kHz" || getSongInfoText() == "1411kbps stereo 44.1kHz"){
						image2.setXmlParam ("image", cover_cdImage);
					}
					else{
						image2.setXmlParam ("image", cover_musicImage);
					}
				}
				else{
					if(System.isVideo()==1){
						image1.setXmlParam ("image", cover_videoImage);
					}
					else if(getSongInfoText() == "1411kbps stereo 44.0kHz" || getSongInfoText() == "1411kbps stereo 44.1kHz"){
						image1.setXmlParam ("image", cover_cdImage);
					}
					else{
						image1.setXmlParam ("image", cover_musicImage);
					}
				}
				break;
      			}


			/*		////////////////////////////////////////////////
					If its not a video or audioCD look for a picture
					\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
			*/
			String getFilename = getPath(fullFileName) +temp + System.getToken(cover_picNames, ";", picNum);
			getFilename = replaceString(getFilename, "%artist%", getPlayItemMetaDataString("artist"));
			getFilename = replaceString(getFilename, "%title%", getPlayItemMetaDataString("title"));
			getFilename = replaceString(getFilename, "%album%", getPlayItemMetaDataString("album"));
			getFilename = replaceString(getFilename, "%year%", getPlayItemMetaDataString("year"));

			map m = new Map;
			m.loadMap(getFilename);
			if(m.getWidth()==0 || (m.getWidth()==64 && m.getHeight()==64)){
				picNum++;
			}
			else{
				if(artToggle){
					image2.setXmlParam ("image", getFilename);
				}
				else{
					image1.setXmlParam ("image", getFilename);
				}
				break;
			}
			delete m;
		}
	}

	centerImage();

			/*		///////////////////////////////////////////////
					If picture doesn't change there is no animation
					\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
			*/
	if(image1.getXMLParam("image") == image2.getXMLParam("image") || firstCover){
		animateCover("none");
		firstCover=false;
	}
	else{
		animateCover(cover_transition);
	}

}

setSize(){
	groupImage1.setXMLParam("w", integerToString(XUIGroup.getWidth()));
	groupImage1.setXMLParam("h", integerToString(XUIGroup.getHeight()));
	groupImage2.setXMLParam("w", integerToString(XUIGroup.getWidth()));
	groupImage2.setXMLParam("h", integerToString(XUIGroup.getHeight()));
}

/*		//////////////////////
		Do the animations here
		\\\\\\\\\\\\\\\\\\\\\\
*/
animateCover(String type){
	int dir = 1;
	//System.debugString("asked for " + type, 0);
	// ------------ Random Animation
	if(type=="random"){
		int i = System.random(10);
		if(i==0){
			type="fade";
		}
		else if(i==1){
			type="fadeslide";
		}
		else if(i==2){
			type="slide:w";
		}
		else if(i==3){
			type="slide:w:r";
		}
		else if(i==4){
			type="slide:h";
		}
		else if(i==5){
			type="slide:h:r";
		}
		else if(i==6){
			type="slide:z";
		}
		else if(i==7){
			type="slide:z:r";
		}
		else if(i==8){
			type="slide:z2";
		}
		else{
			type="slide:z2:r";
		}			
	}

	// Reversed animations
	if(type=="slide:w:r"){
		dir = -1;
		type ="slide:w";
	}
	else if(type=="slide:h:r"){
		dir = -1;
		type ="slide:h";
	}
	else if(type=="slide:z:r"){
		dir = -1;
		type ="slide:z";
	}
	else if(type=="slide:z2:r"){
		dir = -1;
		type ="slide:z2";
	}

	// ------------ Fade Animation
	// ------------ No Animation
	if(type=="none"){
		groupImage1.setXmlParam("x","0");
		groupImage1.setXmlParam("Y","0");
		groupImage2.setXmlParam("x","0");
		groupImage2.setXmlParam("Y","0");

		if(artToggle){ 									//Show Image2
			groupImage1.setAlpha(0);
			groupImage2.setAlpha(255);
		}
		else{ 										//Show Image1
			groupImage1.setAlpha(255);
			groupImage2.setAlpha(0);
		}
	}
	else if(type=="fade"){
		groupImage1.setXmlParam("x","0");
		groupImage1.setXmlParam("Y","0");
		groupImage2.setXmlParam("x","0");
		groupImage2.setXmlParam("Y","0");

		groupImage1.setTargetX(0); // *FIX - Without this the animation will goto a targetXY(think it's a bug in maki)
		groupImage2.setTargetX(0);
		groupImage1.setTargetY(0);
		groupImage2.setTargetY(0);

		if(artToggle){									//Show Image2
			groupImage1.setAlpha(255);
			groupImage2.setAlpha(0);
			groupImage1.setTargetA(0);
			groupImage2.setTargetA(255);
		}
		else{										//Show Image1
			groupImage1.setAlpha(0);
			groupImage2.setAlpha(255);
			groupImage1.setTargetA(255);
			groupImage2.setTargetA(0);
		}
		groupImage1.setTargetSpeed(cover_transitionTime);
		groupImage2.setTargetSpeed(cover_transitionTime);
		groupImage1.gotoTarget();
		groupImage2.gotoTarget();
	}
	// ------------ FadeSlide Animation
	else if(type=="fadeslide"){
		groupImage1.setAlpha(255);
		groupImage2.setAlpha(255);
		groupImage1.setXMLParam("y","0"); // *FIX - Without this the animation will goto a targetXY(think it's a bug in maki)
		groupImage2.setXMLParam("y","0"); //
		groupImage1.setTargetY(0); //
		groupImage2.setTargetY(0);  //

		if(artToggle){									//Show Image2
			groupImage1.setAlpha(255);
			groupImage2.setAlpha(0);

			groupImage1.setXMLParam("x","0");
			groupImage2.setXMLParam("x",integerToString(XUIGroup.getWidth()*dir));
			groupImage1.setTargetA(0);
			groupImage2.setTargetA(255);
			groupImage1.setTargetX(-XUIGroup.getWidth()*dir);
			groupImage2.setTargetX(0);
		}
		else{										//Show Image1
			groupImage1.setAlpha(0);
			groupImage2.setAlpha(255);

			groupImage1.setXMLParam("x",integerToString(XUIGroup.getWidth()*dir));
			groupImage2.setXMLParam("x","0");
			groupImage1.setTargetA(255);
			groupImage2.setTargetA(0);
			groupImage1.setTargetX(0);
			groupImage2.setTargetX(-XUIGroup.getWidth()*dir);
		}
		groupImage1.setTargetSpeed(cover_transitionTime);
		groupImage2.setTargetSpeed(cover_transitionTime);
		groupImage1.gotoTarget();
		groupImage2.gotoTarget();
	}
	// ------------ Slide Animation
	else if(type=="slide:w"){
		groupImage1.setAlpha(255);
		groupImage2.setAlpha(255);
		groupImage1.setTargetA(255); // *FIX - Bug in maki? (see fade animation explanation)
		groupImage2.setTargetA(255); //
		groupImage1.setXMLParam("y","0"); //
		groupImage2.setXMLParam("y","0"); //
		groupImage1.setTargetY(0); //
		groupImage2.setTargetY(0); //

		if(artToggle){									//Show Image2
			groupImage1.setXMLParam("x","0");
			groupImage2.setXMLParam("x",integerToString(XUIGroup.getWidth()*dir));
			groupImage1.setTargetX(-XUIGroup.getWidth()*dir);
			groupImage2.setTargetX(0);
		}
		else{										//Show Image1
			groupImage1.setXMLParam("x",integerToString(XUIGroup.getWidth()*dir));
			groupImage2.setXMLParam("x","0");
			groupImage1.setTargetX(0);
			groupImage2.setTargetX(-XUIGroup.getWidth()*dir);
		}
		groupImage1.setTargetSpeed(cover_transitionTime);
		groupImage2.setTargetSpeed(cover_transitionTime);
		groupImage1.gotoTarget();
		groupImage2.gotoTarget();
	}
	else if(type=="slide:h"){
		groupImage1.setAlpha(255);
		groupImage2.setAlpha(255);
		groupImage1.setTargetA(255); // *FIX - Bug in maki? (see fade animation explanation)
		groupImage2.setTargetA(255); //
		groupImage1.setXMLParam("x","0"); //
		groupImage2.setXMLParam("x","0"); //
		groupImage1.setTargetX(0); //
		groupImage2.setTargetX(0); //

		if(artToggle){									//Show Image2
			groupImage1.setXMLParam("y","0");
			groupImage2.setXMLParam("y",integerToString(-XUIGroup.getHeight()*dir));
			groupImage1.setTargetY(XUIGroup.getHeight()*dir);
			groupImage2.setTargetY(0);
		}
		else{										//Show Image1
			groupImage1.setXMLParam("y",integerToString(-XUIGroup.getHeight()*dir));
			groupImage2.setXMLParam("y","0");
			groupImage1.setTargetY(0);
			groupImage2.setTargetY(XUIGroup.getHeight()*dir);
		}
		groupImage1.setTargetSpeed(cover_transitionTime);
		groupImage2.setTargetSpeed(cover_transitionTime);
		groupImage1.gotoTarget();
		groupImage2.gotoTarget();
	}
	// ------------ Slide:Z Animation
	else if(type=="slide:z"){
		groupImage1.setAlpha(255);
		groupImage2.setAlpha(255);
		groupImage1.setTargetA(255); // *FIX - Bug in maki? (see fade animation explanation)
		groupImage2.setTargetA(255);

		if(artToggle){									//Show Image2
			groupImage1.setXMLParam("x","0");
			groupImage1.setXMLParam("y","0");
			groupImage2.setXMLParam("x",integerToString(XUIGroup.getWidth()*dir));
			groupImage2.setXMLParam("y",integerToString(XUIGroup.getHeight()*dir));
			groupImage1.setTargetX(-XUIGroup.getWidth()*dir);
			groupImage1.setTargetY(-XUIGroup.getHeight()*dir);
			groupImage2.setTargetX(0);
			groupImage2.setTargetY(0);
		}
		else{										//Show Image1
			groupImage1.setXMLParam("x",integerToString(XUIGroup.getWidth()*dir));
			groupImage1.setXMLParam("y",integerToString(XUIGroup.getHeight()*dir));
			groupImage2.setXMLParam("x","0");
			groupImage2.setXMLParam("y","0");
			groupImage1.setTargetX(0);
			groupImage1.setTargetY(0);
			groupImage2.setTargetX(-XUIGroup.getWidth()*dir);
			groupImage2.setTargetY(-XUIGroup.getHeight()*dir);
		}
		groupImage1.setTargetSpeed(cover_transitionTime);
		groupImage2.setTargetSpeed(cover_transitionTime);
		groupImage1.gotoTarget();
		groupImage2.gotoTarget();
	}
	// ------------ Slide:Z2 Animation
	else if(type=="slide:z2"){
		groupImage1.setAlpha(255);
		groupImage2.setAlpha(255);
		groupImage1.setTargetA(255); // *FIX - Bug in maki? (see fade animation explanation)
		groupImage2.setTargetA(255);

		if(artToggle){									//Show Image2
			groupImage1.setXMLParam("x","0");
			groupImage1.setXMLParam("y","0");
			groupImage2.setXMLParam("x",integerToString(-XUIGroup.getWidth()*dir));
			groupImage2.setXMLParam("y",integerToString(XUIGroup.getHeight()*dir));
			groupImage1.setTargetX(XUIGroup.getWidth()*dir);
			groupImage1.setTargetY(-XUIGroup.getHeight()*dir);
			groupImage2.setTargetX(0);
			groupImage2.setTargetY(0);
		}
		else{										//Show Image1
			groupImage1.setXMLParam("x",integerToString(-XUIGroup.getWidth()*dir));
			groupImage1.setXMLParam("y",integerToString(XUIGroup.getHeight()*dir));
			groupImage2.setXMLParam("x","0");
			groupImage2.setXMLParam("y","0");
			groupImage1.setTargetX(0);
			groupImage1.setTargetY(0);
			groupImage2.setTargetX(XUIGroup.getWidth()*dir);
			groupImage2.setTargetY(-XUIGroup.getHeight()*dir);
		}
		groupImage1.setTargetSpeed(cover_transitionTime);
		groupImage2.setTargetSpeed(cover_transitionTime);
		groupImage1.gotoTarget();
		groupImage2.gotoTarget();
	}
	artToggle=!artToggle;
	//System.debugString("got " + type, 0);
}

XUIGroup.onResize(int x, int y, int w, int h){
	groupW = w;
	groupH = h;

	//setSize();

	artToggle=!artToggle;
	centerImage();
	artToggle=!artToggle;

	//if(groupImage1.isGoingToTarget()){
		artToggle=!artToggle;
		groupImage1.cancelTarget();
		groupImage2.cancelTarget();
		animateCover("none");
	//}
}

centerImage(){
	Boolean isFile = false; //Don't maximize noCover images
	map m = new Map;
	if(!artToggle){
		//System.debugString("centerImage() on image1", 1);
		centerThis=groupImageHold1;
		m.loadMap(image1.getXMLParam("image"));
		if(strsearch(image1.getXmlParam("image"),":")!=-1){
			isFile=true;
		}
	}
	else{
		//System.debugString("centerImage() on image2", 1);
		centerThis=groupImageHold2;
		m.loadMap(image2.getXMLParam("image"));
		if(strsearch(image2.getXmlParam("image"),":")!=-1){
			isFile=true;
		}
	} 

	ArtW = m.getWidth();
	ArtH = m.getHeight();
	delete m;

	if((cover_strech==1 && isFile) || (cover_strechnc==1 && !isFile)){			// Maximize it?
		centerThis.setXMLParam ("w", integertostring(groupW));
		centerThis.setXMLParam ("h", integertostring(groupH));

		if(cover_keepRatio==1){								// Keep ratio?
			if(ArtH==0 || groupH==0){}						//Do not divide by zero!
			else if((ArtW/ArtH)>(groupW/groupH)){
				centerThis.setXmlParam ("h", integertostring((groupW)*(ArtH/ArtW)));
       			}
			else{
				centerThis.setXmlParam ("w", integertostring((groupH)*(ArtW/ArtH)));
			}
		}
	}
	else{
		centerThis.setXMLParam ("w", integertostring(ArtW+cover_shadow*6));
		centerThis.setXMLParam ("h", integertostring(ArtH+cover_shadow*6));

		if(ArtW>groupW || ArtH>groupH){
			if(groupW*(ArtH/ArtW)<groupH && ArtW>groupW){
				centerThis.setXmlParam ("w", integertostring(groupW));
         			centerThis.setXmlParam ("h", integertostring(groupW*(ArtH/ArtW)));
			}
			else{
				centerThis.setXmlParam ("h", integertostring(groupH));
				centerThis.setXmlParam ("w", integertostring(groupH*(ArtW/ArtH)));
			}
		}

	}
	centerThis.setXmlParam ("x", integertostring(groupW/2 - centerThis.getWidth()/2));
	centerThis.setXmlParam ("y", integertostring((groupH)/2 - centerThis.getHeight()/2));
	return centerThis;
}

mousetrap.onLeftButtonDblClk(int x, int y){
	if(cover_dbCAction=="dir"){
		 System.navigateUrl(getPath(getPlayItemMetaDataString("filename")));
	}
	else if(cover_dbCAction=="pic"){
		if(artToggle){
			if(strsearch(image1.getXmlParam("image"),":")==-1){
				System.navigateUrl(getPath(getPlayItemMetaDataString("filename")));
			}
			else{
				System.navigateUrl(image1.getXmlParam("image"));
			}
		}
		else{
			if(strsearch(image2.getXmlParam("image"),":")==-1){
				System.navigateUrl(getPath(getPlayItemMetaDataString("filename")));
			}
			else{
				System.navigateUrl(image2.getXmlParam("image"));
			}
		}
	}
}

mousetrap.onRightButtonUp(int x, int y){
	if(cover_menu==1){
		artPopup = new PopupMenu;
		artPopup.addCommand(getToken(cover_language,";",0), 1, 0, 0);
		if(artToggle){
			if(strsearch(image1.getXmlParam("image"),":")==-1){
				artPopup.addCommand(getToken(cover_language,";",1), 2, 0, 1);

			}
			else{
				artPopup.addCommand(getToken(cover_language,";",1), 2, 0, 0);
				artPopup.addSeparator();
				artPopup.addCommand(getToken(cover_language,";",2), 3, 0, 1);
				artPopup.addCommand(integerToString(ArtW)+"x"+integerToString(ArtH), 4, 0, 1);
			}
		}
		else{
			if(strsearch(image2.getXmlParam("image"),":")==-1){
				artPopup.addCommand(getToken(cover_language,";",1), 2, 0, 1);
			}
			else{
				artPopup.addCommand(getToken(cover_language,";",1), 2, 0, 0);
				artPopup.addSeparator();
				artPopup.addCommand(getToken(cover_language,";",2), 3, 0, 1);
				artPopup.addCommand(integerToString(ArtW)+"x"+integerToString(ArtH), 4, 0, 1);
			}
		}
		ProcessMenuResult(artPopup.popAtMouse());
		complete;
	}
}

ProcessMenuResult(int a){
	if(a==1){
		System.navigateUrl(getPath(getPlayItemMetaDataString("filename")));
	}
	else if(a==2){
		if(artToggle){
			System.navigateUrl(image1.getXmlParam("image"));
		}
		else{
			System.navigateUrl(image2.getXmlParam("image"));
		}
	}
	delete artPopup;
}

waitForReturn.onTimer(){
	if(System.getPlayItemLength() == -1){
		waitForReturn.stop();
		waitForReturn.start();
	}
	else{
		setArt();
		waitForReturn.stop();
	}
}

String replaceString(string baseString, string toreplace, string replacedby) {
	if (toreplace == "") return baseString;
	string sf1 = strupper(baseString);
	string sf2 = strupper(toreplace);
	int i = strsearch(sf1, sf2);
	if (i == -1) return baseString;
	string left = "", right = "";
	if (i != 0) left = strleft(baseString, i);
	if (strlen(basestring) - i - strlen(toreplace) != 0) {
		right = strright(basestring, strlen(basestring) - i - strlen(toreplace));
	}
	return left + replacedby + right;
}