using System;
using System.Diagnostics;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Text;
using System.Windows.Forms;

namespace MusicShowBackgroundCreator
{
    /// <summary>
    /// Show the Image image of a ImageEdit object
    /// </summary>
    public partial class ImageControl : UserControl
    {
        private bool _showRealSize = false;

        public ImageControl()
        {
            InitializeComponent();
        }

        #region Image

        /// <summary>
        /// Associated ImageEdit object
        /// </summary>
        public ImageEdit Image
        {
            get { return _image; }
            set
            {
                if (_image != value)
                {
                    _image.Dispose();
                    _image = value;
                    if (_image == null)
                        _image = new ImageEdit();
                    
                    _image.OnChange
                        += new System.EventHandler(this.Image_OnChange);
                }

                ShowPicture();
            }
        }

        /// <summary>
        /// Notify main form when ImageEdit's image changed
        /// </summary>
        public event EventHandler OnChange;
        private void Image_OnChange(object sender, EventArgs e)
        {
            ShowPicture();
        }
        
        // Redraw image on resize
        private void pnlMain_Resize(object sender, EventArgs e)
        {
            ShowPicture();
        }

        /// <summary>
        /// Pass the thumbnail image to pctMain PictureBox
        /// </summary>
        private void ShowPicture()
        {
            tbSave.Enabled = tbUndo.Enabled = _image.IsChanged;

            DockStyle dock = (_showRealSize
                ? DockStyle.None : DockStyle.Fill);
            if (pnlInner.Dock != dock)
                pnlInner.Dock = dock;

            if (_showRealSize)
            {
                _image.Scale = _image.Scale;
                pnlInner.Width = Math.Max(_image.Width, pnlMain.Width);
                pnlInner.Height = Math.Max(_image.Height, pnlMain.Height);
            }
            else if (pnlMain.Width > 0 && pnlMain.Height > 0
                && (pnlMain.Width < _image.Width
                || pnlMain.Height < _image.Height))
                _image.Scale = (int) (Math.Min(
                    (double)(((double)pnlMain.Width)
                    / ((double)_image.Width)),
                    (double)(((double)pnlMain.Height)
                    / ((double)_image.Height))) * 100);

            pctMain.Image = _image.Image;
            txtPoint.Text = _image.Width + " x " + _image.Height;
            cboZoom.Text = _image.Scale + "%";
            Application.DoEvents();

            if (OnChange != null)
                OnChange(this, new EventArgs());
        }
        #endregion

        #region Zoom

        private void cboZoom_SelectedIndexChanged(
            object sender, System.EventArgs e)
        {
            if (cboZoom.SelectedIndex >= 0)
                Zoom();
        }

        private void cboZoom_KeyDown(object sender,
            System.Windows.Forms.KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
                Zoom();
        }

        /// <summary>
        /// Calculate and apply the Scale factor when
        /// different zoom value selected
        /// </summary>
        private void Zoom()
        {
            int scale = 100;
            bool showRealSize = (cboZoom.SelectedIndex != 0);
            
            if (showRealSize)
            {
                string zoom = cboZoom.Text;
                if (zoom.EndsWith("%"))
                    zoom = zoom.Substring(0, zoom.Length - 1);

                try { scale = Convert.ToInt32(zoom); }
                catch { scale = 0; }
            }

            if (scale >= 10 && scale <= 500)
            {
                if (_showRealSize != showRealSize)
                {
                    _showRealSize = showRealSize;
                    ShowPicture();
                }
                _image.Scale = scale;
            }
            else
                ShowMessage("Zoom/Scale must be between 10% and 500%!");
        }
        #endregion

        #region Crop Selection

        private void pctMain_MouseDown(object sender,
            System.Windows.Forms.MouseEventArgs e)
        {
            _image.EndSelection = new Point(e.X, e.Y);
            if (pctMain.Image != null)
                _image.StartSelection = _image.EndSelection;
            WriteCurrentPoint(true);
        }

        private void pctMain_MouseMove(object sender,
            System.Windows.Forms.MouseEventArgs e)
        {
            if (_image.StartSelection != Point.Empty)
                _image.DrawSelection(pctMain);
            _image.EndSelection = new Point(e.X, e.Y);
            if (_image.StartSelection != Point.Empty)
                _image.DrawSelection(pctMain);
            WriteCurrentPoint(false);
        }

        private void pctMain_MouseUp(object sender,
            System.Windows.Forms.MouseEventArgs e)
        {
            if (_image.StartSelection != Point.Empty)
            {
                Rectangle rect = _image.DrawSelection(pctMain);

                if (_image.StartSelection == _image.EndSelection)
                    WriteCurrentPoint(true);
                
                else if (rect.Width > 0 && rect.Height > 0)
                    _image.Resize((int)((2 * rect.X
                        - pctMain.Width + pctMain.Image.Width)
                        / (2 * _image.Scale/100)),
                        (int)((2 * rect.Y
                        - pctMain.Height + pctMain.Image.Height)
                        / (2 * _image.Scale / 100)),
                        (int)(rect.Width * 100 / _image.Scale),
                        (int)(rect.Height * 100 / _image.Scale));
                
                _image.StartSelection = Point.Empty;
            }
            _image.EndSelection = Point.Empty;
        }

        private void WriteCurrentPoint(bool save)
        {
            if (_image.EndSelection != Point.Empty)
            {
                try
                {
                    int x = (int)((2 * _image.EndSelection.X
                        - pctMain.Width + pctMain.Image.Width)
                        / (2 * _image.Scale/100));
                    int y = (int)((2 * _image.EndSelection.Y
                        - pctMain.Height + pctMain.Image.Height)
                        / (2 * _image.Scale/100));
                    if (x >= 0 && y >= 0
                        && x <= _image.Width && y <= _image.Height)
                    {
                        if (save)
                            _image.TextLocation = new Point(x, y);
                        txtPoint.Text = x + "," + y;
                        Cursor.Current = Cursors.Cross;
                        return;
                    }
                }
                catch { }
            }
            
            txtPoint.Text = _image.Width + " x " + _image.Height;
            Cursor.Current = Cursors.Default;
        }
        #endregion

        #region Commands

        // Generic method for all toolbar button commands
        private void Command_Click(object sender, EventArgs e)
        {
            if (sender == tbOpen)       Open();
            else if (sender == tbSave)  Save();
            else if (sender == tbUndo)  Undo();
            else if (sender == tbLeft)  RotateLeft();
            else if (sender == tbRight) RotateRight();
            Application.DoEvents();
        }

        public void Open()
        {
            ImageEdit image = null;
            try { image = ImageEdit.Open(); }
            catch (Exception ex) { ShowMessage(ex.Message); }
            if (image != null)
                Image = image;
        }
        public void Save()
        {
            try { _image.Save(); }
            catch (Exception ex) { ShowMessage(ex.Message); }
        }
        public void SaveAs()
        {
            try { _image.SaveAs(); }
            catch (Exception ex) { ShowMessage(ex.Message); }
        }
        public void Undo() { _image.Undo(); }
        public void RotateLeft() { _image.Rotations = -1; }
        public void RotateRight() { _image.Rotations = 1; }

        private void ShowMessage(string message)
        {
            MessageBox.Show(message, "MusicShow Background Creator",
                MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
        }
        #endregion
    }
}
