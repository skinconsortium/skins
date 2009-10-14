{include file='header'}

<script type="text/javascript">
	//<![CDATA[
	var tabMenu = new TabMenu();
	onloadEvents.push(function() { tabMenu.showSubTabMenu("{$activeTabMenuItem}") });
	//]]>
</script>

<div class="mainHeadline">
	<img src="{@RELATIVE_WBB_DIR}icon/startPageConfigL.png" alt="" />
	<div class="headlineContainer">
		<h2>{lang}wcf.acp.startpage.settings{/lang}</h2>
		<p>{lang}wcf.acp.startpage.settings.description{/lang}</p>
	</div>
</div>

{if $errorField}
	<p class="error">{lang}wcf.global.form.error{/lang}</p>
{/if}

{if $success|isset}
	<p class="success">{if $action == 'add'}{lang}wbb.acp.board.add.success{/lang}{else}{lang}wbb.acp.board.edit.success{/lang}{/if}</p>	
{/if}

<form method="post" action="index.php?form=StartPageSettings">
	<div class="border content">
		<div class="container-1">
			<fieldset>
				<legend>{lang}wcf.acp.startpage.settings.request{/lang}</legend>
					<p>{lang}wcf.acp.startpage.settings.request.description{/lang}</p>
								
					{** Status: off *}
				
					<div id="status_offDiv" class="formCheckBox formElement{if $errorField == 'status_off'} formError{/if}">				
						<div class="formField">
							<label for="status_off"><input 
								onclick="if (this.checked) hideOptions('requestDiv');"
								id="status_off" type="radio" name="status" value="0" {if $general_wbbstartpage_status == 0}checked="checked"{/if}
 							/> {lang}wcf.acp.startpage.settings.request.status.off{/lang}</label>
							{if $errorField == 'status_off'}
								<p class="innerError">
									{if $errorType == 'empty'}{lang}wcf.global.error.empty{/lang}{/if}
								</p>
							{/if}
						</div>
						<div class="formFieldDesc hidden" id="status_offHelpMessage">
							<p>{lang}wcf.acp.startpage.settings.request.status.off.description{/lang}</p>
						</div>							
					</div>
					<script type="text/javascript">
						//<![CDATA[
						inlineHelp.register('status_off');
						//]]>
					</script>
					
					{** Status: suggested pages *}
					{foreach from=$suggestedStartpages item=suggestedStartpageName key=suggestedStartpageID}
						<div id="status_{$suggestedStartpageID}Div" class="formCheckBox formElement{if $errorField == '$suggestedStartpageName'} formError{/if}">				
							<div class="formField">
								<label for="status_{$suggestedStartpageID}"><input 
									onclick="if (this.checked) hideOptions('requestDiv');"
									id="status_{$suggestedStartpageID}" type="radio" name="status" value="{$suggestedStartpageID}" {if $general_wbbstartpage_status == $suggestedStartpageID}checked="checked"{/if}
	 							/> {lang}{$suggestedStartpageName}{/lang}</label>
								{if $errorField == 'status_off'}
									<p class="innerError">
										{if $errorType == 'empty'}{lang}wcf.global.error.empty{/lang}{/if}
									</p>
								{/if}
							</div>
							<div class="formFieldDesc hidden" id="status_{$suggestedStartpageID}HelpMessage">
								<p>{lang}wcf.acp.startpage.settings.request.status.suggested.description{/lang}</p>
							</div>							
						</div>
						<script type="text/javascript">
							//<![CDATA[
							inlineHelp.register('status_off');
							//]]>
						</script>
						<script type="text/javascript">
							//<![CDATA[
							inlineHelp.register('status_{$suggestedStartpageID}');
							//]]>
						</script>											
					{/foreach}					
					
					{** Status: custom *}
				
					<div id="status_customDiv" class="formCheckBox formElement{if $errorField == 'status_custom'} formError{/if}">
						<div class="formField">
							<label for="status_custom"><input 
								onclick="if (this.checked) showOptions('requestDiv');"
								id="status_custom" type="radio" name="status" value="-1" {if $general_wbbstartpage_status == -1}checked="checked"{/if}
							/> {lang}wcf.acp.startpage.settings.request.status.custom{/lang}</label>
							{if $errorField == 'status_custom'}
								<p class="innerError">
									{if $errorType == 'empty'}{lang}wcf.global.error.empty{/lang}{/if}
								</p>
							{/if}
						</div>
						<div class="formFieldDesc hidden" id="status_customHelpMessage">
							<p>{lang}wcf.acp.startpage.settings.request.status.custom.description{/lang}</p>
						</div>							
					</div>
					<script type="text/javascript">
						//<![CDATA[
						inlineHelp.register('status_custom');
						//]]>
					</script>					
	
					{** Request Form *}
					
					<div id="requestDiv" class="formElement{if $errorField == 'title'} formError{/if}">
						<div class="formField">
							<input type="text" class="inputText" style="margin-left:20px; width:90%;" id="request" name="request" value="{$general_wbbstartpage_customrequest}" />						
							
							{if $errorField == 'request'}
								<p class="innerError">
									{if $errorType == 'empty'}{lang}wcf.global.error.empty{/lang}{/if}
								</p>
							{/if}
							<div class="formFieldDesc hidden" id="requestHelpMessage" style="margin-left:20px;">
								<p>{lang}wcf.acp.startpage.settings.request.status.custom.edit.description{/lang}</p>
							</div>								
						</div>						
					</div>
					<script type="text/javascript">
						//<![CDATA[
						inlineHelp.register('request');
						{if $general_wbbstartpage_status != -1}hideOptions('requestDiv');{/if}
						//]]>
					</script>										
			</fieldset>
		</div>
	</div>
	
	<div class="formSubmit">
		<input type="submit" accesskey="s" value="{lang}wcf.global.button.submit{/lang}" />
		<input type="reset" accesskey="r" value="{lang}wcf.global.button.reset{/lang}" />
		<input type="hidden" name="packageID" value="{@PACKAGE_ID}" />
 		{@SID_INPUT_TAG}
 		{if $boardID|isset}<input type="hidden" name="boardID" value="{@$boardID}" />{/if}
 		<input type="hidden" id="activeTabMenuItem" name="activeTabMenuItem" value="{$activeTabMenuItem}" />
 	</div>
</form>

{include file='footer'}