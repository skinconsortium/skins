module pages.test;

import paneltree.PanelTree;

class TestPanel: dfl.panel.Panel
{	
	PanelTree listView1;
	this()
	{
		name = "TetsPanel";
		bounds = dfl.all.Rect(0, 0, 368, 328);
		
		listView1 = new PanelTree(100, 10);
		listView1.name = "listView1";
		listView1.dock = dfl.all.DockStyle.FILL;
		listView1.parent = this;		
		
	}
}