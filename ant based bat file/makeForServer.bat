@ECHO OFF
@SETLOCAL

REM ***** COPYCMD is used for WIN2000 or about for not prompt message for override file ***
Set COPYCMD=/Y

javac -version

:LIB_CP
ECHO.
ECHO. *** BEGINNING TO BUILD WITH CYBERUTIL ***
ECHO.

SET LIB_CP=%classpath%;
SET LIB_CP=%LIB_CP%..\..\..\btss\btss\Deploy\lib\CyberUtil.jar;
SET LIB_CP=%LIB_CP%..\..\..\btss\btss\Deploy\lib\CyberUtilBatch.jar;
SET LIB_CP=%LIB_CP%..\..\..\btss\btss\Deploy\lib\CyberUtilBatchDB.jar;
SET LIB_CP=%LIB_CP%..\..\..\btss\btss\Deploy\lib\CyberUtilBatchJob.jar;
SET LIB_CP=%LIB_CP%..\..\..\btss\btss\Deploy\lib\CyberUtilBatchSvr.jar;
SET LIB_CP=%LIB_CP%..\..\..\btss\btss\Deploy\lib\CyberUtilBatchVo.jar;
SET LIB_CP=%LIB_CP%..\..\..\btss\btss\Deploy\lib\CyberUtilCommon.jar;
SET LIB_CP=%LIB_CP%..\..\..\btss\btss\Deploy\lib\CyberUtilTools.jar;
SET LIB_CP=%LIB_CP%..\..\..\frank\Deploy\server\lib\FdbkUtil.jar;
SET LIB_CP=%LIB_CP%..\Deploy\lib\external\apache\common\commons-beanutils.jar;
SET LIB_CP=%LIB_CP%..\Deploy\lib\external\apache\common\commons-beanutils-bean-collections.jar;
SET LIB_CP=%LIB_CP%..\Deploy\lib\external\apache\common\commons-beanutils-core.jar;
SET LIB_CP=%LIB_CP%..\Deploy\lib\external\apache\common\commons-chain-1.2.jar;
SET LIB_CP=%LIB_CP%..\Deploy\lib\external\apache\common\commons-codec-1.3.jar;
SET LIB_CP=%LIB_CP%..\Deploy\lib\external\apache\common\commons-collections-3.2.1.jar;
SET LIB_CP=%LIB_CP%..\Deploy\lib\external\apache\common\commons-configuration-1.5.zip;
SET LIB_CP=%LIB_CP%..\Deploy\lib\external\apache\common\commons-digester-1.8.jar;
SET LIB_CP=%LIB_CP%..\Deploy\lib\external\apache\common\commons-httpclient-3.1.jar;
SET LIB_CP=%LIB_CP%..\Deploy\lib\external\apache\common\commons-lang-2.4.jar;
SET LIB_CP=%LIB_CP%..\Deploy\lib\external\apache\common\commons-logging-1.1.1.jar;
SET LIB_CP=%LIB_CP%..\Deploy\lib\external\apache\common\commons-logging-adapters-1.1.1.jar;
SET LIB_CP=%LIB_CP%..\Deploy\lib\external\apache\common\commons-logging-api-1.1.1.jar;
SET LIB_CP=%LIB_CP%..\Deploy\lib\external\apache\common\commons-validator-1.3.1.jar;
SET LIB_CP=%LIB_CP%..\Deploy\lib\external\apache\http\httpcore-4.0.1.jar;
SET LIB_CP=%LIB_CP%..\Deploy\lib\external\apache\logging\log4j.jar;
SET LIB_CP=%LIB_CP%..\Deploy\lib\external\db\db2jcc-9.7.2.1.jar;
SET LIB_CP=%LIB_CP%..\Deploy\lib\external\db\mchange-commons-java-0.2.3.4.jar;
SET LIB_CP=%LIB_CP%..\Deploy\lib\external\db\ojdbc8.jar;
SET LIB_CP=%LIB_CP%..\Deploy\lib\external\hsm\HsmCommon.jar;
SET LIB_CP=%LIB_CP%..\Deploy\lib\external\ibatis\ibatis-2.3.0.677_cv.jar;
SET LIB_CP=%LIB_CP%..\Deploy\lib\external\jdom\jdom.jar;
SET LIB_CP=%LIB_CP%..\Deploy\lib\external\jnotify\jnotify-0.91.jar;
SET LIB_CP=%LIB_CP%..\Deploy\lib\external\spring\spring.jar;
SET LIB_CP=%LIB_CP%..\Deploy\lib\external\spring\aspectj\aspectjrt.jar;
SET LIB_CP=%LIB_CP%..\Deploy\lib\external\spring\aspectj\aspectjweaver.jar;
SET LIB_CP=%LIB_CP%..\Deploy\lib\external\servlet-api.jar;
SET LIB_CP=%LIB_CP%..\Deploy\lib\external\vtpassword\vt-password.jar;

:EXCLUDE_FILE
ECHO .java >> exclude.txt
ECHO vssver.scc >> exclude.txt
ECHO .contrib >> exclude.txt
ECHO .keep >> exclude.txt
ECHO .mkelem >> exclude.txt
ECHO .checkout >> exclude.txt
ECHO .unloaded >> exclude.txt
ECHO .class >> exclude.txt
ECHO .mf >> exclude.txt

CALL:COMPILE_AND_ADD_CP CqssVo
CALL:COMPILE_AND_ADD_CP CqssDB
CALL:COMPILE_AND_ADD_CP CqssBatchJobDB
CALL:COMPILE_AND_ADD_CP CqssSvr
CALL:COMPILE_AND_ADD_CP CqssSecurityAdmin

ECHO.
ECHO. Copying jars to \Deploy\lib --
ECHO.

XCOPY .\*.jar ..\Deploy\lib\ /A
DEL exclude.txt
GOTO QUIT

REM ******************************************************************
REM * Function Name: COMPILE_AND_ADD_CP
REM * Description: Compile a specific app, then add the jar to classpath
REM * Param 1: App name
REM ******************************************************************

:COMPILE_AND_ADD_CP
CALL:COMPILE_APP %1
CALL:ADD_CLASSPATH %1
GOTO:EOF

REM ******************************************************************
REM * Function Name: ADD_CLASSPATH
REM * Description: Add classpath of a specific app
REM * Param 1: App name
REM ******************************************************************

:ADD_CLASSPATH
IF EXIST .\%1.jar (
    SET LIB_CP=%LIB_CP%.\%1.jar;
    GOTO:EOF
)

IF EXIST ..\Deploy\lib\%1.jar SET LIB_CP=%LIB_CP%..\Deploy\lib\%1.jar;
GOTO:EOF

REM ******************************************************************
REM * Function Name: COMPILE_APP
REM * Description: Compile a specific app and jar up the source
REM * Param 1: App name
REM ******************************************************************

:COMPILE_APP
ECHO.
ECHO.
ECHO. Compiling java source files for App [%1] --
ECHO.

IF NOT EXIST ..\Source\%1\src GOTO COMPILE_APP_NOT_EXIST
IF NOT EXIST ..\Source\%1\bin MKDIR ..\Source\%1\bin
DIR ..\Source\%1\src\*.java /S /B > .\%1
TYPE .\%1

javac -J-Xmx4m -J-Xmx128m -deprecation -g -d ..\Source\%1\bin -classpath %LIB_CP% -sourcepath ..\Source\%1 @%1
del .\%1 /Q
ECHO.
ECHO. Including non-java source files --
ECHO.
xcopy ..\Source\%1\src ..\Source\%1\bin /R /E /EXCLUDE:exclude.txt

:JAR_SRC
ECHO.
ECHO. Jar-ing up the source
ECHO.
jar cfm .\%1.jar ..\Source\%1\src\META-INF\MANIFEST.MF -C ..\Source\%1\bin .
rem jar cvf .\%1.jar -C ..\Source\%1\bin .
GOTO:EOF

:COMPILE_APP_NOT_EXIST
ECHO.
ECHO. Application directory [%1] does not exist, skipping compilation ...
ECHO.

:QUIT
@ENDLOCAL