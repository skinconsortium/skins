@prompt $
@set path=%path%;"c:\Program Files\7-Zip"
@set plugin_name=me.songbook.wcf.startsitePIPtest
@set plugin_source=../../wcf/lib/acp/package/plugin
@cls
@echo Make WCF Plugin Package


@echo deleting old archives
@echo -----------
del *.tar /Q
del *.gz /Q

@echo generating new archives
@echo -----------

7z a -ttar -x!*.cmd %plugin_name%.tar -x!.svn ./*.*

7z a -tgzip %plugin_name%.tar.gz %plugin_name%.tar
pause