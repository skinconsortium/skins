module controller.ModelController;
import dfl.all;
import com.skinconsortium.d.model.ModelContainer;
import com.skinconsortium.d.model.FileModelBase;
import com.skinconsortium.d.commons.ConfigFile;
import PU = tango.util.PathUtil;
import tango.io.Path;

class ModelController(Model: FileModelBase)
{
	private IModelContainer main;
	
	public char[] FILE_FILTER = "myFile Libraries (*.myf)|*.myf|All files (*.*)|*.*";
	public char[] DEFAULT_SAVE_EXTENSION = ".myf";
	public char[] LAST_PATH_TAG = "lastSaveOpenPath";
	
	this(IModelContainer main)
	{
		this.main = main;
	}
	
	public void updateModel(Model model)
	{
		main.setModel(model);
	}
	
	private Model getModel()
	{
		return cast(Model) main.getModel();
	}
	alias getModel model;
	
	/// returns whether we can proceed or not
	public bool checkDirty()
	{
		if (model !is null && model.isDirty())
		{
			DialogResult res = msgBox("The current file contains changes.\nDo you want to save it (recommended)?","", MsgBoxButtons.YES_NO_CANCEL, MsgBoxIcon.QUESTION);
			
			switch (res)
			{
			case DialogResult.YES:
				if (model.getFilename is null)
					saveModelAs();
				else
					model.save();
				return true;
			case DialogResult.NO:
				return true;			
			default:
				return false;
			}
		}
		
		return true;
	}
	
	public void newModel()
	{
		if(!checkDirty())
			return;
		
		this.updateModel(new Model());
	}
	
	public void openModel()
	{
		if(!checkDirty())
			return;
		
		OpenFileDialog fd = new OpenFileDialog();
		fd.initialDirectory = ConfigFile.getValue(LAST_PATH_TAG);
		fd.filter = FILE_FILTER;
		auto res = fd.showDialog();
		char[] normalizedPath = PU.normalize(fd.fileName);
		
		debug tango.io.Stdout.Stdout(normalizedPath).newline;
		
		if (res !is dfl.base.DialogResult.OK)
			return;
		
		this.updateModel(new Model(normalizedPath));
		
		PathParser p;
		p.parse(normalizedPath);		
		ConfigFile.setValue(LAST_PATH_TAG, p.folder());
	}
	
	public void saveModelAs()
	{
		SaveFileDialog fd = new SaveFileDialog();
		fd.initialDirectory = ConfigFile.getValue(LAST_PATH_TAG);
		fd.filter = FILE_FILTER;
		fd.defaultExt = DEFAULT_SAVE_EXTENSION;
		auto res = fd.showDialog();
		char[] normalizedPath = PU.normalize(fd.fileName);
		
		debug tango.io.Stdout.Stdout(normalizedPath).newline;
		
		if (res !is dfl.base.DialogResult.OK)
			return;
		
		getModel().setFilename(normalizedPath);
		getModel().save();
		
		PathParser p;
		p.parse(normalizedPath);
		ConfigFile.setValue(LAST_PATH_TAG, p.folder());
	}
	
	public void saveModel()
	{
		if (model.getFilename() is null)
			saveModelAs();
		else
			model.save();
	}
}