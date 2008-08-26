using System;
using System.IO;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace MusicShowBackgroundCreator
{
    public partial class MainForm : Form
    {
        public MainForm()
        {
            InitializeComponent();
        }

        private void MainForm_Load(object sender, EventArgs e)
        {
            Show();
            Update();
            propGrid.SelectedObject = imgThumb.Thumbnail = imgMain.Image;
            imgMain.Open();
        }

        // Refresh property grid and thumbnail contro, when image changes
        private void ImageControl_OnChange(object sender, EventArgs e)
        {
            propGrid.SelectedObject = imgThumb.Thumbnail = imgMain.Image;
        }

        // Generic method for all menu commands
        private void Command_Click(object sender, EventArgs e)
        {
            if (sender == mnuFileOpen)              imgMain.Open();
            else if (sender == mnuFileSave)         imgMain.Save();
            else if (sender == mnuFileSaveAs)       imgMain.SaveAs();
            else if (sender == mnuFileExit)         Close();
        }

        private void mnuFile_DropDownOpening(object sender, EventArgs e)
        {
            mnuFileSaveAs.Enabled = (imgMain.Image.FileName != null);
            mnuFileSave.Enabled = (mnuFileSaveAs.Enabled && imgMain.Image.IsChanged);
        }

        private void imgMain_Load(object sender, EventArgs e)
        {

        }
        private void filterbrightness_Click(object sender, EventArgs e)
        {//Brightness Correction
            Parameter dlg = new Parameter();
            dlg.nValue = 0;

            if (DialogResult.OK == dlg.ShowDialog())
            {
                if (BitmapFilter.Brightness(image, dlg.nValue))
                    this.Invalidate();
            }
        }
        private void filtercontrast_Click(object sender, EventArgs e)
        {//Contrasts Pictures Colors
            Parameter dlg = new Parameter();
            dlg.nValue = 0;

            if (DialogResult.OK == dlg.ShowDialog())
            {
                if (BitmapFilter.Contrast(image, (sbyte)dlg.nValue))
                    this.Invalidate();
            }

        }

        private void filtercolor_Click(object sender, EventArgs e)
        {//Color Correction
            ColorInput dlg = new ColorInput();
            dlg.red = dlg.green = dlg.blue = 0;

            if (DialogResult.OK == dlg.ShowDialog())
            {
                if (BitmapFilter.Color(image, dlg.red, dlg.green, dlg.blue))
                    this.Invalidate();
            }
        }

        private void filtergamma_Click(object sender, EventArgs e)
        {//Gamma Correction
            ColorInput dlg = new ColorInput();
            dlg.red = dlg.green = dlg.blue = 1;

            if (DialogResult.OK == dlg.ShowDialog())
            {
                if (BitmapFilter.Gamma(image, dlg.red, dlg.green, dlg.blue))
                    this.Invalidate();
            }
        }

        private void filtergray_Click(object sender, EventArgs e)
        {//Grayscale Pictures Colors
            if (BitmapFilter.GrayScale(image))
                this.Invalidate();
        }

        private void filterinvert_Click(object sender, EventArgs e)
        {//Inverts Pictures Colors
            if (BitmapFilter.Invert(image))
                this.Invalidate();
        }
    }
}