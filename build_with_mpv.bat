@echo off
echo Cleaning Flutter build...
flutter clean
flutter pub get

echo Creating build directory...
mkdir "build\windows\x64"

echo Restoring MPV library...
copy "mpv_backup\mpv-dev-x86_64-20250225-git-66659a4.7z" "build\windows\x64\"

echo Building Windows application...
flutter build windows

echo Deploying
.\deploy.bat