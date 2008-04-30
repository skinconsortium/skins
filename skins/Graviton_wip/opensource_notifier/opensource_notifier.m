//-----------------------------------------------------------------------------
// opensource_notifier.m
//
// Add a Winamp Modern-esque notifier to your skin, with prefrences and all that
//
// by iPlayTheSpoons (Jared Kole)
//
// please leave this part when you distribute your skin
//SLoB modified for a bit extra
//-----------------------------------------------------------------------------

#include <lib/std.mi>
#include "../scripts/attribs.m"

Function Go(Float Fadein,Float Fadeout);
function SetSize();
Function SetInfo();
Function Prep();

Global Container Noti, Prefs;
Global Layout Notifier,NotifierSize;
Global Group Texts;
Global Text Artist, Song, Album, PlEntry, Nexttrack, tracklength;
Global Text FadeinText,StayText,FadeoutText, txtNotiShadowSlider;
Global Slider FadeinSlider, StaySlider, FadeoutSlider, ShadowSlider;
Global CheckBox FadeEffect, SlideEffect, Fullscreen, CDCover, covertypelocal, covertypenet;

Global Browser PhysicalCover;
Global Timer Stay, Buffer;
Global Int Tracker, TitleW, Wide, iShadowOpacity, iShadow;
Global Float Fadein, Fadeout, StayTime;
Global String Effect, Position;
Global GUIObject lyrnotifiershadow;
global layer notiglass, notishadow, notilcd, PhysicallocalCover;
Global int iCoverType;

System.onScriptLoaded() { 

	initAttribs();

	Noti = system.getContainer("opensource_notifier");
	Prefs = system.getContainer("opensource_notifier_prefs");
	
	Notifier = Noti.getLayout("normal");
	NotifierSize = Noti.getLayout("normal");
	PhysicalCover = Notifier.findObject("browser.cdcover");
	PhysicallocalCover = notifier.findObject("local.cdcover");

	Texts = Notifier.findObject("notifier.text");
	
	
	Artist = Notifier.findObject("artist");
	Song = Notifier.findObject("title");
	Album = Notifier.findObject("album");
	PlEntry = Notifier.findObject("plentry");
	Nexttrack = Notifier.findObject("nexttrack");
	tracklength = Notifier.findObject("tracklength");
	
	notiglass = Notifier.findObject("bg.glass");
	//notishadow = Notifier.findObject("bg.shadow");
	notilcd = Notifier.findObject("bg.backlight");
	
	Layout PrefsLayout = Prefs.getLayout("normal");
	
	FadeinText = PrefsLayout.findObject("fadein.text");
	StayText = PrefsLayout.findObject("stay.text");
	FadeoutText = PrefsLayout.findObject("fadeout.text");
	FadeinSlider = PrefsLayout.findObject("fadein.slider");
	StaySlider = PrefsLayout.findObject("stay.slider");
	FadeoutSlider = PrefsLayout.findObject("fadeout.slider");
	Fullscreen = PrefsLayout.findObject("fullscreen");
	FadeEffect = PrefsLayout.findObject("radio.fade");
	SlideEffect = PrefsLayout.findObject("radio.slide");
	CDCover = PrefsLayout.findObject("cover");
	
	covertypelocal = PrefsLayout.findObject("covertype.local");
	covertypenet = PrefsLayout.findObject("covertype.net");

	ShadowSlider = PrefsLayout.findObject("notishadow.slider");
	lyrnotifiershadow = Notifier.findObject("shadow");
	txtNotiShadowSlider = PrefsLayout.findObject("shadow.opacity.label");
	
	lyrnotifiershadow.show();	
	lyrnotifiershadow.setAlpha(255);
		
	Fadein = system.getPrivateInt("OpenNote","FadeIn",6);
	Fadeout = system.getPrivateInt("OpenNote","FadeOut",2);
	StayTime = system.getPrivateInt("OpenNote","Stay",16);
	Effect = system.getPrivateString("OpenNote","Effect","Fade");
	iShadow = system.getPrivateInt("OpenNote","Shadow",255);
	
	if(Effect == "Fade")
		FadeEffect.setChecked(1);
	Else
		SlideEffect.setChecked(1);
	
	Stay = new Timer;
	Buffer = new Timer;
	Buffer.setDelay(100);
	
	FadeinSlider.SetPosition(Fadein);
	FadeoutSlider.SetPosition(Fadeout);
	StaySlider.SetPosition(StayTime);
	ShadowSlider.SetPosition(iShadow);

	Fullscreen.setChecked(system.getPrivateInt("OpenNote","Fullscreen",0));
	
	CDCover.setChecked(system.getPrivateInt("OpenNote","Cover",0));


	iCoverType = system.getPrivateInt("OpenNote","CoverType",0);

	if(iCoverType==0)
	{
		covertypenet.setChecked(1);
	}
	else
	{
		covertypelocal.setChecked(1);
	}

	Notifier.hide();

	//hide notifier on skin refresh
	
	Buffer.stop();
	prep();

	SetSize();
	
}

system.onScriptUnloading()
{
	system.setPrivateInt("OpenNote","FadeIn",(Fadein*4));
	system.setPrivateInt("OpenNote","FadeOut",(Fadeout*4));
	system.setPrivateInt("OpenNote","Stay",((StayTime*4)/1000));
	system.setPrivateString("OpenNote","Effect",Effect);
	system.setPrivateInt("OpenNote","Cover", CDCover.isChecked());
	system.setPrivateInt("OpenNote","Shadow", iShadow);	
	system.setPrivateInt("OpenNote","CoverType", iCoverType);

}


covertypelocal.onToggle(int newstate)
{
	if(covertypelocal.isChecked() == 1)
	{
		myattr_cdcovertype.setData("local");		
		iCoverType=1;
	}
}

covertypenet.onToggle(int newstate)
{
	if(covertypenet.isChecked() == 1)
	{
		myattr_cdcovertype.setData("net");
		iCoverType=0;
	}
}

/*
myattr_glassalpha.onDataChanged() {
	int iNotiGotData = stringtoInteger(getData());
	
	notiglass.setAlpha(iNotiGotData);

}

myattr_shadowalpha.onDataChanged() {
	int iNotishadGotData = stringtoInteger(getData());
	
	notishadow.setAlpha(iNotishadGotData);

}

myattr_lcdalpha.onDataChanged() {
	int iNotilcdGotData = stringtoInteger(getData());
	
	notilcd.setAlpha(iNotilcdGotData);

}
*/


Fullscreen.onToggle(int newstate)
{
	system.setPrivateInt("OpenNote","Fullscreen",newstate);
}

FadeEffect.onToggle(int newstate)
{
	if(FadeEffect.isChecked() == 1)
	{
		Effect = "Fade";
		FadeinSlider.SetPosition(Fadein*4);
		FadeoutSlider.SetPosition(Fadeout*4);
		StaySlider.setPosition((StayTime*4)/1000);
	}
}

SlideEffect.onToggle(int newstate)
{
	if(SlideEffect.isChecked() == 1)
	{
		Effect = "Slide";
		FadeinSlider.SetPosition(Fadein*4);
		FadeoutSlider.SetPosition(Fadeout*4);
		StaySlider.setPosition((StayTime*4)/1000);
		if(Tracker == 2) 	Notifier.setXMLParam("y",integertostring(system.getViewportHeight()+5));
	}
}

ShadowSlider.onSetPosition(int iNewShadow)
{
	
	iShadow= iNewShadow;
	lyrnotifiershadow.setAlpha(iShadow);
	txtNotiShadowSlider.setText(integertostring(iShadow*100/255));
	//FadeinText.setText(system.integertostring(iShadow));
}


FadeinSlider.onSetPosition(int newFadein)
{
	FadeinText.setText(Effect+"-in Time (" + system.floattostring(NewFadein/4,1) + "s):");
	Fadein=NewFadein/4;
}

FadeoutSlider.onSetPosition(int newFadeout)
{
	FadeoutText.setText(Effect+"-out Time (" + system.floattostring(NewFadeout/4,1) + "s):");
	Fadeout=NewFadeout/4;
}

StaySlider.onSetPosition(int newStay)
{
	StayText.setText("Hold Time (" + system.floattostring(NewStay/4,1) + "s):");
	StayTime = (newStay/4)*1000; //1000
	Stay.setdelay(StayTime);
}

system.onTitleChange(String NewTitle){
	Buffer.start();
}

system.onPlay(){
	Nexttrack.setText("Now Playing");
	Buffer.start();
}

system.onResume(){
	Nexttrack.setText("Playing Resumed");
	Buffer.start();
}

System.onPause(){
	Nexttrack.setText("Playing Paused");
	Buffer.start();
}

System.onStop(){
	Nexttrack.setText("Playing Stopped");
	Buffer.start();
}




System.onShowNotification()
{
	Buffer.start();
	complete; 
  	return 1;
}

Buffer.onTimer()
{
	Buffer.stop();
	prep();
}

Notifier.onLeftButtonDown(int x, int y)
{
	Prefs.show();
}

Notifier.onRightButtonDown(int x, int y)
{
	Notifier.hide();
}

Prep()
{
	string freq=system.getPrivateString("OpenNote","Freq","Always Show Notifications");
	if((Fullscreen.isChecked() == 1 && System.isVideoFullscreen() == 0) || Fullscreen.isChecked() == 0){
	if (freq=="Always Show Notifications")
	{
		SetInfo();
		SetSize();
		Go(Fadein, FadeOut);
	}
	if (freq=="Show Notifications When Minimized" && System.isMinimized()==1)
	{
		SetInfo();
		SetSize();
		Go(Fadein, FadeOut);
	}}
}
		

SetInfo()
{
Int stream = 0;
if (StrLeft(getPlayItemString(), 7) == "http://") stream = 1;
	
	String PLTot = integertostring(System.getPlaylistLength());
	String PLCur = integertostring(System.getPlaylistIndex()+1);

  if(!stream)
  {
	
	//Int T = System.getPlayItemLength()/1000;
	//Int M = T/60;
	//Int S = T-(M*60);
	//String Ss;
	//if (S<10)
	//{
	//	Ss = "0" + integertoString(S);
	//}
	//else
	//{
	//	Ss = integertoString(S);
	//}
	
	
	String name;	
	if(getPlayItemMetaDataString("title")=="")
	{name="???";}
	else
	{name=System.getPlayItemMetaDataString("title");}

	Song.setXmlParam("ticker", "1");
	Song.setText(name+"    ");

	if(getPlayItemMetaDataString("artist")=="")
	{
		Artist.setText("by "+"???");
	}
	else		
	{
		Artist.setText("by "+system.getPlayItemMetaDataString("artist"));
	}

	if(system.getPlayItemMetaDataString("ALBUM") == "")
	{
		Album.setText("");
	}

	if(System.getPlayitemMetaDataString("album") != "")
	{

		if(system.getPlayItemMetaDataString("track") >= "0")
		{
			Album.setText(System.getPlayitemMetaDataString("album") + " (Track " + system.getPlayItemMetaDataString("track") + ")");
		}
		else
		{
			Album.setText(System.getPlayitemMetaDataString("songalbum"));
		}


 		String l = getPlayItemMetaDataString("length");
      		if (l != "") 
		{
        		String Ts = " (" + integerToTime(stringtointeger(l)) + ")";
			tracklength.setText(Ts);
      		}

  	}
  	else
  	{
		Album.setText("");
  	}
	

}//!stream

if(stream){

Nexttrack.setText("On Air");

      Song.setXmlParam("ticker", "1");
      Song.setXmlParam("display", "songtitle");
      Song.setText("");

      if (!isVideo())
        Artist.setText("Internet Radio");
      else
        Artist.setText("Internet TV");

      Album.setText("");
      Album.setXmlParam("display", "songinfo");

}//stream

	PLEntry.setText(PlCur + "/" + PLTot);
	

}

SetSize()
{

	string pos = system.getPrivateString("Walpha_OpenNote", "NotifierPosition", "1. Bottom Right");

		Int ScreenW = system.getViewPortWidth();
		Int ScreenH = system.getViewportHeight();
		Int TitleW = System.strlen(Song.getText());
			
		Wide = artist.getAutoWidth();
	  if (Wide < Album.getAutoWidth()) Wide = album.getAutoWidth();
	  if (Wide < Song.getAutoWidth()) Wide = Song.getAutoWidth();
	  if (Wide < 128) Wide = 150;
	  if (Wide > getViewportWidth()/4) Wide = getViewportWidth()/4;

	  Wide=Wide+50;

	  

		if(CDCover.isChecked() == 1)
		{
			Wide = Wide + 90;
	//Wide=333;
			if(myattr_cdcovertype.getData()=="net")
			{
			  PhysicalCover.show();
			  PhysicallocalCover.hide();
			}
			else
		 	{
			  PhysicallocalCover.show();
			  PhysicalCover.hide();
			  PhysicallocalCover.resize(PhysicallocalCover.getleft(),PhysicallocalCover.gettop(),65,65);
			}

			Texts.setXMLParam("x","70");
			Texts.setXMLParam("w","-80");
		}
		else
		{
			Wide = Wide + 40;
	//Wide=253;
			PhysicalCover.hide();
			PhysicallocalCover.hide();
			Texts.setXMLParam("x","0");
			Texts.setXMLParam("w","-0");
		}
		
		//be done with it	


	if(pos=="1. Bottom Right"){

	Position="b";

		Notifier.setXMLParam("x",integertostring(ScreenW-Wide-10));
		Notifier.setXMLParam("y",integertostring(ScreenH-120));
	}

	if(pos=="2. Bottom Left"){

	Position="b";

		Notifier.setXMLParam("x",integertostring(10));
		Notifier.setXMLParam("y",integertostring(ScreenH-120));
	}

	if(pos=="3. Top Right"){

	Position="t";

		Notifier.setXMLParam("x",integertostring(ScreenW-Wide-10));
		Notifier.setXMLParam("y",integertostring(30));
	}

	if(pos=="4. Top Left"){

	Position="t";

		Notifier.setXMLParam("x",integertostring(10));
		Notifier.setXMLParam("y",integertostring(30));
	}

	Notifier.setXMLParam("h",integertostring(115));
	Notifier.setXMLParam("w",integertostring(Wide));
	lyrnotifiershadow.setAlpha(255);
}

Go(Float Fadein,Float Fadeout)
{
	Tracker = 1;
	if(FadeEffect.isChecked() == 1)
	{
		Notifier.show();
		Notifier.setTargetA(255);
		Notifier.setTargetY(StringToInteger(Notifier.getXMLParam("y")));
		Notifier.SetTargetW(Wide);
		Notifier.setTargetX(StringToInteger(Notifier.getXMLParam("x")));
		Notifier.setTargetSpeed(Fadein);
		Notifier.gotoTarget();
	}
	else
	{
		Notifier.setAlpha(255);
		Notifier.show();
		Notifier.setTargetA(255);
		Notifier.setTargetY(StringToInteger(Notifier.getXMLParam("y")));
		Notifier.SetTargetW(Wide);
		Notifier.setTargetX(StringToInteger(Notifier.getXMLParam("x")));
		Notifier.setTargetSpeed(Fadein);
		Notifier.gotoTarget();
	}
}

Notifier.onTargetReached()
{
	if (Tracker == 1)
	{
		Stay.start();
	}
	if (Tracker == 2)
	{
		Notifier.hide();
	}
}
	
Stay.onTimer()
{
	Stay.stop();
	Tracker = 2;
	if(FadeEffect.isChecked() == 1)
	{
		Notifier.setTargetA(0);
		Notifier.setTargetY(StringToInteger(Notifier.getXMLParam("y")));
		Notifier.SetTargetW(Wide);
		Notifier.setTargetX(StringToInteger(Notifier.getXMLParam("x")));
		Notifier.setTargetSpeed(Fadeout);
		Notifier.gotoTarget();
	}
	else
	{
		Notifier.show();
		Notifier.setTargetA(255);

if(position=="b")
		Notifier.setTargetY(StringToInteger(Notifier.getXMLParam("y"))+145);

if(position=="t")
		Notifier.setTargetY(StringToInteger(Notifier.getXMLParam("y"))-145);

		Notifier.SetTargetW(Wide);
		Notifier.setTargetX(StringToInteger(Notifier.getXMLParam("x")));
		Notifier.setTargetSpeed(Fadein);
		Notifier.gotoTarget();
	}

}


	