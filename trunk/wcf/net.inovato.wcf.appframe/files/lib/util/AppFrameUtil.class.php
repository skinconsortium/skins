<?php

/**
 * Utility Class for WCF AppFrame
 * 
 * @author		Martin Poehlmann
 * @copyright	2009 Inovato, LLC <http://www.inovato.net>
 * @license		Creative Commons Attribution-Noncommercial-No Derivative Works 3.0 Unported <http://creativecommons.org/licenses/by-nc-nd/3.0/>
 * @package		net.inovato.wcf.appframe
 */

class AppFrameUtil
{
	/**
	 * Returns the relative path to a resource file.
	 * 
	 * @param path to a resource like '/icon/homeS.png'. Path must start with a /.
	 * @return relative path to resource
	 */
	public static function getResource($path)
	{

		if (is_file(APPLICATION_DIR.$path))
		{
			return RELATIVE_APPLICATION_DIR.$path;
		}

		return RELATIVE_WCF_DIR.$path;
	}
}
?>