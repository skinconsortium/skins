<?php
// wcf imports
require_once(WCF_DIR.'lib/data/user/avatar/Gravatar.class.php');
require_once(WCF_DIR.'lib/data/user/avatar/Avatar.class.php');

// appframe imports
require_once(WCF_DIR.'lib/data/user/AbstractAppFrameUserSession.class.php');

/**
 * Represents a user session.
 *
 * @author		Martin Poehlmann
 * @copyright	2009 Inovato, LLC <http://www.inovato.net>
 * @license		Creative Commons Attribution-Noncommercial-No Derivative Works 3.0 Unported <http://creativecommons.org/licenses/by-nc-nd/3.0/>
 * @package		net.inovato.wcf.appframe
 */
class AppFrameUserSession extends AbstractAppFrameUserSession
{
	/**
	 * displayable avatar object.
	 *
	 * @var DisplayableAvatar
	 */
	protected $avatar = null;
	
	/**
	 * @see UserSession::__construct()
	 */
	public function __construct($userID = null, $row = null, $username = null)
	{
		$this->sqlSelects .= "	avatar.*,";
		$this->sqlJoins .= " 	LEFT JOIN wcf".WCF_N."_avatar avatar ON (avatar.avatarID = user.avatarID) ";
		parent::__construct($userID, $row, $username);
	}	
	
	/**
	 * @see User::handleData()
	 */
	protected function handleData($data)
	{
		parent::handleData($data);
		
		if (MODULE_AVATAR == 1 && !$this->disableAvatar && $this->showAvatar)
		{
			if (MODULE_GRAVATAR == 1 && $this->gravatar)
			{
				$this->avatar = new Gravatar($this->gravatar);
			}
			else if ($this->avatarID)
			{
				$this->avatar = new Avatar(null, $data);
			}
		}
	}
	
	/**
	 * Updates the global last activity timestamp in user database.
	 * 
	 * @param	integer		$userID
	 * @param	integer		$timestamp
	 */
	public static function updateLastActivityTime($userID, $timestamp = TIME_NOW)
	{
		// update lastActivity in wcf user table
		$sql = "UPDATE	wcf".WCF_N."_user
			SET	lastActivityTime = ".$timestamp."
			WHERE	userID = ".$userID;
		WCF::getDB()->registerShutdownUpdate($sql);
	}	

}
?>