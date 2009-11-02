#include <lib/std.mi>
Function setNfo();
Global Text artistText, titleText, albumText;
System.onScriptLoaded ()
{
	artistText = getScriptGroup().findObject("txt.artist");
	titleText = getScriptGroup().findObject("txt.title");
	albumText = getScriptGroup().findObject("txt.album");
	setNfo();
}
System.onTitleChange (String newtitle)
{
	setNfo();
}
setNfo()
{
	artistText.setXmlParam("text",System.getPlayItemMetaDataString("artist"));
	titleText.setXmlParam("text",System.getPlayItemMetaDataString("title"));
	albumText.setXmlParam("text",System.getPlayItemMetaDataString("album"));
}