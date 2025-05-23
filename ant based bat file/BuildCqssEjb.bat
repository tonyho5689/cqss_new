@ECHO OFF
@SETLOCAL

REM - BELOW WILL CHECK THE PARAMETERS INPUT BY USERS.
:INPUT_VALIDATE
@if A%1==A GOTO INVALID_INPUT
@if GO%1==GOSKIP GOTO CQSS_EJB
@if not GO%1==GOSKIP GOTO SETUP_BUILD_LOG_PATH

:INVALID_INPUT
ECHO.
ECHO SYNTAX ERROR - SHOULD BE '%0 Transmittal_Ref_No' or '%0 SKIP'
ECHO.

GOTO END_BUILD

:SETUP_BUILD_LOG_PATH
SET BUILD_LOG_FILEPATH=.\BuildCqssEjb.log
SET BUILD_LOG_FILEPATH_STR= ^>^> %BUILD_LOG_FILEPATH% 2^>^>&1
@if exist %BUILD_LOG_FILEPATH% del %BUILD_LOG_FILEPATH%

@echo Run BuildCqssEjb Starting: %date% %time% %BUILD_LOG_FILEPATH_STR%

:CQSS_EJB
if not exist %BUILD_LOG_FILEPATH% SET BUILD_LOG_FILEPATH_STR=
@Call CleanupFolder.bat %1 %BUILD_LOG_FILEPATH_STR%
@Call SetupEnv.bat %1 %BUILD_LOG_FILEPATH_STR%
@SETLOCAL
@SET PATH=%ANT_HOME%\bin;%PATH%
@Call ant -Dwashome="%WAS_HOME%" -Dcbslibroot="../../../cbs/cbs/Deploy/Was9/Libraries" -buildfile BuildCqssEjb.xml %BUILD_LOG_FILEPATH_STR%

@if not GO%1==GOSKIP (
    @echo Run BuildCqssEjb Ending: %date% %time% %BUILD_LOG_FILEPATH_STR%
)

@ENDLOCAL

:END_BUILD