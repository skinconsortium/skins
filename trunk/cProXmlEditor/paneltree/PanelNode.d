/**
 * PanelNode.d
 *
 * @author mpdeimos
 * @date 2008/12/28
 */

module paneltree.PanelNode;

import dfl.all;

public class PanelNode: TreeNode
{
	public Panel panel;
	public char[] headline;
	
	public this(char[] name, char[] headline, Panel panel)
	{
		super(name);
		this.panel = panel;
		this.headline = headline;
	}
	
	public ~this()
	{
		delete panel;
	}
}