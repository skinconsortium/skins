<?php
// wcf imports
require_once(WCF_DIR.'lib/page/AbstractAppFramePage.class.php');

// filehub imports
require_once(FILEHUB_DIR.'lib/data/file/StoredFile.class.php');

/**
 * Shows the start page.
 *
 * @author		Martin Poehlmann
 * @copyright	2009 inovato, LLC <http://www.inovato.net>
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
	
	// List of latest files
	public $latestFiles = array();	
	
	/**
	 * @see wcf/lib/page/AbstractPage#readData()
	 */
	public function readData()
	{
		$sql = "SELECT * from filehub".FILEHUB_N.StoredFile::DB_TABLE_SUFFIX."
				ORDER BY '".StoredFile::DB_PRIMARY_KEY."' DESC";
		
		WCF::getDB()->sendQuery($sql, FILEHUB_STARTPAGE_NUMUPLOADS);
		
		while($row = WCF::getDB()->fetchArray())
		{
			$this->latestFiles[] = new StoredFile(null, $row);
		}
	}
	
	public function assignVariables()
	{
		parent::assignVariables();
		WCF::getTPL()->assign(array(
			'latestFiles' => $this->latestFiles
		));
	}
}
?>
