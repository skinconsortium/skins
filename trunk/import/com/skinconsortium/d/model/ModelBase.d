/**
 * Collection of model base classes and interfaces.
 * 
 * @author mpdeimos
 */

module com.skinconsortium.d.model.ModelBase;


/**
 * Sample interface for models.
 */
interface IModel
{
	/** saves the model */
	public void save();
	/** returns whether the model has been changed or not */
	public bool isDirty();
	/** marks the model as dirty */
	protected void makeDirty();
}

/**
 * Base class for models. Should be used instead of the interface.
 */
abstract class ModelBase: IModel
{
	/** flag to show if the model has been changed */
	private bool dirty;
	
	/** returns whether the model has been changed or not */
	override public bool isDirty()
	{
		return dirty;
	}
	
	/** marks the model as dirty */
	override final protected void makeDirty()
	{
		this.dirty = true;
	}
	
	/** saves changes to the model. call super.save() if you intend to alter this function, since this is the only way to clean the model. */
	override public void save()
	{
		this.dirty = false;
	}
}