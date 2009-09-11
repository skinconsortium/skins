<?php
// wcf imports
require_once(WCF_DIR.'lib/data/user/UserProfile.class.php');

/**
 * Represents a user.
 * 
 * @author		Martin Poehlmann
 * @copyright	2009 Inovato, LLC <http://www.inovato.net>
 * @license		GNU Lesser General Public License <http://opensource.org/licenses/lgpl-license.php>
 * @package		net.inovato.stub
 */

class AppFrameUser extends UserProfile
{
	protected $avatar = null;
	
	/**
	 * @see UserProfile::__construct()
	 */
	public function __construct($userID = null, $row = null, $username = null, $email = null)
	{
		// additional user info can be gathered like this
		// $this->sqlJoins .= ' LEFT JOIN wbb'.WBB_N.'_user wbb_user ON (wbb_user.userID = user.userID) ';
		parent::__construct($userID, $row, $username, $email);
	}
}
?>