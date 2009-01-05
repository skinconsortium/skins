/**
 * PanelTree.d
 *
 * @author mpdeimos
 */
 
module paneltree.PanelTree;
 
import dfl.all;
import tango.io.Stdout;
import paneltree.PanelNode;

public class PanelTree: Panel
{
	private TreeView treeview;
	private GroupBox groupBox;
	private int spacer;
	private int treeWidth;
	
	public this(int treeWidth, int spacer)
	{
		super();
		
		this.spacer = spacer;
		this.treeWidth = treeWidth;
		
		treeview = new TreeView();
		treeview.name = "panelTreeView";
		treeview.dock = dfl.control.DockStyle.LEFT;
		treeview.width = treeWidth;
		treeview.beforeSelect ~= &onBeforeSelect;
		treeview.afterSelect ~= &onAfterSelect;
		treeview.parent = this;
		
		Panel spacerDummy = new Panel;
		spacerDummy.name = "spacerDummy";
		spacerDummy.dock = dfl.control.DockStyle.LEFT;
		spacerDummy.width = spacer;
		spacerDummy.parent = this;
		
		groupBox = new GroupBox();
		groupBox.name = "panelGroupBox";
		groupBox.dock = dfl.control.DockStyle.FILL;
		groupBox.parent = this;
	}
	
	/** adds a new node to the tree. if parent is null a root node is created */
	public void addNode(PanelNode newNode, PanelNode parent = null)
	{
		if (parent is null)
		{
			treeview.nodes.add(cast(TreeNode)newNode);
		}
		else
		{
			parent.nodes.add(cast(TreeNode)newNode);
		}
		
		newNode.panel.hide();
		newNode.panel.dock = dfl.all.DockStyle.FILL;
		groupBox.controls.add(newNode.panel);
		
		treeview.expandAll();
	}
	
	protected void onBeforeSelect(TreeView tv, TreeViewCancelEventArgs args)
	{
		PanelNode pn = cast(PanelNode)(tv.selectedNode);
		if (pn is null) return;
		pn.panel.hide();
	}
	
	protected void onAfterSelect(TreeView tv, TreeViewEventArgs args)
	{
		PanelNode pn = cast(PanelNode)(tv.selectedNode);
		if (pn is null) return;
		groupBox.text = pn.headline;
		pn.panel.show();
	}
	
	override protected void onVisibleChanged(EventArgs ea)
	{
		treeview.expandAll();
		if (treeview.nodes.length)
			treeview.selectedNode(treeview.nodes[0]);
	}
	
	public TreeView getTree()
	{
		return treeview;
	}

}
 