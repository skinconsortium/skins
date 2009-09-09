{capture assign=specialStyles}
	<link rel="stylesheet" type="text/css" media="screen" href="{@RELATIVE_STUB_DIR}style/stub.css" />
{/capture}
{capture assign=appFrameGenericSiteContent}
<div class="border content">
	<div class="container-1">
		<h3 class="subHeadline">Hello World, Welcome to AppFrame</h3>
		This is an example WCF Application using the <a href="http://www.inovato.net">Inovato AppFrame</a> with the Woltlab Community Framework.
		<h4 class="subHeadline2">Why should I use AppFrame for my WCF Application?</h4>
		With the AppFrame it is very easy to develop new WCF Applications without taking care of the general site layout or session stuff. But of course you can extend the layout or session information to your liking using class inheritance. AppFrame just gives you a good starting point for your new WCF Application.<br/>Furthermore AppFrame ships with lots of predefined language variables. So you can use them in your Project without the need of translators.
		<h4 class="subHeadline2">OK, but what does it cost?</h4>
		Well, Inovato AppFrame is free to use for everyone.
		<h4 class="subHeadline2">That's nice, where do I need to give credit?</h4>
		You do not need to give credit that you are using Inovato AppFrame for your application. But keeping a link back to www.inovato.net in the footer (like here) or in an extra about/credits page would be cool.
		<h4 class="subHeadline2">Am I allowed to alter the AppFrame?</h4>
		No, it is released under a <a href="http://creativecommons.org/licenses/by-nc-nd/3.0/">Creative Commons Attribution-Noncommercial-No Derivative Works 3.0 Unported License</a>! Inovato AppFrame was developed to be generic, so in most of the cases you will not need to alter it. Just use inheritance. If you still feel like there should be altered anything, feel free to suggest it! Moreover I encourage you to contribute to this project directly, so everyone can benefit from your work.
	</div>
</div>
{/capture}
{capture assign=appFrameGenericSitePageOptions}
	<a href="http://www.inovato.net/solutions/appframe/"><img src="{icon}appFrameHomeS.png{/icon}" alt="" /> <span>{lang}wcf.appframe.generic.moreinfo{/lang}</span></a>
{/capture}
{include file="appFrameGenericSite"}