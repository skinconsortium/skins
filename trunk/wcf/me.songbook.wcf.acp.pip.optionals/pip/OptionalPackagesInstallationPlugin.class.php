<?php
require_once(WCF_DIR.'lib/acp/package/plugin/AbstractXMLPackageInstallationPlugin.class.php');
require_once(WCF_DIR.'lib/acp/package/PackageInstallation.class.php');
require_once(WCF_DIR.'lib/acp/package/PackageUninstallation.class.php');

/**
	* @author	Martin Poehlmann
	* @copyright	Songbook.me <http://www.songbook.me/>
	* @license	GNU Lesser General Public License <http://opensource.org/licenses/lgpl-license.php>
	* @package	me.songbook.wcf.acp.pip.optionals
*/

class OptionalPackagesInstallationPlugin extends AbstractXMLPackageInstallationPlugin {
	public $tagName = 'optionals';
	public $tableName = 'optionals_dummy';

	public function install() {
		parent::install();
	}

	// we do not manage uninstalling! this must be done via package dependencies!
	public function uninstall() {
		//parent::uninstall();
	}

	// we do not manage uninstalling! this must be done via package dependencies!
	public function hasUnistall()
	{
		return false;
	}
	
	
}
?>