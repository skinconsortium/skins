<?php
// wcf imports
require_once(WCF_DIR.'lib/page/AbstractPage.class.php');

/**
 * @author		Martin Poehlmann
 * @copyright	2009 Inovato, LLC <http://www.inovato.net>
 * @license		Creative Commons Attribution-Noncommercial-No Derivative Works 3.0 Unported <http://creativecommons.org/licenses/by-nc-nd/3.0/>
 * @package		net.inovato.wcf.appframe
 */

abstract class AbstractAppFramePage extends AbstractPage
{
	public $templateName = 'appFrameGenericSite';
	
	// Site Title. May be a language var.
	public $appFrameGenericSiteTitle = '';
	
	// Shows the Site Caption
	public $appFrameGenericSiteShowCaption = true;
	
	// Site caption text. May be language vars.
	public $appFrameGenericSiteCaption = '';
	public $appFrameGenericSiteCaptionSub = '';
	
	// Icon shown beside the caption.
	public $appFrameGenericSiteCaptionIcon = '';
	

	/**
	 * @see Page::assignVariables();
	 */
	public function assignVariables()
	{
		parent::assignVariables();

		WCF::getTPL()->assign(array(
			'selfLink' => 'index.php?page=Index'.SID_ARG_2ND_NOT_ENCODED,
			'allowSpidersToIndexThisPage' => true,
			'appFrameGenericSiteTitle' => $this->appFrameGenericSiteTitle,
			'appFrameGenericSiteShowCaption' => $this->appFrameGenericSiteShowCaption,
			'appFrameGenericSiteCaption' => $this->appFrameGenericSiteCaption,
			'appFrameGenericSiteCaptionSub' => $this->appFrameGenericSiteCaptionSub,
			'appFrameGenericSiteCaptionIcon' => $this->appFrameGenericSiteCaptionIcon,
			
		));
		
		/* TODO reimplement something like this
		check if (WCF::getSession()->spiderID)
		{
			if ($lastChangeTime = @filemtime(WBB_DIR.'cache/cache.stat.php')) {
				@header('Last-Modified: '.gmdate('D, d M Y H:i:s', $lastChangeTime).' GMT');
			}
		}*/
	}
}
?>