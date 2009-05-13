/*
Stick mode script for Ebonite
by SLoB

www.skinconsortium.com

*/

#include <lib/std.mi>
#include <lib/config.mi>

#include "ip_stick.m"

system.onScriptLoaded()
{

	load_stick();

}

system.onScriptUnloading()
{

	unload_stick();

}
