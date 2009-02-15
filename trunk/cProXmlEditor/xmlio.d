module xmlio;

import paneltree.PanelTree;
import paneltree.PanelNode;
import dfl.all;

import Text = tango.text.Util;
import tango.text.xml.Document;
import tango.text.xml.DocPrinter;
import tango.io.File;
debug import tango.io.Stdout;

/** Singleton Class - use getInstance() */
public class XmlIO
{
	private static XmlIO instance = null;
	private PanelTree* nodes;
	
	alias Document!(char) Doc;
	alias Doc.Node Node;
	
	private Doc[] docs;
	
	static this()
	{
		instance = new XmlIO;
	}
	
	public:
	
	static void linkPanelTree(PanelTree* nodes)
	{
		instance.nodes = nodes;
	}
	
	static void populateControls(char[] path)
	{
		instance.populate(path);
	}

	static void saveControls(char[] path)
	{
		auto print = new DocPrinter!(char);
		foreach(doc;instance.docs)
		{
			debug Stdout(print(doc)).newline;
		}
		
		instance.populate(path, false);
	}
	
	private void populate(char[] path, bool read = true)
	{
		debug Stdout("-- populate start").newline;
		
		if (read)
			docs.length = 0;
			
		char[] pos = "+";
		
		int i = 0;
		
		foreach(treenode; nodes.getTree.nodes)
		{
			PanelNode curNode = cast(PanelNode)treenode;
			if (curNode.panel.tag is null)
				continue;
			debug Stdout(pos ~ curNode.text).newline;
			
			// open file
			//@ TODO add exists check
			
			File xml = new File (path ~ "/" ~ curNode.text);
				
			auto doc = new Document!(char);

			if (read)
			{
				doc.parse(cast(char[])xml.read());
				
				// We need to copy each node since the original nodes are not editable!
				foreach(noded;doc.root.children)
				{
					noded.detach;
					doc.root.copy(noded);
				}
				
				doc.header;
			}
			else
			{
				doc = docs[i++];
			}

			Control c = cast(Control)curNode.panel;

			recPopulate(&c, pos.dup, doc.root, read);
			
			foreach(subtreenode;treenode.nodes)
			{
				PanelNode curNode = cast(PanelNode)subtreenode;
				if (curNode.panel.tag is null)
					continue;
				
				Control c = cast(Control)curNode.panel;
				recPopulate(&c, pos.dup, doc.root, read);
			}

			if (read)
			{
				docs.length = docs.length+1;
				docs[$-1] = doc;
			}
			debug Stdout("- file output").newline;
			auto print = new DocPrinter!(char);
			debug Stdout(print(doc)).newline;
			if (!read)
				xml.write(cast(char[])print(doc));
		}
		debug Stdout("-- populate stop").newline;
	}
	
	private:
	
	char[] printRoot(Node node)
	{
		char[] content;
		auto printer = new DocPrinter!(char);
		printer.print (node, (char[][] s...){foreach(t; s) content ~= t;});
		debug Stdout(content).newline;
		return content;
	}
	
	void recPopulate(Control* panel, char[] depth, Node node, bool read = true)
	{
		if (panel.tag is null)
			return;
		
		depth ~= "+";
		char[] tag = panel.tag.toString;
		char[] panelName = panel.name;
		
		// remove the leading underscore if neccessary
		if (panelName.length && panelName[0] == '_')
		{
			panelName = panelName[1..$];
		}

		debug Stdout(depth ~ tag ~ " | curnode: " ~ node.name).newline;
		
		Node next = node;

		if (tag == "value")
		{
			foreach (n;node.children())
			{
				debug Stdout(n.name ~ " - " ~ panelName).newline;
				
				if (n.name == panelName)
				{
					//mixin assign!((panel.text), (n.value), read);
					if (read)
						panel.text = n.value;
					else
					{
						/+auto nn = n.parent.element(null, n.name, panel.text);
						nn.parent.move(n);
						n.detach();+/
						
						// We need to ensure _all_ data nodes get cleared!
						foreach(d;n.children)
						{
							if (d.type is XmlNodeType.Data)
							{
								d.detach();
							}
						}
						// Now we can savely set the value :)
						n.value = panel.text;
					}

					debug Stdout(panelName ~ " : "~ n.value ~ " - " ~ panel.text).newline;
					
					return;
				}
			}
			node.element(null, panelName, panel.text);
		}
		else if (tag == "attrib")
		{	
			if (read)
			{
				auto q = node.query.attribute(panelName);
				
				if (!q.count)
				{
					//attrib hasn't been found :( - let's create it :)
					node.attribute(null, panel.name, panel.text);
					return;
				}
				
				foreach(attr;q)
				{
					panel.text = attr.value;
				}
			}
			else
			{
				foreach(attr;node.query.attribute(panelName))
				{
					attr.value = panel.text;
				}
			}
		}
		else if (tag == "attrib-bool")
		{
			auto checkbox = cast(CheckBox*)panel;	
			if (read)
			{
				auto q = node.query.attribute(panelName);
				
				if (!q.count)
				{
					//attrib hasn't been found :( - let's create it :)
					node.attribute(null, checkbox.name, (checkbox.checked ? "1" : "0"));
					return;
				}
				
				foreach(attr;q)
				{
					checkbox.checked = !(attr.value == "" || attr.value == "0");
				}
			}
			else
			{
				foreach(attr;node.query.attribute(panelName))
				{
					if (checkbox.checked)
						attr.value = "1";
					else
						attr.value = "0";
				}
			}
		}
		else if (tag.length >= 13 && tag[0..13] == "attrib-radio:")
		{
			auto checkbox = cast(RadioButton*)panel;
			char[] attribName = tag[13..Text.locate(tag,'=')];
			char[] attribValue = tag[Text.locate(tag,'=')+1..$];
			if (read)
			{
				auto q = node.query.attribute(attribName);
				
				if (!q.count && checkbox.checked)
				{
					//attrib hasn't been found :( - let's create it :)
					node.attribute(null, attribName, attribValue);
					return;
				}
				
				foreach(attr;q)
				{
					checkbox.checked = attr.value == attribValue;
				}
			}
			else
			{
				if (checkbox.checked)
					foreach(attr;node.query.attribute(attribName))
					{
						attr.value = attribValue;
					}
			}
		}
		else if (tag[0..4] == "blob")
		{
			char[] buf;
			if (tag.length < 5) 			//no query attached
			{
				foreach(n;node.children())
				{
					if (read)
					{
						buf ~= printRoot(n);
					}
					else
					{
						n.detach;
					}
				}
			}
			else							//query given
			{
				foreach(n;node.query.child(tag[5..$]))
				{
					if (read)
					{
						buf ~= printRoot(n);
					}
					else
					{
						n.detach;
					}
				}
			}
			if (read)
				panel.text = buf;
			else
			{
				auto doc = new Doc;
				doc.parse(panel.text);
				foreach(nn;doc.root.children)
				{
					node.copy(nn);
				}
			}
		}
		else if (tag.length >= 5 && tag[0..5] == "node:")
		{
			foreach(level;Text.patterns(tag[5..$], "/"))
			{
				auto query = node.query[level];
				
				if (!query.count)
					node.element(null, level);
				else 
					node = query.nodes[0];
			}
		}
		populate:
		foreach(panel; panel.controls)
		{
			recPopulate(&panel, depth.dup, node, read);
		}
	}
}