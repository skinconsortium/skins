#ifndef included
#error This script can only be compiled as a #include
#endif

#ifndef __ATTRIBS_M
#define __ATTRIBS_M

#include "../../../lib/config.mi"

// -----------------------------------------------------------------------------------------------------------------

// this is the page that maps its items to the options menu, you can add attribs or more pages (submenus)
#define CUSTOM_OPTIONSMENU_ITEMS "{1828D28F-78DD-4647-8532-EBA504B8FC04}"

// this is the page that maps its items to the windows menu (aka View), you can add attribs or more pages (submenus)
#define CUSTOM_WINDOWSMENU_ITEMS "{6559CA61-7EB2-4415-A8A9-A2AEEF762B7F}"

// custom options submenu item page, you can add more, just use guidgen and Config.newItem()
#define CUSTOM_PAGE "{02CDB0CB-3998-4606-94A7-DF90E7366439}"

// menubars config page
#define CUSTOM_PAGE_MENUBARS "{12ED320E-6813-45ac-9F8E-78EE5B2B5F6D}"

// notifier config page
#define CUSTOM_PAGE_NOTIFIER "{1AB968B3-8687-4a35-BA70-FCF6D92FB57F}"

#define CUSTOM_PAGE_NOTIFIER_AA "{7BF45B05-2B98-4de8-8778-E5CCC9639ED1}"

#define CUSTOM_PAGE_NOTIFIER_LOC "{715B2C0D-1DF0-4bb2-9D74-0FACAE27CE97}"

#define CUSTOM_PAGE_NOTIFIER_FDIN "{D9891A39-7A38-45d8-9D51-A08F7270C836}"

#define CUSTOM_PAGE_NOTIFIER_FDOUT "{560EAE41-1379-4927-AC55-FB5F4D47C9B8}"

// glowbuttons config page
#define CUSTOM_PAGE_GLOWBUTTONS "{A8EFDFF8-9667-4a38-AA38-A449A85EDCC0}"

#define CUSTOM_PAGE_DISPLAY "{7CC87D3C-553C-46e6-B77B-DF978291449A}"

#define CUSTOM_PAGE_COVER "{F1036C9C-3919-47ac-8494-366778CF10F9}"

#define CUSTOM_PAGE_COVERNF "{956A3C18-9F41-4605-8FBF-D06D41222A95}"

#define CUSTOM_PAGE_COVERQUALITY "{3D466930-024D-4c12-8C23-4045D98A03C2}"

#define CUSTOM_PAGE_VIS "{9EF1EEA2-E07B-4062-9D46-CF5C771014D4}"

#define CUSTOM_PAGE_PLAYBACK "{0E6B520B-DD42-46e8-AAA3-6A7F788BD506}"

#define CUSTOM_PAGE_VIS_SLOTS "{1AD0C758-38B8-475d-B433-00ECCB6374F9}"

// songticker config page
#define CUSTOM_PAGE_SONGTICKER "{7061FDE0-0E12-11D8-BB41-0050DA442EF3}"

// non exposed attribs page
#define CUSTOM_PAGE_NONEXPOSED "{E9C2D926-53CA-400f-9A4D-85E31755A4CF}"


// -----------------------------------------------------------------------------------------------------------------

Function initAttribs();

// -----------------------------------------------------------------------------------------------------------------

Global ConfigAttribute eq_visible_attrib;

Global ConfigAttribute autoupdate_attrib;

Global ConfigAttribute menubar_main_attrib;
Global ConfigAttribute menubar_pe_attrib;
Global ConfigAttribute menubar_ml_attrib;

Global ConfigAttribute notifier_minimized_attrib;
Global ConfigAttribute notifier_windowshade_attrib;
Global ConfigAttribute notifier_always_attrib;
Global ConfigAttribute notifier_never_attrib;
Global ConfigAttribute notifier_fadeintime_attrib;
Global ConfigAttribute notifier_fadeouttime_attrib;
Global ConfigAttribute notifier_holdtime_attrib;
Global ConfigAttribute notifier_disablefullscreen_attrib;
Global ConfigAttribute notifier_endoftrack_attrib;

Global ConfigAttribute notifier_aa_enabled;
Global ConfigAttribute notifier_aa_right;
Global ConfigAttribute notifier_aa_left;
Global ConfigAttribute notifier_aa_smooth;

Global ConfigAttribute notifier_fdout_alpha;
Global ConfigAttribute notifier_fdout_hslide;
Global ConfigAttribute notifier_fdout_vslide;

Global ConfigAttribute notifier_fdin_alpha;
Global ConfigAttribute notifier_fdin_hslide;
Global ConfigAttribute notifier_fdin_vslide;

Global ConfigAttribute notifier_loc_br_attrib;
Global ConfigAttribute notifier_loc_bl_attrib;
Global ConfigAttribute notifier_loc_bc_attrib;
Global ConfigAttribute notifier_loc_tr_attrib;
Global ConfigAttribute notifier_loc_tc_attrib;
Global ConfigAttribute notifier_loc_tl_attrib;

Global ConfigAttribute glowbuttons_glow_attrib;
Global ConfigAttribute glowbuttons_hover_attrib;
Global ConfigAttribute glowbuttons_null_attrib;
Global ConfigAttribute glowbuttons_beat_attrib;

Global ConfigAttribute playback_restore_attrib;
Global ConfigAttribute playback_autoplay_attrib;

Global ConfigAttribute playback_shutdown_track;
Global ConfigAttribute playback_shutdown_playlist;
Global ConfigAttribute playback_shutdown_track_attrib;
Global ConfigAttribute playback_shutdown_playlist_attrib;

Global ConfigAttribute playback_close_track;
Global ConfigAttribute playback_close_playlist;
Global ConfigAttribute playback_close_track_attrib;
Global ConfigAttribute playback_close_playlist_attrib;

Global ConfigAttribute colorthemes_random_attrib;

Global ConfigAttribute prefs_visible_attrib2;
Global ConfigAttribute prefs_visible_attrib;
Global ConfigAttribute prefs_Xvisible_attrib;

Global ConfigAttribute display_discanim_attrib;
Global ConfigAttribute display_discanim_speed_attrib;

Global ConfigAttribute display_glasalpha_attrib;

Global ConfigAttribute cover_dirs_pip_attrib;
Global ConfigAttribute cover_dirs_acp_attrib;
Global ConfigAttribute cover_web_attrib;

Global ConfigAttribute cover_notfound_givengfx_attrib;
Global ConfigAttribute cover_notfound_owngfx_attrib;
Global ConfigAttribute cover_notfound_avs_attrib;
Global ConfigAttribute cover_notfound_video_attrib;

Global ConfigAttribute cover_quality_attrib;
Global ConfigAttribute cover_quality_large_attrib;
Global ConfigAttribute cover_quality_medium_attrib;
Global ConfigAttribute cover_quality_small_attrib;

Global ConfigAttribute cover_smooth_attrib;
Global ConfigAttribute cover_shrink_attrib;
Global ConfigAttribute cover_enlarge_attrib;
Global ConfigAttribute cover_browserration_attrib;
Global ConfigAttribute cover_imageration_attrib;
Global ConfigAttribute cover_notfound_owngfx_tile_attrib;
Global ConfigAttribute cover_notfound_owngfx_hide_attrib;
Global ConfigAttribute cover_notfound_owngfx_attrib;

Class ConfigAttribute ConfigVisAttribute;
Class ConfigAttribute ConfigOwnVisAttribute;

Global ConfigAttribute vis_mode_attrib;
Global ConfigAttribute vis_overlay_attrib;
Global ConfigAttribute vis_speed_attrib;

Global ConfigOwnVisAttribute vis_own1_attrib;
Global ConfigOwnVisAttribute vis_own2_attrib;
Global ConfigOwnVisAttribute vis_own3_attrib;
Global ConfigOwnVisAttribute vis_own4_attrib;
Global ConfigOwnVisAttribute vis_own5_attrib;
Global ConfigOwnVisAttribute vis_own6_attrib;
Global ConfigOwnVisAttribute vis_own7_attrib;
Global ConfigOwnVisAttribute vis_own8_attrib;
Global ConfigOwnVisAttribute vis_own9_attrib;
Global ConfigOwnVisAttribute vis_own10_attrib;

Global ConfigVisAttribute vis_mode_none_attrib;
Global ConfigVisAttribute vis_mode_spec_attrib;
Global ConfigVisAttribute vis_mode_osci_attrib;

Global ConfigVisAttribute vis_mode_4dspec_attrib;
Global ConfigVisAttribute vis_mode_4dosci_attrib;

Global ConfigVisAttribute vis_mode_circ_attrib;
Global ConfigVisAttribute vis_mode_semi_attrib;
Global ConfigVisAttribute vis_mode_dots_attrib;
Global ConfigVisAttribute vis_mode_bolt_attrib;
Global ConfigVisAttribute vis_mode_llama_attrib;

Global ConfigVisAttribute vis_mode_slot1_attrib;
Global ConfigVisAttribute vis_mode_slot2_attrib;
Global ConfigVisAttribute vis_mode_slot3_attrib;
Global ConfigVisAttribute vis_mode_slot4_attrib;
Global ConfigVisAttribute vis_mode_slot5_attrib;
Global ConfigVisAttribute vis_mode_slot6_attrib;
Global ConfigVisAttribute vis_mode_slot7_attrib;
Global ConfigVisAttribute vis_mode_slot8_attrib;
Global ConfigVisAttribute vis_mode_slot9_attrib;
Global ConfigVisAttribute vis_mode_slot10_attrib;

Global ConfigItem custom_page_vis_slots;

Global ConfigAttribute sep;

Global ConfigAttribute songticker_scrolling_enabled_attrib;
Global ConfigAttribute songticker_scrolling_disabled_attrib;

// -----------------------------------------------------------------------------------------------------------------

initAttribs() {

// create the custom cfgpage for this session (if it does exist, it just returns it)
	ConfigItem custom_page = Config.newItem("Skin Configuration", CUSTOM_PAGE);
	ConfigItem custom_page_menubars = Config.newItem("Menus", CUSTOM_PAGE_MENUBARS);
	ConfigItem custom_page_notifier = Config.newItem("Notifications", CUSTOM_PAGE_NOTIFIER);
	ConfigItem custom_page_notifier_aa = Config.newItem("Album Art", CUSTOM_PAGE_NOTIFIER_AA);
	ConfigItem custom_page_notifier_loc = Config.newItem("Location", CUSTOM_PAGE_NOTIFIER_LOC);
	ConfigItem custom_page_notifier_fdin = Config.newItem("Fade In Effect", CUSTOM_PAGE_NOTIFIER_FDIN);
	ConfigItem custom_page_notifier_fdout = Config.newItem("Fade Out Effect", CUSTOM_PAGE_NOTIFIER_FDOUT);
	ConfigItem custom_page_glowbuttons = Config.newItem("Glowbuttons", CUSTOM_PAGE_GLOWBUTTONS);
	ConfigItem custom_page_display = Config.newItem("Display", CUSTOM_PAGE_DISPLAY);
	ConfigItem custom_page_cover = Config.newItem("CoverSearch", CUSTOM_PAGE_COVER);
	ConfigItem custom_page_covernf = Config.newItem("If no cover was found...", CUSTOM_PAGE_COVERNF);
	ConfigItem custom_page_coverhstyle = Config.newItem("Image Quality", CUSTOM_PAGE_COVERQUALITY);
	ConfigItem custom_page_songticker = Config.newItem("Songticker", CUSTOM_PAGE_SONGTICKER);
	ConfigItem custom_page_vis = Config.newItem("Visualization", CUSTOM_PAGE_VIS);
	ConfigItem custom_page_playback = Config.newItem("Playback", CUSTOM_PAGE_PLAYBACK);
	custom_page_vis_slots = Config.newItem("Own Presets", CUSTOM_PAGE_VIS_SLOTS);
/*
	ConfigItem custom_page_ct = Config.getItem("Color Themes"); //!

	ConfigAttribute cfga = custom_page_ct.getAttribute("{coloredit}blue silver | mint");
	cfga.setData("1");
*/
	ConfigItem custom_page_nonexposed = Config.newItem("Hidden", CUSTOM_PAGE_NONEXPOSED);

// load up the cfgpage in which we'll insert our custom page
	ConfigItem custom_options_page = Config.getItem(CUSTOM_OPTIONSMENU_ITEMS);
	ConfigItem custom_windows_page = Config.getItem(CUSTOM_WINDOWSMENU_ITEMS);

// this creates a submenu for these attributes
	eq_visible_attrib = custom_windows_page.newAttribute("Equalizer\tAlt+G", "0");

	prefs_visible_attrib2 = custom_options_page.newAttribute("Skin Preferences...\tAlt+P", "0");
	prefs_visible_attrib = custom_windows_page.newAttribute("Skin Preferences\tAlt+P", "0");


	ConfigAttribute submenuattrib = custom_options_page.newAttribute("Skin Configuration", "");
	submenuattrib.setData(CUSTOM_PAGE); // discard any default value and point at our custom cfgpage

//Titan Preferences > Menus
	ConfigAttribute menubarssubmenu = custom_page.newAttribute("Menus", "");
	menubarssubmenu.setData(CUSTOM_PAGE_MENUBARS);

	menubar_main_attrib = custom_page_menubars.newAttribute("Show Menus in Main Window", "1");
	menubar_pe_attrib = custom_page_menubars.newAttribute("Show Menus in Playlist Editor", "1");
	menubar_ml_attrib = custom_page_menubars.newAttribute("Show Menus in Media Library", "1");

//Titan Preferences > Notifications
	ConfigAttribute notifiersubmenu = custom_page.newAttribute("Notifications", "");
	notifiersubmenu.setData(CUSTOM_PAGE_NOTIFIER);

	notifier_always_attrib = custom_page_notifier.newAttribute("Show always", "1");
	notifier_windowshade_attrib = custom_page_notifier.newAttribute("Show with windowshade and when minimized", "0");
	notifier_minimized_attrib = custom_page_notifier.newAttribute("Show only when minimized", "0");
	notifier_never_attrib = custom_page_notifier.newAttribute("Never show", "0");
	sep = custom_page_notifier.newAttribute("sep1", ""); sep.setData("-");
	ConfigAttribute notifierlocsubmenu = custom_page_notifier.newAttribute("Location", "");
	notifierlocsubmenu.setData(CUSTOM_PAGE_NOTIFIER_LOC);
	sep = custom_page_notifier.newAttribute("sep1.1", ""); sep.setData("-");
	ConfigAttribute notifierfdinsubmenu = custom_page_notifier.newAttribute("Fade In Effect", "");
	notifierfdinsubmenu.setData(CUSTOM_PAGE_NOTIFIER_FDIN);
	ConfigAttribute notifierfdoutsubmenu = custom_page_notifier.newAttribute("Fade Out Effect", "");
	notifierfdoutsubmenu.setData(CUSTOM_PAGE_NOTIFIER_FDOUT);
	sep = custom_page_notifier.newAttribute("sep1.2", ""); sep.setData("-");
	notifier_disablefullscreen_attrib = custom_page_notifier.newAttribute("Disable in fullscreen", "1");
	notifier_endoftrack_attrib = custom_page_notifier.newAttribute("Show on the end of track again", "1");

	notifier_fadeintime_attrib = custom_page_nonexposed.newAttribute("Notifications fade in time", "1000");
	notifier_fadeouttime_attrib = custom_page_nonexposed.newAttribute("Notifications fade out time", "5000");
	notifier_holdtime_attrib = custom_page_nonexposed.newAttribute("Notifications display time", "2000");

	sep = custom_page_notifier.newAttribute("sep2", ""); sep.setData("-");
	ConfigAttribute notifieraasubmenu = custom_page_notifier.newAttribute("Album Art", "");
	notifieraasubmenu.setData(CUSTOM_PAGE_NOTIFIER_AA);

//Titan Preferences > Notifications > Location
	notifier_loc_br_attrib = custom_page_notifier_loc.newAttribute("Bottom Right", "1");
	notifier_loc_bc_attrib = custom_page_notifier_loc.newAttribute("Bottom Center", "0");
	notifier_loc_bl_attrib = custom_page_notifier_loc.newAttribute("Bottom Left", "0");
	notifier_loc_tr_attrib = custom_page_notifier_loc.newAttribute("Top Right", "0");
	notifier_loc_tc_attrib = custom_page_notifier_loc.newAttribute("Top Center", "0");
	notifier_loc_tl_attrib = custom_page_notifier_loc.newAttribute("Top Left", "0");

//Titan Preferences > Notifications > Fade...
	notifier_fdout_alpha = custom_page_notifier_fdout.newAttribute("Alpha Fade ", "1");
	notifier_fdout_vslide = custom_page_notifier_fdout.newAttribute("Vertical Slide ", "0");
	notifier_fdout_hslide = custom_page_notifier_fdout.newAttribute("Horizontal Slide ", "0");

	notifier_fdin_alpha = custom_page_notifier_fdin.newAttribute("Alpha Fade", "1");
	notifier_fdin_vslide = custom_page_notifier_fdin.newAttribute("Vertical Slide", "0");
	notifier_fdin_hslide = custom_page_notifier_fdin.newAttribute("Horizontal Slide", "0");

//Titan Preferences > Notifications > Album Art
	notifier_aa_enabled = custom_page_notifier_aa.newAttribute("Display Album Art", "1");
	sep = custom_page_notifier_aa.newAttribute("sep1", ""); sep.setData("-");
	notifier_aa_right = custom_page_notifier_aa.newAttribute("Show on the right side", "0");
	notifier_aa_left = custom_page_notifier_aa.newAttribute("Show on the left side", "1");
	sep = custom_page_notifier_aa.newAttribute("sep2", ""); sep.setData("-");
	notifier_aa_smooth = custom_page_notifier_aa.newAttribute("Smooth Album Art", "1");

//Titan Preferences > Glowbuttons
	ConfigAttribute glowbuttonssubmenu = custom_page.newAttribute("Glowbuttons", "");
	glowbuttonssubmenu.setData(CUSTOM_PAGE_GLOWBUTTONS);
	
	glowbuttons_glow_attrib = custom_page_glowbuttons.newAttribute("Glow Effect", "1");
	glowbuttons_hover_attrib = custom_page_glowbuttons.newAttribute("Hover Effect", "0");
	sep = custom_page_glowbuttons.newAttribute("sep1", ""); sep.setData("-");
	glowbuttons_beat_attrib = custom_page_glowbuttons.newAttribute("On Beat Pulsation", "0");
	sep = custom_page_glowbuttons.newAttribute("sep12", ""); sep.setData("-");
	glowbuttons_null_attrib = custom_page_glowbuttons.newAttribute("No Effect", "0");

//Titan Preferences > Visualization
	ConfigAttribute vissubmenu = custom_page.newAttribute("Visualization", "");
	vissubmenu.setData(CUSTOM_PAGE_VIS);

	vis_mode_attrib = custom_page_nonexposed.newAttribute("Vismode", "Spectrum Analyzer");
	vis_speed_attrib = custom_page_nonexposed.newAttribute("Visspeed", "49");

	vis_own1_attrib = custom_page_nonexposed.newAttribute("OwnVisPreset1", "nix");
	vis_own2_attrib = custom_page_nonexposed.newAttribute("OwnVisPreset2", "nix");
	vis_own3_attrib = custom_page_nonexposed.newAttribute("OwnVisPreset3", "nix");
	vis_own4_attrib = custom_page_nonexposed.newAttribute("OwnVisPreset4", "nix");
	vis_own5_attrib = custom_page_nonexposed.newAttribute("OwnVisPreset5", "nix");
	vis_own6_attrib = custom_page_nonexposed.newAttribute("OwnVisPreset6", "nix");
	vis_own7_attrib = custom_page_nonexposed.newAttribute("OwnVisPreset7", "nix");
	vis_own8_attrib = custom_page_nonexposed.newAttribute("OwnVisPreset8", "nix");
	vis_own9_attrib = custom_page_nonexposed.newAttribute("OwnVisPreset9", "nix");
	vis_own10_attrib = custom_page_nonexposed.newAttribute("OwnVisPreset10", "nix");

	vis_mode_none_attrib = custom_page_vis.newAttribute("No Visualization", "0");
	sep = custom_page_vis.newAttribute("sep1", ""); sep.setData("-");
	vis_mode_spec_attrib = custom_page_vis.newAttribute("Spectrum Analyzer", "0");
	vis_mode_osci_attrib = custom_page_vis.newAttribute("Oscilliscope", "0");
	sep = custom_page_vis.newAttribute("sep2", ""); sep.setData("-");
	vis_mode_4dspec_attrib = custom_page_vis.newAttribute("4D Spectrum", "0");
	vis_mode_4dosci_attrib = custom_page_vis.newAttribute("4D Oscilliscope", "1");
	sep = custom_page_vis.newAttribute("sep0", ""); sep.setData("-");
	vis_mode_circ_attrib = custom_page_vis.newAttribute("Circle", "0");
	vis_mode_semi_attrib = custom_page_vis.newAttribute("SemiOrbit", "0");
	vis_mode_dots_attrib = custom_page_vis.newAttribute("Dots", "0");
	vis_mode_bolt_attrib = custom_page_vis.newAttribute("Lighting Bolt", "0");
	vis_mode_llama_attrib = custom_page_vis.newAttribute("Rockin' Llamas", "0");
	sep = custom_page_vis.newAttribute("sep3", ""); sep.setData("-");

	ConfigAttribute visslotssubmenu = custom_page_vis.newAttribute("Own Presets", "");
	visslotssubmenu.setData(CUSTOM_PAGE_VIS_SLOTS);

	if (vis_own1_attrib.getData() == "nix") vis_mode_slot1_attrib = custom_page_vis_slots.newAttribute("Slot 1 (empty)", "0");
	else vis_mode_slot1_attrib = custom_page_vis_slots.newAttribute(getToken(vis_own1_attrib.getData(), ";", 0), "0");
	if (vis_own2_attrib.getData() == "nix") vis_mode_slot2_attrib = custom_page_vis_slots.newAttribute("Slot 2 (empty)", "0");
	else vis_mode_slot2_attrib = custom_page_vis_slots.newAttribute(getToken(vis_own2_attrib.getData(), ";", 0), "0");
	if (vis_own3_attrib.getData() == "nix") vis_mode_slot3_attrib = custom_page_vis_slots.newAttribute("Slot 3 (empty)", "0");
	else vis_mode_slot3_attrib = custom_page_vis_slots.newAttribute(getToken(vis_own3_attrib.getData(), ";", 0), "0");
	if (vis_own4_attrib.getData() == "nix") vis_mode_slot4_attrib = custom_page_vis_slots.newAttribute("Slot 4 (empty)", "0");
	else vis_mode_slot4_attrib = custom_page_vis_slots.newAttribute(getToken(vis_own4_attrib.getData(), ";", 0), "0");
	if (vis_own5_attrib.getData() == "nix") vis_mode_slot5_attrib = custom_page_vis_slots.newAttribute("Slot 5 (empty)", "0");
	else vis_mode_slot5_attrib = custom_page_vis_slots.newAttribute(getToken(vis_own5_attrib.getData(), ";", 0), "0");
	if (vis_own6_attrib.getData() == "nix") vis_mode_slot6_attrib = custom_page_vis_slots.newAttribute("Slot 6 (empty)", "0");
	else vis_mode_slot6_attrib = custom_page_vis_slots.newAttribute(getToken(vis_own6_attrib.getData(), ";", 0), "0");
	if (vis_own7_attrib.getData() == "nix") vis_mode_slot7_attrib = custom_page_vis_slots.newAttribute("Slot 7 (empty)", "0");
	else vis_mode_slot7_attrib = custom_page_vis_slots.newAttribute(getToken(vis_own7_attrib.getData(), ";", 0), "0");
	if (vis_own8_attrib.getData() == "nix") vis_mode_slot8_attrib = custom_page_vis_slots.newAttribute("Slot 8 (empty)", "0");
	else vis_mode_slot8_attrib = custom_page_vis_slots.newAttribute(getToken(vis_own8_attrib.getData(), ";", 0), "0");
	if (vis_own9_attrib.getData() == "nix") vis_mode_slot9_attrib = custom_page_vis_slots.newAttribute("Slot 9 (empty)", "0");
	else vis_mode_slot9_attrib = custom_page_vis_slots.newAttribute(getToken(vis_own9_attrib.getData(), ";", 0), "0");
	if (vis_own10_attrib.getData() == "nix") vis_mode_slot10_attrib = custom_page_vis_slots.newAttribute("Slot 10 (empty)", "0");
	else vis_mode_slot10_attrib = custom_page_vis_slots.newAttribute(getToken(vis_own10_attrib.getData(), ";", 0), "0");

	sep = custom_page_vis.newAttribute("sep4", ""); sep.setData("-");
	vis_overlay_attrib = custom_page_vis.newAttribute("Show LCD Overlay", "1");

//Titan Preferences > Playback
	ConfigAttribute playbacksubmenu = custom_page.newAttribute("Playback", "");
	playbacksubmenu.setData(CUSTOM_PAGE_PLAYBACK);

	playback_restore_attrib = custom_page_playback.newAttribute("Restore Playbackstate and Position at Startup", "0");
	playback_autoplay_attrib = custom_page_playback.newAttribute("Autoplay at Startup", "0");
	sep = custom_page_playback.newAttribute("sep666", ""); sep.setData("-");
	playback_close_track = custom_page_playback.newAttribute("Close Winamp at end of Track\tShift+Q", "0");
	playback_close_playlist = custom_page_playback.newAttribute("Close Winamp at end of Playlist\tCtrl+Q", "0");

	playback_close_track_attrib = custom_page_nonexposed.newAttribute("Close Winamp at end of Track", "0");
	playback_close_playlist_attrib = custom_page_nonexposed.newAttribute("Close Winamp at end of Playlist", "0");

	sep = custom_page_playback.newAttribute("sep668", ""); sep.setData("-");
	playback_shutdown_track = custom_page_playback.newAttribute("Shutdown at end of Track\tShift+Alt+Q", "0");
	playback_shutdown_playlist = custom_page_playback.newAttribute("Shutdown at end of Playlist\tCtrl+Alt+Q", "0");

	playback_shutdown_track_attrib = custom_page_nonexposed.newAttribute("Shutdown at end of Track", "0");
	playback_shutdown_playlist_attrib = custom_page_nonexposed.newAttribute("Shutdown at end of Playlist", "0");
//Titan Preferences > Display

	display_discanim_speed_attrib = custom_page_nonexposed.newAttribute("Discspeed", "9");
	display_glasalpha_attrib = custom_page_nonexposed.newAttribute("Glasalpha", "255");

	ConfigAttribute displaysubmenu = custom_page.newAttribute("Display", "");
	displaysubmenu.setData(CUSTOM_PAGE_DISPLAY);

	display_discanim_attrib = custom_page_display.newAttribute("Enable DiscAnimation", "1");

	display_discanim_speed_attrib = custom_page_nonexposed.newAttribute("Discspeed", "9");
	display_glasalpha_attrib = custom_page_nonexposed.newAttribute("Glasalpha", "255");

//Titan Preferences > CoverSearch
	ConfigAttribute coversubmenu = custom_page.newAttribute("CoverSearch", "");
	coversubmenu.setData(CUSTOM_PAGE_COVER);

	ConfigAttribute covernfsubmenu = custom_page_cover.newAttribute("If no was cover found...", "");
	covernfsubmenu.setData(CUSTOM_PAGE_COVERNF);

	sep = custom_page_cover.newAttribute("sep", ""); sep.setData("-");

	cover_dirs_pip_attrib = custom_page_cover.newAttribute("Search in playitem directory", "1");
	cover_dirs_acp_attrib = custom_page_cover.newAttribute("Search in additional cover directory", "1");
	cover_web_attrib = custom_page_cover.newAttribute("Search via Amazon.com", "1");

	sep = custom_page_cover.newAttribute("sep-99", ""); sep.setData("-");

	ConfigAttribute coverhstylesubmenu = custom_page_cover.newAttribute("Image Quality", "");
	coverhstylesubmenu.setData(CUSTOM_PAGE_COVERQUALITY);

	cover_quality_attrib = custom_page_nonexposed.newAttribute("CoverImageQuality", "Large");
	cover_quality_large_attrib = custom_page_coverhstyle.newAttribute("Large", "1");
	cover_quality_medium_attrib = custom_page_coverhstyle.newAttribute("Medium", "0");
	cover_quality_small_attrib = custom_page_coverhstyle.newAttribute("Small", "0");

	cover_notfound_givengfx_attrib = custom_page_covernf.newAttribute("Show 'Cover not found' image", "1");
	cover_notfound_video_attrib = custom_page_covernf.newAttribute("Try to find one with a Cover Plugin", "0");


	sep = custom_page_cover.newAttribute("sep1", ""); sep.setData("-");
	cover_notfound_owngfx_attrib = custom_page_cover.newAttribute("Custom Background", "0");
	cover_notfound_owngfx_hide_attrib = custom_page_cover.newAttribute("Hide on searchresult", "1");
	sep = custom_page_cover.newAttribute("sep55", ""); sep.setData("-");
	cover_imageration_attrib = custom_page_cover.newAttribute("Keep Album Art ratio", "1");
	cover_shrink_attrib = custom_page_cover.newAttribute("Don't shrink Album Art", "0");
	cover_enlarge_attrib = custom_page_cover.newAttribute("Don't enlarge Album Art", "1");
	cover_smooth_attrib = custom_page_cover.newAttribute("Smooth Album Art ", "1");
	cover_browserration_attrib = custom_page_cover.newAttribute("Keep Browser ratio 1:1", "1");

	cover_notfound_owngfx_tile_attrib = custom_page_nonexposed.newAttribute("tile custom background", "0");

//Titan Preferences > Songticker
	ConfigAttribute songtickersubmenu = custom_page.newAttribute("Songticker", "");
	songtickersubmenu.setData(CUSTOM_PAGE_SONGTICKER);

	songticker_scrolling_enabled_attrib = custom_page_songticker.newAttribute("Enable Songticker scrolling", "1");
	songticker_scrolling_disabled_attrib = custom_page_songticker.newAttribute("Disable Songticker scrolling", "0");

//Titan Preferences

	sep = custom_page.newAttribute("sep3", ""); sep.setData("-");
	colorthemes_random_attrib = custom_page.newAttribute("Random ColorThemes on play", "0");
	autoupdate_attrib = custom_page.newAttribute("Check for Skinupdates at Startup", "1");

//Non Exposed

}

// -----------------------------------------------------------------------------------------------------------------

#ifdef MAIN_ATTRIBS_MGR

Global Int attribs_mychange;
Global Int attribs_vischange;

#define NOOFF if (getData()=="0") { setData("1"); return; }

notifier_always_attrib.onDataChanged() {
  if (attribs_mychange) return;
  NOOFF
  attribs_mychange = 1;
  notifier_never_attrib.setData("0");
  notifier_windowshade_attrib.setData("0");
  notifier_minimized_attrib.setData("0");
  attribs_mychange = 0;
}

notifier_never_attrib.onDataChanged() {
  if (attribs_mychange) return;
  NOOFF
  attribs_mychange = 1;
  notifier_always_attrib.setData("0");
  notifier_windowshade_attrib.setData("0");
  notifier_minimized_attrib.setData("0");
  attribs_mychange = 0;
}

notifier_minimized_attrib.onDataChanged() {
  if (attribs_mychange) return;
  NOOFF
  attribs_mychange = 1;
  notifier_never_attrib.setData("0");
  notifier_windowshade_attrib.setData("0");
  notifier_always_attrib.setData("0");
  attribs_mychange = 0;
}

notifier_windowshade_attrib.onDataChanged() {
  if (attribs_mychange) return;
  NOOFF
  attribs_mychange = 1;
  notifier_never_attrib.setData("0");
  notifier_always_attrib.setData("0");
  notifier_minimized_attrib.setData("0");
  attribs_mychange = 0;
}

notifier_aa_right.onDataChanged() {
  if (attribs_mychange) return;
  NOOFF
  attribs_mychange = 1;
  notifier_aa_left.setData("0");
  attribs_mychange = 0;
}

notifier_aa_left.onDataChanged() {
  if (attribs_mychange) return;
  NOOFF
  attribs_mychange = 1;
  notifier_aa_right.setData("0");
  attribs_mychange = 0;
}

notifier_fdout_alpha.onDataChanged() {
	if (attribs_mychange) return;
	NOOFF
	attribs_mychange = 1;
	notifier_fdout_hslide.setData("0");
	notifier_fdout_vslide.setData("0");
	attribs_mychange = 0;
}
notifier_fdout_hslide.onDataChanged() {
	if (attribs_mychange) return;
	NOOFF
	attribs_mychange = 1;
	notifier_fdout_alpha.setData("0");
	notifier_fdout_vslide.setData("0");
	attribs_mychange = 0;
}
notifier_fdout_vslide.onDataChanged() {
	if (attribs_mychange) return;
	NOOFF
	attribs_mychange = 1;
	notifier_fdout_hslide.setData("0");
	notifier_fdout_alpha.setData("0");
	attribs_mychange = 0;
}

notifier_fdin_alpha.onDataChanged() {
	if (attribs_mychange) return;
	NOOFF
	attribs_mychange = 1;
	notifier_fdin_hslide.setData("0");
	notifier_fdin_vslide.setData("0");
	attribs_mychange = 0;
}
notifier_fdin_hslide.onDataChanged() {
	if (attribs_mychange) return;
	NOOFF
	attribs_mychange = 1;
	notifier_fdin_alpha.setData("0");
	notifier_fdin_vslide.setData("0");
	attribs_mychange = 0;
}
notifier_fdin_vslide.onDataChanged() {
	if (attribs_mychange) return;
	NOOFF
	attribs_mychange = 1;
	notifier_fdin_hslide.setData("0");
	notifier_fdin_alpha.setData("0");
	attribs_mychange = 0;
}

notifier_loc_br_attrib.onDataChanged() {
	if (attribs_mychange) return;
	NOOFF
	attribs_mychange = 1;
	notifier_loc_bc_attrib.setData("0");
	notifier_loc_bl_attrib.setData("0");
	notifier_loc_tr_attrib.setData("0");
	notifier_loc_tc_attrib.setData("0");
	notifier_loc_tl_attrib.setData("0");
	attribs_mychange = 0;
}
notifier_loc_bc_attrib.onDataChanged() {
	if (attribs_mychange) return;
	NOOFF
	attribs_mychange = 1;
	notifier_loc_br_attrib.setData("0");
	notifier_loc_bl_attrib.setData("0");
	notifier_loc_tr_attrib.setData("0");
	notifier_loc_tc_attrib.setData("0");
	notifier_loc_tl_attrib.setData("0");
	attribs_mychange = 0;
}
notifier_loc_bl_attrib.onDataChanged() {
	if (attribs_mychange) return;
	NOOFF
	attribs_mychange = 1;
	notifier_loc_bc_attrib.setData("0");
	notifier_loc_br_attrib.setData("0");
	notifier_loc_tr_attrib.setData("0");
	notifier_loc_tc_attrib.setData("0");
	notifier_loc_tl_attrib.setData("0");
	attribs_mychange = 0;
}
notifier_loc_tl_attrib.onDataChanged() {
	if (attribs_mychange) return;
	NOOFF
	attribs_mychange = 1;
	notifier_loc_bc_attrib.setData("0");
	notifier_loc_bl_attrib.setData("0");
	notifier_loc_tr_attrib.setData("0");
	notifier_loc_tc_attrib.setData("0");
	notifier_loc_br_attrib.setData("0");
	attribs_mychange = 0;
}
notifier_loc_tr_attrib.onDataChanged() {
	if (attribs_mychange) return;
	NOOFF
	attribs_mychange = 1;
	notifier_loc_bc_attrib.setData("0");
	notifier_loc_bl_attrib.setData("0");
	notifier_loc_br_attrib.setData("0");
	notifier_loc_tc_attrib.setData("0");
	notifier_loc_tl_attrib.setData("0");
	attribs_mychange = 0;
}
notifier_loc_tc_attrib.onDataChanged() {
	if (attribs_mychange) return;
	NOOFF
	attribs_mychange = 1;
	notifier_loc_bc_attrib.setData("0");
	notifier_loc_bl_attrib.setData("0");
	notifier_loc_tr_attrib.setData("0");
	notifier_loc_br_attrib.setData("0");
	notifier_loc_tl_attrib.setData("0");
	attribs_mychange = 0;
}

glowbuttons_glow_attrib.onDataChanged() {
	if (attribs_mychange) return;
	NOOFF
	attribs_mychange = 1;
	glowbuttons_hover_attrib.setData("0");
	glowbuttons_null_attrib.setData("0");
	glowbuttons_beat_attrib.setData("0");
	attribs_mychange = 0;
}
glowbuttons_hover_attrib.onDataChanged() {
	if (attribs_mychange) return;
	NOOFF
	attribs_mychange = 1;
	glowbuttons_glow_attrib.setData("0");
	glowbuttons_null_attrib.setData("0");
	glowbuttons_beat_attrib.setData("0");
	attribs_mychange = 0;
}
glowbuttons_null_attrib.onDataChanged() {
	if (attribs_mychange) return;
	NOOFF
	attribs_mychange = 1;
	glowbuttons_hover_attrib.setData("0");
	glowbuttons_glow_attrib.setData("0");
	glowbuttons_beat_attrib.setData("0");
	attribs_mychange = 0;
}
glowbuttons_beat_attrib.onDataChanged() {
	if (attribs_mychange) return;
	NOOFF
	attribs_mychange = 1;
	glowbuttons_hover_attrib.setData("0");
	glowbuttons_glow_attrib.setData("0");
	glowbuttons_null_attrib.setData("0");
	attribs_mychange = 0;
}

cover_notfound_givengfx_attrib.onDataChanged() {
	if (attribs_mychange) return;
	NOOFF
	attribs_mychange = 1;
	cover_notfound_video_attrib.setData("0");
	attribs_mychange = 0;
}
cover_notfound_video_attrib.onDataChanged() {
	if (attribs_mychange) return;
	NOOFF
	attribs_mychange = 1;
	cover_notfound_givengfx_attrib.setData("0");
	attribs_mychange = 0;
}


/*---*/
cover_quality_attrib.onDataChanged() {
	if (attribs_mychange) return;
	configattribute attrib = Config.getItemByGuid(CUSTOM_PAGE_COVERQUALITY).getAttribute(getData());
	attrib.setData("1");
	attribs_mychange = 0;
}

cover_quality_large_attrib.onDataChanged() {
	if (attribs_mychange) return;
	NOOFF
	attribs_mychange = 1;
	cover_quality_attrib.setData(getAttributeName());
	cover_quality_medium_attrib.setData("0");
	cover_quality_small_attrib.setData("0");
	attribs_mychange = 0;
}
cover_quality_medium_attrib.onDataChanged() {
	if (attribs_mychange) return;
	NOOFF
	attribs_mychange = 1;
	cover_quality_attrib.setData(getAttributeName());
	cover_quality_large_attrib.setData("0");
	cover_quality_small_attrib.setData("0");
	attribs_mychange = 0;
}
cover_quality_small_attrib.onDataChanged() {
	if (attribs_mychange) return;
	NOOFF
	attribs_mychange = 1;
	cover_quality_attrib.setData(getAttributeName());
	cover_quality_medium_attrib.setData("0");
	cover_quality_large_attrib.setData("0");
	attribs_mychange = 0;
}

/*---*/

playback_shutdown_track.onDataChanged() {
	if (attribs_mychange) return;
	attribs_mychange = 1;
	playback_shutdown_track_attrib.setData(getData());
	if (getData() == "1") {
		playback_shutdown_playlist.setData("0");
		playback_shutdown_playlist_attrib.setData("0");
		playback_close_track.setData("0");
		playback_close_track_attrib.setData("0");
		playback_close_playlist.setData("0");
		playback_close_playlist_attrib.setData("0");
	}
	attribs_mychange = 0;
}
playback_shutdown_playlist.onDataChanged() {
	if (attribs_mychange) return;
	attribs_mychange = 1;
	playback_shutdown_playlist_attrib.setData(getData());
	if (getData() == "1") {
		playback_shutdown_track.setData("0");
		playback_shutdown_track_attrib.setData("0");
		playback_close_track.setData("0");
		playback_close_track_attrib.setData("0");
		playback_close_playlist.setData("0");
		playback_close_playlist_attrib.setData("0");
	}
	attribs_mychange = 0;
}

playback_shutdown_track_attrib.onDataChanged() {
	if (attribs_mychange) return;
	attribs_mychange = 1;
	playback_shutdown_track.setData(getData());
	if (getData() == "1") {
		playback_shutdown_playlist.setData("0");
		playback_shutdown_playlist_attrib.setData("0");
		playback_close_track.setData("0");
		playback_close_track_attrib.setData("0");
		playback_close_playlist.setData("0");
		playback_close_playlist_attrib.setData("0");
	}
	attribs_mychange = 0;
}
playback_shutdown_playlist_attrib.onDataChanged() {
	if (attribs_mychange) return;
	attribs_mychange = 1;
	playback_shutdown_playlist.setData(getData());
	if (getData() == "1") {
		playback_shutdown_track.setData("0");
		playback_shutdown_track_attrib.setData("0");
		playback_close_track.setData("0");
		playback_close_track_attrib.setData("0");
		playback_close_playlist.setData("0");
		playback_close_playlist_attrib.setData("0");
	}
	attribs_mychange = 0;
}
playback_close_track.onDataChanged() {
	if (attribs_mychange) return;
	attribs_mychange = 1;
	playback_close_track_attrib.setData(getData());
	if (getData() == "1") {
		playback_shutdown_track.setData("0");
		playback_shutdown_track_attrib.setData("0");
		playback_shutdown_playlist.setData("0");
		playback_shutdown_playlist_attrib.setData("0");
		playback_close_playlist.setData("0");
		playback_close_playlist_attrib.setData("0");
	}
	attribs_mychange = 0;
}
playback_close_playlist.onDataChanged() {
	if (attribs_mychange) return;
	attribs_mychange = 1;
	playback_close_playlist_attrib.setData(getData());
	if (getData() == "1") {
		playback_shutdown_track.setData("0");
		playback_shutdown_track_attrib.setData("0");
		playback_shutdown_playlist.setData("0");
		playback_shutdown_playlist_attrib.setData("0");
		playback_close_track.setData("0");
		playback_close_track_attrib.setData("0");
	}
	attribs_mychange = 0;
}

playback_close_track_attrib.onDataChanged() {
	if (attribs_mychange) return;
	attribs_mychange = 1;
	playback_close_track.setData(getData());
	if (getData() == "1") {
		playback_shutdown_playlist.setData("0");
		playback_shutdown_playlist_attrib.setData("0");
		playback_shutdown_playlist.setData("0");
		playback_shutdown_playlist_attrib.setData("0");
		playback_close_playlist.setData("0");
		playback_close_playlist_attrib.setData("0");
	}
	attribs_mychange = 0;
}
playback_close_playlist_attrib.onDataChanged() {
	if (attribs_mychange) return;
	attribs_mychange = 1;
	playback_close_playlist.setData(getData());
	if (getData() == "1") {
		playback_shutdown_track.setData("0");
		playback_shutdown_track_attrib.setData("0");
		playback_shutdown_playlist.setData("0");
		playback_shutdown_playlist_attrib.setData("0");
		playback_close_track.setData("0");
		playback_close_track_attrib.setData("0");
	}
	attribs_mychange = 0;
}



vis_mode_attrib.onDataChanged() {
#ifdef VIS_ATTRIBS_MGR
	int i_items = List_Vis.getNumItems() - 1;
	for ( int i = 0; i <= i_items; i++ ) {
		if (getData() == List_Vis.getItemLabel(i, 1)) { List_Vis.deselectAll(); List_Vis.setItemFocused(i); }
	}
#endif
	if (attribs_vischange) return;
	NOOFF
	attribs_vischange = 1;

	if (getData() != vis_mode_none_attrib.getAttributeName()) vis_mode_none_attrib.setData("0");
	else vis_mode_none_attrib.setData("1");

	if (getData() != vis_mode_osci_attrib.getAttributeName()) vis_mode_osci_attrib.setData("0");
	else vis_mode_osci_attrib.setData("1");
	if (getData() != vis_mode_spec_attrib.getAttributeName()) vis_mode_spec_attrib.setData("0");
	else vis_mode_spec_attrib.setData("1");

	if (getData() != vis_mode_4dspec_attrib.getAttributeName()) vis_mode_4dspec_attrib.setData("0");
	else vis_mode_4dspec_attrib.setData("1");
	if (getData() != vis_mode_4dosci_attrib.getAttributeName()) vis_mode_4dosci_attrib.setData("0");
	else vis_mode_4dosci_attrib.setData("1");

	if (getData() != vis_mode_circ_attrib.getAttributeName()) vis_mode_circ_attrib.setData("0");
	else vis_mode_circ_attrib.setData("1");
	if (getData() != vis_mode_semi_attrib.getAttributeName()) vis_mode_semi_attrib.setData("0");
	else vis_mode_semi_attrib.setData("1");
	if (getData() != vis_mode_dots_attrib.getAttributeName()) vis_mode_dots_attrib.setData("0");
	else vis_mode_dots_attrib.setData("1");
	if (getData() != vis_mode_bolt_attrib.getAttributeName()) vis_mode_bolt_attrib.setData("0");
	else vis_mode_bolt_attrib.setData("1");

	if (getData() != vis_mode_llama_attrib.getAttributeName()) vis_mode_llama_attrib.setData("0");
	else vis_mode_llama_attrib.setData("1");

	if (getData() != vis_mode_slot1_attrib.getAttributeName()) vis_mode_slot1_attrib.setData("0");
	else vis_mode_slot1_attrib.setData("1");
	if (getData() != vis_mode_slot2_attrib.getAttributeName()) vis_mode_slot2_attrib.setData("0");
	else vis_mode_slot2_attrib.setData("1");
	if (getData() != vis_mode_slot3_attrib.getAttributeName()) vis_mode_slot3_attrib.setData("0");
	else vis_mode_slot3_attrib.setData("1");
	if (getData() != vis_mode_slot4_attrib.getAttributeName()) vis_mode_slot4_attrib.setData("0");
	else vis_mode_slot4_attrib.setData("1");
	if (getData() != vis_mode_slot5_attrib.getAttributeName()) vis_mode_slot5_attrib.setData("0");
	else vis_mode_slot5_attrib.setData("1");
	if (getData() != vis_mode_slot6_attrib.getAttributeName()) vis_mode_slot6_attrib.setData("0");
	else vis_mode_slot6_attrib.setData("1");
	if (getData() != vis_mode_slot7_attrib.getAttributeName()) vis_mode_slot7_attrib.setData("0");
	else vis_mode_slot7_attrib.setData("1");
	if (getData() != vis_mode_slot8_attrib.getAttributeName()) vis_mode_slot8_attrib.setData("0");
	else vis_mode_slot8_attrib.setData("1");
	if (getData() != vis_mode_slot9_attrib.getAttributeName()) vis_mode_slot9_attrib.setData("0");
	else vis_mode_slot9_attrib.setData("1");
	if (getData() != vis_mode_slot10_attrib.getAttributeName()) vis_mode_slot10_attrib.setData("0");
	else vis_mode_slot10_attrib.setData("1");

	attribs_vischange = 0;
}
ConfigVisAttribute.onDataChanged() {
	if (attribs_mychange) return;
	if (attribs_vischange) return;
	NOOFF
	attribs_mychange = 1;
	vis_mode_attrib.setData(getAttributeName());
	attribs_mychange = 0;
}

ConfigOwnVisAttribute.onDataChanged() {
	if (ConfigOwnVisAttribute == vis_own1_attrib) {
		if (vis_own1_attrib.getData() == "nix") vis_mode_slot1_attrib = custom_page_vis_slots.newAttribute("Slot 1 (empty)", "0");
		else vis_mode_slot1_attrib = custom_page_vis_slots.newAttribute(getToken(vis_own1_attrib.getData(), ";", 0), "0");
	}
	if (ConfigOwnVisAttribute == vis_own2_attrib) {
		if (vis_own2_attrib.getData() == "nix") vis_mode_slot2_attrib = custom_page_vis_slots.newAttribute("Slot 2 (empty)", "0");
		else vis_mode_slot2_attrib = custom_page_vis_slots.newAttribute(getToken(vis_own2_attrib.getData(), ";", 0), "0");
	}
	if (ConfigOwnVisAttribute == vis_own3_attrib) {
		if (vis_own3_attrib.getData() == "nix") vis_mode_slot3_attrib = custom_page_vis_slots.newAttribute("Slot 3 (empty)", "0");
		else vis_mode_slot3_attrib = custom_page_vis_slots.newAttribute(getToken(vis_own3_attrib.getData(), ";", 0), "0");
	}
	if (ConfigOwnVisAttribute == vis_own4_attrib) {
		if (vis_own4_attrib.getData() == "nix") vis_mode_slot4_attrib = custom_page_vis_slots.newAttribute("Slot 4 (empty)", "0");
		else vis_mode_slot4_attrib = custom_page_vis_slots.newAttribute(getToken(vis_own4_attrib.getData(), ";", 0), "0");
	}
	if (ConfigOwnVisAttribute == vis_own5_attrib) {
		if (vis_own5_attrib.getData() == "nix") vis_mode_slot5_attrib = custom_page_vis_slots.newAttribute("Slot 5 (empty)", "0");
		else vis_mode_slot5_attrib = custom_page_vis_slots.newAttribute(getToken(vis_own5_attrib.getData(), ";", 0), "0");
	}
	if (ConfigOwnVisAttribute == vis_own6_attrib) {
		if (vis_own6_attrib.getData() == "nix") vis_mode_slot6_attrib = custom_page_vis_slots.newAttribute("Slot 6 (empty)", "0");
		else vis_mode_slot6_attrib = custom_page_vis_slots.newAttribute(getToken(vis_own6_attrib.getData(), ";", 0), "0");
	}
	if (ConfigOwnVisAttribute == vis_own7_attrib) {
		if (vis_own7_attrib.getData() == "nix") vis_mode_slot7_attrib = custom_page_vis_slots.newAttribute("Slot 7 (empty)", "0");
		else vis_mode_slot7_attrib = custom_page_vis_slots.newAttribute(getToken(vis_own7_attrib.getData(), ";", 0), "0");
	}
	if (ConfigOwnVisAttribute == vis_own8_attrib) {
		if (vis_own8_attrib.getData() == "nix") vis_mode_slot8_attrib = custom_page_vis_slots.newAttribute("Slot 8 (empty)", "0");
		else vis_mode_slot8_attrib = custom_page_vis_slots.newAttribute(getToken(vis_own8_attrib.getData(), ";", 0), "0");
	}
	if (ConfigOwnVisAttribute == vis_own9_attrib) {
		if (vis_own9_attrib.getData() == "nix") vis_mode_slot9_attrib = custom_page_vis_slots.newAttribute("Slot 9 (empty)", "0");
		else vis_mode_slot9_attrib = custom_page_vis_slots.newAttribute(getToken(vis_own9_attrib.getData(), ";", 0), "0");
	}
	if (ConfigOwnVisAttribute == vis_own10_attrib) {
		if (vis_own10_attrib.getData() == "nix") vis_mode_slot10_attrib = custom_page_vis_slots.newAttribute("Slot 10 (empty)", "0");
		else vis_mode_slot10_attrib = custom_page_vis_slots.newAttribute(getToken(vis_own10_attrib.getData(), ";", 0), "0");
	}
}
songticker_scrolling_enabled_attrib.onDataChanged() {
  if (attribs_mychange) return;
  attribs_mychange = 1;
  if (getData() == "1") songticker_scrolling_disabled_attrib.setData("0");
  if (getData() == "0") songticker_scrolling_disabled_attrib.setData("1");
  attribs_mychange = 0;
}
songticker_scrolling_disabled_attrib.onDataChanged() {
  if (attribs_mychange) return;
  attribs_mychange = 1;
  if (getData() == "1") songticker_scrolling_enabled_attrib.setData("0");
  if (getData() == "0") songticker_scrolling_enabled_attrib.setData("1");
  attribs_mychange = 0;
}

#endif

#ifdef OWNVIS_ATTRIBS_MGR

ConfigOwnVisAttribute.onDataChanged() {
	if (ConfigOwnVisAttribute == vis_own1_attrib) {
		if (vis_own1_attrib.getData() == "nix") vis_mode_slot1_attrib = custom_page_vis_slots.newAttribute("Slot 1 (empty)", "0");
		else vis_mode_slot1_attrib = custom_page_vis_slots.newAttribute(getToken(vis_own1_attrib.getData(), ";", 0), "0");
	}
	if (ConfigOwnVisAttribute == vis_own2_attrib) {
		if (vis_own2_attrib.getData() == "nix") vis_mode_slot2_attrib = custom_page_vis_slots.newAttribute("Slot 2 (empty)", "0");
		else vis_mode_slot2_attrib = custom_page_vis_slots.newAttribute(getToken(vis_own2_attrib.getData(), ";", 0), "0");
	}
	if (ConfigOwnVisAttribute == vis_own3_attrib) {
		if (vis_own3_attrib.getData() == "nix") vis_mode_slot3_attrib = custom_page_vis_slots.newAttribute("Slot 3 (empty)", "0");
		else vis_mode_slot3_attrib = custom_page_vis_slots.newAttribute(getToken(vis_own3_attrib.getData(), ";", 0), "0");
	}
	if (ConfigOwnVisAttribute == vis_own4_attrib) {
		if (vis_own4_attrib.getData() == "nix") vis_mode_slot4_attrib = custom_page_vis_slots.newAttribute("Slot 4 (empty)", "0");
		else vis_mode_slot4_attrib = custom_page_vis_slots.newAttribute(getToken(vis_own4_attrib.getData(), ";", 0), "0");
	}
	if (ConfigOwnVisAttribute == vis_own5_attrib) {
		if (vis_own5_attrib.getData() == "nix") vis_mode_slot5_attrib = custom_page_vis_slots.newAttribute("Slot 5 (empty)", "0");
		else vis_mode_slot5_attrib = custom_page_vis_slots.newAttribute(getToken(vis_own5_attrib.getData(), ";", 0), "0");
	}
	if (ConfigOwnVisAttribute == vis_own6_attrib) {
		if (vis_own6_attrib.getData() == "nix") vis_mode_slot6_attrib = custom_page_vis_slots.newAttribute("Slot 6 (empty)", "0");
		else vis_mode_slot6_attrib = custom_page_vis_slots.newAttribute(getToken(vis_own6_attrib.getData(), ";", 0), "0");
	}
	if (ConfigOwnVisAttribute == vis_own7_attrib) {
		if (vis_own7_attrib.getData() == "nix") vis_mode_slot7_attrib = custom_page_vis_slots.newAttribute("Slot 7 (empty)", "0");
		else vis_mode_slot7_attrib = custom_page_vis_slots.newAttribute(getToken(vis_own7_attrib.getData(), ";", 0), "0");
	}
	if (ConfigOwnVisAttribute == vis_own8_attrib) {
		if (vis_own8_attrib.getData() == "nix") vis_mode_slot8_attrib = custom_page_vis_slots.newAttribute("Slot 8 (empty)", "0");
		else vis_mode_slot8_attrib = custom_page_vis_slots.newAttribute(getToken(vis_own8_attrib.getData(), ";", 0), "0");
	}
	if (ConfigOwnVisAttribute == vis_own9_attrib) {
		if (vis_own9_attrib.getData() == "nix") vis_mode_slot9_attrib = custom_page_vis_slots.newAttribute("Slot 9 (empty)", "0");
		else vis_mode_slot9_attrib = custom_page_vis_slots.newAttribute(getToken(vis_own9_attrib.getData(), ";", 0), "0");
	}
	if (ConfigOwnVisAttribute == vis_own10_attrib) {
		if (vis_own10_attrib.getData() == "nix") vis_mode_slot10_attrib = custom_page_vis_slots.newAttribute("Slot 10 (empty)", "0");
		else vis_mode_slot10_attrib = custom_page_vis_slots.newAttribute(getToken(vis_own10_attrib.getData(), ";", 0), "0");
	}
}

#endif
#endif