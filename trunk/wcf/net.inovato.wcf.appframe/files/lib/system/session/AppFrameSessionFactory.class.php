<?php
// stub imports
require_once(WCF_DIR.'lib/system/session/AppFrameSession.class.php');
require_once(WCF_DIR.'lib/data/user/AppFrameUserSession.class.php');
require_once(WCF_DIR.'lib/data/user/AppFrameGuestSession.class.php');

// wcf imports
require_once(WCF_DIR.'lib/system/session/CookieSessionFactory.class.php');

/**
 * @author		Martin Poehlmann
 * @copyright	2009 Inovato, LLC <http://www.inovato.net>
 * @license		Creative Commons Attribution-Noncommercial-No Derivative Works 3.0 Unported <http://creativecommons.org/licenses/by-nc-nd/3.0/>
 * @package		net.inovato.wcf.appframe
 */

class AppFrameSessionFactory extends CookieSessionFactory {
	protected $guestClassName = 'AppFrameGuestSession';
	protected $userClassName = 'AppFrameUserSession';
	protected $sessionClassName = 'AppFrameSession';
}
?>