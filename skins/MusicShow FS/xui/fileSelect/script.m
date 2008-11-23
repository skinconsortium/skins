#include <lib/std.mi>
#include <lib/exd.mi>

/* Part of exd.mi 

Function String replaceString(string baseString, string toreplace, string replacedby);

/**
 replaceString()

 Returns the class name for the object.

 @param  baseString    The String which you want to modify.
 @param  toreplace     The String you want to be replaced.
 @param  replacedby    The String instead of 'toreplace'.
 @ret                  The replaced string.
*/

String replaceString(string baseString, string toreplace, string replacedby) {
	if (toreplace == "") return baseString;
	int i = strsearch(baseString, toreplace);
	if (i == -1) return baseString;
	string left = "", right = "";
	if (i != 0) left = strleft(baseString, i);

	if (strlen(basestring) - i - strlen(toreplace) != 0) {
		right = strright(basestring, strlen(basestring) - i - strlen(toreplace));
	}
	return left + replacedby + right;
}

Global browser fselect;
Global Button select;
Global int gone;
Global Edit fileout;
Global string str_url;
Global Boolean b_path=0;

System.onScriptLoaded() {
	group xui = getScriptGroup();

	fselect = xui.getObject("filebrowse");
	fileout = xui.getObject("filename");
	select = xui.getObject("select");

	str_url = getParam();
	
	gone = 1;
}

System.onScriptUnLoading() {
	select = NULL;
	fselect = NULL;
	fileout = NULL;
}

System.onSetXUIParam(string param, string value) {
	if (strlower(Param) == "getonlypath") {	
		if (value == "1") b_path=1;
		
	}

}

select.onLeftClick() { 
	fselect.navigateUrl(str_url); 
}

fselect.onDocumentComplete(String url) {
	if(gone == 1) {
		int flocpos = strsearch(url, "?add={__");

		if(flocpos != -1) {
			int starting = (flocpos + strlen("?add={__"));
			int length = (strlen(url) - (flocpos + strlen("?add={__")));
			String floc = strmid(url, starting, length);
			for ( int i = 0; i < 666; i++ ) {	
				if (strsearch(floc, "%20") != -1) {
					floc = replaceString(floc, "%20", " ");
					i = 0;
				} else i = 666;
			}
			if (b_path) floc = getPath(floc);
			fileout.setText(floc);
			fselect.navigateUrl("about:blank");
		}
	}
}

/* browse about:blank to prevent autoopen box on browser set visible */

fselect.onSetVisible(int v) {
	if (!v) {
		fselect.navigateUrl("about:blank");
	}
}