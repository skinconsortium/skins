{include file="documentHeader"}
<head>
	<title>{lang}wbb.sb.news.title{/lang} - {PAGE_TITLE}</title>
	
	{include file='headInclude' sandbox=false}

	<link rel="alternate" type="application/rss+xml" href="index.php?page=SimpleNewsFeed&amp;type=RSS2" title="RSS2" />
	<link rel="alternate" type="application/atom+xml" href="index.php?page=SimpleNewsFeed&amp;type=Atom" title="Atom" />
	
	{if SONGBOOK_NEWS_ADDTHIS_ENABLE}
		<script type="text/javascript">
			var addthis_pub = "{SONGBOOK_NEWS_ADDTHIS_USERNAME}";
			var addthis_offset_top=-4;
			var addthis_offset_left=0;
			var addthis_language='{$langCodeShort}';
		</script>
	{/if}
	
	<style type="text/css">
		.leftFloat { float:left; }
		.clearingSpace { clear:both; margin-top: 20px; }
		
		{if $additionalNewsStyles|isset}$additionalNewsStyles{/if}
	</style>
</head>
<body>

{include file='header' sandbox=false}

<div id="main">
	{if $newsPrePadding|isset}{@$newsPrePadding}{/if}
	{foreach from=$hotTopics item=hotTopic key=key}
		<div style="margin-bottom: 30px;">
			<div class="mainHeadline">
				<img src="{@RELATIVE_WBB_DIR}icon/simpleNewsL.png" width="48" height="48" alt="" title="" />
				<div class="headlineContainer">
		                  
					<h2>{@$hotTopic->subject}</h2>
					<p class="light smallFont" style="">
						{@$hotTopic->time|time} - {lang}wbb.board.threads.postBy{/lang} {if $hotTopic->userID}<a href="index.php?page=User&amp;userID={@$hotTopic->userID}{@SID_ARG_2ND}">{$hotTopic->username}</a>{else}{$hotTopic->username}{/if}
						- {$hotThreads[$key]->replies} {if $hotThreads[$key]->replies != 1}{lang}wbb.sb.news.comments{/lang}{else}{lang}wbb.sb.news.comment{/lang}{/if}
					</p>
				</div>
			</div>

			{if SONGBOOK_NEWS_HOTTOPIC_BORDERS}
				<div class="border content">
					<div class="container-1" {if SONGBOOK_NEWS_HOTTOPIC_CENTERTEXT}style="text-align:center;"{/if}>
						{if SONGBOOK_NEWS_HOTTOPIC_TRUNCTATE > 0}
							{assign var=formattedMsg value=$hotTopic->getFormattedMessage()}
							{@$formattedMsg|truncate:SONGBOOK_NEWS_HOTTOPIC_TRUNCTATE:"..."}{if $formattedMsg|strlen > SONGBOOK_NEWS_HOTTOPIC_TRUNCTATE} <a href="{@RELATIVE_WBB_DIR}index.php?page=Thread&amp;threadID={$hotThreads[$key]->threadID}{@SID_ARG_2ND}" title="{lang}wbb.sb.news.trunctate.tooltip{/lang}">{lang}wbb.sb.news.trunctate{/lang}</a>{/if}
						
						{else}
							{@$hotTopic->getFormattedMessage()}
						{/if}
					</div>
				</div>
			{else}
				<div> 
						{if SONGBOOK_NEWS_HOTTOPIC_TRUNCTATE > 0}
							{assign var=formattedMsg value=$hotTopic->getFormattedMessage()}
							{@$formattedMsg|truncate:SONGBOOK_NEWS_HOTTOPIC_TRUNCTATE:"..."}{if $formattedMsg|strlen > SONGBOOK_NEWS_HOTTOPIC_TRUNCTATE} <a href="{@RELATIVE_WBB_DIR}index.php?page=Thread&amp;threadID={$hotThreads[$key]->threadID}{@SID_ARG_2ND}" title="{lang}wbb.sb.news.trunctate.tooltip{/lang}">{lang}wbb.sb.news.trunctate{/lang}</a>{/if}
						
						{else}
							{@$hotTopic->getFormattedMessage()}
						{/if}
				</div>
				<br/>
			{/if}
			<div class="largeButtons{if !SONGBOOK_NEWS_HOTTOPIC_RIGHTALIGN} leftFloat{/if}">
				<ul>
					{if SONGBOOK_NEWS_ADDTHIS_ENABLE}
						<li><a rel="nofollow" href="http://www.addthis.com/bookmark.php" onmouseover="return addthis_open(this, '', '{@PAGE_URL}/index.php?page=Thread&amp;threadID={$hotThreads[$key]->threadID}', '{@$hotTopic->subject|encodejs}')" onmouseout="addthis_close()" onclick="return addthis_sendto()"><img src="{@RELATIVE_WBB_DIR}icon/addThisM.png" alt="{lang}wbb.sb.news.share{/lang}" height="24" width="24" /><span> {lang}wbb.sb.news.share{/lang}</span></a></li>
					{/if}
					{if $hotThreads[$key]->isClosed != true}
						<li><a href="{@RELATIVE_WBB_DIR}index.php?page=Thread&amp;threadID={$hotThreads[$key]->threadID}{@SID_ARG_2ND}"><img src="{@RELATIVE_WBB_DIR}icon/discussM.png" alt="{lang}wbb.sb.news.discuss{/lang}" /> <span>{lang}wbb.sb.news.discuss{/lang}</span></a></li>
					{/if}
				</ul>
			</div>
			{if !SONGBOOK_NEWS_HOTTOPIC_RIGHTALIGN}<br class="clearingSpace"/>{/if}
		</div>
	{/foreach}
	<div class="pageOptions{if !SONGBOOK_NEWS_HOTTOPIC_RIGHTALIGN} leftFloat{/if}">
		<a href="index.php?page=Board&amp;boardID={SONGBOOK_NEWS_HOTTOPIC_BOARDID}"><img src="{@RELATIVE_WBB_DIR}icon/simpleNewsArchive.png" alt="" /> <span>{lang}wbb.sb.news.archive{/lang}</span></a>
		{if $displayRSSLinks}
		<a href="index.php?page=SimpleNewsFeed&amp;type=RSS2"><img src="{@RELATIVE_WBB_DIR}icon/addThisS.png" alt="" /> <span>{lang}wbb.sb.news.rssabo{/lang}</span></a>
		<a href="index.php?page=SimpleNewsFeed&amp;type=Atom"><img src="{@RELATIVE_WBB_DIR}icon/addThisS.png" alt="" /> <span>{lang}wbb.sb.news.atomabo{/lang}</span></a>
		{/if}
	</div>
	{if $newsPostPadding|isset}{@$newsPostPadding}{/if}
</div>

{include file='footer' sandbox=false}
<script type="text/javascript" src="http://s7.addthis.com/js/152/addthis_widget.js"></script>
</body>
</html>