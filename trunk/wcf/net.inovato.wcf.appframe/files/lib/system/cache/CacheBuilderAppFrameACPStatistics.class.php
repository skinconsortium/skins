<?php
require_once(WCF_DIR.'lib/system/cache/CacheBuilder.class.php');

/**
 * Shows the welcome page in admin control panel.
 * 
 * @author		Martin Poehlmann
 * @copyright	2009 Inovato, LLC <http://www.inovato.net>
 * @license		Creative Commons Attribution-Noncommercial-No Derivative Works 3.0 Unported <http://creativecommons.org/licenses/by-nc-nd/3.0/>
 * @package		net.inovato.wcf.appframe
 */
class CacheBuilderAppFrameACPStatistics implements CacheBuilder
{
	/**
	 * @see CacheBuilder::getData()
	 */
	public function getData($cacheResource)
	{
		$data = array();
		
		// appframe version
		$sql = "SELECT	packageVersion
				FROM	wcf" . WCF_N . "_package
				WHERE	package = 'net.inovato.wcf.appframe'";
		$row = WCF::getDB()->getFirstRow($sql);
		$data['appFrameVersion'] = $row['packageVersion'];
		
		// members
		$sql = "SELECT	COUNT(*) AS members
				FROM	wcf" . WCF_N . "_user";
		$row = WCF::getDB()->getFirstRow($sql);
		$data['members'] = $row['members'];
		
		// database entries and size
		$data['databaseSize'] = 0;
		$data['databaseEntries'] = 0;
		$sql = "SHOW TABLE STATUS";
		$result = WCF::getDB()->sendQuery($sql);
		while($row = WCF::getDB()->fetchArray($result))
		{
			$data['databaseSize'] += $row['Data_length'] + $row['Index_length'];
			$data['databaseEntries'] += $row['Rows'];
		}			
		
		return $data;
	}
}

?>