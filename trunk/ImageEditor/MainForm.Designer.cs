namespace XtractPro.Multimedia
{
    partial class MainForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            imgMain.Dispose();
            imgThumb.Dispose();
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(MainForm));
            this.mnuMain = new System.Windows.Forms.MenuStrip();
            this.mnuFile = new System.Windows.Forms.ToolStripMenuItem();
            this.mnuFileOpen = new System.Windows.Forms.ToolStripMenuItem();
            this.mnuFileSave = new System.Windows.Forms.ToolStripMenuItem();
            this.mnuFileSaveAs = new System.Windows.Forms.ToolStripMenuItem();
            this.mnuFileSep1 = new System.Windows.Forms.ToolStripSeparator();
            this.mnuFileExit = new System.Windows.Forms.ToolStripMenuItem();
            this.editToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.undo = new System.Windows.Forms.ToolStripMenuItem();
            this.mirrortype = new System.Windows.Forms.ToolStripMenuItem();
            this.mtbrightness = new System.Windows.Forms.ToolStripMenuItem();
            this.mtgradient = new System.Windows.Forms.ToolStripMenuItem();
            this.filterToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.filterbrightness = new System.Windows.Forms.ToolStripMenuItem();
            this.filtercontrast = new System.Windows.Forms.ToolStripMenuItem();
            this.filtercolor = new System.Windows.Forms.ToolStripMenuItem();
            this.filtergamma = new System.Windows.Forms.ToolStripMenuItem();
            this.filtergray = new System.Windows.Forms.ToolStripMenuItem();
            this.filterinvert = new System.Windows.Forms.ToolStripMenuItem();
            this.sbrMain = new System.Windows.Forms.StatusStrip();
            this.splMain = new System.Windows.Forms.SplitContainer();
            this.splProps = new System.Windows.Forms.SplitContainer();
            this.imgMain = new XtractPro.Multimedia.ImageControl();
            this.imageEdit1 = new XtractPro.Multimedia.ImageEdit();
            this.imgThumb = new XtractPro.Multimedia.ThumbnailControl();
            this.imageEdit2 = new XtractPro.Multimedia.ImageEdit();
            this.propGrid = new System.Windows.Forms.PropertyGrid();
            this.toolStripSeparator1 = new System.Windows.Forms.ToolStripSeparator();
            this.toolStripSeparator2 = new System.Windows.Forms.ToolStripSeparator();
            this.mnuMain.SuspendLayout();
            this.splMain.Panel1.SuspendLayout();
            this.splMain.Panel2.SuspendLayout();
            this.splMain.SuspendLayout();
            this.splProps.Panel1.SuspendLayout();
            this.splProps.Panel2.SuspendLayout();
            this.splProps.SuspendLayout();
            this.SuspendLayout();
            // 
            // mnuMain
            // 
            this.mnuMain.BackgroundImage = ((System.Drawing.Image)(resources.GetObject("mnuMain.BackgroundImage")));
            this.mnuMain.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.mnuFile,
            this.editToolStripMenuItem,
            this.filterToolStripMenuItem});
            this.mnuMain.Location = new System.Drawing.Point(0, 0);
            this.mnuMain.Name = "mnuMain";
            this.mnuMain.Size = new System.Drawing.Size(796, 24);
            this.mnuMain.TabIndex = 0;
            this.mnuMain.Text = "menuStrip1";
            // 
            // mnuFile
            // 
            this.mnuFile.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.mnuFileOpen,
            this.mnuFileSave,
            this.mnuFileSaveAs,
            this.mnuFileSep1,
            this.mnuFileExit});
            this.mnuFile.Name = "mnuFile";
            this.mnuFile.Size = new System.Drawing.Size(39, 20);
            this.mnuFile.Text = "&File";
            this.mnuFile.DropDownOpening += new System.EventHandler(this.mnuFile_DropDownOpening);
            // 
            // mnuFileOpen
            // 
            this.mnuFileOpen.Name = "mnuFileOpen";
            this.mnuFileOpen.Size = new System.Drawing.Size(152, 22);
            this.mnuFileOpen.Text = "&Open...";
            this.mnuFileOpen.Click += new System.EventHandler(this.Command_Click);
            // 
            // mnuFileSave
            // 
            this.mnuFileSave.Name = "mnuFileSave";
            this.mnuFileSave.Size = new System.Drawing.Size(152, 22);
            this.mnuFileSave.Text = "&Save";
            this.mnuFileSave.Click += new System.EventHandler(this.Command_Click);
            // 
            // mnuFileSaveAs
            // 
            this.mnuFileSaveAs.Name = "mnuFileSaveAs";
            this.mnuFileSaveAs.Size = new System.Drawing.Size(152, 22);
            this.mnuFileSaveAs.Text = "Save &As...";
            this.mnuFileSaveAs.Click += new System.EventHandler(this.Command_Click);
            // 
            // mnuFileSep1
            // 
            this.mnuFileSep1.Name = "mnuFileSep1";
            this.mnuFileSep1.Size = new System.Drawing.Size(149, 6);
            // 
            // mnuFileExit
            // 
            this.mnuFileExit.Name = "mnuFileExit";
            this.mnuFileExit.Size = new System.Drawing.Size(152, 22);
            this.mnuFileExit.Text = "E&xit";
            this.mnuFileExit.Click += new System.EventHandler(this.Command_Click);
            // 
            // editToolStripMenuItem
            // 
            this.editToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.undo,
            this.mirrortype});
            this.editToolStripMenuItem.Name = "editToolStripMenuItem";
            this.editToolStripMenuItem.Size = new System.Drawing.Size(40, 20);
            this.editToolStripMenuItem.Text = "Edit";
            // 
            // undo
            // 
            this.undo.Name = "undo";
            this.undo.Size = new System.Drawing.Size(152, 22);
            this.undo.Text = "Undo";
            // 
            // mirrortype
            // 
            this.mirrortype.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.mtbrightness,
            this.mtgradient});
            this.mirrortype.Name = "mirrortype";
            this.mirrortype.Size = new System.Drawing.Size(152, 22);
            this.mirrortype.Text = "Mirror Type";
            // 
            // mtbrightness
            // 
            this.mtbrightness.Name = "mtbrightness";
            this.mtbrightness.Size = new System.Drawing.Size(152, 22);
            this.mtbrightness.Text = "Brightness";
            // 
            // mtgradient
            // 
            this.mtgradient.Name = "mtgradient";
            this.mtgradient.Size = new System.Drawing.Size(152, 22);
            this.mtgradient.Text = "Gradient";
            // 
            // filterToolStripMenuItem
            // 
            this.filterToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.filterbrightness,
            this.filtercontrast,
            this.toolStripSeparator1,
            this.filtercolor,
            this.filtergamma,
            this.toolStripSeparator2,
            this.filtergray,
            this.filterinvert});
            this.filterToolStripMenuItem.Name = "filterToolStripMenuItem";
            this.filterToolStripMenuItem.Size = new System.Drawing.Size(46, 20);
            this.filterToolStripMenuItem.Text = "Filter";
            // 
            // filterbrightness
            // 
            this.filterbrightness.Name = "filterbrightness";
            this.filterbrightness.Size = new System.Drawing.Size(152, 22);
            this.filterbrightness.Text = "Brightness";
            // 
            // filtercontrast
            // 
            this.filtercontrast.Name = "filtercontrast";
            this.filtercontrast.Size = new System.Drawing.Size(152, 22);
            this.filtercontrast.Text = "Contrast";
            // 
            // filtercolor
            // 
            this.filtercolor.Name = "filtercolor";
            this.filtercolor.Size = new System.Drawing.Size(152, 22);
            this.filtercolor.Text = "Color";
            // 
            // filtergamma
            // 
            this.filtergamma.Name = "filtergamma";
            this.filtergamma.Size = new System.Drawing.Size(152, 22);
            this.filtergamma.Text = "Gamma";
            // 
            // filtergray
            // 
            this.filtergray.Name = "filtergray";
            this.filtergray.Size = new System.Drawing.Size(152, 22);
            this.filtergray.Text = "Grayscale";
            // 
            // filterinvert
            // 
            this.filterinvert.Name = "filterinvert";
            this.filterinvert.Size = new System.Drawing.Size(152, 22);
            this.filterinvert.Text = "Invert";
            // 
            // sbrMain
            // 
            this.sbrMain.Location = new System.Drawing.Point(0, 584);
            this.sbrMain.Name = "sbrMain";
            this.sbrMain.Size = new System.Drawing.Size(796, 22);
            this.sbrMain.TabIndex = 2;
            this.sbrMain.Text = "statusStrip1";
            // 
            // splMain
            // 
            this.splMain.Dock = System.Windows.Forms.DockStyle.Fill;
            this.splMain.Location = new System.Drawing.Point(0, 24);
            this.splMain.Name = "splMain";
            // 
            // splMain.Panel1
            // 
            this.splMain.Panel1.Controls.Add(this.imgMain);
            // 
            // splMain.Panel2
            // 
            this.splMain.Panel2.Controls.Add(this.splProps);
            this.splMain.Size = new System.Drawing.Size(796, 560);
            this.splMain.SplitterDistance = 549;
            this.splMain.TabIndex = 3;
            // 
            // splProps
            // 
            this.splProps.Dock = System.Windows.Forms.DockStyle.Fill;
            this.splProps.Location = new System.Drawing.Point(0, 0);
            this.splProps.Name = "splProps";
            this.splProps.Orientation = System.Windows.Forms.Orientation.Horizontal;
            // 
            // splProps.Panel1
            // 
            this.splProps.Panel1.Controls.Add(this.imgThumb);
            // 
            // splProps.Panel2
            // 
            this.splProps.Panel2.Controls.Add(this.propGrid);
            this.splProps.Size = new System.Drawing.Size(243, 560);
            this.splProps.SplitterDistance = 169;
            this.splProps.TabIndex = 0;
            // 
            // imgMain
            // 
            this.imgMain.BackgroundImage = ((System.Drawing.Image)(resources.GetObject("imgMain.BackgroundImage")));
            this.imgMain.Dock = System.Windows.Forms.DockStyle.Fill;
            this.imgMain.Image = this.imageEdit1;
            this.imgMain.Location = new System.Drawing.Point(0, 0);
            this.imgMain.Name = "imgMain";
            this.imgMain.Size = new System.Drawing.Size(549, 560);
            this.imgMain.TabIndex = 0;
            this.imgMain.Load += new System.EventHandler(this.imgMain_Load);
            this.imgMain.OnChange += new System.EventHandler(this.ImageControl_OnChange);
            // 
            // imageEdit1
            // 
            this.imageEdit1.BorderColor = System.Drawing.Color.Yellow;
            this.imageEdit1.EndSelection = new System.Drawing.Point(0, 0);
            this.imageEdit1.Height = 128;
            this.imageEdit1.MaxSize = 128;
            this.imageEdit1.MinSize = 128;
            this.imageEdit1.StartSelection = new System.Drawing.Point(0, 0);
            this.imageEdit1.TextBackColor = System.Drawing.Color.White;
            this.imageEdit1.TextFont = new System.Drawing.Font("Arial", 10F);
            this.imageEdit1.TextForeColor = System.Drawing.Color.Black;
            this.imageEdit1.TextLocation = new System.Drawing.Point(0, 0);
            this.imageEdit1.TextStringFormatFlags = System.Drawing.StringFormatFlags.FitBlackBox;
            this.imageEdit1.Width = 128;
            // 
            // imgThumb
            // 
            this.imgThumb.Dock = System.Windows.Forms.DockStyle.Fill;
            this.imgThumb.Location = new System.Drawing.Point(0, 0);
            this.imgThumb.Name = "imgThumb";
            this.imgThumb.Size = new System.Drawing.Size(243, 169);
            this.imgThumb.TabIndex = 0;
            this.imgThumb.Thumbnail = this.imageEdit2;
            // 
            // imageEdit2
            // 
            this.imageEdit2.BorderColor = System.Drawing.Color.Yellow;
            this.imageEdit2.EndSelection = new System.Drawing.Point(0, 0);
            this.imageEdit2.Height = 128;
            this.imageEdit2.MaxSize = 128;
            this.imageEdit2.MinSize = 128;
            this.imageEdit2.StartSelection = new System.Drawing.Point(0, 0);
            this.imageEdit2.TextBackColor = System.Drawing.Color.White;
            this.imageEdit2.TextFont = new System.Drawing.Font("Arial", 10F);
            this.imageEdit2.TextForeColor = System.Drawing.Color.Black;
            this.imageEdit2.TextLocation = new System.Drawing.Point(0, 0);
            this.imageEdit2.TextStringFormatFlags = System.Drawing.StringFormatFlags.FitBlackBox;
            this.imageEdit2.Width = 128;
            // 
            // propGrid
            // 
            this.propGrid.Dock = System.Windows.Forms.DockStyle.Fill;
            this.propGrid.Location = new System.Drawing.Point(0, 0);
            this.propGrid.Name = "propGrid";
            this.propGrid.Size = new System.Drawing.Size(243, 387);
            this.propGrid.TabIndex = 0;
            // 
            // toolStripSeparator1
            // 
            this.toolStripSeparator1.Name = "toolStripSeparator1";
            this.toolStripSeparator1.Size = new System.Drawing.Size(149, 6);
            // 
            // toolStripSeparator2
            // 
            this.toolStripSeparator2.Name = "toolStripSeparator2";
            this.toolStripSeparator2.Size = new System.Drawing.Size(149, 6);
            // 
            // MainForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(796, 606);
            this.Controls.Add(this.splMain);
            this.Controls.Add(this.sbrMain);
            this.Controls.Add(this.mnuMain);
            this.MainMenuStrip = this.mnuMain;
            this.Name = "MainForm";
            this.Text = "MusicShow Background Creator";
            this.Load += new System.EventHandler(this.MainForm_Load);
            this.mnuMain.ResumeLayout(false);
            this.mnuMain.PerformLayout();
            this.splMain.Panel1.ResumeLayout(false);
            this.splMain.Panel2.ResumeLayout(false);
            this.splMain.ResumeLayout(false);
            this.splProps.Panel1.ResumeLayout(false);
            this.splProps.Panel2.ResumeLayout(false);
            this.splProps.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.MenuStrip mnuMain;
        private System.Windows.Forms.StatusStrip sbrMain;
        private System.Windows.Forms.SplitContainer splMain;
        private System.Windows.Forms.SplitContainer splProps;
        private ThumbnailControl imgThumb;
        private ImageControl imgMain;
        private System.Windows.Forms.ToolStripMenuItem mnuFile;
        private System.Windows.Forms.ToolStripMenuItem mnuFileOpen;
        private System.Windows.Forms.ToolStripSeparator mnuFileSep1;
        private System.Windows.Forms.ToolStripMenuItem mnuFileExit;
        private System.Windows.Forms.ToolStripMenuItem mnuFileSave;
        private System.Windows.Forms.ToolStripMenuItem mnuFileSaveAs;
        private ImageEdit imageEdit1;
        private ImageEdit imageEdit2;
        private System.Windows.Forms.ToolStripMenuItem editToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem undo;
        private System.Windows.Forms.ToolStripMenuItem mirrortype;
        private System.Windows.Forms.ToolStripMenuItem mtbrightness;
        private System.Windows.Forms.ToolStripMenuItem mtgradient;
        private System.Windows.Forms.ToolStripMenuItem filterToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem filterbrightness;
        private System.Windows.Forms.ToolStripMenuItem filtercontrast;
        private System.Windows.Forms.ToolStripMenuItem filtercolor;
        private System.Windows.Forms.ToolStripMenuItem filtergamma;
        private System.Windows.Forms.ToolStripMenuItem filtergray;
        private System.Windows.Forms.ToolStripMenuItem filterinvert;
        private System.Windows.Forms.PropertyGrid propGrid;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator1;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator2;
    }
}

