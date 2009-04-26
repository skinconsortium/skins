module com.skinconsortium.d.commons.NSISDefinitionFile;

import tango.io.FilePath;
import tango.io.File;
debug import tango.io.Stdout;
//import tango.sys.Environment;
import tango.io.FileSystem;
import Text = tango.text.Util;

version (ownNsisDefinitionFile)
{
	import main;
}

/**
 * ConfigFile
 *
 * Creates and handlex a config.xml file within the exe directory.
 *
 * @author mpdeimos
 */
public class NSISDefinitionFile
{
	private static const char[] configFilename = "config.nsh";
	
	private static char[][char[]] definitionMap;
	private static File file;
	
	/** static constructor - loads/creates the xml document */
	static this()
	{
		version (ownNsisDefinitionFile)
		{
			FilePath fp = new FilePath(FileSystem.toAbsolute(OWN_NSIS_DEFINITION_FILE));
		}
		else
		{
			FilePath fp = new FilePath(FileSystem.toAbsolute(configFilename));
		}

		bool existed = fp.exists;
		if (!existed)
		{
			fp.createFile;
		}
	
		file = new File(fp.toString());
		
		if (existed)
		{
			char[] content = cast(char[]) file.read();
			
			foreach (line; Text.lines(content))
			{
				if (line.length == 0)
					continue;
				
				if (line[0] == ';')
					continue;
				
				char[][3] bits; int i = 0;
				foreach(value;Text.quotes!(char)(line, " "))
				{
					if (i > 2)
						break;
					
					bits[i] = value;
					i++;
				}
				
				if (bits.length < 2)
					continue;
				
				if (bits[0] == "!define")
				{
					if (bits.length > 2)
						definitionMap[bits[1]] = bits[2][1..$-1];
					else
						definitionMap[bits[1]] = null;
				}
			}
		}
	}
	
	/** static destructor - saves the file on program termination */
	static ~this()
	{
		save();
	}
	
	/** saves model changes */
	static void save()
	{	
		char[] fileoutput = "; NSIS Definition File\r\n; Created by NSISDefinitionFile\r\n; (c) 2009 Martin Poehlmann\r\n";
		foreach(key,value;definitionMap)
		{
			fileoutput ~= "\r\n!define "~key;
			if (value !is null)
				fileoutput ~= " \""~value~"\"";
				
		}
		file.write(cast(void[])fileoutput);		
	}
	
	static char[] getValue(char[] name, char[] defaultReturn = "")
	{	
		char[] ret = defaultReturn;
		try
		{
			ret = definitionMap[name];
		}
		catch (Exception e) {}
		return ret;
	}

	/+static char[] getValue(char[] name, Object defaultReturn = null)
	{
		foreach (node;doc.query["DCommonsConfig"][name])
		{
			return node.value;
		}
		return defaultReturn.toString();
	}+/
	/+
	static int getValue(char[] name, int defaultReturn)
	{
		char[] val = getValue(name, tango.text.convert.Integer.toString(defaultReturn));
		return tango.text.convert.Integer.toInt!(char)(val);
	}
	
	static bool getValue(char[] name, bool defaultReturn)
	{
		int ret = getValue(name, defaultReturn ? 1 : 0);
		return ret != 0;
	}
	+/
	static void setValue(char[] name, char[] value)
	{
		definitionMap[name] = value;
	}
	/+
	static void setValue(char[] name, int value)
	{
		setValue(name, tango.text.convert.Integer.toString(value));
	}
	
	static void setValue(char[] name, bool value)
	{
		setValue(name, tango.text.convert.Integer.toString(value != 0 ? 1 : 0));
	}
	+/
	/+static void setValue(char[] name, Object value)
	{
		setValue(name, value.toString());
	}+/
}