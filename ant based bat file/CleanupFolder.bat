@if GO%1==GOSKIP GOTO ENDCLEANUP
@echo cleanup Binary
@rmdir /S /Q .\Binary
@echo cleanup *.contrib, *.keep, *.mkelem, *.checkout, *.unloaded
@del ..\*.contrib* /S /F /Q > cleanup.log 2>&1
@del ..\*.keep* /S /F /Q >> cleanup.log 2>&1
@del ..\*.mkelem* /S /F /Q >> cleanup.log 2>&1
@del ..\*.checkout* /S /F /Q >> cleanup.log 2>&1
@del ..\*.unloaded* /S /F /Q >> cleanup.log 2>&1

@dir ..\*.contrib* /S /B > dirlist.txt 2>> cleanup.log
@dir ..\*.keep* /S /B >> dirlist.txt 2>> cleanup.log
@dir ..\*.mkelem* /S /B >> dirlist.txt 2>> cleanup.log
@dir ..\*.checkout* /S /B >> dirlist.txt 2>> cleanup.log
@dir ..\*.unloaded* /S /B >> dirlist.txt 2>> cleanup.log

@type dirlist.txt | sort /R > dirSortList.txt
@del dirlist.txt
@for /F %%i in (dirSortList.txt) do rmdir /S /Q %%i >> cleanup.log 2>&1
@del dirSortList.txt
@del cleanup.log
@echo cleanup completed

:ENDCLEANUP