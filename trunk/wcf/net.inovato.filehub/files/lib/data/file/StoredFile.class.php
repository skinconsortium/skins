<?php
// wcf imports
require_once(WCF_DIR.'lib/data/DatabaseObject.class.php');

/**
 * Represents a file in the storage directories.
 * 
 * @author		Martin Poehlmann
 * @copyright	2009 Inovato, LLC <http://www.inovato.net>
 * @license		Creative Commons Attribution-Noncommercial-No Derivative Works 3.0 Unported <http://creativecommons.org/licenses/by-nc-nd/3.0/>
 * @package		net.inovato.filehub
 */

define ('RELATIVE_STORAGE_ROOT', RELATIVE_FILEHUB_DIR.'storage/');
define ('STORAGE_ROOT', FILEHUB_DIR.'storage/');

class StoredFile extends DatabaseObject
{
	const DB_TABLE_SUFFIX = '_items';
	const DB_PRIMARY_KEY = 'fileID';
	
	// storage dir of the file
	public $fileDir;
	
	// path to a temporary stored file
	public $temporaryPath = null;
	
	public function __construct($itemID = null, $dataRow = null, $file = null)
	{
		if ($file != null && $file['error'] == 0) // we want to create a new Object
		{
			// set default data
			$this->storetime = TIME_NOW;
			$this->filename = $file['name']; 
			$this->filetype = $file['type']; 
			$this->filesize = $file['size'];
			
			if (!empty($this->filename) && StringUtil::indexOf($this->filename, '.') !== false)
			{
				$this->fileext = StringUtil::toLowerCase(StringUtil::substring($this->filename, StringUtil::lastIndexOf($this->filename, '.') + 1));
			}
			else
			{
				$this->fileext = '';
			}	
				
			$this->temporaryPath = $file['tmp_name']; 
			
			$this->userID = WCF::getUser()->userID;
			if ($this->userID)
			{
				$this->username = WCF::getUser()->username;
			}
						
			$this->fileDir = STORAGE_ROOT.$this->storetime.'/';
	
		}
		/*else if ($itemID != null)						// create an object depending on the typeID
		{	
			$sql = "SELECT * FROM wcf".WCF_N.self::DB_TABLE_SUFFIX."
						WHERE ".self::DB_PRIMARY_KEY."=".$itemID;
			
			$result = WCF::getDB()->sendQuery($sql);
			
			// create a new object if no data has been found
			if (!WCF::getDB()->countRows($result))
			{
				return;
			}
			// Fill fields
			$this->handleData(WCF::getDB()->fetchArray($result));
		}
		else											// This means a dataRow is submitted
		{
			$this->handleData($dataRow);
		}
		
		$this->projectDir = PROJECTS_ROOT.$this->itemID.'/';
		$this->relativeProjectDir = RELATIVE_PROJECTS_ROOT.$this->itemID.'/';*/
	}
	
	public function save()
	{
		if(!$this->fileID) // storing a new file
		{
			// Add fileinfo to DB
			
			$sql = "INSERT INTO filehub".FILEHUB_N.self::DB_TABLE_SUFFIX.
				 "(userID, username, storetime, filename, fileext, filetype, filesize, title, ipAddress)
				  VALUES(".
					$this->userID.", ".
					"'".escapeString($this->username)."', ".
					$this->storetime.", ".
					"'".escapeString($this->filename)."', ".
					"'".escapeString($this->fileext)."', ".
					"'".escapeString($this->filetype)."', ".
					intval($this->filesize).", ".
					"'".($this->title?escapeString($this->title):escapeString($this->filename))."', ".
					"'".escapeString(WCF::getSession()->ipAddress)."'".
					")";
					
			WCF::getDB()->sendQuery($sql);
			$this->itemID = WCF::getDB()->getInsertID();
			
			// Update Stats
			
			// TODO manage stats
			/*$sql = "UPDATE wcf".WCF_N."_download_stats
								SET intVal=intVal+1
				  				WHERE title='projects'";
			
			WCF::getDB()->sendQuery($sql);*/
			
			// Move File
			if (!is_dir($this->fileDir))
			{
				@mkdir($this->fileDir);
				@chmod($this->fileDir, 0755);
			}
			
			$finalFileName = $this->fileDir.$this->filename;
	
			if (!@copy($this->temporaryPath, $finalFileName))
			{
				// copy failed: delete temp file
				@unlink($this->temporaryPath);
				// TODO rise exception
				return;
			}
			// set permissions
			@chmod($this->temporaryPath, 0755);		
		}
		else
		{
			
		}
	}
}
?>