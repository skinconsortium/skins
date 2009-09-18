{capture assign=specialStyles}
	<link rel="stylesheet" type="text/css" media="screen" href="{@RELATIVE_FILEHUB_DIR}style/stub.css" />
{/capture}
{capture assign=appFrameGenericSiteContent}
<div class="border content">
	<div class="container-1">
		<form method="POST" action="index.php?form=Upload" enctype="multipart/form-data"> 
		<input type="file" name="file" style="width: 340px;" size="39" /> 
		<input type="submit" value="Upload" /> 
		</form> 
	</div>
</div>
{/capture}
{capture assign=appFrameGenericSitePageOptions}
	<a href="http://www.inovato.net/solutions/appframe/"><img src="{icon}appFrameHomeS.png{/icon}" alt="" /> <span>{lang}wcf.appframe.generic.moreinfo{/lang}</span></a>
{/capture}
{include file="appFrameGenericSite"}
