<?php
require_once(WCF_DIR.'lib/system/WCFACP.class.php');
require_once(WCF_DIR.'lib/util/AppFrameUtil.class.php');

/**
 * @author		Martin Poehlmann
 * @copyright	2009 Inovato, LLC <http://www.inovato.net>
 * @license		Creative Commons Attribution-Noncommercial-No Derivative Works 3.0 Unported <http://creativecommons.org/licenses/by-nc-nd/3.0/>
 * @package		net.inovato.wcf.appframe
 */

class AppFrameACP extends WCFACP
{
	/**
	 * @see WCF::getOptionsFilename()
	 */
	protected function getOptionsFilename()
	{
		return APPLICATION_DIR.'options.inc.php';
	}
	
	/**
	 * Initialises the template engine.
	 */
	protected function initTPL()
	{
		global $packageDirs;
		
		self::$tplObj = new ACPTemplate(self::getLanguage()->getLanguageID(), ArrayUtil::appendSuffix($packageDirs, 'acp/templates/'));
		$this->assignDefaultTemplateVariables();
	}
	
	/**
	 * Does the user authentication.
	 */
	protected function initAuth()
	{
		parent::initAuth();
		
		// user ban
		if (self::getUser()->banned)
		{
			require_once(WCF_DIR.'lib/system/exception/PermissionDeniedException.class.php');
			throw new PermissionDeniedException();
		}
	}
	
	/**
	 * @see WCF::assignDefaultTemplateVariables()
	 */
	protected function assignDefaultTemplateVariables()
	{
		parent::assignDefaultTemplateVariables();
		
		$jumpToAppIcon = AppFrameUtil::getResource('/icon/appFrameHomeS.png');
		
		self::getTPL()->assign(array(
			// add jump to application link 			
			'additionalHeaderButtons' => '<li><a href="'.RELATIVE_APPLICATION_DIR.'index.php?page=Index"><img src="'.$jumpToAppIcon.'" alt="" /> <span>'.WCF::getLanguage()->get('wcf.appframe.acp.jumpToApp').'</span></a></li>',
			// individual page title
			'pageTitle' => StringUtil::encodeHTML(PAGE_TITLE . ' - ' . PACKAGE_NAME . ' ' . PACKAGE_VERSION)
		));
	}
}
?>