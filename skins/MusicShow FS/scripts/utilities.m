/*** 

	Utilities.m - common functions used by the most scripts.

***/

#ifndef included
#error This script can only be compiled as a #include
#endif

#define ON 1
#define OFF 0

#define VID_GUID "{F0816D7B-FFFC-4343-80F2-E8199AA15CC3}"
#define VIS_GUID "{0000000A-000C-0010-FF7B-01014263450C}"
#define PL_GUID "{45F3F7C1-A6F3-4EE6-A15E-125E92FC3F8D}"
#define ML_GUID "{6B0EDF80-C9A5-11D3-9F26-00C04F39FFC6}"

#define COLOR1DEF "0,0,0"
#define COLOR2DEF "255,255,255"

function centerObject(guiObject obj, boolean centx, boolean centy);
function setGuiCoord(guiObject obj, string coord);
function guiObject findXUIObject(group parentGroup, string id, string xuiID);
function int hexToInt(string ch);
function string urlDecode(string url);
function string getURLData(string url, string dataname);
function string validateFileName(string fname, string controlchars, string replacechars);

// centers guiobjects depending on parent group/layout
centerObject(guiObject obj, boolean centx, boolean centy) {

  guiObject parentobj = obj.getParent();

  int x, y;

  if (centx) 
    x = (parentobj.getWidth() - obj.getWidth())/2;
  else
    x = obj.getGuiX();
  if (centy) 
    y = (parentobj.getHeight() - obj.getHeight())/2;
  else
    y = obj.getGuiY();
    
  if (x < 0) x = 0;
  if (y < 0) y = 0;

  obj.setXMLParam("x", integerToString(x));
  obj.setXMLParam("y", integerToString(y));

}

// sets all gui coordinates using 1 string
setGuiCoord(guiObject obj, string coord) {
	if (!obj) return;
	
	if (getToken(coord,",",0)!="") obj.setXMLParam("x",getToken(coord,",",0));
	if (getToken(coord,",",1)!="") obj.setXMLParam("y",getToken(coord,",",1));
	if (getToken(coord,",",2)!="") obj.setXMLParam("w",getToken(coord,",",2));
	if (getToken(coord,",",3)!="") obj.setXMLParam("h",getToken(coord,",",3));
	if (getToken(coord,",",4)!="") obj.setXMLParam("relatx",getToken(coord,",",4));
	if (getToken(coord,",",5)!="") obj.setXMLParam("relaty",getToken(coord,",",5));
	if (getToken(coord,",",6)!="") obj.setXMLParam("relatw",getToken(coord,",",6));
	if (getToken(coord,",",7)!="") obj.setXMLParam("relath",getToken(coord,",",7));
}

// locates objects in xui/groups objects
guiObject findXUIObject(group parentGroup, string id, string xuiID) {
  group _XUIGroup = parentGroup.findObject(id);
  if (_XUIGroup) 
    guiObject _retObj = _XUIGroup.findObject(xuiID);
  
  return _retObj;
}

// converts single HEX char to int.
int hexToInt(string ch) {
	int ret;
	
	ch = strupper(strleft(ch,1));
	if (ch=="A") ret = 10;
	else if (ch=="B") ret = 11;
	else if (ch=="C") ret = 12;
	else if (ch=="D") ret = 13;
	else if (ch=="E") ret = 14;
	else if (ch=="F") ret = 15;
	else ret = stringToInteger(ch);
	
	return ret;
}

// url decode..
string urlDecode(string url) {
	int c, len = strlen(url);
	string ret = "", char;
	string hex1, hex2;
	
	c=0;
	while (c < len) {
		char = strmid(url,c,1);
		if (char=="%") {
			hex1 = strmid(url,c+1,1);
			hex2 = strmid(url,c+2,1);
			char = chr(hexToInt(hex1)*16+hexToInt(hex2));
			ret = ret + char;
			c += 3;
		} else {
			ret = ret + char;
			c++;
		}
	}
	
	return ret;
	
}

// grabs data passed thru urls, e.g. index.php?var1=100&var2=test
string getURLData(string url, string dataname) {
	string searchstr = dataname + "=";
	int dataloc = strsearch(url, searchstr);
	if (dataloc < 0) return "";
	
	string ret = strRight(url, strlen(url)-dataloc-strlen(searchstr)); 
	ret = getToken(ret, "&", 0);
	
	return ret;
}

// replaces special chars on _fname with valid char for use as filenames.
string validateFileName(string _fname, string controlchars, string replacechars) {
	int c, d, len = strlen(_fname);

	string ret = "", char;
	
	for (c=0; c<len; c++) {
		char = strmid(_fname,c,1);
		d = strsearch(controlchars,char);
		if (d>=0) char = strmid(replacechars,d,1);
		ret = ret + char;
	}
	
	return ret;
}

// function utilities needing attribs.m

#ifdef __ATTRIBS_M
function setTempText(string tempText);

setTempText(string tempText) {
	temptext_attrib.setData(tempText);
}

// hookable functions - general timer (skin-wide synchronization)
function onGenTimer100ms(); onGenTimer100ms() {return;}
function onGenTimer200ms(); onGenTimer200ms() {return;}
function onGenTimer500ms(); onGenTimer500ms() {return;}
function onGenTimer1sec(); onGenTimer1sec() {return;}

genTimerAttrib.onDataChanged() {
	int timec = stringToInteger(getData());
	
	onGenTimer100ms();
	if ((timec % 2) == 0) onGenTimer200ms();
	if ((timec % 5) == 0) onGenTimer500ms();
	if (timec == 0) onGenTimer1sec();
}

#endif