@echo off
:: Disable delayed expansion (this prevents the use of ! to expand variables dynamically)
@setlocal DisableDelayedExpansion

:: Check if the script is run with administrative privileges
NET SESSION

:: If not run as administrator, go to the ELEVATE section to ask for elevated privileges
IF %ERRORLEVEL% NEQ 0 GOTO ELEVATE

:: If the script is already running as administrator, go to the main tasks
GOTO ADMINTASKS

:ELEVATE
:: This section handles re-launching the script with elevated privileges

:: Change to the directory of the batch file to ensure correct path
CD /d %~dp0

:: Use MSHTA to re-launch the script as administrator
MSHTA "javascript: var shell = new ActiveXObject('shell.application'); shell.ShellExecute('%~nx0', '', '', 'runas', 1);close();"

:: Exit the current instance of the script (the elevated one will continue)
EXIT

:ADMINTASKS
:: This section starts the main tasks after the script is elevated to administrator privileges

:top
:: Set the console text color to green (0A) and clear the screen
color 0A
cls

:: Display an ASCII art logo and instructions for the user
echo.
echo.    TTTTTTTTTTTTTTTTTTTTTTTTEEEEEEEEEEEEEEEEEEEEEENNNNNNNN        NNNNNNNNZZZZZZZZZZZZZZZZZZZ     OOOOOOOOO     
echo.    T:::::::::::::::::::::TE::::::::::::::::::::EN:::::::N       N::::::NZ:::::::::::::::::Z   OO:::::::::OO   
echo.    T:::::::::::::::::::::TE::::::::::::::::::::EN::::::::N      N::::::NZ:::::::::::::::::Z OO:::::::::::::OO 
echo.    T:::::TT:::::::TT:::::TEE::::::EEEEEEEEE::::EN:::::::::N     N::::::NZ:::ZZZZZZZZ:::::Z O:::::::OOO:::::::O
echo.    TTTTTT  T:::::T  TTTTTT  E:::::E       EEEEEEN::::::::::N    N::::::NZZZZZ     Z:::::Z  O::::::O   O::::::O
echo.           T:::::T          E:::::E             N:::::::::::N   N::::::N        Z:::::Z    O:::::O     O:::::O
echo.           T:::::T          E::::::EEEEEEEEEE   N:::::::N::::N  N::::::N       Z:::::Z     O:::::O     O:::::O
echo.           T:::::T          E:::::::::::::::E   N::::::N N::::N N::::::N      Z:::::Z      O:::::O     O:::::O
echo.           T:::::T          E:::::::::::::::E   N::::::N  N::::N:::::::N     Z:::::Z       O:::::O     O:::::O
echo.           T:::::T          E::::::EEEEEEEEEE   N::::::N   N:::::::::::N    Z:::::Z        O:::::O     O:::::O
echo.           T:::::T          E:::::E             N::::::N    N::::::::::N   Z:::::Z         O:::::O     O:::::O
echo.           T:::::T          E:::::E       EEEEEEN::::::N     N:::::::::NZZZ:::::Z     ZZZZZO::::::O   O::::::O
echo.       TT:::::::TT      EE::::::EEEEEEEE:::::EN::::::N      N::::::::NZ::::::ZZZZZZZZ:::ZO:::::::OOO:::::::O
echo.       T:::::::::T      E::::::::::::::::::::EN::::::N       N:::::::NZ:::::::::::::::::Z OO:::::::::::::OO 
echo.       T:::::::::T      E::::::::::::::::::::EN::::::N        N::::::NZ:::::::::::::::::Z   OO:::::::::OO   
echo.       TTTTTTTTTTT      EEEEEEEEEEEEEEEEEEEEEENNNNNNNN         NNNNNNNZZZZZZZZZZZZZZZZZZZ     OOOOOOOOO     
echo.

:: Display the options menu for the user to select which action to take
echo.    ===================== SELECT AN OPTION ====================
echo.    [1] Activate Windows 10 - Home
echo.    [2] Activate Windows 10 - Professional
echo.    [3] Activate Windows 10 - Education
echo.    [4] Activate Windows 10 - Enterprise
echo.    [5] Activate Windows 10 - ProfessionalN
echo.    [6] Activate Windows Server 2016
echo.    [7] Activate Windows 11 - Home
echo.    [8] Activate Windows 11 - Professional
echo.    [9] Deactivate Windows
echo.

:: Set product keys for various Windows versions
set "Win10Home=TX9XD-98N7V-6WMQ6-BX7FG-H8Q99"
set "Win10Professional=W269N-WFGWX-YVC9B-4J6C9-T83GX"
set "Win10ProfessionalN=MH37W-N47XK-V7XM9-C7227-GCQG9"
set "Win10Education=NW6C2-QMPVW-D7KKK-3GKT6-VCFB2"
set "Win10Enterprise=NPPR9-FWDCX-D2C8J-H872K-2YT43"
set "Win10Server=WC2BQ-8NRM3-FDDYY-2BFGV-KHKQY"
set "Win11Home=YTMG3-N6DKC-DKB77-7M9GH-8HVX7"
set "Win11Professional=NRG8B-VKK3Q-CXVCJ-9G2XF-6Q84J"

:: Ask the user to choose an option and set the result in the _choice variable
choice /C:123456789 /M "Enter the value: " /N
set _choice=%errorlevel%

:: Depending on the user's choice, jump to the corresponding activation or deactivation task
if %_choice% == 1 goto Win10Home
if %_choice% == 2 goto Win10Professional
if %_choice% == 3 goto Win10Education
if %_choice% == 4 goto Win10Enterprise
if %_choice% == 5 goto Win10ProfessionalN
if %_choice% == 6 goto Win10Server
if %_choice% == 7 goto Win11Home
if %_choice% == 8 goto Win11Professional
if %_choice% == 9 goto Deactivate

:: This section activates Windows 10 Home by installing the product key
:Win10Home
slmgr /ipk %Win10Home%
goto final

:: This section activates Windows 10 Professional by installing the product key
:Win10Professional
slmgr /ipk %Win10Professional%
goto final

:: This section activates Windows 10 ProfessionalN by installing the product key
:Win10ProfessionalN
slmgr /ipk %Win10ProfessionalN%
goto final

:: This section activates Windows 10 Education by installing the product key
:Win10Education
slmgr /ipk %Win10Education%
goto final

:: This section activates Windows 10 Enterprise by installing the product key
:Win10Enterprise
slmgr /ipk %Win10Enterprise%
goto final

:: This section activates Windows Server 2016 by installing the product key
:Win10Server
slmgr /ipk %Win10Server%
goto final

:: This section activates Windows 11 Home by installing the product key
:Win11Home
slmgr /ipk %Win11Home%
goto final

:: This section activates Windows 11 Professional by installing the product key
:Win11Professional
slmgr /ipk %Win11Professional%
goto final

:: This section deactivates Windows by removing the product key
:Deactivate
slmgr /upk && slmgr /cpky
echo Windows has been deactivated.
pause
goto top

:: This section finalizes activation by setting the KMS server and activating Windows
:final
slmgr /skms kms8.msguides.com
slmgr /ato
pause
goto top
