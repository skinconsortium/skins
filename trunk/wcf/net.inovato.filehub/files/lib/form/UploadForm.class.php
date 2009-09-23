<?php
// wcf imports
require_once(WCF_DIR.'lib/form/AbstractAppFrameForm.class.php');

// filehub imports
require_once(FILEHUB_DIR.'lib/data/file/StoredFile.class.php');

/**
 * Shows the start page.
 *
 * @author		Martin Poehlmann
 * @copyright	2009 inovato, LLC <http://www.inovato.net>
 * @license		Creative Commons Attribution-Noncommercial-No Derivative Works 3.0 Unported <http://creativecommons.org/licenses/by-nc-nd/3.0/>
 * @package		net.inovato.wcf.appframe
 */
class UploadForm extends AbstractAppFrameForm
{
	public $templateName = 'index';
	
	// Site Title. May be a language var.
	public $appFrameGenericSiteTitle = 'wcf.appframe.generic.home';
	
	// Shows the Site Caption
	public $appFrameGenericSiteShowCaption = true;
	
	// Site caption text. May be language vars.
	public $appFrameGenericSiteCaption = PAGE_TITLE;
	public $appFrameGenericSiteCaptionSub = PAGE_DESCRIPTION;
	
	// Icon shown beside the caption.
	public $appFrameGenericSiteCaptionIcon = 'appFrameHomeL.png';
	
	public $file;
	
	/**
	 * @see Form::readFormParameters()
	 */
	public function readFormParameters()
	{
		parent::readFormParameters();

		if (isset($_FILES['file'])) $this->file = new StoredFile(null, null, $_FILES['file']);
	}
	
	/**
	 * @see Form::save()
	 */

	public function save()
	{
		$this->file->save();
		
		$this->saved();
	}
}
?>
