@echo off
setlocal enabledelayedexpansion

echo Link Opener Script
echo ==================
echo.

REM Find the first .txt file in the current directory
set "txtFile="
for %%f in (*.txt) do (
    set "txtFile=%%f"
    goto :foundFile
)

:foundFile
if "%txtFile%"=="" (
    echo No .txt files found in the current directory!
    pause
    exit /b 1
)

echo Found file: %txtFile%
echo Reading links...

REM Count valid links in the file
set lineCount=0
for /f "usebackq delims=" %%a in ("%txtFile%") do (
    set "line=%%a"
    call :CleanURL "!line!"
    if not "!cleanedURL!"=="" (
        set /a lineCount+=1
    )
)

echo Total links found: %lineCount%
echo.

if %lineCount% EQU 0 (
    echo No valid links found in the file!
    pause
    exit /b 1
)

echo Starting to open links...
echo.

set currentLine=0
for /f "usebackq delims=" %%a in ("%txtFile%") do (
    set "line=%%a"
    
    REM Clean the URL
    call :CleanURL "!line!"
    
    if not "!cleanedURL!"=="" (
        set /a currentLine+=1
        echo [!currentLine!/%lineCount%] Opening: !cleanedURL!
        
        REM Open the URL in default browser
        start "" "!cleanedURL!"
        
        REM Wait 1 second (1000 milliseconds)
        ping -n 2 127.0.0.1 >nul
    )
)

echo.
echo All links have been opened!
echo.
pause
exit /b

:CleanURL
REM Clean the URL string
set "url=%~1"
if "!url!"=="" (
    set "cleanedURL="
    goto :eof
)

REM Remove any non-ASCII/weird characters at the beginning
REM This handles the ・ｿ character issue
set "temp=!url!"

REM Remove common problematic characters and trim
for %%c in (・ ｿ ▒ □ • · • ·) do (
    set "temp=!temp:%%c=!"
)

REM Remove control characters and other weird symbols
set "temp=!temp:"=!"
set "temp=!temp:'=!"

REM Trim leading/trailing spaces and quotes
for /f "tokens=* delims= " %%i in ("!temp!") do set "temp=%%i"
for /f "delims= " %%i in ("!temp!") do set "temp=%%i"

REM Check if it looks like a URL
echo !temp! | findstr /i "^http" >nul
if !errorlevel! equ 0 (
    set "cleanedURL=!temp!"
) else (
    echo !temp! | findstr /i "^www\." >nul
    if !errorlevel! equ 0 (
        set "cleanedURL=https://!temp!"
    ) else (
        echo !temp! | findstr /i "^youtu" >nul
        if !errorlevel! equ 0 (
            set "cleanedURL=https://!temp!"
        ) else (
            set "cleanedURL="
        )
    )
)

goto :eof