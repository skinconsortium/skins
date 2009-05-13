/*
Mini mode script for Ebonite
by SLoB

www.skinconsortium.com

*/

#include <lib/std.mi>
#include <lib/config.mi>

#include "ip_mini.m"

system.onScriptLoaded()
{

	load_mini();

}

system.onScriptUnloading()
{

	unload_mini();

}
