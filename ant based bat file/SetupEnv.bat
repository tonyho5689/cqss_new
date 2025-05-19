@if GO%1==GOSKIP GOTO END_SETUP
@echo Finding WAS9 Path .......

@if exist "C:\IBM\WebSphere\AppServer" (
  @set WAS_HOME=C:\IBM\WebSphere\AppServer
  GOTO COMPLETE_WAS9_PATH
)

@if exist "D:\IBM\WebSphere\AppServer" (
  @set WAS_HOME=D:\IBM\WebSphere\AppServer
  GOTO COMPLETE_WAS9_PATH
)

@echo Default path not found, extensive search started ..... >> %DEPLOY_LOG_FILEPATH%
@echo Searching C: >> %DEPLOY_LOG_FILEPATH%
@dir C:\WebSphere /s /b /ad | findstr /E /C:"IBM\WebSphere" > wasroot.txt
@if NOT ERRORLEVEL 1 goto PARSE_WASROOT

@echo Searching D: >> %DEPLOY_LOG_FILEPATH%
@dir D:\WebSphere /s /b /ad | findstr /E /C:"IBM\WebSphere" > wasroot.txt
@if ERRORLEVEL 1 (
  @popd
  @echo WAS9 Path not found, please contact admin for WAS9 installation >> %DEPLOY_LOG_FILEPATH%
  @goto END
)

:PARSE_WASROOT
@ for /F "tokens=*" %%i in (wasroot.txt) do set WAS_HOME=%%i
@if exist wasroot.txt del wasroot.txt

:COMPLETE_WAS9_PATH

@set ANT_HOME=%CD%\apache-ant-1.5.4
@set JAVA_HOME=%WAS_HOME%\java\8.0

@echo WAS home set to "%WAS_HOME%"
@echo Java home set to "%JAVA_HOME%"
@echo Ant home set to "%ANT_HOME%"

:END_SETUP