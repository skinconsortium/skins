{include file='header'}

<script type="text/javascript" src="{@RELATIVE_WCF_DIR}js/Suggestion.class.js"></script>
<script type="text/javascript" src="{@RELATIVE_WCF_DIR}js/TabMenu.class.js"></script>
<script type="text/javascript">
	//<![CDATA[
	var tabMenu = new TabMenu();
	onloadEvents.push(function() { tabMenu.showSubTabMenu('{if $updates|count > 0}updates{elseif $news|count > 0}news{else}system{/if}') });
	//]]>
</script>

<div class="mainHeadline">
	<img src="{@RELATIVE_WCF_DIR}icon/AppFrameAcpL.png" alt="" />
	<div class="headlineContainer">
		<h2>{lang}wcf.appframe.acp.index{/lang}</h2>
	</div>
</div>

{if $this->user->getPermission('admin.user.canEditUser')}
	<form method="post" action="index.php?form=UserSearch">
		<fieldset>
			<legend>{lang}wcf.appframe.acp.index.searchUsers{/lang}</legend>
			
			<div class="formElement">
				<div class="formFieldLabel">
					<label for="username">{lang}wcf.user.username{/lang}</label>
				</div>
				<div class="formField">
					<input type="text" class="inputText" id="username" name="staticParameters[username]" value="" />
					<script type="text/javascript">
						//<![CDATA[
						suggestion.enableMultiple(false);
						suggestion.init('username');
						//]]>
					</script>
					<label><input type="checkbox" name="matchExactly[username]" value="1" /> {lang}wcf.global.search.matchesExactly{/lang}</label>
				</div>
			</div>
			
			{if $this->user->getPermission('admin.user.canMailUser')}
				<div class="formElement">
					<div class="formFieldLabel">
						<label for="email">{lang}wcf.user.email{/lang}</label>
					</div>
					<div class="formField">	
						<input type="text" class="inputText" id="email" name="staticParameters[email]" value="" />
						<label><input type="checkbox" name="matchExactly[email]" value="1" /> {lang}wcf.global.search.matchesExactly{/lang}</label>
					</div>
				</div>
			{/if}
			
			{if $additionalSearchFields|isset}{@$additionalSearchFields}{/if}
		</fieldset>
		<div class="formSubmit">
			<input type="submit" accesskey="s" value="{lang}wcf.global.button.submit{/lang}" />
			<input type="reset" accesskey="r" value="{lang}wcf.global.button.reset{/lang}" />
			<input type="hidden" name="packageID" value="{@PACKAGE_ID}" />
	 		{@SID_INPUT_TAG}
		</div>
	</form>
{/if}

{if $additionalFields|isset}{@$additionalFields}{/if}

<div class="tabMenu">
	<ul>
		{if $updates|count > 0}<li id="updates"><a onclick="tabMenu.showSubTabMenu('updates');"><span>{lang}wcf.appframe.acp.index.updates{/lang}</span></a></li>{/if}
		{if $news|count > 0}<li id="news"><a onclick="tabMenu.showSubTabMenu('news');"><span>{lang}wcf.appframe.acp.index.news{/lang}</span></a></li>{/if}
		<li id="system"><a onclick="tabMenu.showSubTabMenu('system');"><span>{lang}wcf.appframe.acp.index.system{/lang}</span></a></li>
		<li id="stat"><a onclick="tabMenu.showSubTabMenu('stat');"><span>{lang}wcf.appframe.acp.index.stat{/lang}</span></a></li>
		<li id="credits"><a onclick="tabMenu.showSubTabMenu('credits');"><span>{lang}wcf.appframe.acp.index.credits{/lang}</span></a></li>
		{if $additionalTabs|isset}{@$additionalTabs}{/if}
	</ul>
</div>
<div class="subTabMenu">
	<div class="containerHead"><div> </div></div>
</div>

{if $updates|count > 0}
	<form method="post" action="index.php?form=PackageUpdate">
		<div class="border tabMenuContent hidden" id="updates-content">
			<div class="container-1">
				<h3 class="subHeadline">{lang}wcf.appframe.acp.index.updates{/lang}</h3>
				<p class="description">{lang}wcf.appframe.acp.index.updates.description{/lang}</p>
				
				<ul>
					{foreach from=$updates item=update}
						<li{if $update.version.updateType == 'security'} class="formError"{/if}>
							{lang}wcf.appframe.acp.index.updates.update{/lang}
							<input type="hidden" name="updates[{@$update.packageID}]" value="{$update.version.packageVersion}" />
						</li>
					{/foreach}
				</ul>
				
				<p><input type="submit" value="{lang}wcf.appframe.acp.index.updates.startUpdate{/lang}" /></p>
				<input type="hidden" name="packageID" value="{@PACKAGE_ID}" />
				{@SID_INPUT_TAG}
			</div>
		</div>
	</form>
{/if}

{if $news|count > 0}
	<div class="border tabMenuContent hidden" id="news-content">
		<div class="container-1">
			<h3 class="subHeadline">{lang}wcf.appframe.acp.index.news{/lang}</h3>
			{foreach from=$news item=newsItem}
				<div class="message content">
					<div class="messageInner container-{cycle name='results' values='1,2'}">
						<p class="light smallFont">{if $newsItem.author}{$newsItem.author} - {/if}{@$newsItem.pubDate|time}</p>
						<h4><a href="{@RELATIVE_WCF_DIR}acp/dereferrer.php?url={$newsItem.link|rawurlencode}" class="externalURL">{@$newsItem.title}</a></h4>

						<div class="messageBody">
							{@$newsItem.description}
						</div>
						<hr />
					</div>
				</div>
			{/foreach}
		</div>
	</div>
{/if}

<div class="border tabMenuContent hidden" id="system-content">
	<div class="container-1">
		<h3 class="subHeadline">{lang}wcf.appframe.acp.index.system{/lang}</h3>
		
		<fieldset>
			<legend>{lang}wcf.appframe.acp.index.system.software{/lang}</legend>
		
			<div class="formElement">
				<p class="formFieldLabel">{lang}wcf.appframe.acp.index.system.app.version{/lang}</p>
				<p class="formField">{PACKAGE_VERSION}</p>
			</div>
			<div class="formElement">
				<p class="formFieldLabel">{lang}wcf.appframe.acp.index.system.appframe.version{/lang}</p>
				<p class="formField">{$appFrameVersion}</p>
			</div>			
			<div class="formElement">
				<p class="formFieldLabel">{lang}wcf.appframe.acp.index.system.wcf.version{/lang}</p>
				<p class="formField">{WCF_VERSION}</p>
			</div>
		</fieldset>
		
		<fieldset>
			<legend>{lang}wcf.appframe.acp.index.system.server{/lang}</legend>
		
			<div class="formElement">
				<p class="formFieldLabel">{lang}wcf.appframe.acp.index.system.os{/lang}</p>
				<p class="formField">{$os}</p>
			</div>
			<div class="formElement">
				<p class="formFieldLabel">{lang}wcf.appframe.acp.index.system.webserver{/lang}</p>
				<p class="formField">{$webserver}</p>
			</div>
			<div class="formElement">
				<p class="formFieldLabel">{lang}wcf.appframe.acp.index.system.php{/lang}</p>
				<p class="formField">{PHP_VERSION}</p>
			</div>
			<div class="formElement">
				<p class="formFieldLabel">{lang}wcf.appframe.acp.index.system.sql.type{/lang}</p>
				<p class="formField">{$sqlType} &quot;{$dbName}&quot;</p>
			</div>
			<div class="formElement">
				<p class="formFieldLabel">{lang}wcf.appframe.acp.index.system.sql.version{/lang}</p>
				<p class="formField">{$sqlVersion}</p>
			</div>
			{if $load}
				<div class="formElement">
					<p class="formFieldLabel">{lang}wcf.appframe.acp.index.system.load{/lang}</p>
					<p class="formField">{$load}</p>
				</div>
			{/if}
		</fieldset>
	</div>
</div>

<div class="border tabMenuContent hidden" id="stat-content">
	<div class="container-1">
		<h3 class="subHeadline">{lang}wcf.appframe.acp.index.stat{/lang}</h3>
		
		<fieldset>
			<legend>{lang}wcf.appframe.acp.index.stat.wcf{/lang}</legend>		
			
			<div class="formElement">
				<p class="formFieldLabel">{lang}wcf.appframe.acp.index.stat.members{/lang}</p>
				<p class="formField">{#$members}</p>
			</div>
			<div class="formElement">
				<p class="formFieldLabel">{lang}wcf.appframe.acp.index.stat.usersOnline{/lang}</p>
				<p class="formField">{#$totalUsersOnline}</p>
			</div>			
			<div class="formElement">
				<p class="formFieldLabel">{lang}wcf.appframe.acp.index.stat.database.entries{/lang}</p>
				<p class="formField">{#$databaseEntries}</p>
			</div>
			<div class="formElement">
				<p class="formFieldLabel">{lang}wcf.appframe.acp.index.stat.database.size{/lang}</p>
				<p class="formField">{@$databaseSize|filesize}</p>
			</div>
			
		</fieldset>
		
		<fieldset>
			<legend>{lang}wcf.appframe.acp.index.stat.app{/lang}</legend>		
			
			<div class="formElement">
				<p class="formFieldLabel">{lang}wcf.appframe.acp.index.stat.usersOnline{/lang}</p>
				<p class="formField">{#$usersOnline}</p>
			</div>
			{if $additionalStats|isset}{@$additionalStats}{/if}
		</fieldset>		
	</div>
</div>

<div class="border tabMenuContent hidden" id="credits-content">
	<div class="container-1">
		<h3 class="subHeadline">{lang}wcf.appframe.acp.index.credits{/lang}</h3>

		<fieldset>
			<legend>{lang}wcf.appframe.acp.index.credits{/lang}</legend>	
							
			{include file='appFrameIndexCredits'}
		</fieldset>
		
		<fieldset>
			<legend>{lang}wcf.appframe.acp.index.credits.appframe{/lang}</legend>	
							
			<div class="formElement">
				<p class="formFieldLabel">{lang}wcf.appframe.acp.index.credits.developedBy{/lang}</p>
				<p class="formField"><a href="{@RELATIVE_WCF_DIR}acp/dereferrer.php?url={"http://www.inovato.net"|rawurlencode}" class="externalURL">Inovato, LLC</a></p>
			</div>	
			<div class="formElement">
				<p class="formFieldLabel">{lang}wcf.appframe.acp.index.credits.productManager{/lang}</p>
				<p class="formField">Martin P&ouml;hlmann</p>
			</div>		
			<div class="formElement">
				<p class="formFieldLabel">{lang}wcf.appframe.acp.index.credits.developer{/lang}</p>
				<p class="formField">Martin P&ouml;hlmann</p>
			</div>		
			<div class="formElement">
				<p class="formFieldLabel">{lang}wcf.appframe.acp.index.credits.designer{/lang}</p>
				<p class="formField">Martin P&ouml;hlmann</p>
			</div>		
			<div class="formElement">
				<p class="formFieldLabel">{lang}wcf.appframe.acp.index.credits.translators{/lang}</p>
				<p class="formField">Martin P&ouml;hlmann</p>
			</div>		
			<div class="formElement" style="margin-top: 10px">
				<p class="formFieldLabel"></p>
				<p class="formField">Copyright &copy; 2009 Inovato, LLC.</p>
			</div>
		</fieldset>
	</div>
</div>

{if $additionalTabContents|isset}{@$additionalTabContents}{/if}

{include file='footer'}