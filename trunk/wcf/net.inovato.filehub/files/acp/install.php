<?php
/**
 * Installation scripts.
 * 
 * @author		Martin Poehlmann
 * @copyright	2009 Inovato, LLC <http://www.inovato.net>
 * @license		Creative Commons Attribution-Noncommercial-No Derivative Works 3.0 Unported <http://creativecommons.org/licenses/by-nc-nd/3.0/>
 * @package		net.inovato.filehub
 */

// change group options from admin group to true
/*$sql = "UPDATE	wcf".WCF_N."_group_option_value
	SET	optionValue = 1
	WHERE	groupID = 4
		AND optionValue = '0'";
WCF::getDB()->sendQuery($sql);*/
?>