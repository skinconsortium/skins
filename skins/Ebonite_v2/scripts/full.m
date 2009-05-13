/*
Full mode script for Ebonite
by SLoB

www.skinconsortium.com

*/

#include <lib/std.mi>
#include <lib/config.mi>
#include "attribs.m"
#include "ip_full.m"

system.onScriptLoaded()
{

	load_full();

}

system.onScriptUnloading()
{

	unload_full();

}
