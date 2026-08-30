@echo off
color 1F
title System Tools Menu - by Abbas Khodari

:: ---------------------------------------------
:: Check for Administrator privileges
:: ---------------------------------------------
net session >nul 2>&1
if %errorlevel% NEQ 0 (
    echo ================================================
    echo   This tool requires Administrator privileges.
    echo   Requesting elevation...
    echo ================================================
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:MENU
cls
echo ================================================
echo                 SYSTEM TOOLS MENU
echo             (Running as Administrator)
echo                by Abbas Khodari
echo ================================================
echo.
echo   [1] Show Windows Product Key
echo   [2] Device Properties (System Information)
echo   [3] Clean Temporary Files
echo   [4] Scan and Repair System (SFC / CHKDSK)
echo   [5] Exit
echo.
echo ================================================
set /p choice="Enter your choice and press Enter: "

if "%choice%"=="1" goto ACTIVE
if "%choice%"=="2" goto PROPERTIES
if "%choice%"=="3" goto TEMP
if "%choice%"=="4" goto TROUBLESHOOT
if "%choice%"=="5" goto END

echo.
echo Invalid choice, please try again...
timeout /t 2 >nul
goto MENU

:ACTIVE
cls
title Windows Product Key
echo Please wait.......
echo.
powershell -NoProfile -Command "(Get-CimInstance -ClassName SoftwareLicensingService).OA3xOriginalProductKey"
if errorlevel 1 (
    echo Could not retrieve the key using PowerShell, trying WMIC...
    wmic path softwarelicensingservice get OA3xOriginalProductKey 2>nul
    if errorlevel 1 echo Failed. WMIC may not be available on this system.
)
echo.
pause
goto MENU

:PROPERTIES
cls
title Device Properties
echo Please wait........
echo.
msinfo32
if errorlevel 1 echo Failed to open System Information.
goto MENU

:TEMP
cls
title Clean Temporary Files
echo Deleting temporary files...
echo NOTE: Some files in use may not be deletable - this is normal.
echo.

del /s /q "C:\Windows\Temp\*.*" >nul 2>&1
rd /s /q "C:\Windows\Temp" >nul 2>&1

del /s /q "%LOCALAPPDATA%\Temp\*.*" >nul 2>&1
rd /s /q "%LOCALAPPDATA%\Temp" >nul 2>&1

del /s /q "C:\Windows\Prefetch\*.*" >nul 2>&1
rd /s /q "C:\Windows\Prefetch" >nul 2>&1

echo.
echo Cleanup completed.
pause
goto MENU

:TROUBLESHOOT
cls
title Scan and Repair System
echo This will run:  sfc /scannow   then   chkdsk /f
echo.
echo WARNING:
echo  - This may take a long time to finish.
echo  - chkdsk /f on the system drive (C:) usually cannot run
echo    while Windows is using it, so it will be SCHEDULED
echo    to run on the next restart. You will need to restart
echo    your PC afterwards for the disk check to actually run.
echo.
set /p confirm="Do you want to continue? (Y/N): "
if /i not "%confirm%"=="Y" goto MENU

sfc /scannow
echo.
chkdsk C: /f
echo.
echo If chkdsk asked to schedule the check, restart your PC
echo to let it run before Windows fully loads.
pause
goto MENU

:END
exit
