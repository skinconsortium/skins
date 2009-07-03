@prompt $
@set path=%path%;"c:\Program Files\7-Zip"
@set plugin_name=me.songbook.wcf.acp.pip.optionals
@set plugin_source=../../wcf/lib/acp/package/plugin
@cls
@echo Make WCF Plugin Package

@echo copying source files to package directory
@echo -----------
@echo --pip--
robocopy %plugin_source% ./pip *.* /S /XL


@echo deleting old archives
@echo -----------
del *.tar /Q
del *.gz /Q

@echo generating new archives
@echo -----------
cd pip
7z a -r -ttar ../pip.tar ./*
cd ..
7z a -ttar -x!*.cmd %plugin_name%.tar ./*.*
7z a -r -ttar %plugin_name%.tar ./*/*.tar

7z a -tgzip %plugin_name%.tar.gz %plugin_name%.tar
pause