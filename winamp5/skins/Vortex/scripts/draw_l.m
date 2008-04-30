                        /*
+-----------------------------------------------+
|draw_r.m                                       |
+-----------------------------------------------+
|Made by: hammerhead and Rohan Prabhu           |
|Application: Controls right drawer(made by     |
|             hammerhead) and file type display |
|		      (made by Rohan Prabhu)    |
|Copyrights/License: Use freely                 |
+-----------------------------------------------+
     
SLoB                  
shift media type to main display, use draw for something more purposeful such as buttons/options for something
*/

#include "../../../lib/std.mi"

Global Group Grp;
//Function applyFileData();
//Global text ft, ff;

System.OnScriptLoaded ()
{
	Grp = GetScriptGroup();
	//Grp.onLeftButtonUp(NULL, NULL);

	//ft=grp.findObject("file.type");
	//ff=grp.findObject("file.family");

	//applyFileData();
}

Grp.OnLeftButtonUp (int x, int y)
{
	if (Grp.GetLeft() > 0)
	{
		Grp.SetTargetX(0);
		Grp.SetTargetSpeed(0.5);
		Grp.GotoTarget();
	}
	else
	{
		Grp.SetTargetX(57);
		Grp.SetTargetSpeed(0.5);
		Grp.GotoTarget();
	}
//}


//System.onTitleChange(string newtitle) {
//	applyFileData();
//}

//System.onTitle2Change(string newtitle) {
//	applyFileData();
//}

//applyFileData() {
//	ft.setText(System.getExtension(System.getPlayItemString()));
//	if(System.getExtFamily(System.getExtension(System.getPlayItemString()))=="") {
//		ff.setText("media");
//	} else {
//		ff.setText(System.getExtFamily("mp3"));
//	}
}