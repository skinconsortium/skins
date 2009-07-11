<?php
require_once(WCF_DIR.'lib/system/event/EventListener.class.php');

/**
 * Eventlistener for making the Start Page of the forum configurable
 * 
 * @author		Martin 'mpdeimos' Poehlmann
 * @copyright	2009 Skin Consortium
 * @license		Creative Commons Attribution-Noncommercial-Share Alike 3.0 Unported License <http://creativecommons.org/licenses/by-nc-sa/3.0/>
 * @package		me.songbook.wbb.startpage
 */

class StartPageListener implements EventListener
{
	/**
	 * @see EventListener::execute()
	 */
	public function execute($eventObj, $className, $eventName) 
	{
		if (GENERAL_WBBSTARTPAGE_STATUS && empty($_GET['page']) && empty($_POST['page']))
		{
			// TODO (mpdeimos) Attach SID?
			HeaderUtil::redirect("index.php?".GENERAL_WBBSTARTPAGE_REQUEST);
		}
	}
}
?>