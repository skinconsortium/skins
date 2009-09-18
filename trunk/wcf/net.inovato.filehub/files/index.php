<?php
/**
 * @author		Martin Poehlmann
 * @copyright	2009 inovato, LLC <http://www.inovato.net>
 * @license		Creative Commons Attribution-Noncommercial-No Derivative Works 3.0 Unported <http://creativecommons.org/licenses/by-nc-nd/3.0/>
 * @package		net.inovato.stub
 */

require_once('./global.php');
RequestHandler::handle(ArrayUtil::appendSuffix($packageDirs, 'lib/'));
?>
