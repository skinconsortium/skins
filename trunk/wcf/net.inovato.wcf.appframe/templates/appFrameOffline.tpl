{include file="documentHeader"}
<head>
	<title>{lang}wcf.global.error.title{/lang} - {lang}{PAGE_TITLE}{/lang}</title>
	{include file='AppFrameHeadInclude' sandbox=false}
</head>
<body{if $templateName|isset} id="tpl{$templateName|ucfirst}"{/if}>
{include file='appFrameHeader' sandbox=false}

<div id="main">
	
	<div class="warning">
		{lang}wcf.appframe.global.offline{/lang}
		<p>{if APPFRAME_OFFLINE_MESSAGE_ALLOW_HTML}{@APPFRAME_OFFLINE_MESSAGE}{else}{@APPFRAME_OFFLINE_MESSAGE|htmlspecialchars|nl2br}{/if}</p>
	</div>

</div>

{include file='appFrameFooter' sandbox=false}
</body>
</html>