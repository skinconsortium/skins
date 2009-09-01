{include file="documentHeader"}
<head>
	<title>{lang}stub.index.title{/lang} - {lang}{PAGE_TITLE}{/lang}</title>
	
	{include file='headInclude' sandbox=false}
</head>
<body{if $templateName|isset} id="tpl{$templateName|ucfirst}"{/if}>
{include file='header' sandbox=true}

<div id="main">
	
	<div class="mainHeadline">
		<img src="{icon}homeL.png{/icon}" alt="" title="" />
		<div class="headlineContainer">
			<h2>{lang}{PAGE_TITLE}{/lang}</h2>
			<p>{lang}{PAGE_DESCRIPTION}{/lang}</p>
		</div>
	</div>
	
	{if $userMessages|isset}{@$userMessages}{/if}
	
	{if $additionalTopContents|isset}{@$additionalTopContents}{/if}

</div>

{include file='footer' sandbox=false}

</body>
</html>