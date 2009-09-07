<?php
// wcf imports
require_once(WCF_DIR.'lib/page/AbstractPage.class.php');
require_once(WCF_DIR.'lib/acp/package/PackageInstallationQueue.class.php');
require_once(WCF_DIR.'lib/data/feed/FeedReaderSource.class.php');

/**
 * Shows the welcome page in admin control panel.
 * 
 * @author		Martin Poehlmann
 * @copyright	2009 Inovato, LLC <http://www.inovato.net>
 * @license		Creative Commons Attribution-Noncommercial-No Derivative Works 3.0 Unported <http://creativecommons.org/licenses/by-nc-nd/3.0/>
 * @package		net.inovato.wcf.appframe
 */
abstract class AppFrameIndexPage extends AbstractPage
{
	// template
	public $templateName = 'appFrameIndex';
	
	// data
	public $os = '', $webserver = '', $sqlVersion = '', $sqlType = '', $load = '';
	public $stat = array();
	public $news = array();
	public $updates = array();
	
	/**
	 * @see Page::readData()
	 */
	public function readData() {
		parent::readData();
		
		$this->os = PHP_OS;
		if (isset($_SERVER['SERVER_SOFTWARE'])) $this->webserver = $_SERVER['SERVER_SOFTWARE'];
		$this->sqlVersion = WCF::getDB()->getVersion();
		$this->sqlType = WCF::getDB()->getDBType();
		$this->readLoad();
		$this->readStat();
		
		$this->readUpdates();
		$this->readNewsFeeds();
	}
	
	/**
	 * Checks for available updates
	 */
	public function readUpdates()
	{
		if (WCF::getUser()->getPermission('admin.system.package.canUpdatePackage'))
		{
			require_once(WCF_DIR.'lib/acp/package/update/PackageUpdate.class.php');
			$this->updates = PackageUpdate::getAvailableUpdates();
		}
	}
	
	/**
	 * Checks for recent newsfeeds.
	 */
	public function readNewsFeeds()
	{
		$this->news = FeedReaderSource::getEntries(5);
		foreach ($this->news as $key => $news)
		{
			$this->news[$key]['description'] = preg_replace('/href="(.*?)"/e', '\'href="'.RELATIVE_WCF_DIR.'acp/dereferrer.php?url=\'.rawurlencode(\'$1\').\'" class="externalURL"\'', $news['description']);
		}		
	}
	
	/**
	 * @see Page::show()
	 */
	public function show() {
		// Borrowed Code from WCF IndexPage (ACP) - cannot inherit due to missing namespaces
		{
			$wcfPackageID = WCFACP::getWcfPackageID();
			// check package installation queue
			if ($wcfPackageID == 0) {
				PackageInstallationQueue::checkPackageInstallationQueue();
			}
			
			if (WCFACP::getWcfPackageID() == PACKAGE_ID) {
				$packages = WCF::getCache()->get('packages');
				foreach ($packages as $packageID => $package) {
					break;
				}
				
				if (isset($packageID) && $packageID != PACKAGE_ID) {
					HeaderUtil::redirect('../'.$packages[$packageID]['packageDir'].'acp/index.php'.SID_ARG_1ST, false);
					exit;
				}
			}
		}
		
		// show page
		parent::show();
		
	}
	
	/**
	 * Gets a list of simple statistics.
	 */
	protected function readStat()
	{
		// appframe version
		$sql = "SELECT	packageVersion
				FROM	wcf" . WCF_N . "_package
				WHERE	package = 'net.inovato.wcf.appframe'";
		$row = WCF::getDB()->getFirstRow($sql);
		$this->stat['appFrameVersion'] = $row['packageVersion'];
		
		
		// members
		$sql = "SELECT	COUNT(*) AS members
				FROM	wcf" . WCF_N . "_user";
		$row = WCF::getDB()->getFirstRow($sql);
		$this->stat['members'] = $row['members'];
		
		// database entries and size
		// TODO use caching
		$this->stat['databaseSize'] = 0;
		$this->stat['databaseEntries'] = 0;
		$sql = "SHOW TABLE STATUS";
		$result = WCF::getDB()->sendQuery($sql);
		while($row = WCF::getDB()->fetchArray($result))
		{
			$this->stat['databaseSize'] += $row['Data_length'] + $row['Index_length'];
			$this->stat['databaseEntries'] += $row['Rows'];
		}
		
		// total users online
		$sql = "SELECT	COUNT(*) AS totalUsersOnline
			FROM	wcf".WCF_N."_session
			WHERE	lastActivityTime > ".(TIME_NOW - USER_ONLINE_TIMEOUT);
		$row = WCF::getDB()->getFirstRow($sql);
		$this->stat['totalUsersOnline'] = $row['totalUsersOnline'];		
		
		// users online
		$sql = "SELECT	COUNT(*) AS usersOnline
			FROM	wcf".WCF_N."_session
			WHERE	packageID = ".PACKAGE_ID."
				AND lastActivityTime > ".(TIME_NOW - USER_ONLINE_TIMEOUT);
		$row = WCF::getDB()->getFirstRow($sql);
		$this->stat['usersOnline'] = $row['usersOnline'];
	}
	
	/**
	 * Gets the current server load.
	 */
	protected function readLoad() {
		if ($uptime = @exec("uptime")) {
			if (preg_match("/averages?: ([0-9\.]+,?[\s]+[0-9\.]+,?[\s]+[0-9\.]+)/", $uptime, $match)) {
				$this->load = $match[1];
			}
		}
	}	
	
	/**
	 * @see Page::assignVariables()
	 */
	public function assignVariables() {
		parent::assignVariables();
		
		WCF::getTPL()->assign(array(
			'os' => $this->os,
			'webserver' => $this->webserver,
			'sqlVersion' => $this->sqlVersion,
			'sqlType' => $this->sqlType,
			'load' => $this->load,
			'news' => $this->news,
			'updates' => $this->updates,
			'dbName' => WCF::getDB()->getDatabaseName(),
			'cacheSource' => get_class(WCF::getCache()->getCacheSource())
		));
		WCF::getTPL()->assign($this->stat);
	}	
}
?>