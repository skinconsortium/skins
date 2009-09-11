<?php
require_once(WBB_DIR.'lib/page/FeedPage.class.php');

class SimpleNewsFeedPage extends FeedPage 
{
	private $boards = array();
	private $boardsToCheck = array();
	
	public function readParameters()
	{
		parent::readParameters();	
		if (SONGBOOK_NEWS_HOTTOPIC_SUBBOARDS)
		{
			$this->boardsToCheck = explode(",",SONGBOOK_NEWS_HOTTOPIC_BOARDID);
			$this->recGetSubBoards();	
			$this->boardIDs = $this->boards;
		}
		else
		{
			$this->boardIDs = explode(",",SONGBOOK_NEWS_HOTTOPIC_BOARDID);
		}
		$this->limit = SONGBOOK_NEWS_FEED_THREADLIMIT;
		$this->hours = SONGBOOK_NEWS_FEED_TIMELIMIT * 24;
	}
	
	//! Duplicated in SimpleNewsPage.class.php
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
}
?>