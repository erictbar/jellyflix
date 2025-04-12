@echo off
set DEPLOY_DIR=D:\Apps\jellyflix
set SOURCE_DIR=D:\Developer\jellyflix\build\windows\x64\runner\Release

echo Preserving original Release folder...
if exist "%DEPLOY_DIR%\Release" (
    move "%DEPLOY_DIR%\Release" "%DEPLOY_DIR%\Release.keep"
)

echo Cleaning deployment directory except Release...
rd /s /q "%DEPLOY_DIR%"
mkdir "%DEPLOY_DIR%"

echo Copying new build files...
xcopy /E /I /Y "%SOURCE_DIR%\*" "%DEPLOY_DIR%"

echo Restoring original Release folder...
if exist "%DEPLOY_DIR%\Release.keep" (
    rd /s /q "%DEPLOY_DIR%\Release"
    move "%DEPLOY_DIR%\Release.keep" "%DEPLOY_DIR%\Release"
)

echo Creating downloads directory...
if not exist "%DEPLOY_DIR%\downloads" (
    mkdir "%DEPLOY_DIR%\downloads"
)

echo Creating config file...
echo DOWNLOAD_DIR=E:\Media\jellyflix\downloads> "%DEPLOY_DIR%\config.txt"

echo Deployment complete at %DEPLOY_DIR%