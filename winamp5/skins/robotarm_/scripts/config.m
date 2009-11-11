#include <lib/std.mi>
Global CheckBox CheckB;
System.onScriptLoaded ()
{
	checkB = getScriptGroup().findObject("backupNav");
	if (System.getPrivateInt("robotarm", "showBackupNav", 0) == 1) checkB.setChecked(1);
	else checkB.setChecked(0);
}
checkB.onToggle(int newVal)
{
	System.setPrivateInt("robotarm", "showBackupNav", newVal);
}