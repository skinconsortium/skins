namespace XtractPro.Multimedia
{
    partial class ThumbnailControl
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
            _thumbnail.Dispose();
            base.Dispose(disposing);
        }

        #region Component Designer generated code

        /// <summary> 
        /// Required method for Designer support - do not modify 
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            _thumbnail = new ImageEdit();
            this.pnlMain = new System.Windows.Forms.Panel();
            this.pnlInner = new System.Windows.Forms.Panel();
            this.pctMain = new System.Windows.Forms.PictureBox();
            this.pnlMain.SuspendLayout();
            this.pnlInner.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pctMain)).BeginInit();
            this.SuspendLayout();
            // 
            // pnlMain
            // 
            this.pnlMain.AutoScroll = true;
            this.pnlMain.BackColor = System.Drawing.SystemColors.ControlDark;
            this.pnlMain.Controls.Add(this.pnlInner);
            this.pnlMain.Dock = System.Windows.Forms.DockStyle.Fill;
            this.pnlMain.Location = new System.Drawing.Point(0, 0);
            this.pnlMain.Name = "pnlMain";
            this.pnlMain.Size = new System.Drawing.Size(300, 300);
            this.pnlMain.TabIndex = 1;
            this.pnlMain.Resize += new System.EventHandler(this.pnlMain_Resize);
            // 
            // pnlInner
            // 
            this.pnlInner.AutoScroll = true;
            this.pnlInner.BackColor = System.Drawing.SystemColors.ControlDark;
            this.pnlInner.Controls.Add(this.pctMain);
            this.pnlInner.Location = new System.Drawing.Point(0, 0);
            this.pnlInner.Name = "pnlInner";
            this.pnlInner.Size = new System.Drawing.Size(300, 300);
            this.pnlInner.TabIndex = 0;
            // 
            // pctMain
            // 
            this.pctMain.BackColor = System.Drawing.SystemColors.Control;
            this.pctMain.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.pctMain.Dock = System.Windows.Forms.DockStyle.Fill;
            this.pctMain.Location = new System.Drawing.Point(0, 0);
            this.pctMain.Name = "pctMain";
            this.pctMain.Size = new System.Drawing.Size(300, 300);
            this.pctMain.SizeMode = System.Windows.Forms.PictureBoxSizeMode.CenterImage;
            this.pctMain.TabIndex = 0;
            this.pctMain.TabStop = false;
            // 
            // ThumbnailControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.pnlMain);
            this.Name = "ThumbnailControl";
            this.Size = new System.Drawing.Size(300, 300);
            this.pnlMain.ResumeLayout(false);
            this.pnlInner.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.pctMain)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Panel pnlMain;
        private System.Windows.Forms.Panel pnlInner;
        private System.Windows.Forms.PictureBox pctMain;
        private ImageEdit _thumbnail;
    }
}
