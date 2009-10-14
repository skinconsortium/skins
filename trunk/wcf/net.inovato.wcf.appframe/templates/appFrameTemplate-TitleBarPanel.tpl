{if !$titleBarPanelID|isset}
{assign var='titleBarPanelID' value='FooBar'}
{/if}
{if !$titleBarPanelName|isset}
{assign var='titleBarPanelName' value='FooBar'}
{/if}
<div class="border titleBarPanel">
	<div class="containerHead">
		<div class="containerIcon">
			<a onclick="openList('{$titleBarPanelID}', { save: true, openTitle: '{lang}wcf.appframe.generic.panelOpen{/lang}', closeTitle: '{lang}wcf.appframe.generic.panelClose{/lang}' })"><img src="{icon}minusS.png{/icon}" id="{$titleBarPanelID}Image" alt="" title="{lang}wcf.appframe.generic.panelClose{/lang}" /></a>
	
		</div>
		<div class="containerContent">
			<h3>{lang}{$titleBarPanelName}{/lang}</h3>
		</div>
	</div>
</div>