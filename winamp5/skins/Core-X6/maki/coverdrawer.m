function coverdrawerOnLoaded();
function coverdrawerSetStars(int Number); // Number is the number of stars to set to hover position
function coverDrawerOnTitleChange(string newtitle); // Function is called by OnTitleChange from the main script

coverdrawerOnLoaded()
{
	if (cattrAlbumArt.getData()== "1")
	{
		grpCover.setXMLParam("x","3");
	} else
	{
		grpCover.setXMLParam("x","151");
	}

	coverdrawerSetStars(0);
}

cattrAlbumArt.OnDataChanged()
{
	if (cattrAlbumArt.getData()== "1")
	{
		grpCover.setTargetX(3);
		grpCover.setTargetY(50);
		grpCover.setTargetSpeed(1);
		grpCover.GotoTarget();
	} else
	{
		grpCover.setTargetX(151);
		grpCover.setTargetY(50);
		grpCover.setTargetSpeed(1);
		grpCover.GotoTarget();
	}
}

btnCoverButton.onLeftButtonUp(int x, int y)
{
	// A standard button triggers when the button was pressed on it, then released, but in it's area too.
	if (btnCoverButton.isMouseOver(x, y))
	{
		if (cattrAlbumArt.getData()=="1")
		{
			cattrAlbumArt.setData("0");
		} else
		{
			cattrAlbumArt.setData("1");
		}	
	}
	
}

// Handling the rating stars

System.onCurrentTrackRated(int rating)
{
	coverdrawerSetStars(0);
}

btnCoverStar1.onEnterArea(){
	coverdrawerSetStars(1);
}
btnCoverStar2.onEnterArea(){
	coverdrawerSetStars(2);
}
btnCoverStar3.onEnterArea(){
	coverdrawerSetStars(3);
}
btnCoverStar4.onEnterArea(){
	coverdrawerSetStars(4);
}
btnCoverStar5.onEnterArea(){
	coverdrawerSetStars(5);
}
btnCoverStar1.onLeaveArea(){
	coverdrawerSetStars(0);
}
btnCoverStar2.onLeaveArea(){
	coverdrawerSetStars(0);
}
btnCoverStar3.onLeaveArea(){
	coverdrawerSetStars(0);
}
btnCoverStar4.onLeaveArea(){
	coverdrawerSetStars(0);
}
btnCoverStar5.onLeaveArea(){
	coverdrawerSetStars(0);
}

btnCoverStar1.onLeftClick(){
	System.setCurrentTrackRating(1);
	coverdrawerSetStars(1);
}
btnCoverStar2.onLeftClick(){
	System.setCurrentTrackRating(2);
	coverdrawerSetStars(2);
}
btnCoverStar3.onLeftClick(){
	System.setCurrentTrackRating(3);
	coverdrawerSetStars(3);
}
btnCoverStar4.onLeftClick(){
	System.setCurrentTrackRating(4);
	coverdrawerSetStars(4);
}
btnCoverStar5.onLeftClick(){
	System.setCurrentTrackRating(5);
	coverdrawerSetStars(5);
}

coverdrawerSetStars(int Number){

	int rating = System.getCurrentTrackRating();

	if (rating >= 1)
	{
		btnCoverStar1.setXMLParam("image","player.normal.cover.starlight.bitmap");
	} else
	{
		btnCoverStar1.setXMLParam("image","player.normal.cover.stardark.bitmap");
	}
	if (rating >= 2)
	{
		btnCoverStar2.setXMLParam("image","player.normal.cover.starlight.bitmap");
	} else
	{
		btnCoverStar2.setXMLParam("image","player.normal.cover.stardark.bitmap");
	}
	if (rating >= 3)
	{
		btnCoverStar3.setXMLParam("image","player.normal.cover.starlight.bitmap");
	} else
	{
		btnCoverStar3.setXMLParam("image","player.normal.cover.stardark.bitmap");
	}
	if (rating >= 4)
	{
		btnCoverStar4.setXMLParam("image","player.normal.cover.starlight.bitmap");
	} else
	{
		btnCoverStar4.setXMLParam("image","player.normal.cover.stardark.bitmap");
	}
	if (rating == 5)
	{
		btnCoverStar5.setXMLParam("image","player.normal.cover.starlight.bitmap");
	} else
	{
		btnCoverStar5.setXMLParam("image","player.normal.cover.stardark.bitmap");
	}
	if (Number == 0)
	{
		btnCoverStar1.setAlpha(255);
		btnCoverStar2.setAlpha(255);
		btnCoverStar3.setAlpha(255);
		btnCoverStar4.setAlpha(255);
		btnCoverStar5.setAlpha(255);
	} else
	{
		if (Number >= 1)
		{
			btnCoverStar1.setAlpha(255);
		} else
		{
			btnCoverStar1.setAlpha(150);
		}
		if (Number >= 2)
		{
			btnCoverStar2.setAlpha(255);
		} else
		{
			btnCoverStar2.setAlpha(150);
		}
		if (Number >= 3)
		{
			btnCoverStar3.setAlpha(255);
		} else
		{
			btnCoverStar3.setAlpha(150);
		}
		if (Number >= 4)
		{
			btnCoverStar4.setAlpha(255);
		} else
		{
			btnCoverStar4.setAlpha(150);
		}
		if (Number == 5)
		{
			btnCoverStar5.setAlpha(255);
		} else
		{
			btnCoverStar5.setAlpha(150);
		}
	}
}

coverDrawerOnTitleChange(string newtitle)
{
	coverdrawerSetStars(0);
}