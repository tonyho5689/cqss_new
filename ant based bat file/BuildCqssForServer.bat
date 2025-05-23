@SETLOCAL
@ECHO OFF

REM - LABEL INDICATING THE BEGINNING OF THE DOCUMENT.
:BEGIN
CLS

REM - BELOW WILL CHECK THE PARAMETERS INPUT BY USERS.
:INPUT_VALIDATE
IF [%1] == [] GOTO INVALID_INPUT
GOTO ENV_SETUP

:INVALID_INPUT
ECHO.
ECHO SYNTAX ERROR - SHOULD BE '%0 Transmittal_Ref_No'
ECHO.

GOTO END_WITH_ERROR

:ENV_SETUP
IF [%LOG_HOME%] == [] SET LOG_HOME=.D:
SET BUILD_TEMP=.\
SET BUILD_LOG_FILEPATH=%BUILD_TEMP%\buildCqssForServer.log

@ECHO TRANSMITTAL# %1 >> %BUILD_LOG_FILEPATH%
@if exist %BUILD_LOG_FILEPATH% del %BUILD_LOG_FILEPATH%
@date /T >> %BUILD_LOG_FILEPATH%
@time /T >> %BUILD_LOG_FILEPATH%

:CHECK_DEFAULT_JDK
IF NOT EXIST "C:\Program Files\Java\jdk1.8.0_152" GOTO CHECK_BACKUP_JDK
SET JAVA_HOME=C:\Program Files\Java\jdk1.8.0_152
SET PATH=%JAVA_HOME%\bin;%PATH%
GOTO BUILD

:CHECK_BACKUP_JDK
IF NOT EXIST "C:\Program Files (x86)\Java\jdk1.8.0_152" GOTO END_WITH_JDK_NOT_FOUND
SET JAVA_HOME=C:\Program Files (x86)\Java\jdk1.8.0_152
SET PATH=%JAVA_HOME%\bin;%PATH%
GOTO BUILD

:BUILD
@echo JAVA_HOME set to "%JAVA_HOME%" >> %BUILD_LOG_FILEPATH%
@echo PATH set to "%PATH%" >> %BUILD_LOG_FILEPATH%
makeForServer.bat >> %BUILD_LOG_FILEPATH% 2>&1

@GOTO END

:DIR_EXIST
ECHO directory %BUILD_TEMP% already exists, please use another Transmittal_Ref_No
GOTO END_WITH_ERROR

:END_WITH_ERROR
ECHO --- PLEASE CHECK ---
GOTO END

:END_WITH_JDK_NOT_FOUND
ECHO --- PLEASE CHECK ---
ECHO --- THE JDK PATH NOT FOUND ---
GOTO END

:END
@ECHO ON
@ENDLOCAL