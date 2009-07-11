<?php
require_once(WCF_DIR.'lib/acp/package/plugin/AbstractPackageInstallationPlugin.class.php');
require_once(WCF_DIR.'lib/acp/package/PackageInstallation.class.php');
require_once(WCF_DIR.'lib/acp/package/PackageUninstallation.class.php');
require_once(WCF_DIR.'lib/acp/option/Options.class.php');

/**
 * PIP for installing StartPages
 * 
 * @author		Martin 'mpdeimos' Poehlmann
 * @copyright	2009 Skin Consortium
 * @license		Creative Commons Attribution-Noncommercial-Share Alike 3.0 Unported License <http://creativecommons.org/licenses/by-nc-sa/3.0/>
 * @package		me.songbook.wbb.startpage
*/

class StartPageInstallationPlugin extends AbstractPackageInstallationPlugin
{
	/** DB table suffix */	
	const TABLE_NAME = 'startpage';
	/** DB table suffix */
	public $tableName = self::TABLE_NAME;
	
	/** Tagname of our PIP */
	public $tagName = 'startpage';

	/**
	 * @see AbstractPackageInstallationPlugin::install()
	 */
	public function install() {
		parent::install();
		
		// create associative array of startpages the current plugin offers
		$instructions = $this->installation->getInstructions();
		$pages = $instructions[$this->tagName];
		$pagesToInstall = array();
		foreach ($pages as $page)
		{
			$pagesToInstall[$page['cdata']] = $page['name'];
		}
		
		if (!isset($_POST['send'])) // Executed before showing the Selection page
		{
			// Insert suggested Start Pages in DB
			self::suggestStartPages($this->installation->getPackageID(), $pagesToInstall);
		
			// Now the DB is setup up, we can display some options to the admin
			WCF::getTPL()->assign(array(
				'pagesToInstall' => $pagesToInstall,
			));
			
			WCF::getTPL()->display('packageInstallationStartPageSelect');
			exit;
		}
		else // Executed after the user has selected a start page
		{
			if ($_POST['request'] != "keep") // no updates if the user wishes to keep the current startsite
			{
				$pageID = self::getPageID($this->installation->getPackageID(), $_POST['request']);
				
				self::setStartPage($pageID, $_POST['request']);
			}
		}
	}

	/**
	 * @see AbstractPackageInstallationPlugin::uninstall()
	 */	
	public function uninstall()
	{
		// check if a page of the currently uninstalling plugin is set as startsite
		$sql = "SELECT	COUNT(*) as count
			FROM	wcf".WCF_N."_".self::TABLE_NAME."
			WHERE	packageID = ".$this->installation->getPackageID()."
			AND		pageID = ".GENERAL_WBBSTARTPAGE_STATUS;
		$count = WCF::getDB()->getFirstRow($sql);
		
		if ($count['count'] > 0)
		{
			self::setStartPage(0);		
		}

		parent::uninstall();
	}

	/**
	 * @see AbstractPackageInstallationPlugin::hasUnistall()
	 */	
	public function hasUnistall()
	{
		parent::hasUninstall();
	}
	
	
	/// Open API for setting/suggesting the Start Page
	
	/**
	 * Adds new pages to the suggested startpage list. If a request already exists, the name of this request is updated.
	 *
	 * @param integer		$packageID	ID of the package this pages belong to. Needed for uninstallation and needs to be greater than 0.
	 * @param languageVar 	$pages		Associative array of page requests (key) and page names (values). Page requests should not contain any session information and page names should be a language variable.
	 */
	public static function suggestStartPages($packageID, $pages)
	{
		if ($packageID == 0 || empty($pages))
		{
			return;
		}
		
		// get startpages that were already installed by this plugin
		$sql = "SELECT	request
			FROM	wcf".WCF_N."_".self::TABLE_NAME."
			WHERE	packageID = ".$packageID;
		
		WCF::getDB()->sendQuery($sql);
		$installedRequests = array();
		while($row = WCF::getDB()->fetchArray())
		{		
			$installedRequests[] = $row['request'];
		}
		
		$sql = "INSERT INTO wcf".WCF_N."_".self::TABLE_NAME." (packageID, pageName, request) VALUES ";
		$first = true;
		foreach ($pages as $pageRequest => $pageName) {
			if (!in_array($pageRequest, $installedRequests)) // add new entries
			{
				if ($first)
				{
					$first = false;
				}
				else
				{
					$sql .= ', ';
				}
				$sql .= "('".$packageID."', '".$pageName."', '".$pageRequest."')"; 
			}
			else // update existing entries
			{
				$nsql = "UPDATE wcf".WCF_N."_".self::TABLE_NAME."
				SET		pageName = '".$pageName."'
				WHERE	packageID = ".$packageID."
				AND		request = '".$pageRequest."'";
				$installationCount = WCF::getDB()->sendQuery($nsql);			
			}
		}

		// just send query if there is actualy something to do.
		if (!$first)
			WCF::getDB()->sendQuery($sql);
	}
	
	/**
	 * Returns the pageID of a packageID, request pair.
	 *
	 * @param integer	 $packageID
	 * @param string	 $request
	 */
	public static function getPageID($packageID, $request)
	{
		$sql = "SELECT	pageID
			FROM	wcf".WCF_N."_".self::TABLE_NAME."
			WHERE	packageID = ".$packageID."
			AND		request = '".$request."'";

		$row = WCF::getDB()->getFirstRow($sql);
		
		return $row['pageID'];
	}
	
	/**
	 * Sets the WBB startpage to a suggested page stored in the db.
	 *
	 * @param integer	 $pageID	ID of the new start page in our DB. If $pageID is 0 the default start page (Forum Root) is used. If $pageID is -1 the custom startpage is used.
	 * @param string	 $request	(optional) request of the new startpage. Will be read from DB if not specified.
	 */
	public static function setStartPage($pageID, $request = null)
	{
		if ($pageID != 0 && $request == null) // If not specified read the request from DB
		{
			$sql = "SELECT	request
				FROM	wcf".WCF_N."_".self::TABLE_NAME."
				WHERE	pageID = ".($pageID < 0 ? 1 : $pageID);
	
			$row = WCF::getDB()->getFirstRow($sql);

			$request = $row['request'];
		}

		// get startpage plugin ID
		$sql = "SELECT packageID
			FROM	wcf".WCF_N."_package
			WHERE 	package = 'me.songbook.wbb.startpage'
			AND		parentPackageID = ".PACKAGE_ID;
		
		$row = WCF::getDB()->getFirstRow($sql);
		
		//die("".$pageID);

		// insert stuff in options table
		$sql = "UPDATE	wcf".WCF_N."_option
				SET		optionValue = '".$pageID."'
				WHERE	optionName = 'general_wbbstartpage_status'
				AND 	packageID = ". $row['packageID'];
		WCF::getDB()->sendQuery($sql);
		
		if ($pageID != 0)
		{
			$sql = "UPDATE	wcf".WCF_N."_option
					SET		optionValue = '".$request."'
					WHERE	optionName = 'general_wbbstartpage_request'
					AND 	packageID = ". $row['packageID'];
			WCF::getDB()->sendQuery($sql);
		}
	
		// clear cache
		Options::resetCache();
		
		// delete relevant options.inc.php's
		Options::resetFile();
	}
}
?>