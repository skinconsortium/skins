/**
 * Creed - Full Circle
 * Display Mods
 *
 * @author Martin Poehlmann
 * @date 2009-10-18
 */

#include <lib/std.mi>
#include <lib/../../../sandbox3/classicpro_w5s/ClassicPro.mi>

System.onScriptLoaded()
{
	Group normal = getScriptGroup().getParentLayout();

	//ClassicPro.applyStyle(normal, "$set:_self ");
	ClassicPro.applyStyle(normal.getObject("SongTime"), "$set:SongTime");
	ClassicPro.applyStyle(normal.getObject("status"), "$set:status");
	Group fi = normal.getObject("fileinfo.mode.1");
	ClassicPro.applyStyle(fi, "$set:fileinfo.mode.1");
	fi.findObject("info.size").setAlpha(0);
	fi.findObject("info.size.layer").setAlpha(0);
	GuiObject go = fi.findObject("info.kbps");//.resize(10,90,30,5);
	go.setXmlParam("x", "-58");
	go.setXmlParam("y", "10");

	normal.findObject("seeker").setXmlParam("y", "-67");
	normal.findObject("seeker2").setXmlParam("y", "-67");

	ClassicPro.applyStyle(normal.getObject("volume.bg"), "$set:volume.bg");
	ClassicPro.applyStyle(normal.getObject("volume.bg2"), "$set:volume.bg2");
	ClassicPro.applyStyle(normal.getObject("volume.images"), "$set:volume.images");
	ClassicPro.applyStyle(normal.getObject("Volume"), "$set:Volume");
	ClassicPro.applyStyle(normal.getObject("mute"), "$set:mute");
	ClassicPro.applyStyle(normal.getObject("mute.warning"), "$set:mute.warning");

	ClassicPro.applyStyle(normal.getObject("main.vis"), "$set:main.vis");
	ClassicPro.applyStyle(normal.getObject("vis.overlay"), "$set:vis.overlay1");
	ClassicPro.applyStyle(normal.getObject("vis.overlay.2"), "$set:vis.overlay2");
	ClassicPro.applyStyle(normal.getObject("vis.mousetrap"), "$set:vis.mousetrap");

	ClassicPro.applyStyle(normal.getObject("cpro.screen"), "$set:cpro.screen");

	normal.setXmlParam("minimum_w", "348");
}

