<?php
// wcf imports
require_once(WCF_DIR.'lib/form/AbstractForm.class.php');

// appframe imports
require_once(WCF_DIR.'lib/page/AbstractAppFramePage.class.php');
require_once(WCF_DIR.'lib/page/AppFramePage.class.php');
require_once(WCF_DIR.'lib/page/util/AppFrameBreadCrumb.class.php');

/**
 * @author		Martin Poehlmann
 * @copyright	2009 Inovato, LLC <http://www.inovato.net>
 * @license		Creative Commons Attribution-Noncommercial-No Derivative Works 3.0 Unported <http://creativecommons.org/licenses/by-nc-nd/3.0/>
 * @package		net.inovato.wcf.appframe
 */

abstract class AbstractAppFrameForm extends AbstractForm implements AppFramePage
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
	
	// Self Link to the page. This will normally be constructed out of the classname. Modify in setSelfLink() method.
	public $appFrameSelfLink;
	
	// Allow Searchbots to index the page.
	public $appFrameAllowSpidersToIndexThisPage = true;
	
	// BreadCrumb navigation entries 
	public $appFrameBreadCrumbs = array();
	
	/**
	 * Creates a new AbstractAppFrameForm object.
	 */
	public function __construct()
	{
		$this->setSelfLink();
		parent::__construct();
	}
	
	/**
	 * Sets the self link
	 */
	public function setSelfLink()
	{
		$this->appFrameSelfLink = AbstractAppFramePage::buildAppFrameSelfLink($this);
	}

	/**
	 * @see Page::assignVariables();
	 */
	public function assignVariables()
	{
		parent::assignVariables();

		AbstractAppFramePage::assignAppFrameVariables($this);
		
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