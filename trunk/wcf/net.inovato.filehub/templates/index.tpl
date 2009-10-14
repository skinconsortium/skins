{capture assign=specialStyles}
	<link rel="stylesheet" type="text/css" media="screen" href="{@RELATIVE_FILEHUB_DIR}style/filehub.css" />
{/capture}
{capture assign=appFrameGenericSiteContent}
{if FILEHUB_STARTPAGE_SHOWUPLOAD && $this->user->getPermission('user.filehub.store.canUploadFiles')}

{include file="appFrameTitleBarPanel" titleBarPanelID="uploadToolsContainer" titleBarPanelName="filehub.pages.home.quickupload"}
<div class="border borderMarginRemove content" id="uploadToolsContainer">
	<div class="container-1">
		<div class="floatLeft">
			<img src="{icon}fileUploadXL.png{/icon}" h="96" w="96" alt="" title="{lang}filehub.pages.home.selectFile{/lang}"/>
		</div>
		<div id="uploadTools">	
			<form method="POST" action="index.php?form=Upload" enctype="multipart/form-data">
				<fieldset>
					<legend>{lang}filehub.pages.home.selectFile{/lang}</legend>
					<input type="file" name="file" class="stretched"/>
					<div id="uploadCheckbox">
						<label><input type="checkbox" name="public" value="1" checked="checked"/> {lang}filehub.pages.home.makePrivate{/lang}</label>
					</div>
				</fieldset>
				{@SID_INPUT_TAG}
				<input type="hidden" name="submit" value="Submit" />
				<div id="uploadSubmit">	
					<input type="submit" value="{lang}filehub.pages.home.upload{/lang}" />
				</div>
			</form> 
		</div>
	</div>
</div>
{/if}
{if $latestFiles|count}
{include file="appFrameTitleBarPanel" titleBarPanelID="latestFiles" titleBarPanelName="filehub.pages.home.latestFiles"}
<div class="border borderMarginRemove" id="latestFiles">
	<div class="tableHead listHead smallFont light" style="padding: 100px !important; width 100% !important;">
		<div style="margin-right: 1px; width: 100%; overflow:hidden;">
		<ul class="emptyHead noSpacing" style="margin-right: 100px !important">
			<li>
				<div class="fileHubListDateHead"><a>Date</a></div>
			</li>
			<li>
				<div class="fileHubListNameHead"><a>Filename</a></div>
			</li>
			<li>
				<div class="fileHubListSizeHead"><a>Filesize</a></div>
			</li>
			<li>
				<div class="fileHubListDldsHead"><a>Downloads</a></div>
			</li>
			<li>
				<div class="fileHubListViewsHead"><a>Views</a></div>
			</li>
		</ul>
		</div>
	</div>
	{foreach from=$latestFiles item=file}
	{cycle values='container-1,container-2' print=false advance=false}
	<div class="content listBody">
		<div class="{cycle}" style="overflow: auto;">
			<div class="containerIcon">
				<img src="{$file->getFileTypeIcon()}" h="24" w="24" alt="" title=""/>
			</div>
			<div class="containerContent">
				<div class="listRight fileHubListCount">
					<dl class="definitionList">
						<dt>Downloads</dt>
						<dd>0</dd>
						<dt>Views</dt>
						<dd>0</dd>
					</dl>
				</div>
				<div class="fileHubListSize listRight">
					{$file->filesize|filesize}
				</div>			
				<div class="listRight listStatus">
					{if $this->user->userID == $file->userID} <img src="{icon}userS.png{/icon}" h="16" w="16" alt="" title=""/>{/if}
				</div>
				<div class="fileHubListContent">
					<h4><strong><a href="http://www.winamp.com">{$file->title}</a></strong></h4>
					<p class="smallFont light">by {$file->username} ({@$file->storetime|shorttime})</p>
				</div>
			</div>
		</div>
	</div>
	{/foreach}
</div>
{/if}
{/capture}
{capture assign=appFrameGenericSitePageOptions}
	<a href="http://www.inovato.net/solutions/appframe/"><img src="{icon}appFrameHomeS.png{/icon}" alt="" /> <span>{lang}wcf.appframe.generic.moreinfo{/lang}</span></a>
{/capture}
{include file="appFrameGenericSite"}