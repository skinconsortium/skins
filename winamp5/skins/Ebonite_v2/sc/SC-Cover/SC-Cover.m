#include <lib/std.mi>

#define FXPi 3.14159

//Function setArt();
Function setAlbumArt();
Function setSize();
Function animateCover(String type);
Function centerImage();
Function showShadow(Boolean onOff);
Function ProcessMenuResult(int a);
Function String replaceString(string baseString, string toreplace, string replacedby);
Function toggleFXImage();
Function layerFX1();
Function disableFX();
Global layout Cover;
Global Group XUIGroup, groupImageHold1, groupImageHold2, groupImage1, groupImage2, centerThis, shadow1, shadow2, groupimagereflections;
Global Layer mousetrap, shadeA1, shadeA2, shadeA3, shadeA4, shadeA5, shadeB1, shadeB2, shadeB3, shadeB4, shadeB5;
Global Layer image1reflection, image2reflection;
Global int ArtW, ArtH, groupW, groupH;
Global boolean artToggle, firstCover;
Global Timer waitForReturn;
Global Popupmenu artPopup, cover_transitionTimeSubMenu, cover_transitionRandomSubMenu, cover_transitiondistortionSubMenu;
Global Popupmenu cover_transitionNormalSubMenu, cover_transitionLayerFXSubMenu, cover_transitionCycleSubMenu, cover_transitionFadeOutTimeSubMenu;
Global Popupmenu cover_demomodeSubmenu, CoverOptionsStd, CoverOptionsAdv;

Global String cover_transition;
Global String cover_dbCAction;
Global String cover_musicImage;
Global String cover_videoImage;
Global String cover_cdImage;
Global String cover_picNames;
Global String cover_language;
Global float cover_transitionTime, cover_transitionFadeOutTime;
Global int cover_keepRatio;
Global int cover_stretch;
Global int cover_stretchnc;
Global int cover_shadow;
Global int cover_menu;

Global int cover_reflections;
//Global int forceTransition;
Global int fxLength;
Global int transitionTimeMenuValue;
//Global int Transition_RandomiselayerFX, Transition_RandomiseBasic, Transition_RandomiseALL, Transition_ResettoDefault;
Global int Transition_CyclelayerFX, Transition_CycleBasic, Transition_CycleALL;

Global Layer Fx1, Fx2, Reflection1;
Global Double dp, tp, rp, z0, x1, Y1, Z1, x2, y2, x, y, z, dR, dbR, dTheta, dbD, rx;
Global Double dz, dx, dy, t, d1, d2, resR, r1, dblSmidge, dblFactor, OriginaldblFactor, dblSmidgeReflection;
Global Timer fxTmr, TransitionDisabler, demotmr;
Global String cover_transition_clone, cover_transition_original;
Global int ctt1, ctt2, ctt3, ctt4, ctt5, ctt6, ctt7, ctt8, ctt9, ctt10, dUFOVu;
Global int ctdv1, ctdv2, ctdv3, ctdv4, ctdv5;
Global int cover_transitionDistortionFactor;
Global int ctn1, ctlfx1;
Global int LayerFXSubTransition, LayerFXSubTransitionEnable, LayerFXSubTransitionVariationEnable;
Global int ctt11, ctt12, ctt13, ctt14, ctt15, ctt16, ctt17, ctt18, cover_transitionMenuFadeOutValue;
Global int demoMode, bAllowDemoMode, dir;
Global string sfx2, sfx1;
Global guiobject image1, image2;

System.onScriptLoaded() 
{

	
	XUIGroup = getScriptGroup();
	/*Cover = getContainer("covermain").getLayout("cover");*/
	
	groupImageHold1 = XUIGroup.findObject("group.image.hold.1");
	groupImageHold2 = XUIGroup.findObject("group.image.hold.2");
	groupImage1 = XUIGroup.findObject("group.image.1");
	groupImage2 = XUIGroup.findObject("group.image.2");
	image1 = XUIGroup.findObject("image.1");
	image2 = XUIGroup.findObject("image.2");
	mousetrap = XUIGroup.findObject("mousetrap");
	shadow1 = XUIGroup.findObject("group.image.1.shadow");
	shadow2 = XUIGroup.findObject("group.image.2.shadow");
	

	Fx1 = XUIGroup.findObject("layerfx.1");
	Fx2 = XUIGroup.findObject("layerfx.2");
	
	Fx1.fx_setBgFx(0);
  	Fx1.fx_setWrap(0);
  	Fx1.fx_setBilinear(1);
  	Fx1.fx_setAlphaMode(1);
  	Fx1.fx_setGridSize(12,12); //this can be anything really, higher looks smoother
  	Fx1.fx_setRect(1);
	Fx1.fx_setClear(1);
  	Fx1.fx_setLocalized(1);
  	Fx1.fx_setRealtime(1);
  	Fx1.fx_setSpeed(30);
  	Fx1.setAlpha(255);
	
	Fx1.hide();
	Fx1.fx_setEnabled(0);
	
	Fx2.fx_setBgFx(0);
  	Fx2.fx_setWrap(0);
  	Fx2.fx_setBilinear(1);
  	Fx2.fx_setAlphaMode(1);
  	Fx2.fx_setGridSize(12,12); //this can be anything really, higher looks smoother
  	Fx2.fx_setRect(1);
	Fx2.fx_setClear(1);
  	Fx2.fx_setLocalized(1);
  	Fx2.fx_setRealtime(1);
  	Fx2.fx_setSpeed(30);
  	Fx2.setAlpha(255);
	
	Fx2.hide();
	Fx2.fx_setEnabled(0);
	
	z0=1.1;
	x1=0.1;
	Y1=0.1;
	Z1=0.3;
	x2=0.1;
	y2=0.1; 
	x=0.1;
	y=0.1; 
	z=0.4;
	r1 = 0;
	dp=0.1;
	tp=0.1;
	dUFOVu=255;
	dblSmidge = 0;
	dblSmidgeReflection = 0;
	OriginaldblFactor = 0.15; //Tweak this to adjust level of distortion, default for now
	dblFactor = 0.15; // adjustable level of distortion
	ctt1 = 0;
	ctt2 = 0; 
	ctt3 = 0;
	ctt4 = 0;
	ctt5 = 0;
	ctt6 = 0;
	ctt7 = 0;
	ctt8 = 0;
	ctt9 = 0;
	ctt10 = 0;
	
	ctt11 = 0;
	ctt12 = 0;
	ctt13 = 0;
	ctt14 = 0;
	ctt15 = 0;
	ctt16 = 0;
	ctt17 = 0;
	ctt18 = 0;
	
	ctdv1 = 0;
	ctdv2 = 0;
	ctdv3 = 0;
	ctdv4 = 0;
	ctdv5 = 0;
	
	
	
	ctn1 = 0;
	ctlfx1 = 0;
	LayerFXSubTransition = 1;
	#ifdef DEBUG
	LayerFXSubTransition = 1;
	#endif

	firstCover=true;
	artToggle = false;
		
	waitForReturn = new Timer;
	waitForReturn.setDelay(100);
	//waitForReturn.stop();
	waitForReturn.start();

	// DEFAULT PARAMS
	cover_transition = "fade";
	cover_dbCAction = "dir";
	cover_picNames = "%artist% - [Cover] - %album%.jpg;%artist% - %album%.jpg;%album% (%year%).jpg;(%year%) %album%.jpg;%album%.jpg;cover.jpg;coverart.jpg;folder.jpg;front.jpg;cover.png;coverart.png;folder.png;front.png;C:\My Covers";
	cover_language = "Explore Item Folder;Open Album Art;Force Transition;Stretch Cover;Image Dimensions"; // Default English Langauge for menu's
	cover_keepRatio = 1;
	cover_stretchnc = 0;
	cover_shadow = 0;
	cover_menu = 1;
	cover_transition_clone = "";
	transitionTimeMenuValue = getPrivateInt("SC_Cover", "TransitionTime", 1.0);
	cover_transitionTime = transitionTimeMenuValue;
		
	cover_transitionDistortionFactor = getPrivateInt("SC_Cover", "DistortionFactor", 5);
	LayerFXSubTransitionEnable = getPrivateInt("SC_Cover", "EnabledLayerFXSubTransitions", 1);
	LayerFXSubTransitionVariationEnable = getPrivateInt("SC_Cover", "EnabledLayerFXTransitionVariations", 1);
	Transition_CyclelayerFX = getPrivateInt("SC_Cover", "CyclelayerFX", 0);
	Transition_CycleBasic = getPrivateInt("SC_Cover", "CycleBasic", 0);
	cover_transitionMenuFadeOutValue = getPrivateInt("SC_Cover", "TransitionFadeOutTime", 3);
	
	
	if(cover_transitionMenuFadeOutValue==0)
	{
		cover_transitionMenuFadeOutValue = 3;
	}
	//messagebox(integertostring(cover_transitionMenuFadeOutValue,2),"",1,"");
	//fade out trans time
	if(cover_transitionMenuFadeOutValue>=1 && cover_transitionMenuFadeOutValue<=7)
	{	
		ctt11 = 0;
		ctt12 = 0;
		ctt13 = 0;
		ctt14 = 0;
		ctt15 = 0;
		ctt16 = 0;
		ctt17 = 0;

		if(cover_transitionMenuFadeOutValue==1)
		{
			ctt11 = 1;
			cover_transitionFadeOutTime=0.5;
		}
		else if(cover_transitionMenuFadeOutValue==2)
		{
			ctt12 = 1;
			cover_transitionFadeOutTime=0.8;
		}
		else if(cover_transitionMenuFadeOutValue==3)
		{
			ctt13 = 1;
			cover_transitionFadeOutTime=1.0;			
		}
		else if(cover_transitionMenuFadeOutValue==4)
		{
			ctt14 = 1;
			cover_transitionFadeOutTime=1.3;
		}
		else if(cover_transitionMenuFadeOutValue==5)
		{
			ctt15 = 1;
			cover_transitionFadeOutTime=1.5;
		}
		else if(cover_transitionMenuFadeOutValue==6)
		{
			ctt16 = 1;
			cover_transitionFadeOutTime=2.0;
		}
		else if(cover_transitionMenuFadeOutValue==7)
		{
			ctt17 = 1;
			cover_transitionFadeOutTime=2.5;
		}		
	}
	
	//trans time
	if(cover_transitionTime>=0.5 && cover_transitionTime<=6.0)
	{	
		ctt1 = 0;
		ctt2 = 0; 
		ctt3 = 0;
		ctt4 = 0;
		ctt5 = 0;
		ctt6 = 0;
		ctt7 = 0;
		ctt8 = 0;	
		ctt9 = 0;
		ctt10 = 0;

		if(cover_transitionTime==0.5)
		{
			ctt1 = 1;
		}
		else if(cover_transitionTime==1.0)
		{
			ctt2 = 1; 
		}
		else if(cover_transitionTime==1.5)
		{
			ctt3 = 1;
		}
		else if(cover_transitionTime==2.0)
		{
			ctt4 = 1;
		}
		else if(cover_transitionTime==2.5)
		{
			ctt5 = 1;
		}
		else if(cover_transitionTime==3.0)
		{
			ctt6 = 1;
		}
		else if(cover_transitionTime==3.5)
		{
			ctt7 = 1;
		}
		else if(cover_transitionTime==4.0)
		{
			ctt8 = 1;
		}
		else if(cover_transitionTime==5.0)
		{
			ctt9 = 1;
		}
		else if(cover_transitionTime==6.0)
		{
			ctt10 = 1;
		}
	}	
	
	ctdv1 = 0;
	ctdv2 = 0; 
	ctdv3 = 0;
	ctdv4 = 0;
	ctdv5 = 0;	
	//sort out distortion factor
	if(cover_transitionDistortionFactor==1)
	{
		ctdv1 = 1;
	}
	else if(cover_transitionDistortionFactor==5)
	{
		ctdv2 = 1; 
	}
	else if(cover_transitionDistortionFactor==10)
	{
		ctdv3 = 1;
	}
	else if(cover_transitionDistortionFactor==15)
	{
		ctdv4 = 1;
	}
	else if(cover_transitionDistortionFactor==20)
	{
		ctdv5 = 1;		
	}

	//reset to original value before distorting
	dblFactor = OriginaldblFactor;
	dblFactor =	dblFactor * cover_transitionDistortionFactor;

	
	if(cover_stretch==1)
	{
		cover_reflections = 0;
	}
	
	//timer/effect length
	fxLength = cover_transitionTime*1000;
	
	fxTmr = new Timer;
	fxTmr.setDelay(fxLength);
	fxTmr.stop();
		
	demotmr = new Timer;
	demotmr.setDelay(750);
	demotmr.stop();
	
	//timer to disable layerfx after fade out
	TransitionDisabler = new Timer;
	TransitionDisabler.setDelay(2000);
	TransitionDisabler.stop();
		
	//demo mode
	demoMode=0;
	bAllowDemoMode=0;
	
}

System.onScriptUnloading(){

	setPrivateInt("SC_Cover", "cover_reflections", cover_reflections);
	setPrivateInt("SC_Cover", "TransitionTime", transitionTimeMenuValue);
	setPrivateInt("SC_Cover", "DistortionFactor", cover_transitionDistortionFactor);
	setPrivateInt("SC_Cover", "EnabledLayerFXSubTransitions", LayerFXSubTransitionEnable);
	setPrivateInt("SC_Cover", "EnabledLayerFXTransitionVariations", LayerFXSubTransitionVariationEnable);
	setPrivateInt("SC_Cover", "CyclelayerFX", Transition_CyclelayerFX);
	setPrivateInt("SC_Cover", "CycleBasic", Transition_CycleBasic);
	setPrivateInt("SC_Cover", "TransitionFadeOutTime", cover_transitionMenuFadeOutValue);

			
	delete waitForReturn;
	delete fxTmr;
	delete demotmr;
	delete TransitionDisabler;
}


Cover.onSetVisible(Boolean on)
{
	if(on)
	{
		waitForReturn.start();
	}
	else
	{
		fxTmr.stop();
		demotmr.stop();
		TransitionDisabler.stop();
		waitForReturn.stop();
		Fx2.fx_setEnabled(0);
		Fx2.fx_setEnabled(0);	
	
	}
}





System.onTitleChange(String newTitle)
{
	if(cover_stretch==1)
	{
		cover_reflections = 0;
	}
	
	waitForReturn.start();
}

System.onSetXuiParam(String param, String value) {
	if(strlower(param) == "changemode"){
		cover_transition = strlower(value);
		cover_transition_original = strlower(value);
	}
	else if(strlower(param) == "changetime"){
		cover_transitionTime = stringToFloat(value);
		fxLength = cover_transitionTime*1000;
		fxTmr.setDelay(fxLength);	
	}
	else if(strlower(param) == "filelist"){
		cover_picNames = value;
		//setArt(); //using albumart object		
	}
	else if(strlower(param) == "keepratio"){
		cover_keepRatio = stringToInteger(value);
	}
	else if(strlower(param) == "stretch"){
		cover_stretch = stringToInteger(value);
		//setArt(); //using albumart object
	}
	else if(strlower(param) == "stretchnocover"){
		cover_stretchnc = stringToInteger(value);
	}
	else if(strlower(param) == "musicimage"){
		cover_musicImage = value;
		//setArt(); //using albumart object
	}
	else if(strlower(param) == "videoimage"){
		cover_videoImage = value;
		//setArt(); //using albumart object
	}
	else if(strlower(param) == "cdmusicimage"){
		cover_cdImage = value;
		//setArt(); //using albumart object
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
	else if(strlower(param) == "allowdemomode"){
		bAllowDemoMode = stringtointeger(value);
		demoMode = stringtointeger(value);
	}
	
	artToggle=!artToggle;
	centerImage();
	artToggle=!artToggle;
}

/*
setArt(){
	String fullFileName = getPlayItemMetaDataString("filename");
	String protect = System.getToken(fullFileName, "%", 0);		// Filenames with a %-sign will crash Winamp... *Not anymore
	String temp = System.Strleft("\ ", 1);

	int picNum = 0;



	if(fullFileName != ""){		// && protect == fullFileName){
	
	String lookHere = getPath(fullFileName) + temp;
	Boolean didILookThere = false;
	while(true){

			//Select which type of Picture to show (video, audioCD, cover)
			
			if(StrLeft(getPlayItemString(), 7) == "http://"){
				if(artToggle){
					image2.setXmlParam ("image", cover_musicImage);
				}
				else{
					image1.setXmlParam ("image", cover_musicImage);
				}
				break;

			}
			
			if(System.getToken(cover_picNames, ";", picNum)==""){
				//debugString("NEW FOLDER --- "+System.getToken(cover_picNames, ";", picNum-1),9);

				if(strsearch(System.getToken(cover_picNames, ";", picNum-1),":")!=-1 && !didILookThere){
					lookHere = System.getToken(cover_picNames, ";", picNum-1) + temp;
					picNum = 0;
					didILookThere = true;
				}
				else{
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
      		}



			//If its not a video or audioCD look for a picture

			String getFilename = lookHere + System.getToken(cover_picNames, ";", picNum);
			getFilename = replaceString(getFilename, "%artist%", getPlayItemMetaDataString("artist"));
			getFilename = replaceString(getFilename, "%title%", getPlayItemMetaDataString("title"));
			getFilename = replaceString(getFilename, "%album%", getPlayItemMetaDataString("album"));
			getFilename = replaceString(getFilename, "%year%", getPlayItemMetaDataString("year"));
			getFilename = replaceString(getFilename, "%track%", getPlayItemMetaDataString("track"));
			getFilename = replaceString(getFilename, "%genre%", getPlayItemMetaDataString("genre"));

			map m = new Map;
			m.loadMap(getFilename);
			//debugString(getFilename,9);
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

			
	if((image1.getXMLParam("image") == image2.getXMLParam("image") || firstCover))
	{
		animateCover("none");
		firstCover=false;
	}
	else
	{


		animateCover(cover_transition);

	}

}
*/

setAlbumArt()
{
	animateCover(cover_transition);
}

setSize(){
	groupImage1.setXMLParam("w", integerToString(XUIGroup.getWidth()));
	groupImage1.setXMLParam("h", integerToString(XUIGroup.getHeight()));
	groupImage2.setXMLParam("w", integerToString(XUIGroup.getWidth()));
	groupImage2.setXMLParam("h", integerToString(XUIGroup.getHeight()));
	
	//image1reflection.setXMLParam("w", integerToString(XUIGroup.getWidth()));
	
	//image2reflection.setXMLParam("w", integerToString(XUIGroup.getWidth()));
}

/*		//////////////////////
		Do the animations here
		\\\\\\\\\\\\\\\\\\\\\\
*/
animateCover(String type){
	dir = 1;
	int i=0;
	#ifdef DEBUG
		debug("asked for " + type);
	#endif
	
	cover_transition_clone = type;
	
	// ------------ Random Animation
	if(type=="random" || type=="random:std" || type=="random:lfx"){
		
		//all transitions
		if(type=="random")
		{
			i = System.random(17);
		}
		else
		{
			//override above random if menu item for randomising on just normal transitions only, ie no layerfx in random choice		
			if(type=="random:std")
			{
				i = System.random(10);		
			}					
			else if(type=="random:lfx")
			{
				i = System.random(7) + 10;			
			}
		}
		
		if(i==0){
			type="fade";
		}
		else if(i==1){
			type="fadeslide";
		}
		else if(i==2){
			type="slide:h:l";
		}
		else if(i==3){
			type="slide:h:r";
		}
		else if(i==4){
			type="slide:v:d";
		}
		else if(i==5){
			type="slide:v:u";
		}
		else if(i==6){
			type="slide:y:l";
		}
		else if(i==7){
			type="slide:y:r";
		}
		else if(i==8){
			type="slide:y2:l";
		}
		else if(i==9){
			type="slide:y2:r";
		}
		else if(i==10){
			type="lyrfx1";
		}
		else if(i==11){
			type="lyrfx2";
		}
		else if(i==12){
			type="lyrfx3";
		}
		else if(i==13){
			type="lyrfx4";
		}
		else if(i==14){
			type="lyrfx5";
		}
		else if(i==15){
			type="lyrfx6";
		}
		else if(i==16){
			type="lyrfx7";
		}
		cover_transition_clone = type;
	}


	// Reversed animations
	if(type=="slide:h:r"){
		dir = -1;
		type ="slide:h:l";
	}
	else if(type=="slide:v:u"){
		dir = -1;
		type ="slide:v:d";
	}
	else if(type=="slide:y:r"){
		dir = -1;
		type ="slide:y:l";
	}
	else if(type=="slide:y2:r"){
		dir = -1;
		type ="slide:y2:l";
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

			TransitionDisabler.start(); //do not remove this line
			

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
		

			TransitionDisabler.start(); //do not remove this line

		
	}
	// ------------ Slide Animation
	else if(type=="slide:h:l"){
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
		
			TransitionDisabler.start(); //do not remove this line

	}
	else if(type=="slide:v:d"){
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
		
			TransitionDisabler.start(); //do not remove this line

	}
	// ------------ Slide:Y Animation
	else if(type=="slide:y:l"){
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
		
			TransitionDisabler.start(); //do not remove this line

	}
	// ------------ Slide:Y2 Animation
	else if(type=="slide:y2:l"){
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
		
			TransitionDisabler.start(); //do not remove this line


	} //now SLoBs additional FX
	else if(type=="lyrfx1" || type=="lyrfx2" || type=="lyrfx3" || type=="lyrfx4" || type=="lyrfx5" || type=="lyrfx6" || type=="lyrfx7")
	{				
		//do layerfx first
		cover_transition_clone = type;
		
		layerFX1();
		
	}
	
	#ifdef DEBUG
		debug("coming from anim function " + type);
	#endif
		
	artToggle=!artToggle;
	
}


layerFX1()
{

	#ifdef DEBUG
		//debug("forceTransition=" + integertostring(forceTransition));
		debug("LayerFXSubTransition=" + integertostring(LayerFXSubTransition));
		
	#endif
	//if(forceTransition==0)
	//{
	//	return;
	//}

	groupImage1.setXmlParam("x","0");
	groupImage1.setXmlParam("Y","0");
	groupImage2.setXmlParam("x","0");
	groupImage2.setXmlParam("Y","0");
	groupImage1.setTargetX(0); // *FIX - Without this the animation will goto a targetXY(think it's a bug in maki)
	groupImage2.setTargetX(0);
	groupImage1.setTargetY(0);
	groupImage2.setTargetY(0);
	
	groupImage1.gotoTarget();
	groupImage2.gotoTarget();
	
	if(artToggle)
	{
		sfx2 = getPlayItemMetaDataString("filename");//image2.getXMLParam("src");
			
		#ifdef DEBUG
			//debug("sfx2=" + sfx2);
			debug("sfx2=" + cover_transition_clone);
		#endif
		Fx2.setXMLParam("image", sfx2);

		groupImage1.setAlpha(255);
		groupImage2.setAlpha(0);
		groupImage1.setTargetA(0); // *FIX - Bug in maki? (see fade animation explanation)
		groupImage2.setTargetA(255);
		
		Fx2.show();
		Fx2.setTargetA(255);
		Fx2.setTargetSpeed(0);
		Fx2.gotoTarget();		
		Fx2.fx_setEnabled(1);
		
fxTmr.start();

		
	}
	else
	{					
		sfx1 = getPlayItemMetaDataString("filename"); //image1.getXMLParam("src");
		
		#ifdef DEBUG
			//debug("sfx1=" + sfx1);
			debug("sfx1=" + cover_transition_clone);
		#endif
		Fx1.setXMLParam("image", sfx1);

		groupImage2.setAlpha(255);
		groupImage2.setAlpha(0);
		groupImage1.setTargetA(0); // *FIX - Bug in maki? (see fade animation explanation)
		groupImage1.setTargetA(255);
		
		Fx1.show();
		Fx1.setTargetA(255);
		Fx1.setTargetSpeed(0);	
		Fx1.gotoTarget();
		Fx1.fx_setEnabled(1);
		
			fxTmr.start();

		
		
		//use this as an interim
		if(groupImage2.getAlpha()==255)
		{
			groupImage2.setTargetA(0);
			groupImage2.setTargetSpeed(0.5);
			groupImage2.gotoTarget();
		}
	
		//final catch of image2 still visible bug	
			if(groupImage2.getAlpha()>=0)
			{
				groupImage2.setTargetA(0);
				groupImage2.setTargetSpeed(0.3);
				groupImage2.gotoTarget();
			}
		
	}	
		groupImage1.setTargetSpeed(cover_transitionTime);
		groupImage1.gotoTarget();
		
		if(groupImage2.getAlpha()==255)
		{
			groupImage2.setTargetA(0);
			groupImage2.setTargetSpeed(cover_transitionTime);
			groupImage2.gotoTarget();
		}
}



	
Fx1.fx_onFrame() 
{
	dp = dp + 0.1;
	tp = tp + 0.3;
	dUFOVu =  ((((System.getLeftVuMeter() + System.getRightVuMeter()) / 2)) / 350);
	
	if(dblSmidge == 0.000001) {
		dblSmidge = 0;
	}
	else {
		dblSmidge = 0.000001;
	}
}
Fx2.fx_onFrame() 
{
	dp = dp + 0.1;
	tp = tp + 0.3;
	dUFOVu =  ((((System.getLeftVuMeter() + System.getRightVuMeter()) / 2)) / 350);
	
	if(dblSmidge == 0.000001) {
		dblSmidge = 0;
	} else {
		dblSmidge = 0.000001;
	}
}

Fx1.fx_onGetPixelX(double r, double d, double x, double y) 
{
	if(cover_transition_clone=="lyrfx1")
	{
		x = x * sqrt(tp-y) + sin(dp-x);			//}
		y = y * sqrt(dp-x) + sin(tp-y);			//> shimmering effect
		dR = d * cos(x) * sin(y) * (dblFactor); //}
	}
	
	if(cover_transition_clone=="lyrfx2")
	{
		dR = (d /2 - sin(FXPi*r+(tp-y)) + cos(dp*(r+x))*dblFactor/(r+dp)); //joining rotation effect
	}
	//vortexes
	if(cover_transition_clone=="lyrfx3")
	{
		if(LayerFXSubTransition==1)
		{
			dR = (d * 2.0 - sin(dp-x) + cos(tp-y) * dblFactor/dp); //cool ring/vortex type thing
		}
		else if(LayerFXSubTransition==2)
		{
			dx=1.5-sin(tp+x);
			dy=sin(dp+y);	
			dR=d*(dx+dy*dUFOVu/6); //spinning/twisting vortex
		}
		else if(LayerFXSubTransition==3)
		{
			dR = d*(1.01+cos(x+dp*0.325)*dblFactor); //colour circle
		}
		else if(LayerFXSubTransition==4)
		{
			dR = d*(1.01+cos(dp*x)*dblFactor); //colour circle
		}
		
	}

	if(cover_transition_clone=="lyrfx4")
	{
		if(d==0)d=x;
		dR=cos(dp+d*x*y) - sin(tp+x*y) / (dblFactor*dp+0.01);

	}
	
	if(cover_transition_clone=="lyrfx5")
	{
		//bendy pipe thing, cool
		dx=x*cos(dp)+y*sin(dp);
		dy=-x*sin(dp)+y*cos(dp);
		dz=x*cos(tp)+d*sin(tp);
		dR= dx + dy * dz * (dblFactor/1.4);
		
	}
	
	if(cover_transition_clone=="lyrfx6")
	{
		//some sub transitions for testing purposes more than anything but ya never know :)
	
		if(LayerFXSubTransition==1)
		{
			dR = sin(x-r*dp) + cos(x-d*FXPi+dp) * dblFactor;
		}
		else if(LayerFXSubTransition==2)
		{
			dR = x+sin(x-y*tp) * cos(dblFactor*dp); 
			
		}
		else if(LayerFXSubTransition==3)
		{
			dR = sin(x-r+dp) + cos(y-d*FXPi+dp) / dblFactor;
		}
		else if(LayerFXSubTransition==4)
		{
			x=sin(x-tp);
			y=sin(y-x+dp);
			dR = x*y *dblFactor;	
		}

		
	}
	//psychedelic ripple
	if(cover_transition_clone=="lyrfx7")
	{
		if(LayerFXSubTransition==1)
		{
			dR = sin(x-y+r+dp) * cos(x-y-d*FXPi*dp) * dblFactor;
		}
		else if(LayerFXSubTransition==2)
		{
			//dR = (sin(pow(y*dp,2) + cos(pow(x*r*FXPi*dp,2)))) * dblFactor;
			dR = sin(x-y+r-(tp-dp)) * cos(x-y-d*FXPi*(sin((tp-dp/2))+0.01)) * dblFactor;
			
			//dR = (cos(pow(y*dp,2) + pow(x-tp,2)) - sin(pow(y-dp,2))) * dblFactor;
		}
		else if(LayerFXSubTransition==3)
		{
			//dR = (cos(pow(y+dp,2) + pow(x-dp,2)) + sin(pow(tp,2))) * dblFactor;
			dR = (cos(pow(y+dp,2) + pow(x-dp,2))) * dblFactor;
		}
		else if(LayerFXSubTransition==4)
		{
			dR = sin(x-y+r+dp-tp) * cos(x-y-d*FXPi*dp-tp) * (dblFactor/3);
		}

	}

	return dR+dblSmidge;
}

Fx1.fx_onGetPixelY(double r, double d, double x, double y) 
{
	if(cover_transition_clone=="lyrfx1")
	{
		x = x * sqrt(tp-y) + sin(dp-x);	
		y = y * sqrt(dp-x) + sin(tp-y);		
		dR = d * cos(x) * sin(y) * (dblFactor); 
	}
	
	if(cover_transition_clone=="lyrfx2")
	{
		dR = (d /2 - sin(FXPi*r+(tp-y)) + cos(dp*(r+x))*dblFactor/(r+dp));	
	}
	//vortexes
	if(cover_transition_clone=="lyrfx3")
	{
		if(LayerFXSubTransition==1)
		{
			dR = (d * 2.0 - sin(dp-x) + cos(tp-y) * dblFactor/dp); //cool ring/vortex type thing
		}
		else if(LayerFXSubTransition==2)
		{
			dx=1.5-sin(tp+x);
			dy=sin(dp+y);	
			dR=d*(dx+dy*dUFOVu/6); //spinning/twisting vortex
		}
		else if(LayerFXSubTransition==3)
		{
			dR = d*(1.01+cos(y+dp*0.325)*dblFactor); //colour circle
		}
		else if(LayerFXSubTransition==4)
		{
			dR = d*(1.01+cos(dp*y)*dblFactor); //colour circle
		}

	}

	if(cover_transition_clone=="lyrfx4")
	{
		if(d==0)d=x;
		dR=cos(dp+d*x*y) - sin(tp+x*y) / (dblFactor*dp+0.01);


	}
	
	if(cover_transition_clone=="lyrfx5")
	{
		//bendy pipe thing, cool
		dx=x*cos(dp)+y*sin(dp);
		dy=-x*sin(dp)+y*cos(dp);
		dz=x*cos(tp)+d*sin(tp);
		dR= dx + dy * dz * (dblFactor/1.4);

	}
	
	if(cover_transition_clone=="lyrfx6")
	{
		//some sub transitions for testing purposes more than anything but ya never know :)
	
		if(LayerFXSubTransition==1)
		{
			dR = sin(y-r*dp) + cos(y-d*FXPi+dp) * dblFactor;			
		}
		else if(LayerFXSubTransition==2)
		{
			dR = x+sin(x-y*tp) * cos(dblFactor*dp);   
			
		}
		else if(LayerFXSubTransition==3)
		{
			dR = sin(x-r+dp) + cos(y-d*FXPi+dp) / dblFactor;
		}
		else if(LayerFXSubTransition==4)
		{
			x=sin(x-tp);
			y=sin(y-x+dp);
			dR = x*y *dblFactor;	
		}
		
	}
	//psychedelic ripple
	if(cover_transition_clone=="lyrfx7")
	{
		if(LayerFXSubTransition==1)
		{
			dR = sin(x-y+r+dp) * cos(x-y-d*FXPi*dp) * dblFactor;
		}
		else if(LayerFXSubTransition==2)
		{
			//dR = (sin(pow(y*dp,2) + cos(pow(x*r*FXPi*dp,2)))) * dblFactor;
			dR = sin(x-y+r-(tp-dp)) * cos(x-y-d*FXPi*(sin((tp-dp/2))+0.01)) * dblFactor;
			
		}
		else if(LayerFXSubTransition==3)
		{
			//dR = (cos(pow(y+dp,2) + pow(x-dp,2)) + sin(pow(tp,2))) * dblFactor;
			dR = (cos(pow(y+dp,2) + pow(x-dp,2))) * dblFactor;
		}
		else if(LayerFXSubTransition==4)
		{
			dR = sin(x-y+r+dp-tp) * cos(x-y-d*FXPi*dp-tp) * (dblFactor/4);
		}

	}


	return dR+dblSmidge;
}


Fx2.fx_onGetPixelX(double r, double d, double x, double y) 
{
	if(cover_transition_clone=="lyrfx1")
	{
		x = x * sqrt(tp-y) + sin(dp-x);		
		y = y * sqrt(dp-x) + sin(tp-y);		
		dR = d * cos(x) * sin(y) * (dblFactor);
	}

	if(cover_transition_clone=="lyrfx2")
	{
		dR = (d /2 - sin(FXPi*r+(tp-y)) + cos(dp*(r+x))*dblFactor/(r+dp));
	}
	//vortexes
	if(cover_transition_clone=="lyrfx3")
	{
		if(LayerFXSubTransition==1)
		{
			dR = (d * 2.0 - sin(dp-x) + cos(tp-y) * dblFactor/dp); //cool ring/vortex type thing
		}
		else if(LayerFXSubTransition==2)
		{
			dx=1.5-sin(tp+x);
			dy=sin(dp+y);	
			dR=d*(dx+dy*dUFOVu/6); //spinning/twisting vortex
		}
		else if(LayerFXSubTransition==3)
		{
			dR = d*(1.01+cos(x+dp*0.325)*dblFactor); //colour circle
		}
		else if(LayerFXSubTransition==4)
		{
			dR = d*(1.01+cos(dp*x)*dblFactor); //colour circle
		}

		
	}

	if(cover_transition_clone=="lyrfx4")
	{
		if(d==0)d=x;
		dR=cos(dp+d*x*y) - sin(tp+x*y) / (dblFactor*dp+0.01);

	}

	if(cover_transition_clone=="lyrfx5")
	{
		//bendy pipe thing, cool
		dx=x*cos(dp)+y*sin(dp);
		dy=-x*sin(dp)+y*cos(dp);
		dz=x*cos(tp)+d*sin(tp);
		dR= dx + dy * dz * (dblFactor/1.4);

	}

	if(cover_transition_clone=="lyrfx6")
	{
		//some sub transitions for testing purposes more than anything but ya never know :)
	
		if(LayerFXSubTransition==1)
		{
			dR = sin(x-r*dp) + cos(x-d*FXPi+dp) * dblFactor;			
		}
		else if(LayerFXSubTransition==2)
		{
			dR = x+sin(x-y*tp) * cos(dblFactor*dp);    
		}
		else if(LayerFXSubTransition==3)
		{
			dR = sin(x-r+dp) + cos(y-d*FXPi+dp) / dblFactor;
		}
		else if(LayerFXSubTransition==4)
		{
			x=sin(x-tp);
			y=sin(y-x+dp);
			dR = x*y *dblFactor;	
		}
		
	}
	//psychedelic ripple
	if(cover_transition_clone=="lyrfx7")
	{
		if(LayerFXSubTransition==1)
		{
			dR = sin(x-y+r+dp) * cos(x-y-d*FXPi*dp) * dblFactor;
		}
		else if(LayerFXSubTransition==2)
		{
			//dR = (sin(pow(y*dp,2) + cos(pow(x*r*FXPi*dp,2)))) * dblFactor;
			dR = sin(x-y+r-(tp-dp)) * cos(x-y-d*FXPi*(sin((tp-dp/2))+0.01)) * dblFactor;
			
		}
		else if(LayerFXSubTransition==3)
		{
			//dR = (cos(pow(y+dp,2) + pow(x-dp,2)) + sin(pow(tp,2))) * dblFactor;
			dR = (cos(pow(y+dp,2) + pow(x-dp,2))) * dblFactor;
		}
		else if(LayerFXSubTransition==4)
		{
			dR = sin(x-y+r+dp-tp) * cos(x-y-d*FXPi*dp-tp) * (dblFactor/4);

		}


	}
	
	return dR+dblSmidge;
}

Fx2.fx_onGetPixelY(double r, double d, double x, double y) 
{
	if(cover_transition_clone=="lyrfx1")
	{
		x = x * sqrt(tp-y) + sin(dp-x);		
		y = y * sqrt(dp-x) + sin(tp-y);		
		dR = d * cos(x) * sin(y) * (dblFactor); 	
	}

	if(cover_transition_clone=="lyrfx2")
	{
		dR = (d /2 - sin(FXPi*r+(tp-y)) + cos(dp*(r+x))*dblFactor/(r+dp));
	}
	//vortexes
	if(cover_transition_clone=="lyrfx3")
	{
		if(LayerFXSubTransition==1)
		{
			dR = (d * 2.0 - sin(dp-x) + cos(tp-y) * dblFactor/dp); //cool ring/vortex type thing
		}
		else if(LayerFXSubTransition==2)
		{
			dx=1.5-sin(tp+x);
			dy=sin(dp+y);	
			dR=d*(dx+dy*dUFOVu/6); //spinning/twisting vortex
		}
		else if(LayerFXSubTransition==3)
		{
			dR = d*(1.01+cos(y+dp*0.325)*dblFactor); //colour circle
		}
		else if(LayerFXSubTransition==4)
		{
			dR = d*(1.01+cos(dp*y)*dblFactor); //colour circle
		}

	}

	if(cover_transition_clone=="lyrfx4")
	{
		if(d==0)d=dp;
		dx=sin(dp)*sin(dp);
		dy=cos(dp)*cos(dp);
		z=cos(d);
		x=(tp+dx)*z;
		y=(tp+dy)*z;
		dR= cos(x) - sin(y) * (dblFactor/1.3);
	}
	
	if(cover_transition_clone=="lyrfx5")
	{
		//bendy pipe thing, cool
		dx=x*cos(dp)+y*sin(dp);
		dy=-x*sin(dp)+y*cos(dp);
		dz=x*cos(tp)+d*sin(tp);
		dR= dx + dy * dz * (dblFactor/1.4);
	}
	
	if(cover_transition_clone=="lyrfx6")
	{
		//some sub transitions for testing purposes more than anything but ya never know :)
	
		if(LayerFXSubTransition==1)
		{
			dR = sin(y-r*dp) + cos(y-d*FXPi+dp) * dblFactor;			
		}
		else if(LayerFXSubTransition==2)
		{
			dR = x+sin(x-y*tp) * cos(dblFactor*dp); //wavey
		}
		else if(LayerFXSubTransition==3)
		{
			dR = sin(x-r+dp) + cos(y-d*FXPi+dp) / dblFactor;
		}
		else if(LayerFXSubTransition==4)
		{
			x=sin(x-tp);
			y=sin(y-x+dp);
			dR = x*y *dblFactor;	
		}
		
	}
	//psychedelic ripple
	if(cover_transition_clone=="lyrfx7")
	{
		if(LayerFXSubTransition==1)
		{
			dR = sin(x-y+r+dp) * cos(x-y-d*FXPi*dp) * dblFactor;
		}
		else if(LayerFXSubTransition==2)
		{
			//dR = (sin(pow(y*dp,2) + cos(pow(x*r*FXPi*dp,2)))) * dblFactor;
			dR = sin(x-y+r-(tp-dp)) * cos(x-y-d*FXPi*(sin((tp-dp/2))+0.01)) * dblFactor;
						
		}
		else if(LayerFXSubTransition==3)
		{
			//dR = (cos(pow(y+dp,2) + pow(x-dp,2)) + sin(pow(tp,2))) * dblFactor;
			dR = (cos(pow(y+dp,2) + pow(x-dp,2))) * dblFactor;

		}
		else if(LayerFXSubTransition==4)
		{
			dR = sin(x-y+r+dp-tp) * cos(x-y-d*FXPi*dp-tp) * (dblFactor/4);

		}
		
	}
	
	
	return dR+dblSmidge;
}



fxTmr.onTimer()
{
	
	fxTmr.stop();

	
	#ifdef DEBUG
		debug("tmr stop transition dp=" + floattostring(dp,2) + " tp=" + floattostring(tp,2));
		debug("cover_transitionFadeOutTime=" + integertostring(cover_transitionMenuFadeOutValue));
		
	#endif
	
	//reset otherwise ever increasing, also allows some scope to get differing effects from the layer fx transitions
	if(dp>200)dp=0.1;
	if(tp>600)tp=0.1;
	
	//reset dp&tp to original values if variation disabled, otherwise leave dp&tp to increment to threshold values set above
	if(LayerFXSubTransitionVariationEnable==0)
	{
		dp = 0.1;
		tp = 0.1;
	}
	
	
	#ifdef DEBUG
		debug("Fading Transition");
	#endif

		TransitionDisabler.start(); //do not remove this line
	

	//fade transitions out, looks better
	Fx2.setTargetA(0);
	Fx2.setTargetSpeed(cover_transitionFadeOutTime);			
	Fx1.setTargetA(0);
	Fx1.setTargetSpeed(cover_transitionFadeOutTime);
	
	Fx2.gotoTarget();
	Fx1.gotoTarget();

}

TransitionDisabler.onTimer()
{
	TransitionDisabler.stop();
	disableFX();
	
	//some sub transitions for testing purposes more than anything but ya never know :)
	if((LayerFXSubTransitionEnable==1) && (cover_transition_clone=="lyrfx3" || cover_transition_clone=="lyrfx6" || cover_transition_clone=="lyrfx7"))
	{
		//randomise sublayerfx if set to random, best way really
	/*	if(Transition_RandomiselayerFX==1)
		{
			LayerFXSubTransition = System.random(4) + 1; //0 based
		}
		else
		{
			LayerFXSubTransition = LayerFXSubTransition + 1;
		}*/
		#ifdef DEBUG
			debug("* random sublyrfx value=" +  integertostring(LayerFXSubTransition));
		#endif
	}
	//dont want to reset now, just need to increment as non subtrans dont have subs
	//else
	//{
	//	LayerFXSubTransition = 1;
	//}
	//up to 4 sub transitions atm, thers so many effects possible thru tweaking, we can cut back once transitions are decided
	if(LayerFXSubTransition>4)
	{
		LayerFXSubTransition = 1;
	}
	//testing
	#ifdef DEBUG
	//	LayerFXSubTransition = 3;
		debug("demoMode in trantmr=" +  integertostring(demoMode));
	#endif
	
	//demo mode
	if(demoMode==1)
	{
	
			demotmr.start();
	
	}
	else
	{
		demotmr.stop();
	}
}

demotmr.onTimer()
{
	demotmr.stop();
	animateCover(cover_transition);
}
disableFX()
{
	#ifdef DEBUG
		debug("Disabling Transition");
	#endif
	//now disable
	Fx1.hide();
	Fx2.hide();
	Fx1.fx_setEnabled(0);
	Fx2.fx_setEnabled(0);

}
		

//testing transitions
/*
mousetrap.onLeftButtonDown(int x, int y)
{
	#ifdef DEBUG
		debug("test transition");
		//cover_transition="random";
		//cover_transition_clone="random";

	#endif
	
	animateCover(cover_transition);
}
*/

		

XUIGroup.onResize(int x, int y, int w, int h){
	groupW = w;
	groupH = h;

	setSize();

	artToggle=!artToggle;
	centerImage();
	artToggle=!artToggle;
	centerImage();
	artToggle=!artToggle;
	groupImage1.cancelTarget();
	groupImage2.cancelTarget();
	animateCover("none");
}

centerImage(){
	Boolean isFile = false; //Don't maximize noCover images
	map m = new Map;
	
	if(!artToggle){
		#ifdef DEBUG
			debug("centerImage() on image1");
		#endif
		centerThis=groupImageHold1;
		m.loadMap(image1.getXMLParam("src"));
		if(strsearch(image1.getXmlParam("src"),":")!=-1){
			isFile=true;
		}
	}
	else{
		#ifdef DEBUG
			debug("centerImage() on image2");
		#endif
		centerThis=groupImageHold2;
		m.loadMap(image2.getXMLParam("src"));
		if(strsearch(image2.getXmlParam("src"),":")!=-1){
			isFile=true;
		}
	} 
	

	ArtW = m.getWidth();
	ArtH = m.getHeight();
	delete m;

	if((cover_stretch==1 && isFile) || (cover_stretchnc==1 && !isFile)){			// Maximize it?
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
		centerThis.setXMLParam ("w", integertostring(ArtW));
		centerThis.setXMLParam ("h", integertostring(ArtH));

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
			if(strsearch(image1.getXmlParam("src"),":")==-1){
				System.navigateUrl(getPath(getPlayItemMetaDataString("filename")));
			}
			else{
				System.navigateUrl(image1.getXmlParam("src"));
			}
		}
		else{
			if(strsearch(image2.getXmlParam("src"),":")==-1){
				System.navigateUrl(getPath(getPlayItemMetaDataString("filename")));
			}
			else{
				System.navigateUrl(image2.getXmlParam("src"));
			}
		}
	}
}

mousetrap.onRightButtonUp(int x, int y){
	if(cover_menu==1){
		artPopup = new PopupMenu;
		CoverOptionsAdv = new PopupMenu;
		CoverOptionsStd = new PopupMenu;
		
		cover_transitionTimeSubMenu = new PopupMenu;
		//cover_transitionRandomSubMenu = new PopupMenu;
		cover_transitiondistortionSubMenu = new PopupMenu;
		cover_transitionNormalSubMenu = new PopupMenu;
		cover_transitionLayerFXSubMenu = new PopupMenu;
		cover_transitionCycleSubMenu = new PopupMenu;
		cover_transitionFadeOutTimeSubMenu = new PopupMenu;
		cover_demomodeSubmenu = new PopupMenu;
		
		cover_transitionNormalSubMenu.addCommand("None", 100, ctn1,0); 
				
		cover_transitionLayerFXSubMenu.addCommand("Layer FX 1", 200, ctlfx1,0); 
			 
		cover_transitiondistortionSubMenu.addCommand("1x", 40, ctdv1,0);
		cover_transitiondistortionSubMenu.addCommand("5x", 41, ctdv2,0);
		cover_transitiondistortionSubMenu.addCommand("10x", 42, ctdv3,0);
		cover_transitiondistortionSubMenu.addCommand("15x", 43, ctdv4,0);
		cover_transitiondistortionSubMenu.addCommand("20x", 44, ctdv5,0);
	 
		cover_transitionTimeSubMenu.addCommand("0.5 Seconds", 20, ctt1, 0);
		cover_transitionTimeSubMenu.addCommand("1.0 Seconds", 21, ctt2, 0);
		cover_transitionTimeSubMenu.addCommand("1.5 Seconds", 22, ctt3, 0);
		cover_transitionTimeSubMenu.addCommand("2.0 Seconds", 23, ctt4, 0);
		cover_transitionTimeSubMenu.addCommand("2.5 Seconds", 24, ctt5, 0);
		cover_transitionTimeSubMenu.addCommand("3.0 Seconds", 25, ctt6, 0);
		cover_transitionTimeSubMenu.addCommand("3.5 Seconds", 26, ctt7, 0);
		cover_transitionTimeSubMenu.addCommand("4.0 Seconds", 27, ctt8, 0);
		cover_transitionTimeSubMenu.addCommand("5.0 Seconds", 28, ctt9, 0);
		cover_transitionTimeSubMenu.addCommand("6.0 Seconds", 29, ctt10, 0);
		
		cover_transitionFadeOutTimeSubMenu.addCommand("0.5 Seconds", 60, ctt11, 0);
		cover_transitionFadeOutTimeSubMenu.addCommand("0.8 Seconds", 61, ctt12, 0);
		cover_transitionFadeOutTimeSubMenu.addCommand("1.0 Seconds", 62, ctt13, 0);
		cover_transitionFadeOutTimeSubMenu.addCommand("1.3 Seconds", 63, ctt14, 0);
		cover_transitionFadeOutTimeSubMenu.addCommand("1.5 Seconds", 64, ctt15, 0);
		cover_transitionFadeOutTimeSubMenu.addCommand("2.0 Seconds", 65, ctt16, 0);
		cover_transitionFadeOutTimeSubMenu.addCommand("2.5 Seconds", 66, ctt17, 0);
		
		//#ifdef DEBUG	
		//debug doesnt work with dynamic menus
		//as this is a submenu we can now disable if 0
			if(bAllowDemoMode==0)
			{
				cover_demomodeSubmenu.addCommand("Demo Mode", 69, demoMode, -1);
			}
			else
			{
				cover_demomodeSubmenu.addCommand("Demo Mode", 69, demoMode, 0);
			}
		//#endif
		
		#ifdef DEBUG
			debug("bAllowDemoMode=" + integertostring(bAllowDemoMode));
		#endif
		
					
		
		artPopup.addCommand("Cover Options", -1, 0, 1);
		artPopup.addSeparator();
		artPopup.addCommand(getToken(cover_language,";",0), 1, 0, 0);
		if(artToggle)
		{
			if(strsearch(image1.getXmlParam("src"),":")==-1)
			{
				artPopup.addCommand(getToken(cover_language,";",1), 2, 0, 1);
			}
			else{
				artPopup.addCommand(getToken(cover_language,";",1), 2, 0, 0);
				artPopup.addSeparator();
				artPopup.addCommand(getToken(cover_language,";",4), 6, 0, 1);
				artPopup.addCommand(integerToString(ArtW)+"x"+integerToString(ArtH), 5, 0, 1);
			}
		}
		else{
			if(strsearch(image2.getXmlParam("src"),":")==-1)
			{
				artPopup.addCommand(getToken(cover_language,";",1), 1, 0, 1);
			}
			else{
				artPopup.addCommand(getToken(cover_language,";",1), 2, 0, 0);
				artPopup.addSeparator();
				artPopup.addCommand(getToken(cover_language,";",4), 6, 0, 1);
				artPopup.addCommand(integerToString(ArtW)+"x"+integerToString(ArtH), 5, 0, 1);
			}
		}
		
				artPopup.addSeparator();
				
				artPopup.addSubMenu(CoverOptionsStd, "LayerFx Options");

				CoverOptionsStd.addSubMenu(cover_transitionTimeSubMenu, "Transition Time");
				CoverOptionsStd.addSubMenu(cover_transitionFadeOutTimeSubMenu, "Transition FadeOut Time");				

				CoverOptionsStd.addSeparator();
		
				CoverOptionsStd.addCommand("Allow Sub-Transistions", 199, LayerFXSubTransitionEnable, 0);
				CoverOptionsStd.addCommand("Allow Subtle Variations", 198, LayerFXSubTransitionVariationEnable, 0);
				CoverOptionsStd.addSubMenu(cover_transitiondistortionSubMenu, "Transition Distortion Factor");
				
				//CoverOptionsAdv.addSeparator();
				//CoverOptionsAdv.addSubMenu(cover_demomodeSubmenu, "Demo Mode");


		ProcessMenuResult(artPopup.popAtMouse());
		complete;
	}
}


ProcessMenuResult(int a)
{
	#ifdef DEBUG
		debug(integertostring(a));
	#endif
	if(a<0)return;
	
	if(a==1){
		System.navigateUrl(getPath(getPlayItemMetaDataString("filename")));
	}
	else if(a==2){
		if(artToggle){
			System.navigateUrl(image1.getXmlParam("src"));
		}
		else{
			System.navigateUrl(image2.getXmlParam("src"));
		}
	}
	
	if(a>=20 && a<=29)
	{
	
		ctt1 = 0;
		ctt2 = 0; 
		ctt3 = 0;
		ctt4 = 0;
		ctt5 = 0;
		ctt6 = 0;
		ctt7 = 0;
		ctt8 = 0;
		ctt9 = 0;
		ctt10 = 0;

		float ttValue;
		if(a==20)
		{
			ctt1 = 1;
			ttValue = 0.5;
		}
		else if(a==21)
		{
			ctt2 = 1; 
			ttValue = 1.0;
		}
		else if(a==22)
		{
			ctt3 = 1;
			ttValue = 1.5;
		}
		else if(a==23)
		{
			ctt4 = 1;
			ttValue = 2.0;
		}
		else if(a==24)
		{
			ctt5 = 1;
			ttValue = 2.5;
		}
		else if(a==25)
		{
			ctt6 = 1;
			ttValue = 3.0;
		}
		else if(a==26)
		{
			ctt7 = 1;
			ttValue = 3.5;
		}
		else if(a==27)
		{
			ctt8 = 1;
			ttValue = 4.0;
		}
		else if(a==28)
		{
			ctt9 = 1;
			ttValue = 5.0;
		}
		else if(a==29)
		{
			ctt10 = 1;
			ttValue = 6.0;
		}
		
		cover_transitionTime = ttValue;
		transitionTimeMenuValue = cover_transitionTime;
		//want to get a little longer visual with the layerfx as theyr static compared to moving transistions, edit, nope keep them the same
		fxLength = cover_transitionTime*1000;
		fxTmr.setDelay(fxLength);
	}
	
	if(a>=40 && a<=44)
	{
		ctdv1 = 0;
		ctdv2 = 0; 
		ctdv3 = 0;
		ctdv4 = 0;
		ctdv5 = 0;

		if(a==40)
		{
			ctdv1 = 1;
			cover_transitionDistortionFactor = 1;
		}
		else if(a==41)
		{
			ctdv2 = 1; 
			cover_transitionDistortionFactor = 5;
		}
		else if(a==42)
		{
			ctdv3 = 1;
			cover_transitionDistortionFactor = 10;
		}
		else if(a==43)
		{
			ctdv4 = 1;
			cover_transitionDistortionFactor = 15;
		}
		else if(a==44)
		{
			ctdv5 = 1;
			cover_transitionDistortionFactor = 20;
		}
		
		//reset to original value before distorting
		dblFactor = OriginaldblFactor;
		dblFactor =	dblFactor * cover_transitionDistortionFactor;
	}
		
	//enable layerfx subtransitions, if disabled will only play thru subtransition 1 and not increment
	if(a==199)
	{
		if(LayerFXSubTransitionEnable==0) 
		{
			LayerFXSubTransitionEnable=1;			
		}
		else 
		{
			LayerFXSubTransitionEnable=0;
		}
	}
	
	//if enabled allows dp & tp to increment to allow sublte changes in transitions as the values of dp, tp are used in the transition calculations
	if(a==198)
	{
		if(LayerFXSubTransitionVariationEnable==0) 
		{
			LayerFXSubTransitionVariationEnable=1;			
		}
		else 
		{
			LayerFXSubTransitionVariationEnable=0;
		}
	}
	
	
	if(a>=60 && a<=66)
	{	
		ctt11 = 0;
		ctt12 = 0;
		ctt13 = 0;
		ctt14 = 0;
		ctt15 = 0;
		ctt16 = 0;
		ctt17 = 0;

		if(a==60)
		{
			ctt11 = 1;
			cover_transitionFadeOutTime = 0.5;
			cover_transitionMenuFadeOutValue = 1;
		}
		else if(a==61)
		{
			ctt12 = 1;
			cover_transitionFadeOutTime = 0.8;
			cover_transitionMenuFadeOutValue = 2;
		}
		else if(a==62)
		{
			ctt13 = 1;
			cover_transitionFadeOutTime = 1.0;
			cover_transitionMenuFadeOutValue = 3;
		}
		else if(a==63)
		{
			ctt14 = 1;
			cover_transitionFadeOutTime = 1.3;
			cover_transitionMenuFadeOutValue = 4;
		}
		else if(a==64)
		{
			ctt15 = 1;
			cover_transitionFadeOutTime = 1.5;
			cover_transitionMenuFadeOutValue = 5;
		}
		else if(a==65)
		{
			ctt16 = 1;
			cover_transitionFadeOutTime = 2.0;
			cover_transitionMenuFadeOutValue = 6;
		}
		else if(a==66)
		{
			ctt17 = 1;
			cover_transitionFadeOutTime = 2.5;
			cover_transitionMenuFadeOutValue = 7;
		}
		
		
	}
	
	if(a==69)
	{	
		if(demoMode==0) 
		{
			demoMode=1;
			
				demotmr.start();
			
		}
		else 
		{
			demoMode=0;
			demotmr.stop();
		}
	
	}
			
	delete cover_transitionTimeSubMenu;
	delete cover_transitiondistortionSubMenu;
	delete cover_transitionNormalSubMenu;
	delete cover_transitionLayerFXSubMenu;
	delete cover_transitionCycleSubMenu;
	delete cover_transitionFadeOutTimeSubMenu;
	delete cover_demomodeSubmenu;
	delete artPopup;

}


waitForReturn.onTimer(){
/*	if(System.getPlayItemLength() == -1){
		waitForReturn.stop();
		waitForReturn.start();
	}
	else{
		setArt();
		waitForReturn.stop();
	}*/
	String sit = System.getPlayItemMetaDataString("TITLE");
	if (sit != "")
	{
		waitForReturn.stop();
		//setArt(); //dont need this now as we're using albumart object
		setAlbumArt();
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

