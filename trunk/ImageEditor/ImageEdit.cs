using System;
using System.Diagnostics;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;
using System.Drawing.Drawing2D;
using System.Windows.Forms;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using System.Runtime.InteropServices;

namespace MusicShowBackgroundCreator
{
    /// <summary>
    /// Wrapper around an Image object,
    /// with editable features and properties
    /// </summary>
    public class ImageEdit : Component
    {
        private const PixelFormat PIXEL_FORMAT
            = PixelFormat.Format16bppRgb555;
        public event EventHandler OnChange;

        #region Instantiation

        /// <summary>
        /// Create empty initial image
        /// </summary>
        public ImageEdit()
        {
            Init();
            _image = Empty(_maxThumbSize);
        }
        
        /// <summary>
        /// Load image from file
        /// </summary>
        /// <param name="filename"></param>
        public ImageEdit(string filename)
        {
            Init();
            _filename = filename;
            _image = new Bitmap(_filename);
        }

        /// <summary>
        /// Create an "empty" X image
        /// </summary>
        /// <param name="size">image width and height</param>
        /// <returns></returns>
        public static Image Empty(int size)
        {
            int size4 = (int)(size / 4);
            int size43 = size4 * 3;

            Image image = new Bitmap(size, size, PIXEL_FORMAT);
            using (Graphics g = Graphics.FromImage(image))
            {
                SolidBrush brush = new SolidBrush(Color.White);
                g.FillRectangle(brush, new Rectangle(0, 0, size, size));

                Pen pen = new Pen(Color.Red, 1);
                g.DrawLine(pen, size4, size4, size43, size43);
                g.DrawLine(pen, size4, size43, size43, size4);

                brush.Dispose();
                pen.Dispose();
            }
            return image;
        }

        /// <summary>
        /// Dispose image and last change image
        /// </summary>
        public new void Dispose()
        {
            if (_image != null)
                _image.Dispose();
            if (_imageOld != null)
                _imageOld.Dispose();
        }
        #endregion

        #region File

        [Description("Actual data image")]
        [Category("File")]
        [ReadOnly(true)]
        [ExtenderProvidedProperty()]
        public Image Image
        {
            get
            {
                return (_scale == 100
                    ? _image : Zoom(_image, _scale));
            }
            set
            {
                if (value != null)
                {
                    if (_image != null)
                    {
                        if (_imageOld != null)
                            _imageOld.Dispose();
                        _imageOld = new Bitmap(_image);
                        _image.Dispose();
                    }
                    _image = value;
                    
                    if (OnChange != null)
                        OnChange(this, new EventArgs());
                }
            }
        }
        private Image _image = null;
        private Image _imageOld = null;

        /// <summary>
        /// 
        /// </summary>
        [Description("True is undo image available")]
        [Category("File")]
        [DefaultValue(false)]
        public bool IsChanged
        {
            get { return (_imageOld != null); }
        }

        /// <summary>
        /// Undo last image change
        /// </summary>
        public void Undo()
        {
            if (IsChanged)
            {
                _image.Dispose();
                _image = new Bitmap(_imageOld);
                _imageOld.Dispose();
                _imageOld = null;

                if (OnChange != null)
                    OnChange(this, new EventArgs());
            }
        }

		[Description("File name")]
		[DefaultValue("")]
		[Category("File")]
        [ReadOnly(true)]
		public string FileName
		{
			get { return _filename; }
			set
            {
                _filename = value;
                Save();
            }
		}
        private string _filename = "";

        [Description("Compression factor for JPEG images, on save")]
        [Category("File")]
        [DefaultValue(100)]
        public int Quality
        {
            get { return _quality; }
            set { _quality = value; }
        }
        private int _quality = 100;

        /// <summary>
        /// File extension for an image format
        /// </summary>
        /// <param name="format">image format</param>
        /// <returns>file extension</returns>
        public static string ExtensionFromFormat(ImageFormat format)
        {
            if (format == ImageFormat.Jpeg)     return "jpg";
            if (format == ImageFormat.Gif)      return "gif";
            if (format == ImageFormat.Png)      return "png";
            if (format == ImageFormat.Bmp)      return "bmp";
            if (format == ImageFormat.Tiff)     return "tiff";
            return null;
        }
        /// <summary>
        /// Image format, based on a file extension
        /// </summary>
        /// <param name="ext">full file name or just extension</param>
        /// <returns>image format</returns>
        public static ImageFormat FormatFromExtension(string ext)
        {
            if (ext.IndexOf('.') > 0)
                ext = ext.Substring(ext.LastIndexOf('.') + 1);
            switch (ext.ToLower())
            {
                case "jpg":     return ImageFormat.Jpeg;
                case "gif":     return ImageFormat.Gif;
                case "png":     return ImageFormat.Png;
                case "bmp":     return ImageFormat.Bmp;
                case "tif":     return ImageFormat.Tiff;
            }
            return null;
        }

        #endregion

        #region Open/Save

        // Internal filter for Open/Save dialogs
        private const string FILTER
            = "All Supported Formats|*.jpg;*.gif;*.png;*.bmp;*.tif|"
            + "JPEG (*.jpg)|*.jpg|"
            + "CompuServe GIF (*.gif)|*.gif|"
            + "Portable Network Graphics (*.png)|*.png|"
            + "Windows Bitmaps (*.bmp)|*.bmp|"
            + "TIFF (*.tif)|*.tif|"
            + "All Files (*.*)|*.*";
        
        /// <summary>
        /// Open "Open File" dialog and create ImageEdit
        /// </summary>
        /// <returns></returns>
        public static ImageEdit Open()
        {
            OpenFileDialog dialog = new OpenFileDialog();
            dialog.Filter = FILTER;

            // instantiate ImageEdit from filename
            if (dialog.ShowDialog() == DialogResult.OK)
                return new ImageEdit(dialog.FileName);
            return null;
        }

        /// <summary>
        /// Open "Save As" dialog,
        /// to save current file under different name
        /// </summary>
        public void SaveAs()
        {
            SaveFileDialog dialog = new SaveFileDialog();
            dialog.Filter = FILTER;
            dialog.FileName = _filename;
            dialog.OverwritePrompt = true;
            dialog.AddExtension = true;

            // change FileName and auto-Save it
            if (dialog.ShowDialog() == DialogResult.OK)
                FileName = dialog.FileName;
        }

        /// <summary>
		/// Save changes on current image in file
		/// </summary>
		public void Save()
		{
            // filename not specified. Use FileName = ...
            if (_filename == null || _filename.Length == 0)
                throw new Exception("Unspecified file name");

            // cannot override RO file
            if (File.Exists(_filename)
                && (File.GetAttributes(_filename)
                & FileAttributes.ReadOnly) != 0)
                throw new Exception("File exists and is read-only!");

            // check supported image formats
            ImageFormat format = FormatFromExtension(_filename);
            if (format == null)
                throw new Exception("Unsupported image format");

            // JPG images get special treatement
            if (format.Equals(ImageFormat.Jpeg))
            {
                EncoderParameters oParams = new EncoderParameters(1);
                oParams.Param[0] = new EncoderParameter(
                    System.Drawing.Imaging.Encoder.Quality, _quality);
                ImageCodecInfo oCodecInfo = GetEncoderInfo("image/jpeg");
                _image.Save(_filename, oCodecInfo, oParams);
            }
            else
                _image.Save(_filename, format);

            // remove undo image
            if (_imageOld != null)
                _imageOld.Dispose();
            _imageOld = null;

            // notify image changed (to enable Save/Undo commands)
            if (OnChange != null)
                OnChange(this, new EventArgs());
		}

        // Encoder info for saved JPEG image
		private ImageCodecInfo GetEncoderInfo(String mimeType)
		{
			ImageCodecInfo[] encoders = ImageCodecInfo.GetImageEncoders();
			for (int i=0; i<encoders.Length; i++)
				if (encoders[i].MimeType==mimeType)
					return encoders[i];
			return null;
		}
        #endregion

        #region Thumbnail

        [Description("Thumbnail of this image")]
        [Category("Thumbnail")]
        [Browsable(false)]
        public Image Thumbnail
        {
            get
            {
                Image image = _image;
                return FitInto(image,
                    _minThumbSize, _maxThumbSize, _borderColor, true);
            }
        }

        [Description("Minimum width and height of a thumbnail")]
        [Category("Thumbnail")]
        [DefaultValue(50)]
        public int MinThumbSize
        {
            get { return _minThumbSize; }
            set
            {
                _minThumbSize = value;
                if (OnChange != null)
                    OnChange(this, new EventArgs());
            }
        }
        private int _minThumbSize = 50;

        [Description("Maximum width and height of a thumbnail")]
        [Category("Thumbnail")]
        [DefaultValue(128)]
        public int MaxThumbSize
        {
            get { return _maxThumbSize; }
            set
            {
                _maxThumbSize = value;
                if (OnChange != null)
                    OnChange(this, new EventArgs());
            }
        }
        private int _maxThumbSize = 128;

        // Adjust current image to have width/height fit within min/maxSize
        public void FitInto(int minSize, int maxSize, bool thumbnail)
        {
            Image = FitInto(_image, minSize, maxSize, _borderColor, thumbnail);
        }

        // Adjust external image to have width/height fit within min/maxSize
        public static Image FitInto(Image image,
            int minSize, int maxSize, Color borderColor, bool thumbnail)
        {
            if (minSize <= 0 && maxSize <= 0)
                throw new Exception("Min or max size not strict positive values");

            int w = image.Width;
            int h = image.Height;
            if (maxSize > 0 && (maxSize < w || maxSize < h))
            {
                if (w >= h) { h = (int)(h * maxSize / w); w = maxSize; }
                else { w = (int)(w * maxSize / h); h = maxSize; }
            }
            else if (minSize > 0 && (minSize > w && minSize > h))
            {
                if (w >= h) { h = (int)(h * minSize / w); w = minSize; }
                else { w = (int)(w * minSize / h); h = minSize; }
            }
            if (w <= 0) w = 1;
            if (h <= 0) h = 1;

            Image newimage = image.GetThumbnailImage(w, h, null, IntPtr.Zero);
            if (w != h || w < maxSize)
            {
                Image thumb = new Bitmap(maxSize, maxSize, PIXEL_FORMAT);
                using (Graphics g = Graphics.FromImage(thumb))
                {
                    SolidBrush brush = new SolidBrush(
                        thumbnail ? Color.White : borderColor);
                    g.FillRegion(brush,
                        new Region(new Rectangle(0, 0, maxSize, maxSize)));
                    brush.Dispose();

                    g.DrawImage(newimage,
                        new Rectangle((int)((maxSize - w) / 2),
                        (int)((maxSize - h) / 2), w, h),
                        0, 0, w, h, GraphicsUnit.Pixel);

                    if (thumbnail)
                    {
                        Pen pen = new Pen(Color.Gainsboro, 1);
                        g.DrawRectangle(pen, 0, 0, maxSize - 1, maxSize - 1);
                        pen.Dispose();
                    }
                }
                newimage.Dispose();
                newimage = thumb;
            }
            return newimage;
        }

        #endregion

        #region Size

        /// <summary>
        /// 
        /// </summary>
        [Description("KeepRatio ensures that width or height changes will"
            + " auto-modify the other dimension for a non-distorted image")]
        [Category("Size")]
        [DefaultValue(true)]
        public bool KeepRatio
        {
            get { return _keepRatio; }
            set { _keepRatio = value; }
        }
        private bool _keepRatio = true;

        /// <summary>
        /// 
        /// </summary>
        [Description("In AutoSize mode, changing width"
            + " or height will generate distorted image")]
        [Category("Size")]
        [DefaultValue(true)]
        public bool AutoSize
        {
            get { return _autoSize; }
            set { _autoSize = value; }
        }
        private bool _autoSize = true;

        [Description("Change width. Image will change"
           + " depending on KeepRation and AutoSize")]
        [Category("Size")]
        [DefaultValue(0)]
        public int Width
        {
            get { return _image.Width; }
            set
            {
                if (value > 0)
                {
                    if (_keepRatio)
                        Image = new Bitmap(_image, value,
                            (int)(_image.Height
                            * (((double)value) / _image.Width)));
                    else if (_autoSize)
                        Image = new Bitmap(_image, value, _image.Height);
                    else
                        Image = Resize(_image, 0, 0,
                            value, _image.Height, _borderColor);
                }
            }
        }

        [Description("Change height. Image will change"
            + " depending on KeepRation and AutoSize")]
        [Category("Size")]
        [DefaultValue(0)]
        public int Height
        {
            get { return _image.Height; }
            set
            {
                if (value > 0)
                {
                    if (_keepRatio)
                        Image = new Bitmap(_image,
                            (int)(_image.Width
                            * (((double)value) / _image.Height)), value);
                    else if (_autoSize)
                        Image = new Bitmap(_image, _image.Width, value);
                    else
                        Image = Resize(_image, 0, 0,
                            _image.Width, value, _borderColor);
                }
            }
        }

        // Resize current image, adding bands or cropping (for negative x, y)
        public void Resize(int x, int y, int width, int height)
        {
            Image = Resize(_image, x, y, width, height, _borderColor);
        }

        // Resize external image, adding bands or cropping (for negative x, y)
        public static Image Resize(Image image, int x, int y,
            int width, int height, Color borderColor)
        {
            if (image == null || width <= 0 || height <= 0)
                throw new Exception("Invalid image, width or height");

            Image newimage = new Bitmap(width, height, PIXEL_FORMAT);
            using (Graphics g = Graphics.FromImage(newimage))
            {
                SolidBrush brush = new SolidBrush(borderColor);
                g.FillRegion(brush, new Region(new Rectangle(0, 0, width, height)));
                brush.Dispose();

                g.DrawImage(image, new Rectangle(
                    x > 0 ? 0 : -x, y > 0 ? 0 : -y, width, height),
                    x > 0 ? x : 0, y > 0 ? y : 0, width, height, GraphicsUnit.Pixel);
            }
            return newimage;
        }

        [Description("Resize width and/or height to a minimum size")]
        [Category("Size")]
        [DefaultValue(0)]
        public int MinSize
        {
            get
            {
                return (_image.Width < _image.Height
              ? _image.Width : _image.Height);
            }
            set
            {
                if (value > _image.Width && value > _image.Height)
                {
                    int w = _image.Width;
                    int h = _image.Height;
                    if (w >= h) { h = h * value / w; w = value; }
                    else { w = w * value / h; h = value; }

                    Image = new Bitmap(_image, w, h);
                }
            }
        }

        [Description("Resize width and/or height to a maximum size")]
        [Category("Size")]
        [DefaultValue(0)]
        public int MaxSize
        {
            get
            {
                return (_image.Width > _image.Height
              ? _image.Width : _image.Height);
            }
            set
            {
                if (value > 0 && (value < _image.Width || value < _image.Height))
                {
                    int w = _image.Width;
                    int h = _image.Height;
                    if (w >= h) { h = h * value / w; w = value; }
                    else { w = w * value / h; h = value; }

                    Image = new Bitmap(_image, w, h);
                }
            }
        }

        [Description("Save zoom in or out factor,"
            + " to be transparently applied when reading the Image")]
        [Category("Resize")]
        [DefaultValue(100)]
        public int Scale
        {
            get { return _scale; }
            set
            {
                if (value > 0 && value <= 1000)
                {
                    bool changed = (_scale != value);
                    _scale = value;
                    if (changed && OnChange != null)
                        OnChange(this, new EventArgs());
                }
            }
        }
        private int _scale = 100;

        // Scale (zoom in or out) external image by a scale factor
        public static Image Zoom(Image image, int scale)
        {
            Debug.Assert(image != null);
            return (scale == 100 ? image
                : new Bitmap(image,
                (int)(image.Width * scale / 100),
                (int)(image.Height * scale / 100)));
        }
        #endregion

        #region Border

        [Description("Add border band around image,"
            + " or crop it, for negative value")]
        [Category("Border")]
        [DefaultValue(0)]
        public int BorderWidth
        {
            get { return 0; }
            set
            {
                if (value != 0)
                    Image = Resize(_image, -value, -value,
                        _image.Width + 2 * value, _image.Height + 2 * value,
                        _borderColor);
            }
        }

        [Description("Border color, for BorderWidth change")]
        [Category("Border")]
        public Color BorderColor
        {
            get { return _borderColor; }
            set { _borderColor = value; }
        }
        private Color _borderColor = Color.White;

        [Description("Enlarge or cut part from the left of image")]
        [Category("Border")]
		[DefaultValue(0)]
		public int Left
		{
			get { return 0; }
			set
			{
				if (value!=0)
                    Image = Resize(_image, value, 0,
                        _image.Width - value, _image.Height, _borderColor);
			}
		}

        [Description("Enlarge or cut part from the top of image")]
        [Category("Border")]
		[DefaultValue(0)]
		public int Top
		{
			get { return 0; }
			set
			{
				if (value!=0)
                    Image = Resize(_image, 0, value,
                        _image.Width, _image.Height - value, _borderColor);
			}
		}

        #endregion

        #region Crop

        [Description("Start selection point, for cropping")]
        [Category("Crop")]
        public Point StartSelection
        {
            get { return _startSelection; }
            set { _startSelection = value; }
        }
        private Point _startSelection = Point.Empty;

        [Description("End selection point, for cropping")]
        [Category("Crop")]
        public Point EndSelection
        {
            get { return _endSelection; }
            set { _endSelection = value; }
        }
        private Point _endSelection = Point.Empty;

        /// <summary>
        /// Draw dashed rectangle for a selected area
        /// </summary>
        /// <param name="picture"></param>
        /// <returns></returns>
        public Rectangle DrawSelection(PictureBox picture)
        {
            // get selection rectangle
            Rectangle rect = new Rectangle(_startSelection,
                new Size(_endSelection.X - _startSelection.X,
                _endSelection.Y - _startSelection.Y));

            // draw dashed rectangle, as selection area
            ControlPaint.DrawReversibleFrame(
                picture.RectangleToScreen(rect),
                _borderColor, FrameStyle.Dashed);

            return rect;
        }

        #endregion

		#region Rotations and Flips

		[Description("Rotate image to the left or right,"
            + " for positive values 1, 2 or 3")]
        [Category("Rotations")]
		[DefaultValue(0)]
		public int Rotations
		{
			get { return 0; }
			set
			{
                value = value % 4;
                if (value > 0)
                {
                    Image image = new Bitmap(_image);
                    image.RotateFlip(value == 1
                        ? RotateFlipType.Rotate90FlipNone
                        : (value == 2 ? RotateFlipType.Rotate180FlipNone
                        : RotateFlipType.Rotate270FlipNone));
                    Image = image;
                }
			}
		}

		/// <summary>
		/// 
		/// </summary>
		[Description("Horizontal flip of the image")]
        [Category("Rotations")]
		[DefaultValue(false)]
		public bool FlipHorizontal
		{
			get { return false; }
			set
			{
				if (value)
				{
					Image image = new Bitmap(_image);
					image.RotateFlip(RotateFlipType.RotateNoneFlipX);
                    Image = image;
				}
			}
		}

		[Description("Vertical flip of the image")]
        [Category("Rotations")]
		[DefaultValue(false)]
		public bool FlipVertical
		{
			get { return false; }
			set
			{
				if (value)
				{
					Image image = new Bitmap(_image);
					image.RotateFlip(RotateFlipType.RotateNoneFlipY);
					Image = image;
				}
			}
		}
		#endregion

        #region Text

        /// <summary>
        /// Initialize text-related drawing objects 
        /// </summary>
        private void Init()
        {
            _textLocation = new Point(0, 0);
            _textForeColor = Color.Black;
            _textBackColor = Color.White;
            _textFont = new Font("Arial", 10);
            _textFormat = new StringFormat();
            _textFormat.FormatFlags = StringFormatFlags.FitBlackBox;
            _textBrush = new SolidBrush(_textBackColor);
            _textPen = new Pen(_textForeColor, 1);
        }

		[Description("Text string, to be written from TextLocation")]
		[Category("Text")]
		[DefaultValue("")]
		public string Text
		{
			get { return ""; }
			set
			{
                if (value == null || value.Length == 0)
                    return;

                Image image = new Bitmap(_image);
				using (Graphics g = Graphics.FromImage(image))
				{
					SolidBrush brushText = new SolidBrush(_textForeColor);
                    g.DrawString(value, _textFont, brushText,
						_textLocation.X, _textLocation.Y, _textFormat);
                    brushText.Dispose();
				}
				Image = image;
			}
		}

        [Description("Point where Text can be written")]
        [Category("Text")]
        public Point TextLocation
        {
            get { return _textLocation; }
            set { _textLocation = value; }
        }
        private Point _textLocation;

        [Description("Fore color of applied Text")]
        [Category("Text")]
        public Color TextForeColor
        {
            get { return _textForeColor; }
            set
            {
                _textForeColor = value;
                _textPen.Dispose();
                _textPen = new Pen(_textForeColor, 1);
            }
        }
        private Color _textForeColor;
        private Pen _textPen;

        [Description("Back color of applied Text")]
        [Category("Text")]
        public Color TextBackColor
        {
            get { return _textBackColor; }
            set
            {
                _textBackColor = value;
                _textBrush.Dispose();
                _textBrush = new SolidBrush(_textBackColor);
            }
        }
        private Color _textBackColor;
        private SolidBrush _textBrush;

        [Description("Font of applied Text")]
        [Category("Text")]
        public Font TextFont
        {
            get { return _textFont; }
            set
            {
                _textFont.Dispose();
                _textFont = value;
            }
        }
        private Font _textFont;

        [Description("Format flags of Text to apply")]
        [Category("Text")]
        public StringFormatFlags TextStringFormatFlags
        {
            get { return _textFormat.FormatFlags; }
            set { _textFormat.FormatFlags = value; }
        }
        private StringFormat _textFormat;

        #endregion
    }
}
