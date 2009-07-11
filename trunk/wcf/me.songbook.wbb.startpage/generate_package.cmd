@prompt $
@set path=%path%;"c:\Program Files\7-Zip"
@set plugin_name=me.songbook.wbb.startpage
@set plugin_source=../../forums
@cls
@echo Make WCF Plugin Package

@echo copying source files to package directory
@echo -----------

@echo --files--
robocopy %plugin_source%/ ./files *.* /S /XL
@echo --templates--
robocopy %plugin_source%/acp/templates ./acptemplates *.* /S /XL
@echo --PIPs--
robocopy %plugin_source%/../wcf/lib/acp/package/plugin ./pip *.* /S /XL

@echo deleting old archives
@echo -----------
del *.tar /Q
del *.gz /Q

@echo generating new archives
@echo -----------

cd files
7z a -r -ttar ../files.tar ./*
cd ../acptemplates
7z a -r -ttar ../acptemplates.tar ./*
cd ../pip
7z a -r -ttar ../pip.tar ./*
cd ..
7z a -ttar -x!*.cmd %plugin_name%.tar ./*.*


7z a -tgzip %plugin_name%.tar.gz %plugin_name%.tar

rem robocopy . ./.. %plugin_name%.tar /MOVE
pause