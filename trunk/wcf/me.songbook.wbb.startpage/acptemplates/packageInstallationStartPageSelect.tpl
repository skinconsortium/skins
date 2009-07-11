{include file='setupWindowHeader'}

<form method="post" action="index.php?page=Package">
	<fieldset>
		<legend>{lang}wcf.acp.package.step.StartPageInstallationPlugin{/lang}</legend>
		<div class="inner">
			<p>{lang}wcf.acp.package.step.StartPageInstallationPlugin.description{/lang}</p>
		
			<div class="select">
				<input type="radio" id="optionalPackage-keep" name="request" value="keep" checked="checked" />
				<label for="optionalPackage-keep"><b>{lang}wcf.acp.package.step.StartPageInstallationPlugin.keep{/lang}</b><br />
					{lang}wcf.acp.package.step.StartPageInstallationPlugin.keep.description{/lang}
				</label>			
				{foreach from=$pagesToInstall item=suggestedStartpageName key=suggestedStartpageRequest}
					<input type="radio" id="optionalPackage-{$suggestedStartpageRequest}" name="request" value="{$suggestedStartpageRequest}" />
					<label for="optionalPackage-{$suggestedStartpageRequest}"><b>{lang}{$suggestedStartpageName}{/lang}</b><br />
						{lang}wcf.acp.startpage.settings.request.status.suggested.description{/lang}
					</label>
				{/foreach}
			</div>
			
			<input type="hidden" name="queueID" value="{@$queueID}" />
			<input type="hidden" name="action" value="{@$action}" />
			{@SID_INPUT_TAG}
			<input type="hidden" name="step" value="{@$step}" />
			<input type="hidden" name="packageID" value="{@PACKAGE_ID}" />
			<input type="hidden" name="send" value="send" />
		</div>
	</fieldset>
	
	<div class="nextButton">
		<input type="submit" value="{lang}wcf.global.button.next{/lang}" />
	</div>
</form>

<script type="text/javascript">
	//<![CDATA[
	parent.showWindow(true);
	parent.setCurrentStep('{lang}wcf.acp.package.step.title{/lang}{lang}wcf.acp.package.step.{if $action == 'rollback'}uninstall{else}{@$action}{/if}.{@$step}{/lang}');
	//]]>
</script>

{include file='setupWindowFooter'}