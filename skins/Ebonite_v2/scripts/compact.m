/*
Compact mode script for Ebonite
by SLoB

www.skinconsortium.com

*/

#include <lib/std.mi>
#include <lib/config.mi>

#include "ip_compact.m"

system.onScriptLoaded()
{

	load_compact();

}

system.onScriptUnloading()
{

	unload_compact();

}
