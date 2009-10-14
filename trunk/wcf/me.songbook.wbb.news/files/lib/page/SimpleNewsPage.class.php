<?php
/**
 * Shows 1st post of newest thread in our news board
 * 
 * @author		Martin 'mpdeimos' Poehlmann
 * @copyright	2008 Skin Consortium
 * @license		Creative Commons Attribution-Noncommercial-Share Alike 3.0 Unported License <http://creativecommons.org/licenses/by-nc-sa/3.0/>
 * @package		me.songbook.wbb.news
 */

require_once(WCF_DIR.'lib/page/AbstractPage.class.php');
require_once(WBB_DIR.'lib/data/board/Board.class.php');
require_once(WBB_DIR.'lib/data/thread/Thread.class.php');
require_once(WBB_DIR.'lib/data/post/ViewablePost.class.php');
require_once(WBB_DIR.'lib/data/thread/ThreadList.class.php');

class SimpleNewsPage extends AbstractPage
{
	/** name of our main template */
	public $templateName = 'sb.news';
	
	/** The IDs of the most recent threads in our news forum */
	public $hotTopics;
	public $hotThreads;
	public $rssIDs;
	
	private $boards = array();
	private $boardsToCheck = array();
		
	public function readParameters ()
	{
		parent::readParameters();

		$threadList = new ThreadList();
		
		$threadList->limit = SONGBOOK_NEWS_HOTTOPIC_NUMBEROFTOPICS;
		$threadList->offset = 0;
		$threadList->sqlOrderBy = "time DESC";
		if (SONGBOOK_NEWS_HOTTOPIC_SUBBOARDS)
		{
			$this->boardsToCheck = explode(",",SONGBOOK_NEWS_HOTTOPIC_BOARDID);
			$this->recGetSubBoards();	
		}
		else
		{
			$this->boards = explode(",",SONGBOOK_NEWS_HOTTOPIC_BOARDID);
			//$this->rssIDs = explode(",",SONGBOOK_NEWS_HOTTOPIC_BOARDID);
			//$threadList->sqlConditions = "boardID = ".SONGBOOK_NEWS_HOTTOPIC_BOARDID;
			//$this->rssIDs = SONGBOOK_NEWS_HOTTOPIC_BOARDID;
		}
		
		$this->rssIDs = implode(",", $this->boards);
		$threadList->sqlConditions = "boardID in (".$this->rssIDs.")";
		
		if (!SONGBOOK_NEWS_HOTTOPIC_SHOWANNOUNCEMENTS) $threadList->sqlConditions .= " AND isAnnouncement = 0";
		if (!SONGBOOK_NEWS_HOTTOPIC_SHOWSTICKIES) $threadList->sqlConditions .= " AND isSticky = 0";
		
		$threadList->readThreads();
		
		$this->hotThreads = $threadList->threads;
		
		$threadIDs = explode(",", $threadList->threadIDs);
		
		$this->hotTopics = Array();
		foreach ($threadList->threads as $key => $thread)
		{
			$this->hotTopics[] = new ViewablePost($thread->firstPostID, null, SONGBOOK_NEWS_HOTTOPIC_BOARDID);
			if (SONGBOOK_NEWS_HOTTOPIC_INCTHREADVIEWS) $this->updateViews($threadIDs[$key]);
		}
		
	}
	
	public function assignVariables ()
	{
		parent::assignVariables();
		
		$code = WCF::getLanguage()->getLanguageCode();
		$arr = explode("-", $code);
		$code = $arr[0];

		WCF::getTPL()->assign(array(
			'hotTopics' => $this->hotTopics,
			'hotThreads' => $this->hotThreads,
			'rssIDs' => $this->rssIDs,
			'langCodeShort' => $code,
			'allowSpidersToIndexThisPage' => true,
			'displayRSSLinks' => (version_compare(PACKAGE_VERSION, '3.0.0', '>')) // wbbLite2 has no RSS class, so i might consider writing the feedreader on my own
        ));
	}
	
	//! Duplicated in SimpleNewsFeed.class.php
	private function recGetSubBoards()
	{
		$newBoards = array();
		foreach($this->boardsToCheck as $board)
		{
			$sql = "SELECT boardID FROM wbb".WBB_N."_board_structure
						WHERE parentID = ".$board;
			
			$result = WCF::getDB()->sendQuery($sql);
			
			while($row = WCF::getDB()->fetchArray())
			{
				$newBoards[] = $row['boardID'];
			}
		}
		$this->boards = array_merge_recursive($this->boards, $this->boardsToCheck);
	
		if(sizeof($newBoards))
		{
			$this->boardsToCheck = $newBoards;
			$this->recGetSubBoards();
		}
	}
	
	/**
	 * Updates the views of this thread.
	 */
	public function updateViews($threadID) {
		$sql = "UPDATE	wbb".WBB_N."_thread
			SET 	views = views + 1
			WHERE 	threadID = " . $threadID;
		WCF::getDB()->registerShutdownUpdate($sql);
	}
	
	protected function activateMenu()
	{
		// set active header menu item
		require_once(WCF_DIR.'lib/page/util/menu/HeaderMenu.class.php');
		HeaderMenu::setActiveMenuItem('wcf.header.menu.sb.simplenews');
	}

	public function show() {
		$this->activateMenu();
		//$items = HeaderMenu::getMenuItems();
		//unset($items[0]);
		parent::show();
	}
}
?>