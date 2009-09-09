{include file="documentHeader"}
<head>
	<title>{if $appFrameGenericSiteTitle != ''}{lang}{$appFrameGenericSiteTitle}{/lang} - {/if}{lang}{PAGE_TITLE}{/lang}</title>
	
	{include file='appFrameHeadInclude' sandbox=false}
</head>
<body{if $templateName|isset} id="tpl{$templateName|ucfirst}"{/if}>
{include file='appFrameHeader' sandbox=true}

<div id="main">
	
	{if $appFrameGenericSiteShowCaption}
		<div class="mainHeadline">
			<img src="{icon}{$appFrameGenericSiteCaptionIcon}{/icon}" alt="" title="{$appFrameGenericSiteCaption}" />
			<div class="headlineContainer">
				<h2>{lang}{$appFrameGenericSiteCaption}{/lang}</h2>
				<p>{lang}{$appFrameGenericSiteCaptionSub}{/lang}</p>
			</div>
		</div>
	{/if}
	
	{if $userMessages|isset}{@$userMessages}{/if}
	
	{if $additionalTopContents|isset}{@$additionalTopContents}{/if}
	
	{if $appFrameGenericSiteContent|isset}{@$appFrameGenericSiteContent}{/if}
	
	{if $appFrameGenericSitePageOptions|isset || $additionalPageOptions|isset}
		<div class="pageOptions">
			{if $additionalPageOptions|isset}{@$additionalPageOptions}{/if}
			{if $appFrameGenericSitePageOptions|isset}{@$appFrameGenericSitePageOptions}{/if}
		</div>
	{/if}
		
	{if $additionalBottomContents|isset}{@$additionalBottomContents}{/if}

</div>

{include file='appFrameFooter' sandbox=false}

</body>
</html>