{** 
 * AppFrame Template -- ListHead
 *
 * @param		listHeaderItems		Language Strings for the listheader items. 
 * @param		listHeaderActive	Language String of the active item. (optional)
 * @param		listHeaderSort		Sorting direction - "DESC" or "ASC". (optional)
 *
 * @author		Martin Poehlmann
 * @copyright	2009 inovato, LLC <http://www.inovato.net>
 * @license		Creative Commons Attribution-Noncommercial-No Derivative Works 3.0 Unported <http://creativecommons.org/licenses/by-nc-nd/3.0/>
 * @package		net.inovato.wcf.appframe.core
 *}
 
{if !$listHeaderItems|isset}
{assign var='listHeaderItems' value='Foo;Bar'}
{/if}
<div class="tableHead listHead smallFont light">
	<ul class="emptyHead noSpacing">
		{foreach from=";"|explode:$listHeaderItems item=listHeaderItem}
		<li class="border noSpacing noBorder{if $listHeaderActive|isset && $listHeaderActive == $listHeaderItem} active{/if}">
			<div class="fileHubListDateHead">
				<a>{lang}{$listHeaderItem}{/lang}{if $listHeaderActive|isset && $listHeaderActive == $listHeaderItem && $listHeaderSort|isset} <img alt="" src="{icon}sort{$listHeaderSort}S.png{/icon}"/>{/if}</a></div>
		</li>
		{/foreach}
	</ul>
</div>