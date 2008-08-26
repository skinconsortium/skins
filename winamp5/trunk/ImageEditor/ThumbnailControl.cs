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
    /// Show the Thumbnail image of a ImageEdit object
    /// </summary>
    public partial class ThumbnailControl : UserControl
    {
        public ThumbnailControl()
        {
            InitializeComponent();
        }

        #region Image

        /// <summary>
        /// Associated ImageEdit object
        /// </summary>
        public ImageEdit Thumbnail
        {
            get { return _thumbnail; }
            set
            {
                _thumbnail = value;
                if (_thumbnail == null)
                    _thumbnail = new ImageEdit();
                ShowPicture();
            }
        }

        // Redraw thumbnail on resize
        private void pnlMain_Resize(object sender, EventArgs e)
        {
            ShowPicture();
        }

        /// <summary>
        /// Pass the thumbnail image to pctMain PictureBox
        /// </summary>
        private void ShowPicture()
        {
            Image thumbnail = _thumbnail.Thumbnail;
            pnlInner.Width = Math.Max(thumbnail.Width, pnlMain.Width);
            pnlInner.Height = Math.Max(thumbnail.Height, pnlMain.Height);
            pctMain.Image = thumbnail;
        }
        #endregion
    }
}
