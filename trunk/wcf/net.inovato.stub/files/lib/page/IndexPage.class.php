<?php
// wcf imports
require_once(WCF_DIR.'lib/page/AbstractPage.class.php');

/**
 * Shows the start page.
 *
 * @author		Martin Poehlmann
 * @copyright	2009 Inovato, LLC <http://www.inovato.net>
 * @license		GNU Lesser General Public License <http://opensource.org/licenses/lgpl-license.php>
 * @package		net.inovato.stub
 */
class IndexPage extends AbstractPage {
	public $templateName = 'index';

	/**
	 * @see Page::assignVariables();
	 */
	public function assignVariables() {
		parent::assignVariables();

		WCF::getTPL()->assign(array(
			'selfLink' => 'index.php?page=Index'.SID_ARG_2ND_NOT_ENCODED,
			'allowSpidersToIndexThisPage' => true,
		));
		
		/* TODO check if (WCF::getSession()->spiderID) {
			if ($lastChangeTime = @filemtime(WBB_DIR.'cache/cache.stat.php')) {
				@header('Last-Modified: '.gmdate('D, d M Y H:i:s', $lastChangeTime).' GMT');
			}
		}*/
	}
}
?>