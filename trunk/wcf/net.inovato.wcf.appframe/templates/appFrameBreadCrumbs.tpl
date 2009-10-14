{if $appFrameBreadCrumbs|count}
<ul class="breadCrumbs">
	{foreach from=$appFrameBreadCrumbs item=breadCrumb}
		<li><a href="{$breadCrumb->link}">{if $breadCrumb->icon}<img src="{icon}{$breadCrumb->icon}{/icon}" alt="" /> {/if}<span>{lang}{$breadCrumb->name}{/lang}</span></a> &raquo;</li>
	{/foreach}
</ul>
{/if}