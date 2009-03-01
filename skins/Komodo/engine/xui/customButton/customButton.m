/*************************************************************

  customButton.m
  
  -script to control customButton xui object.
  

*************************************************************/

#include <lib/std.mi>
#include <lib/config.mi>

function updateLabels();

global group scriptGroup;
global button xuibutton;
global layer xuiicon;
global text xuitext1, xuitext2;
global configAttribute attrib;
global string cfglabel1, cfglabel2;
global string label1fontsize, label2fontsize;

System.onScriptLoaded() {
	scriptGroup = getScriptGroup();
	
	xuibutton = scriptGroup.getObject("xuibutton");
	xuiicon = scriptGroup.getObject("xuibutton.icon");
	xuitext1 = scriptGroup.getObject("xuibutton.text1");
	xuitext2 = scriptGroup.getObject("xuibutton.text2");
	
	label1fontsize = xuitext1.getXMLParam("fontsize");
	label2fontsize = xuitext2.getXMLParam("fontsize");
	
	attrib = NULL;
	cfglabel1 = ""; cfglabel2 = "";
	
	string attribguid = scriptGroup.getXMLParam("cfgattrib");

	if (attribguid!="") {
		configItem configGroup = Config.getItemByGuid(getToken(attribguid,";",0));
		if (configGroup) attrib = configGroup.getAttribute(getToken(attribguid,";",1));
		
		if (attrib) attrib.onDataChanged();
	}
}

System.onScriptUnloading() {

}

System.onSetXuiParam(String param, String value) {
	param = strlower(param);
	if (param=="label") {
		xuitext1.setText(value);
	} else if (param=="label2") {
		xuitext2.setText(value);
		updateLabels();
	} else if (param=="icon") {
		xuiicon.setXMLParam("image",value);
		if (value!="") {
			xuitext1.setXMLParam("x","27");
			xuitext1.setXMLParam("w","60");
			xuitext2.setXMLParam("x","27");
			xuitext2.setXMLParam("w","60");
		}
	} else if (param=="cfglabel") {
		cfglabel1 = value;
		
		if (attrib) attrib.onDataChanged();
	} else if (param=="cfglabel2") {
		cfglabel2 = value;
		
		if (attrib) attrib.onDataChanged();
	} else if (param=="cfgattrib") {
		xuibutton.setXMLParam(param, value);
		configItem configGroup = Config.getItemByGuid(getToken(value,";",0));
		if (configGroup) attrib = configGroup.getAttribute(getToken(value,";",1));
		
		if (attrib) attrib.onDataChanged();
	} else {
		xuibutton.setXMLParam(param, value);
	}
}


updateLabels() {
	if (xuitext2.getText()!="") {
		xuitext1.setXMLParam("h",xuitext2.getXMLParam("h"));
		xuitext1.setXMLParam("fontsize",label2fontsize);
	} else {
		xuitext1.setXMLParam("h","30");
		xuitext1.setXMLParam("fontsize",label1fontsize);
	}
}

attrib.onDataChanged() {
	string data = strupper(attrib.getData());
	string currval1 = "", currval2 = "", attribval, label;
	int c = 0;

	do {
		currval1 = getToken(cfglabel1,";",c);
		currval2 = getToken(cfglabel2,";",c);
		
		if (currval1 != "") {
			attribval = strupper(getToken(currval1,"=",0));
			if (attribval == data) xuitext1.setText(getToken(currval1,"=",1));
		}
		if (currval2 != "") {
			attribval = strupper(getToken(currval2,"=",0));
			if (attribval == data) xuitext2.setText(getToken(currval2,"=",1));
		}
		
		c++;
	} while (currval1 != "" || currval2 != "");
	updateLabels();
}