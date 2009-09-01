@prompt $
rem @set path=%path%;"c:\Program Files\7-Zip"
@set path=c:\windows\system32;"c:\Program Files\7-Zip"
@set plugin_name=net.inovato.stub
@set plugin_source=../../stub
@cls
@echo Make WCF Plugin Package

@echo copying source files to package directory
@echo -----------
@echo --templates--
robocopy %plugin_source%/acp/templates ./acptemplates *.* /S /XL

@echo --files--
robocopy %plugin_source%/ ./files *.* /S /XL

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
cd ../templates
7z a -r -ttar ../templates.tar ./*
cd ..
7z a -ttar -x!*.cmd %plugin_name%.tar ./*.*

7z a -tgzip %plugin_name%.tar.gz %plugin_name%.tar

robocopy . ./.. %plugin_name%.tar /MOVE
pause