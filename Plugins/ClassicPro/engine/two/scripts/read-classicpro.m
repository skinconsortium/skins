#include <lib/std.mi>
#include <lib/fileio.mi>
#define DEF_MAX 50

Global Group frameGroup, temp_g, tagViewer;
Global XmlDoc myDoc;
Global Text textObject;//1, plText2, plText3;
//Global Text vidText1, vidText2, vidText3;
//Global Text fileinfo1, fileinfo2;



System.onScriptLoaded (){
	frameGroup = getScriptGroup ();
	


	//delete temp_g;
	

	//Custom Vis code
	myDoc = new XmlDoc;
	String fullpath = getParam()+"ClassicPro.xml";
	myDoc.load (fullpath);
	
	// If we include more stuff in the classicpro.xml at a later stage the parser must set a boolean = true to know that the xml was for this
	if(myDoc.exists()){
		//debug("werk!");
		myDoc.parser_addCallback("ClassicPro/TextSettings*");
		myDoc.parser_start();
		myDoc.parser_destroy();
	}
	delete myDoc;

	//remove all objects after load
	/*delete frameGroup;
	delete plText1;
	delete plText2;
	delete plText3;
	delete vidText1;
	delete vidText2;
	delete vidText3;*/

}

myDoc.parser_onCallback (String xmlpath, String xmltag, list paramname, list paramvalue){
	if(strlower(xmltag) == "style"){
		String busyWith ="";
		for(int i=0; i<paramname.getNumItems(); i++){
			if(strlower(paramname.enumItem(i))=="id"){
				busyWith=paramvalue.enumItem(i);
			}
			else if(busyWith=="normal.statusbar.text"){ //else if - because otherwise the ID param gets set too - might be buggy in cpro1 - check later (note to myself pjn)

				//Playlist status text
				temp_g = frameGroup.findObject("centro.playlist2");
				textObject = temp_g.getObject("centro2.group.pl.buttons").findObject("centro.playlist.pltext1");
				textObject.setXmlParam(paramname.enumItem(i),paramvalue.enumItem(i));

				temp_g = frameGroup.findObject("drawer.playlist");
				textObject = temp_g.getObject("centro2.group.pl.buttons").findObject("centro.playlist.pltext1");
				textObject.setXmlParam(paramname.enumItem(i),paramvalue.enumItem(i));

				temp_g = frameGroup.findObject("centro.playlist.component");
				textObject = temp_g.getObject("centro2.group.pl.buttons").findObject("centro.playlist.pltext1");
				textObject.setXmlParam(paramname.enumItem(i),paramvalue.enumItem(i));

				//Video status text
				temp_g = frameGroup.findObject("centro.video");
				textObject = temp_g.getObject("centro.video.buttons").findObject("centro2.group.video.buttons.text");
				textObject.setXmlParam(paramname.enumItem(i),paramvalue.enumItem(i));

				temp_g = frameGroup.findObject("centro.playlist.directory.vid");
				textObject = temp_g.getObject("centro2.group.video.buttons").findObject("centro2.group.video.buttons.text");
				textObject.setXmlParam(paramname.enumItem(i),paramvalue.enumItem(i));

				temp_g = frameGroup.findObject("drawer.video");
				textObject = temp_g.getObject("centro2.group.video.buttons").findObject("centro2.group.video.buttons.text");
				textObject.setXmlParam(paramname.enumItem(i),paramvalue.enumItem(i));


				//File info status text
				temp_g = frameGroup.findObject("centro.playlist.directory.tag");
				textObject = temp_g.findObject("tagviewer.status.box.text");
				textObject.setXmlParam(paramname.enumItem(i),paramvalue.enumItem(i));

				temp_g = frameGroup.findObject("centro.multidrawer");
				textObject = temp_g.findObject("tagviewer.status.box.text");
				textObject.setXmlParam(paramname.enumItem(i),paramvalue.enumItem(i));
				
				temp_g = NULL;




				//plText2.setXmlParam(paramname.enumItem(i),paramvalue.enumItem(i));
				//plText3.setXmlParam(paramname.enumItem(i),paramvalue.enumItem(i));
				//vidText1.setXmlParam(paramname.enumItem(i),paramvalue.enumItem(i));
				//vidText2.setXmlParam(paramname.enumItem(i),paramvalue.enumItem(i));
				//vidText3.setXmlParam(paramname.enumItem(i),paramvalue.enumItem(i));
				//fileinfo1.setXmlParam(paramname.enumItem(i),paramvalue.enumItem(i));
				//fileinfo2.setXmlParam(paramname.enumItem(i),paramvalue.enumItem(i));
			}
			else if(busyWith=="normal.fileinfo.text"){
				tagViewer = frameGroup.findObject("centro.multidrawer").findObject("info.component.infodisplay");
				tagViewer.sendAction("update_text", paramname.enumItem(i) + ";" + paramvalue.enumItem(i), 0, 0, 0, 0);
				tagViewer = frameGroup.findObject("centro.playlist.directory").findObject("info.component.infodisplay");
				tagViewer.sendAction("update_text", paramname.enumItem(i) + ";" + paramvalue.enumItem(i), 0, 0, 0, 0);
			}		
		}
	}
}