@echo off
:: Simple Windows Activation Tool
:: Easy-to-use version that guides you step by step

title Windows Activation Tool
color 0A
cls

:: Check for admin rights
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo Requesting administrator privileges...
    CD /d %~dp0
    MSHTA "javascript: var shell = new ActiveXObject('shell.application'); shell.ShellExecute('%~nx0', '', '', 'runas', 1);close();"
    EXIT
)

:MAINMENU
cls
echo.
echo  ================================
echo     WINDOWS ACTIVATION TOOL
echo  ================================
echo.
echo    Which Windows version?
echo.
echo    [1] Windows 10
echo    [2] Windows 11
echo    [3] Windows Server 2016
echo    [4] Deactivate Windows
echo    [0] Exit
echo.
echo  ================================

choice /C:12340 /M "Select Windows version (1-4 or 0 to exit): "
set version=%errorlevel%

if %version% == 0 exit /b
if %version% == 4 goto DEACTIVATE
if %version% == 3 goto SERVER2016

:: Windows 10 or 11 edition selection
:EDITIONMENU
cls
echo.
echo  ================================
if %version% == 1 (
    echo    WINDOWS 10 EDITION SELECTION
    set "winprefix=Win10"
) else (
    echo    WINDOWS 11 EDITION SELECTION
    set "winprefix=Win11"
)
echo  ================================
echo.
echo    Available editions:
echo.
if %version% == 1 (
    echo    [1] Home
    echo    [2] Professional
    echo    [3] Education
    echo    [4] Enterprise
    echo    [5] Professional N
) else (
    echo    [1] Home
    echo    [2] Professional
)
echo    [0] Back to main menu
echo.
echo  ================================

choice /C:123450 /M "Select edition (1-5 or 0 to go back): "
set edition=%errorlevel%

if %edition% == 0 goto MAINMENU

:: Set product keys
set "Win10Home=TX9XD-98N7V-6WMQ6-BX7FG-H8Q99"
set "Win10Professional=W269N-WFGWX-YVC9B-4J6C9-T83GX"
set "Win10ProfessionalN=MH37W-N47XK-V7XM9-C7227-GCQG9"
set "Win10Education=NW6C2-QMPVW-D7KKK-3GKT6-VCFB2"
set "Win10Enterprise=NPPR9-FWDCX-D2C8J-H872K-2YT43"
set "Win10Server=WC2BQ-8NRM3-FDDYY-2BFGV-KHKQY"
set "Win11Home=YTMG3-N6DKC-DKB77-7M9GH-8HVX7"
set "Win11Professional=NRG8B-VKK3Q-CXVCJ-9G2XF-6Q84J"

:: Activate selected version
if %version% == 1 (
    if %edition% == 1 (
        set "key=%Win10Home%"
        set "editionname=Windows 10 Home"
    )
    if %edition% == 2 (
        set "key=%Win10Professional%"
        set "editionname=Windows 10 Professional"
    )
    if %edition% == 3 (
        set "key=%Win10Education%"
        set "editionname=Windows 10 Education"
    )
    if %edition% == 4 (
        set "key=%Win10Enterprise%"
        set "editionname=Windows 10 Enterprise"
    )
    if %edition% == 5 (
        set "key=%Win10ProfessionalN%"
        set "editionname=Windows 10 Professional N"
    )
) else if %version% == 2 (
    if %edition% == 1 (
        set "key=%Win11Home%"
        set "editionname=Windows 11 Home"
    )
    if %edition% == 2 (
        set "key=%Win11Professional%"
        set "editionname=Windows 11 Professional"
    )
)

:ACTIVATE
cls
echo.
echo  Activating %editionname%...
echo  Please wait...
echo.
slmgr /ipk %key%
slmgr /skms kms8.msguides.com
slmgr /ato
echo.
echo  Activation attempt complete!
pause
goto MAINMENU

:SERVER2016
cls
echo.
echo  Activating Windows Server 2016...
echo  Please wait...
echo.
slmgr /ipk %Win10Server%
slmgr /skms kms8.msguides.com
slmgr /ato
echo.
echo  Activation attempt complete!
pause
goto MAINMENU

:DEACTIVATE
cls
echo.
echo  Removing Windows activation...
echo  Please wait...
echo.
slmgr /upk
slmgr /cpky
echo.
echo  Windows has been deactivated.
pause
goto MAINMENU
