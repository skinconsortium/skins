function languageParserOnLoaded(string LangPath);
function OrganizeLangVariablesList(list LangIDs, list LangValues);
function string MyTranslate(int VarID);

Global list LangVars;
Global list LangIDs;
Global XmlDoc LangDoc;

// This function loads Language file
languageParserOnLoaded(string LangPath)
{
	
	LangVars = new List;
	LangIDs = new List;

	LangDoc = new XmlDoc;

	string temp = LangPath + "\_" + strlower(System.getLanguageId())+".xml";
	LangDoc.load (temp);
	if (!LangDoc.exists())
	{
		temp = LangPath + "\_en-en.xml";
		LangDoc.load (temp);
		if (!LangDoc.exists())
		{
			MessageBox("Can't load language files. Make sure you have the latest skin and Winamp versions","Error",1,"");
			return;
		}
	}
	LangDoc.parser_addCallback("WasabiXML/Lang/*");
	LangDoc.parser_start();
	LangDoc.parser_destroy();
	delete LangDoc;
	OrganizeLangVariablesList(LangIDs, LangVars);
	delete LangIDs;
}

LangDoc.parser_onCallback (String xmlpath, String xmltag, list paramname, list paramvalue)
	{
	int i;
	
	if(strlower(xmlpath) == "wasabixml/lang/variable")
	{
		if(strlower(xmltag) == "variable")
		{
			for ( int i = 0; i<paramname.getNumItems(); i++ )
			{
				if (strlower(paramname.enumItem(i)) == "id")
				{
					LangIDs.addItem(StringtoInteger(paramvalue.enumItem(i)));
				}
				if (strlower(paramname.enumItem(i)) == "value")
				{
					LangVars.addItem(paramvalue.enumItem(i));
				}
			}
		}
	}
}

OrganizeLangVariablesList(list LangIDs, list LangValues)
{
	list Temp = new List;
	int CurrentListIndex;
	int VariableNumber = LangIDs.getNumItems();
	for ( int i = 0; i < VariableNumber; i++ )
	{
		for ( int j = 0; j < VariableNumber; j++ )
		{
			if (LangIds.enumItem(j) == (i + 1))
			{
				Temp.addItem(LangValues.enumItem(j));
				j = VariableNumber;
			}
		}
	}
	LangVars = Temp;
}

MyTranslate(int VarID)
{
	return LangVars.enumItem(VarID-1);
}