// This scripts uses only function, triggered on keyboad events, doing approtriate actions

function keyboardOnLoaded();

keyboardOnLoaded()
{

}

System.onKeyDown(String key)
{
	if (System.strlower(key) == "alt+a")
	{
		if (cattrAlbumArt.getData()=="1")
		{
			cattrAlbumArt.setData("0");
		} else
		{
			cattrAlbumArt.setData("1");
		}
		complete;
	}
	if (System.strlower(key) == "alt+g")
	{
		if (cattrEq.getData()=="1")
		{
			cattrEq.setData("0");
		} else
		{
			cattrEq.setData("1");
		}
		complete;
	}
}