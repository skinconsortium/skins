<?php
require_once(WCF_DIR.'lib/acp/form/ACPForm.class.php');
require_once(WCF_DIR.'lib/acp/package/plugin/StartPageInstallationPlugin.class.php');

/**
 * ACPSettings Page for making the StartSite of the forum configurable
 * 
 * @author		Martin 'mpdeimos' Poehlmann
 * @copyright	2009 Skin Consortium
 * @license		Creative Commons Attribution-Noncommercial-Share Alike 3.0 Unported License <http://creativecommons.org/licenses/by-nc-sa/3.0/>
 * @package		net.inovato.wbb.startsite
 */

class StartPageSettingsForm extends ACPForm
{
	/// WCF Required Stuff
	public $templateName = 'startPageSettings';
	public $activeMenuItem = 'wcf.acp.menu.link.system.startpage.settings';
	public $neededPermissions = 'admin.system.startpage.canSetStartPage';
	public $activeTabMenuItem = 'system';
	
	/** selected start page */
	public $pageID = -666;
	
	/** URL of custom startpage */
	public $customRequest;
	
	/** Array of suggested startpages */
	public $suggestedStartpages = array();
	
	/**
	 * @see Page::readParameters()
	 */
	public function readParameters()
	{
		parent::readParameters();
		
		if (isset($_REQUEST['status'])) $this->pageID = intval($_REQUEST['status']);
		if (isset($_REQUEST['request'])) $this->customRequest = StringUtil::trim($_REQUEST['request']);
	}
	
	
	/**
	 * @see Page::readData()
	 */
	public function readData()
	{
		parent::readData();
		
		// Select pages from DB that were suggested to be a startpage.
		$sql = "SELECT *
			FROM	wcf".WCF_N."_startpage";
		
		WCF::getDB()->sendQuery($sql);	
		
		while($row = WCF::getDB()->fetchArray())
		{
			if ($row['packageID'] > 0)
			{
				$this->suggestedStartpages[$row['pageID']] = $row['pageName'];
			}
			else if (!isset($customRequest))
			{
				$this->customRequest = $row['request'];
			}
		}
	}	
	
	/**
	 * @see Form::save()
	 */
	public function save()
	{
		parent::save();
		
		// save custom request
		$sql = "UPDATE	wcf".WCF_N."_startpage
				SET		request = '".escapeString($this->customRequest)."'
				WHERE	packageID = 0";
		WCF::getDB()->registerShutdownUpdate($sql);
		
		// Feed database
		StartPageInstallationPlugin::setStartPage($this->pageID, $this->pageID < 0 ? $this->customRequest : null);
		
		$this->saved();
		// show succes message
		WCF::getTPL()->assign(array('success' => true,
									'general_wbbstartpage_customrequest' => $this->customRequest,
									'general_wbbstartpage_status' => $this->pageID
		));
						
	}	
	
	/**
	 * @see Page::assignVariables()
	 */
	public function assignVariables()
	{
		parent::assignVariables();
		
		WCF::getTPL()->assign(array(
			'activeTabMenuItem' => $this->activeTabMenuItem,
			'suggestedStartpages' => $this->suggestedStartpages,
		));
		
		if ($this->pageID == -666)
		{
			WCF::getTPL()->assign(array(
				'general_wbbstartpage_customrequest' => $this->customRequest,
				'general_wbbstartpage_status' => GENERAL_WBBSTARTPAGE_STATUS,		
			));
		}	
	}
}
?>