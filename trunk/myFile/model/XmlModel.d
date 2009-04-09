/**
 * XML Model for myFile
 * 
 * @author mpdeimos
 */

module model.XmlModel;

import tango.io.File;
import tango.io.FilePath;
import tango.text.xml.DocPrinter;
import tango.text.xml.Document;
import tango.util.container.SortedMap;
import tango.util.collection.HashMap;
import tango.core.Array;
import Integer = tango.text.convert.Integer;
import com.skinconsortium.d.model.FileModelBase;

import model.StringUtils;

class XmlModel: FileModelBase
{
	/** The map we store our data in */
	private final SortedMap!(char[], char[]) map;
	
	/** xml root element name */
	private final char[] xmlRoot = "myFileXML";
	
	/** xml tag for file entries */
	private final char[] xmlTag = "fileEntry";
	
	/** xml version */ // TODO make global
	public final char[] xmlVersion = "0.1";
	
	/+/** attributs map */
	public final HashMap!(char[], char[]) attribs;+/
	
	/** filename for exporting */ // TODO add dirty flag
	public char[] exportFilename;
	
	/** title for exporting */ // TODO add dirty flag
	public char[] exportTitle;
	
	public this(char[] filename = null)
	{
		super(filename);
		
		this.map = new SortedMap!(char[], char[])();
		
		if (filename !is null && this.fileExists())
		{
			auto document = new Document!(char);
			File xml = new File (filename);
			document.parse(cast(char[])xml.read());
			fillMap(document);
		}
	}
	
	private void fillMap(Document!(char) document)
	{
		foreach (node; document.query[xmlRoot][xmlTag])
		{
			map.add(xmlEncode!(char)(node.query.attribute("name").nodes[0].value),
				xmlEncode!(char)(node.value));
		}
		try	this.exportFilename = document.query[xmlRoot].attribute("exportFilename").nodes[0].value;
		catch (Exception e) {}		
		try this.exportTitle = document.query[xmlRoot].attribute("exportTitle").nodes[0].value;
		catch (Exception e) {}		
	}
	
	/** saves the current model in xml format */
	public void save()
	{
		assert(filename !is null);
		
		// instanciate xml dom
		auto document = new Document!(char);
		document.header;
		
		// create root element
		auto root = document.root.element(null, xmlRoot)
			.attribute(null, "version", this.xmlVersion)
			.attribute(null, "exportFilename", this.exportFilename)
			.attribute(null, "exportTitle", this.exportTitle);
		
		// render map to xml
		foreach(char[] key, char[] value; map)
		{
			root.element(null, xmlTag, xmlDecode!(char)(value)).attribute(null, "name", xmlDecode!(char)(key));
		}
		
		// create output file if neccessary
		fileExists(true);
		
		// write output file
		auto print = new DocPrinter!(char);
		File xml = new File(filename);
		xml.write(cast(void[])print(document));
		super.save();
	}
	
	/** returns an array of all file entries stored */
	public char[][] getFileEntries()
	{
		char[][] ret;
		ret.length = map.size();
		int i = 0;
		foreach(char[] key, char[] value; map)
		{
			ret[i++] = key;
		}
		return ret;
	}
	
	/** returns the map */
	public SortedMap!(char[], char[]) getMap()
	{
		return this.map;
	}
	
	/** return the value of a named file entry */
	public char[] getValue(char[] key)
	{
		return map[key];
	}
	
	/** sets the value of a named entry. Returns true if inserted, false where an existing key exists and was updated instead */
	public bool setValue(char[] key, char[] value)
	{
		makeDirty();
		return map[key] = value;
	}
	
	/** removes a given key from the model. returns true if key was found, false otherwise. */
	public bool removeKey(char[] key)
	{
		makeDirty();
		return map.removeKey(key);
	}
	
	/** checks if the given key exists in our model, so we prevent overriding */
	public bool containsKey(char[] key)
	{
		return map.containsKey(key);
	}
	
	/** returns an unique name by attaching (1),(2),... to the wished name */
	public char[] makeUnique(char[] key)
	{
		char[] myTag = key.dup;
		if (this.containsKey(key))
		{
			int i = 2;
			while (this.containsKey(key ~ " (" ~ Integer.toString(i) ~ ")"))
			{
				i++;
			}
			myTag = key ~ " (" ~ Integer.toString(i) ~ ")";
		}
		return myTag;
	}
}

