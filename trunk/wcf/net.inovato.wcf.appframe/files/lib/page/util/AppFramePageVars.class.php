<?php
// appframe imports
require_once(WCF_DIR.'lib/page/util/AppFrameBreadCrumb.class.php');

/**
 * Variables for an AppFrame Page. This class isn't required for generic pages, but simplifies stuff alot if you use the AppFrame templates.
 * 
 * @author		Martin Poehlmann
 * @copyright	2009 Inovato, LLC <http://www.inovato.net>
 * @license		Creative Commons Attribution-Noncommercial-No Derivative Works 3.0 Unported <http://creativecommons.org/licenses/by-nc-nd/3.0/>
 * @package		net.inovato.wcf.appframe
 */
class AppFramePageVars
{
	// singleton Object.
	protected static $obj;
	
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
	 * Constructs a singleton object.
	 */
	public function __construct()
	{
		$this->appFrameBreadCrumbs[] = new AppFrameBreadCrumb(PAGE_TITLE, 'index.php?page=Index'.SID_ARG_2ND_NOT_ENCODED, 'indexS.png');
	}
	
	/**
	 * Builds the link to the page itself according to the class name.
	 * @param Page $page
	 */
	public function buildAppFrameSelfLink(Page $page, $addSID = true)
	{
		$last4 = substr(get_class($page), -4, 4);
		if ($last4 == 'Page')
		{
			return 'index.php?page='.substr(get_class($page), 0, -4).($addSID?SID_ARG_2ND_NOT_ENCODED:'');
		}
		else if ($last4 == 'Form')
		{
		 	return 'index.php?form='.substr(get_class($page), 0, -4).($addSID?SID_ARG_2ND_NOT_ENCODED:'');
		}
		else // we assume it's an action now
		{
			return 'index.php?action='.substr(get_class($page), 0, -6).($addSID?SID_ARG_2ND_NOT_ENCODED:'');
		}		
	}	
	
	/**
	 * Assigns all variables to the template engine.
	 */
	public function assignVariables()
	{
		WCF::getTPL()->assign(array(
			'selfLink' => $this->appFrameSelfLink,
			'allowSpidersToIndexThisPage' => $this->appFrameAllowSpidersToIndexThisPage,
			'appFrameGenericSiteTitle' => $this->appFrameGenericSiteTitle,
			'appFrameBreadCrumbs' => $this->appFrameBreadCrumbs,
			'appFrameGenericSiteShowCaption' => $this->appFrameGenericSiteShowCaption,
			'appFrameGenericSiteCaption' => $this->appFrameGenericSiteCaption,
			'appFrameGenericSiteCaptionSub' => $this->appFrameGenericSiteCaptionSub,
			'appFrameGenericSiteCaptionIcon' => $this->appFrameGenericSiteCaptionIcon,
			
		));	
	}
	
	/**
	 * Returns the singleton object.
	 */
	public static function getStore()
	{
		if (!isset(self::$obj))
		{
			self::$obj = new AppFramePageVars();
		}
		return self::$obj;
	}
}
?>