<?php
// stub imports
require_once(STUB_DIR.'lib/system/session/StubSession.class.php');
require_once(STUB_DIR.'lib/data/user/StubUserSession.class.php');
require_once(STUB_DIR.'lib/data/user/StubGuestSession.class.php');

// wcf imports
require_once(WCF_DIR.'lib/system/session/CookieSessionFactory.class.php');

/**
 * @author		Martin Poehlmann
 * @copyright	2009 Inovato, LLC <http://www.inovato.net>
 * @license		GNU Lesser General Public License <http://opensource.org/licenses/lgpl-license.php>
 * @package		net.inovato.stub
 */

class StubSessionFactory extends CookieSessionFactory {
	protected $guestClassName = 'StubGuestSession';
	protected $userClassName = 'StubUserSession';
	protected $sessionClassName = 'StubSession';
}
?>