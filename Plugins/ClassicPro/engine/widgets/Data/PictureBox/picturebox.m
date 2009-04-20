/**
 * Picturebox.m
 *
 * @author mpdeimos
 * @date 08/04/16
 */

#include <lib/std.mi>
#include <lib/colormgr.mi>
#include "../../../lib/ClassicProFile.mi"
//#export_cclass List

#define DISPATCH
#include dispatch_codes.m

Function String playitemPath();
Function readImages();
Function GuiObject createGroup(string id);
Function rightClickMenu(String filename, boolean showOptions);
Function setPreviewImage(GuiObject thumb);

Global String lastPath;
Global Group scriptGroup, previewGroup, selectGroup, selectGroupP, selectGroupTL, quadSplit;
Global GuiObject preview;
Global Layer mousetrap;
Global GuiObject lastSelectedImage;
Global Text statusText;
Global Button options, next, prev;
Global int numPics, curPic;
Global GuiObject gradient;

Global String backslash;

Global Timer refreshImages, slideShow;

Global String defaultImage;

Global int needsRefresh;

System.onScriptLoaded ()
{
	backslash	= strleft("\ ",1);

	scriptGroup	= getScriptGroup();
	previewGroup	= scriptGroup.findObject("centro.widgets.picturebox.preview");
	selectGroupP	= scriptGroup.findObject("centro.widgets.picturebox.select");
	quadSplit	= scriptGroup.findObject("centro.widgets.picturebox.quadsplit");
	selectGroupTL	= scriptGroup.findObject("centro.widgets.picturebox.select.images.thumblist");
	selectGroup	= selectGroupTL.findObject("centro.widgets.picturebox.select.images");
	mousetrap	= previewGroup.findObject("mousetrap");
	preview		= previewGroup.findObject("preview");
	defaultImage	= preview.getXmlParam("image");
	statusText	= scriptGroup.getObject("statustext");
	next		= scriptGroup.getObject("next");
	prev		= scriptGroup.getObject("prev");
	options		= scriptGroup.getObject("options");
	gradient	= previewGroup.findObject("gradient");
	
	quadSplit.setXmlParam("modalpreferred", getPrivateString("ClassicPro", "PictureBox.PrefPos", "smooth"));

	// Init Gradient Colors.
	Color c = ColorMgr.getColor("wasabi.list.text.selected.background");
	String rgb = integerToString(c.getRed()) + "," + integerToString(c.getGreen()) + "," + integerToString(c.getBlue());
	gradient.setXmlParam("points", "0.0=" + rgb + ",0;1.0=" + rgb + ",255");
	gradient.show();

	setDispatcher(selectGroup);

	slideShow = new Timer;
	int d = getPrivateInt("ClassicPro", "PictureBox.SlideShowSpeed", 0)*1000;
	slideShow.setDelay(d);
	refreshImages = new Timer;
	refreshImages.setDelay(1000); // wait one sec on startup before we show the images. This gives Winamp some time to breath.

	// Usually we arent visible on startup, but who knows :P
	if (scriptGroup.isVisible())
	{
		readImages();	
	}
	else
	{
		needsRefresh = true;
	}
}

System.onTitleChange (String newtitle)
{
	refreshImages.stop();
	if (scriptGroup.isVisible())
	{
		refreshImages.start();	
	}
	else
	{
		needsRefresh = true;
	}
}

scriptGroup.onSetVisible (Boolean onoff)
{
	slideShow.stop();
	if (needsRefresh && onoff)
	{
		refreshImages.stop();
		refreshImages.start();
	}
	else
	{
		if (getPrivateInt("ClassicPro", "PictureBox.SlideShowSpeed", 0) > 0 && numPics > 1 && scriptGroup.isvisible())
		{
			slideShow.start();
		}
	}
}

slideShow.onTimer ()
{
	next.leftclick();	
}

refreshImages.onTimer ()
{
	refreshImages.stop();
	refreshImages.setDelay(100); // since now we just wait 100 ms after a song changes.
	readImages();
}


readImages ()
{
	String curPath = playitemPath();
	if (needsRefresh != 2 && lastPath == curPath)
	{
		return;
	}

	needsRefresh = false;

	lastPath = curPath;

	List lst = new List;
	
	ClassicProFile.findFiles(curPath, "*.jpg", lst);
	ClassicProFile.findFiles(curPath, "*.jpeg", lst);
	ClassicProFile.findFiles(curPath, "*.png", lst);
	ClassicProFile.findFiles(curPath, "*.gif", lst);
	ClassicProFile.findFiles(curPath, "*.bmp", lst);

	slideShow.stop();

	// clear old images
	if (numPics)
	{
		for ( int i = 0; i < selectGroup.getNumObjects() && i < numPics; i++ )
		{
			GuiObject l = selectGroup.enumObject(i);
			l.setXmlParam("image", "");
			l.hide();
		}
	}
	
	numPics = lst.getNumItems();
	if (numPics)
	{
		statusText.setText("Loading ...");
		preview.setXmlParam("image", curPath + backslash + lst.enumItem(0));
		for (int i = 0; i < lst.getNumItems(); i++ )
		{
			GuiObject l;
			if (i < selectGroup.getNumObjects())
			{
				l = selectGroup.enumObject(i);
				l.show();
			}
			else
			{
				l = createGroup(integerToString(i));				
			}
			l.setXmlParam("tooltip", lst.enumItem(i));
			l.setXmlParam("userdata", curPath + backslash + lst.enumItem(i));
			l.setXmlParam("image", l.getXmlParam("userdata"));
			selectGroupTL.sendAction("update", "", 0,0,0,0);
		}
	
		setPreviewImage(selectGroup.enumObject(0));

		if (getPrivateInt("ClassicPro", "PictureBox.SlideShowSpeed", 0) > 0 && numPics > 1 && scriptGroup.isvisible())
		{
			slideShow.start();
		}
	}
	else
	{
		preview.setXmlParam("image", defaultImage);
		statusText.setText("No Images Found.");
	}
	
	delete lst;
}

String playitemPath()
{
	String output = "";

	if (System.strleft(System.getPlayItemString(),6) == "cda://")
		output = System.strmid(System.getPlayItemString(), 6, 1)+":"+backslash;
	else 
		output= getPath(getPlayItemMetaDataString("filename"));
	return output;
}

GuiObject createGroup(String id)
{
	GuiObject l = newGroup("centro.widgets.picturebox.select.image");
	l.setXmlParam("x", "0");
	l.setXmlParam("y", "0");
	l.setXmlParam("h", "40");
	l.setXmlParam("w", "40");
	l.setXmlParam("id", id); 
	l.init(selectGroup);
	return l;
}

onMessage(int message, int i0, int i1, int i2, String s0, String s1, GuiObject obj)
{
	if (message == ON_LEFT_BUTTON_UP)
	{
		setPreviewImage(obj);
	}
	else if (message == ON_ENTER_AREA)
	{
		statusText.setText(obj.getXmlParam("tooltip"));
	}
	else if (message == ON_LEAVE_AREA)
	{
		if (lastSelectedImage != NULL)
			statusText.setText(lastSelectedImage.getXmlParam("tooltip"));
	}
	else if (message == ON_RIGHT_BUTTON_UP)
	{
		rightClickMenu(obj.getXmlParam("userdata"), false);
	}
}

mousetrap.onRightButtonUp (int x, int y)
{
	if (lastSelectedImage != NULL)
		rightClickMenu(lastSelectedImage.getXmlParam("userdata"), false);
}

rightClickMenu(String filename, boolean showOptions)
{
	if (!showOptions && !numPics)
	{
		return;
	}

	PopupMenu pop = new PopupMenu;
	
	pop.addCommand("Open", 1, false, !numPics);
	pop.addCommand("Edit", 2, false, !numPics);
	pop.addCommand("Print", 3, false, !numPics);
	pop.addCommand("Open Folder", 4, false, !numPics);

	if (showOptions)
	{
		pop.addSeparator();
		pop.addCommand("Reload", 200, false, false);
		PopupMenu popPrefPos = new PopupMenu;
		popPrefPos.addCommand("Right (Loose)", 201, getPrivateString("ClassicPro", "PictureBox.PrefPos", "smooth") == "right", false);
		popPrefPos.addCommand("Right (Fixed)", 202, getPrivateString("ClassicPro", "PictureBox.PrefPos", "smooth") == "rightfixed", false);
		popPrefPos.addCommand("Bottom (Loose)", 203, getPrivateString("ClassicPro", "PictureBox.PrefPos", "smooth") == "bottom", false);
		popPrefPos.addCommand("Bottom (Fixed)", 204, getPrivateString("ClassicPro", "PictureBox.PrefPos", "smooth") == "bottomfixed", false);
		popPrefPos.addCommand("Smooth ", 205, getPrivateString("ClassicPro", "PictureBox.PrefPos", "smooth") == "smooth", false);
		pop.addSubMenu(popPrefPos, "Preferred Thumbs Position");

		PopupMenu popSlideShow = new PopupMenu;
		popSlideShow.addCommand("0 sec (Off)", 300, getPrivateInt("ClassicPro", "PictureBox.SlideShowSpeed", 0) == 0, false);
		popSlideShow.addCommand("5 sec", 305, getPrivateInt("ClassicPro", "PictureBox.SlideShowSpeed", 0) == 5, false);
		popSlideShow.addCommand("10 sec", 310, getPrivateInt("ClassicPro", "PictureBox.SlideShowSpeed", 0) == 10, false);
		popSlideShow.addCommand("20 sec", 320, getPrivateInt("ClassicPro", "PictureBox.SlideShowSpeed", 0) == 20, false);
		popSlideShow.addCommand("40 sec", 340, getPrivateInt("ClassicPro", "PictureBox.SlideShowSpeed", 0) == 40, false);
		popSlideShow.addCommand("60 sec", 360, getPrivateInt("ClassicPro", "PictureBox.SlideShowSpeed", 0) == 60, false);
		pop.addSubMenu(popSlideShow, "Slide Show");	
	}
	
	
	int r = pop.popAtMouse();

	if (r == 1)
	{
		ClassicProFile.openFile(filename, "");
	}
	else if (r == 2)
	{
		ClassicProFile.editFile(filename, "");
	}
	else if (r == 3)
	{
		ClassicProFile.printFile(filename, "");
	}
	else if (r == 4)
	{
		ClassicProFile.exploreFile(filename);
	}
	else if (r == 200)
	{
		needsRefresh = 2;
		scriptGroup.onSetVisible (true);
	}
	else if (r == 201)
	{
		setPrivateString("ClassicPro", "PictureBox.PrefPos", "right");
		quadSplit.setXmlParam("modalpreferred", "right");
	}
	else if (r == 202)
	{
		setPrivateString("ClassicPro", "PictureBox.PrefPos", "rightfixed");
		quadSplit.setXmlParam("modalpreferred", "rightfixed");
	}
	else if (r == 203)
	{
		setPrivateString("ClassicPro", "PictureBox.PrefPos", "bottom");
		quadSplit.setXmlParam("modalpreferred", "bottom");
	}
	else if (r == 204)
	{
		setPrivateString("ClassicPro", "PictureBox.PrefPos", "bottomfixed");
		quadSplit.setXmlParam("modalpreferred", "bottomfixed");
	}
	else if (r == 205)
	{
		setPrivateString("ClassicPro", "PictureBox.PrefPos", "smooth");
		quadSplit.setXmlParam("modalpreferred", "smooth");
	}
	else if (r >= 300 && r < 400)
	{
		r -= 300;
		setPrivateInt("ClassicPro", "PictureBox.SlideShowSpeed", r);
		if (numPics > 1 && r > 0 && scriptGroup.isvisible())
		{
			int d = r*1000;
			slideShow.setDelay(d);
			slideShow.start();
		}
		else
		{
			slideShow.stop();
		}
		
		
	}
	
	complete;
}

options.onLeftClick ()
{
	if (lastSelectedImage != NULL)
		rightClickMenu(lastSelectedImage.getXmlParam("userdata"), true);
}

next.onLeftClick ()
{
	if (numPics < 2)
	{
		return;
	}
	
	curPic = (curPic + 1) % numPics;
	
	setPreviewImage(selectGroup.findObject(integerToString(curPic)));
}

prev.onLeftClick ()
{
	if (numPics < 2)
	{
		return;
	}

	curPic--;
	if (curPic < 0)
	{
		curPic = numPics - 1;
	}
	

	setPreviewImage(selectGroup.findObject(integerToString(curPic)));
}

setPreviewImage(GuiObject thumb)
{
	if (lastSelectedImage != NULL)
	{
		lastSelectedImage.setXmlParam("selected", "0");		
	}

	lastSelectedImage = thumb;
	lastSelectedImage.setXmlParam("selected", "1");

	preview.setXmlParam("image", lastSelectedImage.getXmlParam("userdata"));
	statusText.setText(lastSelectedImage.getXmlParam("tooltip"));
	curPic = stringTointeger(lastSelectedImage.getId());
}