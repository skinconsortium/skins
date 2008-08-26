namespace MusicShowBackgroundCreator
{
    partial class ImageControl
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
            _image.Dispose();
            base.Dispose(disposing);
        }

        #region Component Designer generated code

        /// <summary> 
        /// Required method for Designer support - do not modify 
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(ImageControl));
            this._image = new XtractPro.Multimedia.ImageEdit();
            this.tbrMain = new System.Windows.Forms.ToolStrip();
            this.tbOpen = new System.Windows.Forms.ToolStripButton();
            this.tbSave = new System.Windows.Forms.ToolStripButton();
            this.tbUndo = new System.Windows.Forms.ToolStripButton();
            this.toolStripSeparator1 = new System.Windows.Forms.ToolStripSeparator();
            this.tbRight = new System.Windows.Forms.ToolStripButton();
            this.tbLeft = new System.Windows.Forms.ToolStripButton();
            this.toolStripSeparator2 = new System.Windows.Forms.ToolStripSeparator();
            this.txtPoint = new System.Windows.Forms.ToolStripLabel();
            this.cboZoom = new System.Windows.Forms.ToolStripComboBox();
            this.pnlMain = new System.Windows.Forms.Panel();
            this.pnlInner = new System.Windows.Forms.Panel();
            this.pctMain = new System.Windows.Forms.PictureBox();
            this.tbrMain.SuspendLayout();
            this.pnlMain.SuspendLayout();
            this.pnlInner.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pctMain)).BeginInit();
            this.SuspendLayout();
            // 
            // _image
            // 
            this._image.BorderColor = System.Drawing.Color.White;
            this._image.EndSelection = new System.Drawing.Point(0, 0);
            this._image.Height = 128;
            this._image.MaxSize = 128;
            this._image.MinSize = 128;
            this._image.StartSelection = new System.Drawing.Point(0, 0);
            this._image.TextBackColor = System.Drawing.Color.White;
            this._image.TextFont = new System.Drawing.Font("Arial", 10F);
            this._image.TextForeColor = System.Drawing.Color.Black;
            this._image.TextLocation = new System.Drawing.Point(0, 0);
            this._image.TextStringFormatFlags = System.Drawing.StringFormatFlags.FitBlackBox;
            this._image.Width = 128;
            // 
            // tbrMain
            // 
            this.tbrMain.BackColor = System.Drawing.Color.Transparent;
            this.tbrMain.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.tbOpen,
            this.tbSave,
            this.tbUndo,
            this.toolStripSeparator1,
            this.tbRight,
            this.tbLeft,
            this.toolStripSeparator2,
            this.txtPoint,
            this.cboZoom});
            this.tbrMain.Location = new System.Drawing.Point(0, 0);
            this.tbrMain.Name = "tbrMain";
            this.tbrMain.Size = new System.Drawing.Size(300, 25);
            this.tbrMain.TabIndex = 0;
            this.tbrMain.Text = "toolStrip1";
            // 
            // tbOpen
            // 
            this.tbOpen.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.tbOpen.Image = ((System.Drawing.Image)(resources.GetObject("tbOpen.Image")));
            this.tbOpen.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.tbOpen.Name = "tbOpen";
            this.tbOpen.Size = new System.Drawing.Size(23, 22);
            this.tbOpen.Text = "Open Image File";
            this.tbOpen.Click += new System.EventHandler(this.Command_Click);
            // 
            // tbSave
            // 
            this.tbSave.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.tbSave.Image = ((System.Drawing.Image)(resources.GetObject("tbSave.Image")));
            this.tbSave.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.tbSave.Name = "tbSave";
            this.tbSave.Size = new System.Drawing.Size(23, 22);
            this.tbSave.Text = "Save Changes";
            this.tbSave.Click += new System.EventHandler(this.Command_Click);
            // 
            // tbUndo
            // 
            this.tbUndo.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.tbUndo.Image = ((System.Drawing.Image)(resources.GetObject("tbUndo.Image")));
            this.tbUndo.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.tbUndo.Name = "tbUndo";
            this.tbUndo.Size = new System.Drawing.Size(23, 22);
            this.tbUndo.Text = "Undo Last Change";
            this.tbUndo.Click += new System.EventHandler(this.Command_Click);
            // 
            // toolStripSeparator1
            // 
            this.toolStripSeparator1.Name = "toolStripSeparator1";
            this.toolStripSeparator1.Size = new System.Drawing.Size(6, 25);
            // 
            // tbRight
            // 
            this.tbRight.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.tbRight.Image = ((System.Drawing.Image)(resources.GetObject("tbRight.Image")));
            this.tbRight.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.tbRight.Name = "tbRight";
            this.tbRight.Size = new System.Drawing.Size(23, 22);
            this.tbRight.Text = "Rotate Clockwise";
            this.tbRight.Click += new System.EventHandler(this.Command_Click);
            // 
            // tbLeft
            // 
            this.tbLeft.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.tbLeft.Image = ((System.Drawing.Image)(resources.GetObject("tbLeft.Image")));
            this.tbLeft.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.tbLeft.Name = "tbLeft";
            this.tbLeft.Size = new System.Drawing.Size(23, 22);
            this.tbLeft.Text = "Rotate Counterclockwise";
            this.tbLeft.Click += new System.EventHandler(this.Command_Click);
            // 
            // toolStripSeparator2
            // 
            this.toolStripSeparator2.Name = "toolStripSeparator2";
            this.toolStripSeparator2.Size = new System.Drawing.Size(6, 25);
            // 
            // txtPoint
            // 
            this.txtPoint.AutoSize = false;
            this.txtPoint.Name = "txtPoint";
            this.txtPoint.Size = new System.Drawing.Size(65, 22);
            this.txtPoint.Text = "0, 0";
            // 
            // cboZoom
            // 
            this.cboZoom.AutoSize = false;
            this.cboZoom.Items.AddRange(new object[] {
            "Size To Fit",
            "100%",
            "200%",
            "300%",
            "500%",
            "80%",
            "60%",
            "50%",
            "30%",
            "10%"});
            this.cboZoom.Name = "cboZoom";
            this.cboZoom.Size = new System.Drawing.Size(75, 23);
            this.cboZoom.Text = "100%";
            this.cboZoom.SelectedIndexChanged += new System.EventHandler(this.cboZoom_SelectedIndexChanged);
            this.cboZoom.KeyDown += new System.Windows.Forms.KeyEventHandler(this.cboZoom_KeyDown);
            // 
            // pnlMain
            // 
            this.pnlMain.AutoScroll = true;
            this.pnlMain.BackColor = System.Drawing.SystemColors.ControlDark;
            this.pnlMain.Controls.Add(this.pnlInner);
            this.pnlMain.Dock = System.Windows.Forms.DockStyle.Fill;
            this.pnlMain.Location = new System.Drawing.Point(0, 25);
            this.pnlMain.Name = "pnlMain";
            this.pnlMain.Size = new System.Drawing.Size(300, 275);
            this.pnlMain.TabIndex = 1;
            this.pnlMain.Resize += new System.EventHandler(this.pnlMain_Resize);
            // 
            // pnlInner
            // 
            this.pnlInner.AutoScroll = true;
            this.pnlInner.BackColor = System.Drawing.SystemColors.ControlDark;
            this.pnlInner.Controls.Add(this.pctMain);
            this.pnlInner.Dock = System.Windows.Forms.DockStyle.Fill;
            this.pnlInner.Location = new System.Drawing.Point(0, 0);
            this.pnlInner.Name = "pnlInner";
            this.pnlInner.Size = new System.Drawing.Size(300, 275);
            this.pnlInner.TabIndex = 0;
            // 
            // pctMain
            // 
            this.pctMain.BackColor = System.Drawing.SystemColors.Control;
            this.pctMain.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.pctMain.Dock = System.Windows.Forms.DockStyle.Fill;
            this.pctMain.Location = new System.Drawing.Point(0, 0);
            this.pctMain.Name = "pctMain";
            this.pctMain.Size = new System.Drawing.Size(300, 275);
            this.pctMain.SizeMode = System.Windows.Forms.PictureBoxSizeMode.CenterImage;
            this.pctMain.TabIndex = 0;
            this.pctMain.TabStop = false;
            this.pctMain.MouseMove += new System.Windows.Forms.MouseEventHandler(this.pctMain_MouseMove);
            this.pctMain.MouseDown += new System.Windows.Forms.MouseEventHandler(this.pctMain_MouseDown);
            this.pctMain.MouseUp += new System.Windows.Forms.MouseEventHandler(this.pctMain_MouseUp);
            // 
            // ImageControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.pnlMain);
            this.Controls.Add(this.tbrMain);
            this.Name = "ImageControl";
            this.Size = new System.Drawing.Size(300, 300);
            this.tbrMain.ResumeLayout(false);
            this.tbrMain.PerformLayout();
            this.pnlMain.ResumeLayout(false);
            this.pnlInner.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.pctMain)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.ToolStrip tbrMain;
        private System.Windows.Forms.Panel pnlMain;
        private System.Windows.Forms.Panel pnlInner;
        private System.Windows.Forms.PictureBox pctMain;
        private System.Windows.Forms.ToolStripButton tbSave;
        private System.Windows.Forms.ToolStripButton tbRight;
        private System.Windows.Forms.ToolStripButton tbLeft;
        private System.Windows.Forms.ToolStripLabel txtPoint;
        private System.Windows.Forms.ToolStripComboBox cboZoom;
        private System.Windows.Forms.ToolStripButton tbOpen;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator1;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator2;
        private System.Windows.Forms.ToolStripButton tbUndo;
        private ImageEdit _image;
    }
}
