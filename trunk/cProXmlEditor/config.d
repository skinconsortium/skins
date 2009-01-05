module config;

import tango.text.xml.Document;
import tango.text.xml.DocPrinter;
import tango.io.FilePath;
import tango.io.File;
import tango.io.Stdout;

Document!(char) cdoc;

/**
 * ConfigFile
 *
 * Creates and handlex a config.xml file within the exe directory.
 *
 * @author mpdeimos
 */
public class ConfigFile
{
	private static const char[] configFilename = "config.xml";
	
	private static Document!(char) doc;
	private static File file;
	
	/** static constructor - loads/creates the xml document */
	static this()
	{
		auto fp = FilePath("").file(configFilename);
		bool existed = fp.exists;
		if (!existed)
		{
			fp.createFile;
		}
	
		file = new File(configFilename);
		doc = new Document!(char);
		doc.header;
		
		if (!existed)
		{
			auto print = new DocPrinter!(char);
			file.write(cast(void[])print(doc));
		}
		
		doc.parse(cast(char[])file.read());
		doc.header;		
	}
	
	/** static destructor - saves the file on program termination */
	static ~this()
	{
		auto print = new DocPrinter!(char);
		file.write(cast(void[])print(doc));		
	}
	
	static char[] getValue(char[] name, char[] defaultReturn = "")
	{
		foreach (node;doc.query["cProXmlEditorConfig"][name])
		{
			return node.value;
		}
		return defaultReturn;
	}
	
	static int getValue(char[] name, int defaultReturn)
	{
		char[] val = getValue(name, tango.text.convert.Integer.toString(defaultReturn));
		return tango.text.convert.Integer.toInt!(char)(val);
	}
	
	static void setValue(char[] name, char[] value)
	{
		if (!doc.query["cProXmlEditorConfig"].count)
			doc.root.element(null, "cProXmlEditorConfig");
		
		foreach(node;doc.query["cProXmlEditorConfig"])
		{
			auto q = node.query[name];
			foreach(node2;q)
				node2.detach;
				
			node.element(null, name, value);
		}
	}
	
	static void setValue(char[] name, int value)
	{
		setValue(name, tango.text.convert.Integer.toString(value));
	}
}