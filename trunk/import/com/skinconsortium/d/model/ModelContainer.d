/**
 * Interface for model containing objects.
 * 
 * @author mpdeimos
 */
module com.skinconsortium.d.model.ModelContainer;

public import com.skinconsortium.d.model.ModelBase;
/**
 * Interface for model containing objects.
 */
interface IModelContainer
{
	/** attaches a new model to the object. */
	public void setModel(IModel model);
	/** returns the current model of the object. */
	public IModel getModel(); 
}
