@echo off
echo Setting up build environment...

REM Create necessary directories for the build
mkdir lib\ejb
mkdir lib\external\apache\common
mkdir lib\external\apache\logging
mkdir lib\external\spring
mkdir lib\external\spring\aspectj
mkdir lib\external\spring\antlr
mkdir lib\external\ibatis
mkdir lib\external\hsm

REM Create placeholder files for system dependencies
type nul > lib\AppCore.jar
type nul > lib\AppMsg.jar
type nul > lib\AppUtil.jar
type nul > lib\EjbCommon.jar
type nul > lib\EjbIntraCommonScs.jar
type nul > lib\HsmCommon.jar
type nul > lib\WnbLog.jar
type nul > lib\Startup.jar
type nul > lib\CyberUtilCommonForWas.jar
type nul > lib\CyberUtilToolsForWas.jar
type nul > lib\CyberUtilForWas.jar

echo Build environment setup complete.
