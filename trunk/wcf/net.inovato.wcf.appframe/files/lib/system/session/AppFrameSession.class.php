<?php
// stub imports
require_once(WCF_DIR.'lib/data/user/AppFrameUserSession.class.php');
require_once(WCF_DIR.'lib/data/user/AppFrameGuestSession.class.php');

// wcf imports
require_once(WCF_DIR.'lib/system/session/CookieSession.class.php');
require_once(WCF_DIR.'lib/data/user/User.class.php');

/**
 * @author		Martin Poehlmann
 * @copyright	2009 Inovato, LLC <http://www.inovato.net>
 * @license		Creative Commons Attribution-Noncommercial-No Derivative Works 3.0 Unported <http://creativecommons.org/licenses/by-nc-nd/3.0/>
 * @package		net.inovato.wcf.appframe
 */

class AppFrameSession extends CookieSession
{
	protected $userSessionClassName = 'AppFrameUserSession';
	protected $guestSessionClassName = 'AppFrameGuestSession';
	protected $styleID = 0;
	
	/**
	 * Initialises the session.
	 */
	public function init()
	{
		parent::init();
		
		// handle style id
		if ($this->user->userID) $this->styleID = $this->user->styleID;
		if (($styleID = $this->getVar('styleID')) !== null) $this->styleID = $styleID;
		
		if ($this->userID)
		{
			/* TODO remimplement something like a global activity for all AppFrame Apps
			 * 				$sql = "DELETE FROM	wbb".WBB_N."_board_visit
					WHERE		userID = ".$this->userID."
							AND lastVisitTime <= ".($this->user->boardLastMarkAllAsReadTime);
				WCF::getDB()->registerShutdownUpdate($sql);
			 */
			
			// update global last activity time
			if ($this->lastActivityTime < TIME_NOW - USER_ONLINE_TIMEOUT + 299)
			{
				AppFrameUserSession::updateLastActivityTime($this->userID);
			}
		}
		// TODO re-implement something like this
		/*else {
			// guest
			$boardLastActivityTime = 0;
			$boardLastVisitTime = $this->user->getLastVisitTime();
			if (isset($_COOKIE[COOKIE_PREFIX.'boardLastActivityTime'])) {
				$boardLastActivityTime = intval($_COOKIE[COOKIE_PREFIX.'boardLastActivityTime']);
			}
			
			if ($boardLastActivityTime != 0 && $boardLastActivityTime < $boardLastVisitTime && $boardLastActivityTime < TIME_NOW - SESSION_TIMEOUT) {
				$this->user->setLastVisitTime($boardLastActivityTime);
				$this->resetUserData();
			}
			
			HeaderUtil::setCookie('boardLastActivityTime', TIME_NOW, TIME_NOW + 365 * 24 * 3600);
		}*/
	}
	
	/**
	 * @see CookieSession::update()
	 */
	public function update()
	{
		// nothing to do for us here atm
		//$this->updateSQL .= ", boardID = ".$this->boardID.", threadID = ".$this->threadID;
		parent::update();
	}
	
	/**
	 * Sets the active style id.
	 * 
	 * @param 	integer		$newStyleID
	 */
	public function setStyleID($newStyleID)
	{
		$this->styleID = $newStyleID;
		if ($newStyleID > 0) $this->register('styleID', $newStyleID);
		else $this->unregister('styleID');
	}
	
	/**
	 * Returns the active style id.
	 * 
	 * @return	integer
	 */
	public function getStyleID()
	{
		return $this->styleID;
	}
}
?>