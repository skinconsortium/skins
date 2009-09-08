#include <lib/std.mi>

Global browser fselect;
Global text dummyadd;
Global int gone;
Global text fileout;

System.onScriptLoaded() {
	layout normal = getContainer("fselect").getLayout("normal");

	fselect = normal.getObject("filebrowse");
	fileout = normal.getObject("filename");

	dummyadd = normal.getObject("dummyaddholder");
	dummyadd.hide();
	fselect.navigateUrl(/*dummyadd.getText() +*/ "file:///H:\Programme\Nullsoft\Winamp5\Skins\noGFX_SUI\html\fselect.html");
	gone = 1;
	fselect.setXMLParam("scrollbars", "never");
}

fselect.onDocumentComplete(String url) {
	if(gone == 1) {
		int flocpos = strsearch(url, "?add={__");

		if(flocpos != -1) {
			int starting = (flocpos + strlen("?add={__"));
			int length = (strlen(url) - (flocpos + strlen("?add={__")));
			String floc = strmid(url, starting, length);
			fileout.setText(floc);
		}
	}
}