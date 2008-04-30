#include <lib/std.mi>

//when the script is loaded, do this
System.onScriptLoaded() {
	Int FirstTime = getPrivateInt("Graviton", "FirstTime", 1);
	if (FirstTime) {
		Container Reminder = System.getContainer("Message");
		Reminder.show();
	}
}


System.onScriptUnloading() {
	setPrivateInt("Graviton", "FirstTime", 0);
}