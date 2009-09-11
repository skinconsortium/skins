<?php
/**
 * @author		Martin Poehlmann
 * @copyright	2009 Inovato, LLC <http://www.inovato.net>
 * @license		GNU Lesser General Public License <http://opensource.org/licenses/lgpl-license.php>
 * @package		net.inovato.appframestub
 */

// define paths
define('RELATIVE_APPFRAMESTUB_DIR', '../');

// include config
$packageDirs = array();
require_once(dirname(dirname(__FILE__)).'/config.inc.php');

// include WCF
require_once(RELATIVE_WCF_DIR.'global.php');
if (!count($packageDirs)) $packageDirs[] = APPFRAMESTUB_DIR;
$packageDirs[] = WCF_DIR;

// define paths for appframe
define('APPLICATION_DIR', APPFRAMESTUB_DIR);
define('RELATIVE_APPLICATION_DIR', RELATIVE_APPFRAMESTUB_DIR);

// starting appframe acp
require_once(WCF_DIR.'lib/system/AppFrameACP.class.php');
new AppFrameACP();
?>