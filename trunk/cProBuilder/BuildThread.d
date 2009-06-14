/**
 * Threadclass for building the ClassicPro Installer
 * 
 * @author mpdeimos
 */
module BuildThread;

import tango.core.Thread;
import tango.sys.Process;
import tango.text.stream.LineIterator;
import dfl.registry;
import dfl.messagebox;

class BuildThread : Thread
{
	/// this method is called once the build process has some output to show
	private void delegate(char[] line) statusUpdate;
	
	/// gets called when the build process is complete
	private void delegate() buildComplete;
	
	/// constant for storing the nsis path
	const static char[] NSIS_PATH;
	
	/** static constructor for init of global vars */
	static this()
	{
		try
		{
			RegistryKey rvalue  = Registry.localMachine.openSubKey(`SOFTWARE\\NSIS`);
			NSIS_PATH = rvalue.getValue(rvalue.getValueNames()[0]).toString();
		}
		catch (Exception e)
		{
			NSIS_PATH = null;
			msgBox("NSIS does not seem to be installed on your Computer!\nPlease download and install NSIS from http://nsis.sf.net!", "Error.");
		}
	}
	
	/** needs a void delegate. this function gets called as soon the BuildThread has some output */
	public this(void delegate(char[] line) statusUpdate, void delegate() complete)
	{
		super(&run);
		this.statusUpdate = statusUpdate;
		this.buildComplete = complete;
	}
	
	/** gets executed as soon the thread starts */
	private void run()
	{
		if (NSIS_PATH is null)
			return;
		
		try
		{
		     auto p = new Process (NSIS_PATH ~ "\\makensis /V3 cPro_Installer.nsi", null);
		     p.execute;
		     foreach (line; new LineIterator!(char) (p.stdout))
		     {
		    	 this.statusUpdate(line);
		     }
		 }
		 catch (Exception e) {}		
		
		 scope(exit)
		 {
			 this.buildComplete();
		 }
	}
	
}