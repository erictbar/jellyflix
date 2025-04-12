@echo off
set DEPLOY_DIR=D:\Deploy\jellyflix
echo Creating deployment directory...
mkdir "%DEPLOY_DIR%"

echo Copying release files...
xcopy /E /I /Y "build\windows\x64\runner\Release\*" "%DEPLOY_DIR%"

echo Creating downloads directory...
mkdir "%DEPLOY_DIR%\downloads"

echo Creating config file...
echo DOWNLOAD_DIR=E:\Media\jellyflix\downloads> "%DEPLOY_DIR%\config.txt"

echo Deployment complete at %DEPLOY_DIR%