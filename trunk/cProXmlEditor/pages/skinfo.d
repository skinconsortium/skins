module pages.Skinfo;

/*
	Generated by Entice Designer
	Entice Designer written by Christopher E. Miller
	www.dprogramming.com/entice.php
*/

import dfl.all;


class Skinfo: dfl.panel.Panel
{
	// Do not modify or move this block of variables.
	//~Entice Designer variables begin here.
	dfl.panel.Panel skinInfoPanel;
	dfl.groupbox.GroupBox authorInformation;
	dfl.textbox.TextBox author;
	dfl.label.Label label9;
	dfl.label.Label label10;
	dfl.label.Label label11;
	dfl.label.Label label12;
	dfl.textbox.TextBox email;
	dfl.textbox.TextBox homepage;
	dfl.textbox.TextBox comment;
	dfl.panel.Panel spacer;
	dfl.groupbox.GroupBox skinInformation;
	dfl.label.Label label15;
	dfl.label.Label label16;
	dfl.textbox.TextBox name;
	dfl.textbox.TextBox _version;
	dfl.groupbox.GroupBox groupBox9;
	dfl.textbox.TextBox textBox15;
	//~Entice Designer variables end here.
	
	
	this()
	{
		initializeSkinfo();
		
		//@  Other Skinfo initialization code here.
		
		
		textBox15.click ~= &ask;

		
	}
		void ask(Control c,EventArgs ea)
		{
			auto box = (cast(TextBox)c);
			if (box.readOnly)
			{
				auto ret = dfl.messagebox.msgBox(this, 
					"Editing additional includes is not recommended!\nAre you sure you want to edit the additional includes?",
					"Warning",
					dfl.messagebox.MsgBoxButtons.OK_CANCEL,
					dfl.messagebox.MsgBoxIcon.WARNING
				);
				
				if(ret == dfl.base.DialogResult.OK)
				{
					box.readOnly = false;
				}
			}
		}	
	
	private void initializeSkinfo()
	{
		// Do not manually modify this function.
		//~Entice Designer 0.8.5.02 code begins here.
		//~DFL Panel
		tag = new dfl.all.StringObject("node:WinampAbstractionLayer");
		bounds = dfl.all.Rect(0, 0, 400, 312);
		//~DFL dfl.panel.Panel=skinInfoPanel
		skinInfoPanel = new dfl.panel.Panel();
		skinInfoPanel.name = "skinInfoPanel";
		skinInfoPanel.dock = dfl.all.DockStyle.TOP;
		skinInfoPanel.tag = new dfl.all.StringObject("node:skininfo");
		skinInfoPanel.bounds = dfl.all.Rect(0, 0, 400, 216);
		skinInfoPanel.parent = this;
		//~DFL dfl.groupbox.GroupBox=authorInformation
		authorInformation = new dfl.groupbox.GroupBox();
		authorInformation.name = "authorInformation";
		authorInformation.dock = dfl.all.DockStyle.TOP;
		authorInformation.tag = new dfl.all.StringObject("flat");
		authorInformation.text = "Author Information";
		authorInformation.bounds = dfl.all.Rect(0, 0, 400, 124);
		authorInformation.parent = skinInfoPanel;
		//~DFL dfl.textbox.TextBox=author
		author = new dfl.textbox.TextBox();
		author.name = "author";
		author.tag = new dfl.all.StringObject("value");
		author.bounds = dfl.all.Rect(112, 19, 280, 23);
		author.parent = authorInformation;
		//~DFL dfl.label.Label=label9
		label9 = new dfl.label.Label();
		label9.name = "label9";
		label9.text = "Author";
		label9.textAlign = dfl.all.ContentAlignment.MIDDLE_LEFT;
		label9.bounds = dfl.all.Rect(8, 19, 100, 23);
		label9.parent = authorInformation;
		//~DFL dfl.label.Label=label10
		label10 = new dfl.label.Label();
		label10.name = "label10";
		label10.text = "Email";
		label10.textAlign = dfl.all.ContentAlignment.MIDDLE_LEFT;
		label10.bounds = dfl.all.Rect(8, 43, 100, 23);
		label10.parent = authorInformation;
		//~DFL dfl.label.Label=label11
		label11 = new dfl.label.Label();
		label11.name = "label11";
		label11.text = "Homepage";
		label11.textAlign = dfl.all.ContentAlignment.MIDDLE_LEFT;
		label11.bounds = dfl.all.Rect(8, 67, 100, 23);
		label11.parent = authorInformation;
		//~DFL dfl.label.Label=label12
		label12 = new dfl.label.Label();
		label12.name = "label12";
		label12.text = "Comment";
		label12.textAlign = dfl.all.ContentAlignment.MIDDLE_LEFT;
		label12.bounds = dfl.all.Rect(8, 91, 100, 23);
		label12.parent = authorInformation;
		//~DFL dfl.textbox.TextBox=email
		email = new dfl.textbox.TextBox();
		email.name = "email";
		email.tag = new dfl.all.StringObject("value");
		email.bounds = dfl.all.Rect(112, 43, 280, 23);
		email.parent = authorInformation;
		//~DFL dfl.textbox.TextBox=homepage
		homepage = new dfl.textbox.TextBox();
		homepage.name = "homepage";
		homepage.tag = new dfl.all.StringObject("value");
		homepage.bounds = dfl.all.Rect(112, 67, 280, 23);
		homepage.parent = authorInformation;
		//~DFL dfl.textbox.TextBox=comment
		comment = new dfl.textbox.TextBox();
		comment.name = "comment";
		comment.tag = new dfl.all.StringObject("value");
		comment.bounds = dfl.all.Rect(112, 91, 280, 23);
		comment.parent = authorInformation;
		//~DFL dfl.panel.Panel=spacer
		spacer = new dfl.panel.Panel();
		spacer.name = "spacer";
		spacer.dock = dfl.all.DockStyle.TOP;
		spacer.bounds = dfl.all.Rect(0, 124, 400, 6);
		spacer.parent = skinInfoPanel;
		//~DFL dfl.groupbox.GroupBox=skinInformation
		skinInformation = new dfl.groupbox.GroupBox();
		skinInformation.name = "skinInformation";
		skinInformation.dock = dfl.all.DockStyle.TOP;
		skinInformation.tag = new dfl.all.StringObject("flat");
		skinInformation.text = "Skin Information";
		skinInformation.bounds = dfl.all.Rect(0, 130, 400, 76);
		skinInformation.parent = skinInfoPanel;
		//~DFL dfl.label.Label=label15
		label15 = new dfl.label.Label();
		label15.name = "label15";
		label15.text = "Skin Name";
		label15.textAlign = dfl.all.ContentAlignment.MIDDLE_LEFT;
		label15.bounds = dfl.all.Rect(8, 19, 100, 23);
		label15.parent = skinInformation;
		//~DFL dfl.label.Label=label16
		label16 = new dfl.label.Label();
		label16.name = "label16";
		label16.text = "Skin Version";
		label16.textAlign = dfl.all.ContentAlignment.MIDDLE_LEFT;
		label16.bounds = dfl.all.Rect(8, 43, 100, 23);
		label16.parent = skinInformation;
		//~DFL dfl.textbox.TextBox=name
		name = new dfl.textbox.TextBox();
		name.name = "name";
		name.tag = new dfl.all.StringObject("value");
		name.bounds = dfl.all.Rect(112, 19, 280, 23);
		name.parent = skinInformation;
		//~DFL dfl.textbox.TextBox=_version
		_version = new dfl.textbox.TextBox();
		_version.name = "_version";
		_version.tag = new dfl.all.StringObject("value");
		_version.bounds = dfl.all.Rect(112, 43, 280, 23);
		_version.parent = skinInformation;
		//~DFL dfl.groupbox.GroupBox=groupBox9
		groupBox9 = new dfl.groupbox.GroupBox();
		groupBox9.name = "groupBox9";
		groupBox9.dock = dfl.all.DockStyle.FILL;
		groupBox9.tag = new dfl.all.StringObject("flat");
		groupBox9.text = "Additional includes";
		groupBox9.bounds = dfl.all.Rect(0, 216, 400, 96);
		groupBox9.parent = this;
		//~DFL dfl.textbox.TextBox=textBox15
		textBox15 = new dfl.textbox.TextBox();
		textBox15.name = "textBox15";
		textBox15.dock = dfl.all.DockStyle.FILL;
		textBox15.tag = new dfl.all.StringObject("blob:include");
		textBox15.multiline = true;
		textBox15.readOnly = true;
		textBox15.bounds = dfl.all.Rect(8, 19, 384, 69);
		textBox15.parent = groupBox9;
		//~Entice Designer 0.8.5.02 code ends here.
	}
}
