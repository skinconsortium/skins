using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;

namespace MusicShowBackgroundCreator
{
	/// <summary>
	/// Summary description for ColorInput.
	/// </summary>
	public class ColorInput : System.Windows.Forms.Form
	{
		private System.Windows.Forms.TextBox Blue;
		private System.Windows.Forms.Label label4;
		private System.Windows.Forms.TextBox Green;
		private System.Windows.Forms.Label label3;
		private System.Windows.Forms.TextBox Red;
		private System.Windows.Forms.Label label2;
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.Button OK;
		private System.Windows.Forms.Button Cancel;
        private TrackBar red_track;
        private TrackBar green_track;
        private TrackBar blue_track;
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.Container components = null;

		public ColorInput()
		{
			//
			// Required for Windows Form Designer support
			//
			InitializeComponent();

			OK.DialogResult = System.Windows.Forms.DialogResult.OK;
		}

		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		protected override void Dispose( bool disposing )
		{
			if( disposing )
			{
				if(components != null)
				{
					components.Dispose();
				}
			}
			base.Dispose( disposing );
		}

		public int red
		{
			get 
			{
				return (Convert.ToInt32(Red.Text, 10));
			}
			set{Red.Text = value.ToString();}
		}

		public int green
		{
			get 
			{
				return (Convert.ToInt32(Green.Text, 10));
			}
			set{Green.Text = value.ToString();}
		}

		public int blue
		{
			get 
			{
				return (Convert.ToInt32(Blue.Text, 10));
			}
			set{Blue.Text = value.ToString();}
		}

		#region Windows Form Designer generated code
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
            this.Blue = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            this.Green = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.Red = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.OK = new System.Windows.Forms.Button();
            this.Cancel = new System.Windows.Forms.Button();
            this.red_track = new System.Windows.Forms.TrackBar();
            this.green_track = new System.Windows.Forms.TrackBar();
            this.blue_track = new System.Windows.Forms.TrackBar();
            ((System.ComponentModel.ISupportInitialize)(this.red_track)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.green_track)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.blue_track)).BeginInit();
            this.SuspendLayout();
            // 
            // Blue
            // 
            this.Blue.Location = new System.Drawing.Point(113, 158);
            this.Blue.Name = "Blue";
            this.Blue.Size = new System.Drawing.Size(100, 20);
            this.Blue.TabIndex = 17;
            this.Blue.Text = "0";
            // 
            // label4
            // 
            this.label4.Location = new System.Drawing.Point(75, 161);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(32, 16);
            this.label4.TabIndex = 16;
            this.label4.Text = "Blue";
            // 
            // Green
            // 
            this.Green.Location = new System.Drawing.Point(113, 103);
            this.Green.Name = "Green";
            this.Green.Size = new System.Drawing.Size(100, 20);
            this.Green.TabIndex = 15;
            this.Green.Text = "0";
            // 
            // label3
            // 
            this.label3.Location = new System.Drawing.Point(75, 106);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(32, 16);
            this.label3.TabIndex = 14;
            this.label3.Text = "Green";
            // 
            // Red
            // 
            this.Red.Location = new System.Drawing.Point(113, 45);
            this.Red.Name = "Red";
            this.Red.Size = new System.Drawing.Size(100, 20);
            this.Red.TabIndex = 13;
            this.Red.Text = "0";
            // 
            // label2
            // 
            this.label2.Location = new System.Drawing.Point(75, 48);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(32, 16);
            this.label2.TabIndex = 12;
            this.label2.Text = "Red";
            // 
            // label1
            // 
            this.label1.Location = new System.Drawing.Point(16, 16);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(184, 24);
            this.label1.TabIndex = 11;
            this.label1.Text = "Enter values between -255 and 255";
            // 
            // OK
            // 
            this.OK.Location = new System.Drawing.Point(113, 217);
            this.OK.Name = "OK";
            this.OK.Size = new System.Drawing.Size(75, 23);
            this.OK.TabIndex = 10;
            this.OK.Text = "OK";
            // 
            // Cancel
            // 
            this.Cancel.Location = new System.Drawing.Point(200, 217);
            this.Cancel.Name = "Cancel";
            this.Cancel.Size = new System.Drawing.Size(75, 23);
            this.Cancel.TabIndex = 9;
            this.Cancel.Text = "Cancel";
            // 
            // red_track
            // 
            this.red_track.AutoSize = false;
            this.red_track.LargeChange = 10;
            this.red_track.Location = new System.Drawing.Point(12, 67);
            this.red_track.Maximum = 255;
            this.red_track.Minimum = -255;
            this.red_track.Name = "red_track";
            this.red_track.Size = new System.Drawing.Size(300, 20);
            this.red_track.TabIndex = 18;
            this.red_track.TickStyle = System.Windows.Forms.TickStyle.None;
            this.red_track.Scroll += new System.EventHandler(this.red_track_Scroll);
            // 
            // green_track
            // 
            this.green_track.AutoSize = false;
            this.green_track.LargeChange = 10;
            this.green_track.Location = new System.Drawing.Point(12, 125);
            this.green_track.Maximum = 255;
            this.green_track.Minimum = -255;
            this.green_track.Name = "green_track";
            this.green_track.Size = new System.Drawing.Size(300, 20);
            this.green_track.TabIndex = 19;
            this.green_track.TickStyle = System.Windows.Forms.TickStyle.None;
            this.green_track.Scroll += new System.EventHandler(this.green_track_Scroll);
            // 
            // blue_track
            // 
            this.blue_track.AutoSize = false;
            this.blue_track.LargeChange = 10;
            this.blue_track.Location = new System.Drawing.Point(12, 180);
            this.blue_track.Maximum = 255;
            this.blue_track.Minimum = -255;
            this.blue_track.Name = "blue_track";
            this.blue_track.Size = new System.Drawing.Size(300, 20);
            this.blue_track.TabIndex = 20;
            this.blue_track.TickStyle = System.Windows.Forms.TickStyle.None;
            this.blue_track.Scroll += new System.EventHandler(this.blue_track_Scroll);
            // 
            // ColorInput
            // 
            this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
            this.ClientSize = new System.Drawing.Size(320, 265);
            this.Controls.Add(this.blue_track);
            this.Controls.Add(this.green_track);
            this.Controls.Add(this.red_track);
            this.Controls.Add(this.Blue);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.Green);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.Red);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.OK);
            this.Controls.Add(this.Cancel);
            this.Name = "ColorInput";
            this.Text = "ColorInput";
            this.Load += new System.EventHandler(this.ColorInput_Load);
            ((System.ComponentModel.ISupportInitialize)(this.red_track)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.green_track)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.blue_track)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

		}
		#endregion

		private void ColorInput_Load(object sender, System.EventArgs e)
		{
		
		}
        private void UpdateColor()
        {
            blue = blue_track.Value;
            red = red_track.Value;
            green = green_track.Value;
        }

        private void blue_track_Scroll(object sender, EventArgs e)
        {
            UpdateColor();
        }

        private void green_track_Scroll(object sender, EventArgs e)
        {
            UpdateColor();
        }

        private void red_track_Scroll(object sender, EventArgs e)
        {
            UpdateColor();
        }
	}
}
