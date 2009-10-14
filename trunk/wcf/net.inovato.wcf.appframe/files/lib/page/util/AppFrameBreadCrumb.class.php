<?php
/**
 * @author		Martin Poehlmann
 * @copyright	2009 Inovato, LLC <http://www.inovato.net>
 * @license		Creative Commons Attribution-Noncommercial-No Derivative Works 3.0 Unported <http://creativecommons.org/licenses/by-nc-nd/3.0/>
 * @package		net.inovato.wcf.appframe
 */
class AppFrameBreadCrumb
{
	// name of the breadcrumb.
	public $name;

	// link of the breadcrumb.
	public $link;
	
	// icon of the breadcrumb.
	public $icon;

	/**
	 * Constructs a BreadCrumb Object for AppFrame.
	 * 
	 * @param $name Name of the BreadCrumb
	 * @param $link Link of the BreadCrumb
	 * @param $icon Icon of the BreadCrumb (optional)
	 */
	public function __construct($name, $link, $icon = null)
	{
		$this->name = $name;
		$this->link = $link;
		$this->icon = $icon;
	}
}
?>