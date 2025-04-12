@echo off
setlocal enabledelayedexpansion

echo Cleaning Flutter build...
call flutter clean || (
    echo Flutter clean failed
    exit /b 1
)
call flutter pub get || (
    echo Flutter pub get failed
    exit /b 1
)

echo Creating build directory...
if not exist "build\windows\x64" (
    mkdir "build\windows\x64" || (
        echo Failed to create build directory
        exit /b 1
    )
)

echo Restoring MPV library...
if exist "mpv_backup\mpv-dev-x86_64-20250225-git-66659a4.7z" (
    copy "mpv_backup\mpv-dev-x86_64-20250225-git-66659a4.7z" "build\windows\x64\" || (
        echo Failed to copy MPV library
        exit /b 1
    )
) else (
    echo MPV backup file not found in mpv_backup directory
    exit /b 1
)

echo Building Windows application...
call flutter build windows || (
    echo Flutter build failed
    exit /b 1
)

echo Running deployment script...
call deploy.bat || (
    echo Deployment failed
    exit /b 1
)

echo Build and deployment completed successfully
exit /b 0