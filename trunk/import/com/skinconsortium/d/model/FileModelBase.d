/**
 * Abstract base class for File based models.
 * @author mpdeimos
 */

module com.skinconsortium.d.model.FileModelBase;
import com.skinconsortium.d.model.ModelBase;
import tango.io.FilePath;

abstract class FileModelBase: ModelBase
{
	/** filename of our model */
	protected char[] filename;
	
	this(char[] filename)
	{
		this.filename = filename;
	}
	
	/** sets the filename for the current model */
	public void setFilename(char[] filename)
	{
		this.filename = filename;
		this.makeDirty();
	}
	
	/** returns the filename for the current model */
	public char[] getFilename()
	{
		return this.filename;
	}
	
	/** 
	 * checks if the file linked to this model exists with option to create it.
	 * Asserts filename is not null! 
	 */
	protected bool fileExists(bool create = false)
	{
		assert(filename !is null);
		
		FilePath p = new FilePath(this.filename);
		if (!p.exists())
		{
			p.createFile();
			return false;
		}
		return true;
	}	
}
