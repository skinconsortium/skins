module xmlio;

import dfl.treeview;
import paneltree.PanelTree;
import paneltree.PanelNode;
import dfl.control;

import tango.text.xml.Document;
import tango.text.xml.DocPrinter;
import tango.io.File;
import tango.io.Stdout;

/** Singleton Class - use getInstance() */
public class XmlIO
{
	private static XmlIO instance = null;
	private PanelTree* nodes;
	
	alias Document!(char) Doc;
	alias Doc.Node Node;
	
	private Doc[] docs;
	
	private this() {}
	
	public:
	
	static XmlIO get()
	{
		if (instance is null)
			instance = new XmlIO;
			
		return instance;
	}
	
	void linkPanelTree(PanelTree* nodes)
	{
		this.nodes = nodes;
	}
	
	void populateControls(char[] path)
	{
		populate(path);
	}

	void saveControls(char[] path)
	{
		auto print = new DocPrinter!(char);
		foreach(doc;docs)
		{
			Stdout(print(doc)).newline;
		}
		
		populate(path, false);
	}
	
	private void populate(char[] path, bool read = true)
	{
		Stdout("-- populate start").newline;
		
		if (read)
			docs.length = 0;
			
		char[] pos = "+";
		
		foreach(treenode; nodes.getTree.nodes)
		{
			PanelNode curNode = cast(PanelNode)treenode;
			if (curNode.panel.tag is null)
				continue;
			Stdout(pos ~ curNode.text).newline;
			
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
				doc = docs[0];
			}

			Control c = cast(Control)curNode.panel;

			recPopulate(&c, pos.dup, doc.root, read);

			if (read)
			{
				docs.length = docs.length+1;
				docs[$-1] = doc;
			}
			Stdout("- file output").newline;
			auto print = new DocPrinter!(char);
			Stdout(print(doc)).newline;
			if (!read)
				xml.write(cast(char[])print(doc));
		}
		Stdout("-- populate stop").newline;
	}
	
	private:
	
	char[] printRoot(Node node)
	{
		char[] content;
		auto printer = new DocPrinter!(char);
		printer.print (node, (char[][] s...){foreach(t; s) content ~= t;});
		Stdout(content).newline;
		return content;
	}
	
	void recPopulate(Control* panel, char[] depth, Node node, bool read = true)
	{
		if (panel.tag is null)
			return;
		
		depth ~= "+";
		char[] tag = panel.tag.toString;

		Stdout(depth ~ tag ~ " | curnode: " ~ node.name).newline;
		
		Node next = node;

		if (tag == "value")
		{
			foreach (n;node.children())
			{
				Stdout(n.name ~ " - " ~ panel.name).newline;
				
				if (n.name == panel.name)
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
						
					Stdout(panel.name ~ " : "~ n.value ~ " - " ~ panel.text).newline;

					return;
				}
			}
			node.element(null, panel.name, panel.text);
		}
		if (tag[0..4] == "blob")
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
			foreach (n;node.children())
			{
				if (n.name() == tag[5..$])
				{
					node = n;
					goto populate;
				}
			}
			node.element(null, tag[5..$]); 
		}
		populate:
		foreach(panel; panel.controls)
		{
			recPopulate(&panel, depth.dup, node, read);
		}
	}
}