<?php
/**
 * @author		Martin Poehlmann
 * @copyright	2009 inovato, LLC <http://www.inovato.net>
 * @license		Creative Commons Attribution-Noncommercial-No Derivative Works 3.0 Unported <http://creativecommons.org/licenses/by-nc-nd/3.0/>
 * @package		net.inovato.filehub
 */

//initialize package array
$packageDirs = array();
//include config
require_once(dirname(__FILE__).'/config.inc.php');

//include WCF
require_once(RELATIVE_WCF_DIR.'global.php');

if(!count($packageDirs)) $packageDirs[] = FILEHUB_DIR;
$packageDirs[] = WCF_DIR;

// define paths for appframe
define('APPLICATION_DIR', FILEHUB_DIR);
define('RELATIVE_APPLICATION_DIR', RELATIVE_FILEHUB_DIR);

//starting stub application
require_once(WCF_DIR.'lib/system/AppFrameCore.class.php');
new AppFrameCore();
?>
