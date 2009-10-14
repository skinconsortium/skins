<?php

/**
 * Utility Class for WCF AppFrame
 * 
 * @author		Martin Poehlmann
 * @copyright	2009 Inovato, LLC <http://www.inovato.net>
 * @license		Creative Commons Attribution-Noncommercial-No Derivative Works 3.0 Unported <http://creativecommons.org/licenses/by-nc-nd/3.0/>
 * @package		net.inovato.wcf.appframe
 */

class AppFrameUtil
{
	/**
	 * list of the file types
	 * 
	 * @var	array
	 */
	protected static $fileTypeGroups = array(
		'Music' => array('Aif', 'Mid', 'Mp3', 'Ogg', 'Wav', 'Aiff', 'M4a'),
		'System' => array('Bat', 'Dll'),
		'Web' => array('Css', 'Js'),
		'Database' => array('Db'),
		'Image' => array('Dmg', 'Img', 'Iso'),
		'TextDocument' => array('Doc', 'Sxw', 'Odt', 'Swd'),
		'Picture' => array('Png', 'Gif', 'Jpg', 'Jpeg', 'Tif', 'Tiff', 'Tga', 'Bmp', 'Psd'),
		'Html' => array('Html', 'Htm', 'Shtml', 'Tpl', 'Mht'),
		'Text' => array('Txt', 'Log', 'Sql', 'Rtf', 'Wri', 'Diff'),
		'Font' => array('Otf', 'Ttf', 'Fon', 'Dfont'),
		'Archive' => array('Zip', 'Rar', 'Ace', '7z', 'Tar', 'Gz', 'Gzip', 'Tgz', 'Bz2', 'Sit', 'Sitx'),
		'SpreadSheet' => array('Xls', 'Sxc', 'Ods', 'Csv'),
		//'Video' => array('Mpeg', 'Avi', 'Wma', 'Mpg'),
		//'Xml' => array('Xml', 'Dtd'),
		//'Flash' => array('Swf', 'Fla'),
		'Java' => array('Jar', 'Java', 'Class')//,
		//'Php' => array('Php', 'Php3', 'Php4', 'Php5', 'Phtml')
	);
	
	/**
	 * Returns the relative path to a resource file.
	 * 
	 * @param path to a resource like '/icon/homeS.png'. Path must start with a /.
	 * @return relative path to resource
	 */
	public static function getResource($path)
	{

		if (is_file(APPLICATION_DIR.$path))
		{
			return RELATIVE_APPLICATION_DIR.$path;
		}

		return RELATIVE_WCF_DIR.$path;
	}
	
	/**
	 * Returns the right file type icon for the given filename or extension.
	 * 
	 * @return	string
	 */
	public static function getFileTypeIcon($filenameOrExtension)
	{
		// Code similar to Attachment.class.php
		
		$fileTypeIcon = '';
		$extension = $filenameOrExtension;
		if (StringUtil::indexOf($filenameOrExtension, '.'))
		{
			// get file extension
			$extension = StringUtil::substring($filenameOrExtension, StringUtil::lastIndexOf($filenameOrExtension, '.') + 1);
		}
		
		$extension = StringUtil::firstCharToUpperCase(StringUtil::toLowerCase($extension));
		// get file type icon
		if (file_exists(WCF_DIR.'icon/fileTypeIcon'.$extension.'M.png'))
		{
			$fileTypeIcon = 'fileTypeIcon'.$extension.'M.png';
		}
		else
		{
			foreach (self::$fileTypeGroups as $key => $group)
			{
				if (in_array($extension, $group))
				{
					$fileTypeIcon = 'fileTypeIcon'.$key.'M.png';
					break;
				} 
			}
			
			if (empty($fileTypeIcon))
			{
				$fileTypeIcon = 'fileTypeIconDefaultM.png';
			}
		}
		if (class_exists('WCFACP')) return RELATIVE_WCF_DIR.'icon/'.$fileTypeIcon;
		else return StyleManager::getStyle()->getIconPath($fileTypeIcon);
	}	
}
?>