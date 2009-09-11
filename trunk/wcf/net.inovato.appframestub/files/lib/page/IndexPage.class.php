<?php
// wcf imports
require_once(WCF_DIR.'lib/page/AbstractAppFramePage.class.php');

/**
 * Shows the start page.
 *
 * @author		Martin Poehlmann
 * @copyright	2009 Inovato, LLC <http://www.inovato.net>
 * @license		Creative Commons Attribution-Noncommercial-No Derivative Works 3.0 Unported <http://creativecommons.org/licenses/by-nc-nd/3.0/>
 * @package		net.inovato.wcf.appframe
 */
class IndexPage extends AbstractAppFramePage
{
	public $templateName = 'index';
	
	// Site Title. May be a language var.
	public $appFrameGenericSiteTitle = 'wcf.appframe.generic.home';
	
	// Shows the Site Caption
	public $appFrameGenericSiteShowCaption = true;
	
	// Site caption text. May be language vars.
	public $appFrameGenericSiteCaption = PAGE_TITLE;
	public $appFrameGenericSiteCaptionSub = PAGE_DESCRIPTION;
	
	// Icon shown beside the caption.
	public $appFrameGenericSiteCaptionIcon = 'appFrameHomeL.png';
}
?>