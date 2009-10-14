<?php
require_once(WCF_DIR.'lib/system/event/EventListener.class.php');

/**
 * Eventlistener for making the Start Page of the forum configurable
 * 
 * @author		Martin 'mpdeimos' Poehlmann
 * @copyright	2009 Skin Consortium
 * @license		Creative Commons Attribution-Noncommercial-Share Alike 3.0 Unported License <http://creativecommons.org/licenses/by-nc-sa/3.0/>
 * @package		net.inovato.wbb.startpage
 */

class StartPageListener implements EventListener
{
	/**
	 * @see EventListener::execute()
	 */
	public function execute($eventObj, $className, $eventName) 
	{
		if (GENERAL_WBBSTARTPAGE_STATUS)
		{
			if (!empty($_GET['page']) || !empty($_POST['page']))
			{
				return;
			}
			if (!empty($_GET['action']) || !empty($_POST['action']))
			{
				return;
			}
			if (!empty($_GET['form']) || !empty($_POST['form']))
			{
				return;
			}
			$requests = explode('&', GENERAL_WBBSTARTPAGE_REQUEST);
			
			// To prevent the whole WBB core to be reloaded, we set the _GET & _REQUEST vars to the new start page
			foreach($requests as $request)
			{
				$rpair = explode('=', $request);
				
				if (count($rpair) != 2) // Seems like this is a really strange request -- so let's do a redirect
				{
					// TODO (mpdeimos) Attach SID?
					HeaderUtil::redirect("index.php?".GENERAL_WBBSTARTPAGE_REQUEST, false);
					exit;
				}

				$_GET[$rpair[0]] = $rpair[1];
				$_REQUEST[$rpair[0]] = $rpair[1];

			}
		}
	}
}
?>