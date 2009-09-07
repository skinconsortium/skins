<?php
// stub imports
require_once(STUB_DIR.'lib/data/user/StubUserSession.class.php');
require_once(STUB_DIR.'lib/data/user/StubGuestSession.class.php');

// wcf imports
require_once(WCF_DIR.'lib/system/session/CookieSession.class.php');
require_once(WCF_DIR.'lib/data/user/User.class.php');

/**
 * @author		Martin Poehlmann
 * @copyright	2009 Inovato, LLC <http://www.inovato.net>
 * @license		GNU Lesser General Public License <http://opensource.org/licenses/lgpl-license.php>
 * @package		net.inovato.stub
 */

class StubSession extends CookieSession {
	protected $userSessionClassName = 'StubUserSession';
	protected $guestSessionClassName = 'StubGuestSession';
	protected $styleID = 0;
	
	/**
	 * Initialises the session.
	 */
	public function init() {
		parent::init();
		
		// handle style id
		if ($this->user->userID) $this->styleID = $this->user->styleID;
		if (($styleID = $this->getVar('styleID')) !== null) $this->styleID = $styleID;
		
		if ($this->userID) {

			// update user stats goes in here
			/*if ($this->user->boardLastActivityTime > $this->user->boardLastVisitTime && $this->user->boardLastActivityTime < TIME_NOW - SESSION_TIMEOUT) {

				// reset user data
				$this->resetUserData();
			}*/
			
			// update global last activity time
			if ($this->lastActivityTime < TIME_NOW - USER_ONLINE_TIMEOUT + 299) {
				StubUserSession::updateLastActivityTime($this->userID);
			}
		}
		// TODO re-implement
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
	public function update() {
		// nothing to do for the stub atm
		//$this->updateSQL .= ", boardID = ".$this->boardID.", threadID = ".$this->threadID;
		 
		parent::update();
	}
	
	/**
	 * Sets the active style id.
	 * 
	 * @param 	integer		$newStyleID
	 */
	public function setStyleID($newStyleID) {
		$this->styleID = $newStyleID;
		if ($newStyleID > 0) $this->register('styleID', $newStyleID);
		else $this->unregister('styleID');
	}
	
	/**
	 * Returns the active style id.
	 * 
	 * @return	integer
	 */
	public function getStyleID() {
		return $this->styleID;
	}
}
?>