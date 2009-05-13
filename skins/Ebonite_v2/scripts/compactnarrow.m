/*
Compact Narrow mode script for Ebonite
by SLoB

www.skinconsortium.com

*/

#include <lib/std.mi>
#include <lib/config.mi>

#include "ip_compactnarrow.m"

system.onScriptLoaded()
{

	load_narrow();

}

system.onScriptUnloading()
{

	unload_narrow();

}
