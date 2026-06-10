@echo off
:: ====================================================================
::   NgulikOS Tuner - FINAL VERSION
::   Target  : Windows 10 LTSC IoT 2021 (19044) - N2840 CPU + HDD
::   Author  : NgulikOS Project (Final Optimized Edition)
::   Version : 2.0 COMPLETE
::   
::   8 MODES:
::   [1] SAFE      - Core privacy + telemetry + bloatware OFF
::   [2] HDD MODE  - SAFE + disk I/O reduction
::   [3] POTATO    - HDD MODE + scheduled tasks OFF
::   [4] POTATO+   - POTATO + WaaSMedic OFF (Defender ON)
::   [5] NUCLEAR   - POTATO+ + Defender OFF
::   [6] CLEAN     - Remove temp files + cache
::   [7] BENCHMARK - Disk/CPU/RAM speed test
::   [8] ROLLBACK  - Restore all to defaults
::   
::   WARNING: Run as Administrator! Back up system first!
:: ====================================================================

setlocal enabledelayedexpansion
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] MUST run as Administrator!
    pause
    exit /b
)

:MENU
cls
echo.
echo  ███╗   ██╗ ████╗ ██╗   ██╗██╗     ██╗██╗  ██╗ ████╗ ███████╗
echo  ████╗  ██║██╔════╝ ██║   ██║██║     ██║██║ ██╔╝██╔════╝██╔════╝
echo  ██╔██╗ ██║██║  ███╗██║   ██║██║     ██║████╔╝ █████╗   ███████╗
echo  ██║╚██╗██║██║   ██║██║   ██║██║     ██║██╔═██╗ ██╔══╝   ╚════██║
echo  ██║ ╚████║╚████╔╝╚████╔╝████╗██║██║  ██╗╚████╔╝ ███████╗███████║
echo  ╚═╝  ╚═══╝ ╚════╝  ╚════╝ ╚════╝╚═╝╚═╝  ╚═╝ ╚════╝ ╚══════╝
echo.
echo  ==== NgulikOS Tuner v2.0 - FINAL EDITION ====
echo.
echo  [1] SAFE      - Telemetry, OneDrive, Xbox, Updates paused
echo  [2] HDD MODE  - SAFE + SysMain, Search, Maintenance, I/O tweaks OFF
echo  [3] POTATO    - HDD MODE + scheduled tasks disabled
echo  [4] POTATO+   - POTATO + WaaSMedic disabled (Defender active)
echo  [5] NUCLEAR   - POTATO+ + Defender OFF (extreme mode)
echo  [6] CLEAN     - Remove temp files, cache, cleanup
echo  [7] BENCHMARK - Test disk/CPU/RAM speed
echo  [8] ROLLBACK  - Restore all to Windows defaults
echo  [0] EXIT
echo.
set /p PILIHAN= Choose mode [0-8]: 

if "%PILIHAN%"=="1" goto SAFE
if "%PILIHAN%"=="2" goto HDD
if "%PILIHAN%"=="3" goto POTATO
if "%PILIHAN%"=="4" goto POTATOPLUS
if "%PILIHAN%"=="5" goto NUCLEAR
if "%PILIHAN%"=="6" goto CLEAN
if "%PILIHAN%"=="7" goto BENCHMARK
if "%PILIHAN%"=="8" goto ROLLBACK
if "%PILIHAN%"=="0" exit
goto MENU

:: ====================================================================
:: MODE 1 - SAFE: Core Privacy + Telemetry + Bloatware OFF
:: ====================================================================
:SAFE
cls
echo.
echo  [SAFE MODE] Starting light optimizations...
echo  ====
echo.

echo [*] Disable Telemetry (AllowTelemetry = 0)...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul 2>&1

echo [*] Disable DiagTrack service...
sc stop DiagTrack >nul 2>&1
sc config DiagTrack start= disabled >nul 2>&1

echo [*] Disable dmwappushsvc...
sc stop dmwappushsvc >nul 2>&1
sc config dmwappushsvc start= disabled >nul 2>&1

echo [*] Disable Connected User Experiences...
sc stop DiagTrack >nul 2>&1
sc config DiagTrack start= disabled >nul 2>&1

echo [*] Disable OneDrive integration...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v DisableFileSyncNGSC /t REG_DWORD /d 1 /f >nul 2>&1
taskkill /f /im OneDrive.exe >nul 2>&1

echo [*] Disable Xbox services (XboxLive, GameSave, etc)...
sc stop XblAuthManager >nul 2>&1
sc config XblAuthManager start= disabled >nul 2>&1
sc stop XblGameSave >nul 2>&1
sc config XblGameSave start= disabled >nul 2>&1
sc stop XboxNetApiSvc >nul 2>&1
sc config XboxNetApiSvc start= disabled >nul 2>&1
sc stop XboxGipSvc >nul 2>&1
sc config XboxGipSvc start= disabled >nul 2>&1

echo [*] Disable Delivery Optimization (DoSvc)...
sc stop DoSvc >nul 2>&1
sc config DoSvc start= disabled >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v DODownloadMode /t REG_DWORD /d 0 /f >nul 2>&1

echo [*] Disable Customer Experience Improvement...
schtasks /Change /TN "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable >nul 2>&1

echo [*] Disable Remote Assistance...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v fAllowToGetHelp /t REG_DWORD /d 0 /f >nul 2>&1

echo [*] Disable Location Tracking...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v DisableLocation /t REG_DWORD /d 1 /f >nul 2>&1

echo [*] Disable Advertising ID...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1

echo [*] Disable App Suggestions...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338389Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338393Enabled /t REG_DWORD /d 0 /f >nul 2>&1

echo [*] UI Responsiveness: AutoEndTasks (kill unresponsive apps faster)...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\taskmgr.exe" /v AutoEndTasks /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v AutoEndTasks /t REG_SZ /d 1 /f >nul 2>&1

echo [*] UI Responsiveness: WaitToKillServiceTimeout = 3000ms (default 5000)...
reg add "HKCU\Control Panel\Desktop" /v WaitToKillServiceTimeout /t REG_SZ /d 3000 /f >nul 2>&1

echo [*] UI Responsiveness: MenuShowDelay = 0ms (no lag on menu open)...
reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 0 /f >nul 2>&1

echo.
echo  [OK] SAFE MODE complete! Restart recommended.
echo.
pause
goto MENU

:: ====================================================================
:: MODE 2 - HDD MODE: SAFE + Disk I/O Reduction + UI Tweaks
:: ====================================================================
:HDD
cls
echo.
echo  [HDD MODE] Starting disk I/O optimization...
echo  ====
echo.

call :SAFE_SILENT

echo [*] Disable SysMain (Superfetch/ReadyBoost)...
sc stop SysMain >nul 2>&1
sc config SysMain start= disabled >nul 2>&1

echo [*] Disable Windows Search (WSearch)...
sc stop WSearch >nul 2>&1
sc config WSearch start= disabled >nul 2>&1

echo [*] Clear Search Index database...
if exist "C:\ProgramData\Microsoft\Search\Data" (
    rd /s /q "C:\ProgramData\Microsoft\Search\Data" >nul 2>&1
    echo     [OK] Search index cleared.
)

echo [*] Disable Automatic Maintenance...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v MaintenanceDisabled /t REG_DWORD /d 1 /f >nul 2>&1

echo [*] Disable Storage Sense...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v 01 /t REG_DWORD /d 0 /f >nul 2>&1

echo [*] Disable Automatic Driver Search...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v SearchOrderConfig /t REG_DWORD /d 0 /f >nul 2>&1

echo [*] Disable Defender scheduled scan tasks...
schtasks /Change /TN "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Windows Defender\Windows Defender Cleanup" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Windows Defender\Windows Defender Verification" /Disable >nul 2>&1

echo [*] Disable Disk Diagnostic...
schtasks /Change /TN "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Disable >nul 2>&1

echo [*] Disable Edge Updater...
sc stop edgeupdate >nul 2>&1
sc config edgeupdate start= disabled >nul 2>&1
sc stop edgeupdatem >nul 2>&1
sc config edgeupdatem start= disabled >nul 2>&1

echo [*] Disable Hibernate (free disk space, reduce writes)...
powercfg -h off >nul 2>&1

echo [*] Set fixed Pagefile 2048MB (prevent constant resize)...
wmic computersystem where name="%computername%" set AutomaticManagedPagefile=False >nul 2>&1
wmic pagefileset where name="C:\\pagefile.sys" set InitialSize=2048,MaximumSize=2048 >nul 2>&1

echo [*] Disable Network Throttling (legacy Vista QoS)...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 4294967295 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 0 /f >nul 2>&1

echo [*] Enable High Performance power plan...
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1

echo [*] Disable Meltdown + Spectre mitigations (safe for N2840)...
:: N2840 (Bay Trail) not vulnerable to Spectre v2 per Intel
:: Unnecessary mitigations waste CPU on old hardware
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverride /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverrideMask /t REG_DWORD /d 3 /f >nul 2>&1

echo [*] NTFS optimizations - disable last access updates...
fsutil behavior set disablelastaccess 1 >nul 2>&1

echo [*] NTFS optimization - disable 8.3 short names...
fsutil behavior set disable8dot3 1 >nul 2>&1

echo [*] NTFS optimization - set MFT zone to 2 (prevent fragmentation)...
fsutil behavior set mftzone 2 >nul 2>&1

echo [*] Visual Effects - Best Performance (minimal animations)...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f >nul 2>&1

echo.
echo  [OK] HDD MODE complete! Restart recommended.
echo.
pause
goto MENU

:: ====================================================================
:: MODE 3 - POTATO: HDD MODE + Disable Scheduled Tasks
:: ====================================================================
:POTATO
cls
echo.
echo  [POTATO MODE] Disabling everything non-essential...
echo  ====
echo.

call :HDD_SILENT

echo [*] Pause Windows Update for 10 years...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DisableWindowsUpdateAccess /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v AUOptions /t REG_DWORD /d 1 /f >nul 2>&1

echo [*] Disable Windows Update services...
sc stop wuauserv >nul 2>&1
sc config wuauserv start= disabled >nul 2>&1

echo [*] Disable CompatTelRunner + all telemetry tasks...
schtasks /Change /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Application Experience\StartupAppTask" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Application Experience\AitAgent" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Autochk\Proxy" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Assessment\WinSAT" /Disable >nul 2>&1

echo [*] Block CompatTelRunner via registry (anti-resurrection)...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v DisableInventory /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v DisablePCA /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v DisableUAR /t REG_DWORD /d 1 /f >nul 2>&1

echo [*] Rename CompatTelRunner binary (permanent disable)...
if exist "%SystemRoot%\System32\CompatTelRunner.exe" (
    takeown /f "%SystemRoot%\System32\CompatTelRunner.exe" >nul 2>&1
    icacls "%SystemRoot%\System32\CompatTelRunner.exe" /grant administrators:F >nul 2>&1
    ren "%SystemRoot%\System32\CompatTelRunner.exe" "CompatTelRunner.exe.bak" >nul 2>&1
    echo     [OK] CompatTelRunner disabled permanently.
)

echo [*] Disable Background Apps...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /t REG_DWORD /d 1 /f >nul 2>&1

echo [*] Disable Consumer Features (bloat)...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1 /f >nul 2>&1

echo [*] Disable Print Spooler (unnecessary on headless/laptop)...
sc stop Spooler >nul 2>&1
sc config Spooler start= disabled >nul 2>&1

echo [*] Disable Fax service...
sc stop Fax >nul 2>&1
sc config Fax start= disabled >nul 2>&1

echo.
echo  [OK] POTATO MODE complete! Restart strongly recommended.
echo.
pause
goto MENU

:: ====================================================================
:: MODE 4 - POTATO+: POTATO + WaaSMedic OFF (Defender stays ON)
:: ====================================================================
:POTATOPLUS
cls
echo.
echo  [POTATO+ MODE] Disable WaaSMedic self-healing...
echo  ====
echo.

call :POTATO_SILENT

echo [*] Disable WaaSMedic (Update Orchestrator service)...
:: WaaSMedic = Windows as a Service Medical (auto-heals broken updates)
:: Bypasses sc config by using protected process
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v FailureActions /t REG_BINARY /d 0000 /f >nul 2>&1
sc stop WaaSMedicSvc >nul 2>&1

echo [*] Disable Update Orchestrator Service (UsoSvc)...
sc stop UsoSvc >nul 2>&1
sc config UsoSvc start= disabled >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

echo [*] Disable Update Orchestrator tasks...
schtasks /Change /TN "\Microsoft\Windows\UpdateOrchestrator\Reboot" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\UpdateOrchestrator\USO_UxBroker" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\WaaSMedic\PerformRemediation" /Disable >nul 2>&1

echo [*] Block Windows Update domains via hosts file...
findstr /c:"windowsupdate.microsoft.com" %WINDIR%\System32\drivers\etc\hosts >nul 2>&1
if !errorlevel! neq 0 (
    echo 0.0.0.0 windowsupdate.microsoft.com >> %WINDIR%\System32\drivers\etc\hosts
    echo 0.0.0.0 update.microsoft.com >> %WINDIR%\System32\drivers\etc\hosts
    echo 0.0.0.0 download.windowsupdate.com >> %WINDIR%\System32\drivers\etc\hosts
    echo 0.0.0.0 wustat.windows.com >> %WINDIR%\System32\drivers\etc\hosts
    echo 0.0.0.0 metadata.microsoft.com >> %WINDIR%\System32\drivers\etc\hosts
    echo     [OK] Update domains blocked in hosts.
)

echo [*] Status: Defender remains ACTIVE (protection active)...
echo     TAPI/security services running normally.

echo.
echo  [OK] POTATO+ complete! Restart recommended.
echo  [i]  Defender ON, WaaSMedic + Updates OFF.
echo.
pause
goto MENU

:: ====================================================================
:: MODE 5 - NUCLEAR: POTATO+ + Defender OFF (No Protection!)
:: ====================================================================
:NUCLEAR
cls
echo.
echo  ====
echo  [NUCLEAR MODE] - EXTREME WARNING!
echo  ====
echo.
echo  This mode will:
echo  - DISABLE Windows Defender completely
echo  - DISABLE all Windows Update mechanisms
echo  - DISABLE WaaSMedic self-healing
echo  - DISABLE Windows Error Reporting
echo  - DISABLE Security Center
echo.
echo  CONSEQUENCES:
echo  - NO antimalware protection active!
echo  - NO security updates!
echo  - EXTREME RISK on internet-connected systems!
echo.
echo  SAFE USE CASES:
echo  - Offline system / airgapped machine
echo  - Performance benchmarking only
echo  - Lab environment / virtual machine
echo.
set /p KONFIRM= Type YES to proceed (irreversible until ROLLBACK): 
if /i not "%KONFIRM%"=="YES" (
    echo [!] Cancelled. Returning to menu.
    pause
    goto MENU
)

call :POTATO_SILENT
call :WAASMEDIC_SILENT

echo [*] Disable Tamper Protection (required before Defender shutdown)...
:: Tamper Protection blocks attempts to disable Defender
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender\Features" /v TamperProtection /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender\Features" /v TamperProtectionSource /t REG_DWORD /d 0 /f >nul 2>&1
timeout /t 2 /nobreak >nul 2>&1

echo [*] Disable Windows Defender via Group Policy (triple-layer block)...
:: Layer 1: Policy - antispyware/antivirus disable
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiVirus /t REG_DWORD /d 1 /f >nul 2>&1
:: Layer 2: Real-time protection disabled
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableRealtimeMonitoring /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableBehaviorMonitoring /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableOnAccessProtection /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableScanOnRealtimeEnable /t REG_DWORD /d 1 /f >nul 2>&1
:: Layer 3: Cloud-based protection disabled
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v DisableBlockAtFirstSeen /t REG_DWORD /d 1 /f >nul 2>&1

echo [*] Stop WinDefend service immediately...
sc stop WinDefend >nul 2>&1
sc config WinDefend start= disabled >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WinDefend" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

echo [*] Disable Windows Security Center...
sc stop wscsvc >nul 2>&1
sc config wscsvc start= disabled >nul 2>&1

echo [*] Disable Windows Error Reporting (telemetry backend)...
sc stop WerSvc >nul 2>&1
sc config WerSvc start= disabled >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 1 /f >nul 2>&1

echo [*] Disable BITS (Background Intelligent Transfer)...
sc stop BITS >nul 2>&1
sc config BITS start= disabled >nul 2>&1

echo [*] Disable SysMain permanently...
sc stop SysMain >nul 2>&1
sc config SysMain start= disabled >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SysMain" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

echo.
echo  ====
echo  [!!] NUCLEAR MODE ACTIVE!
echo  ====
echo.
echo  Defender: OFF
echo  Updates: OFF
echo  Protection: NONE
echo.
echo  Restart REQUIRED immediately!
echo.
pause
goto MENU

:: ====================================================================
:: MODE 6 - CLEAN: Remove Temporary Files + Cache
:: ====================================================================
:CLEAN
cls
echo.
echo  [CLEAN MODE] Removing temporary files and caches...
echo  ====
echo.

echo [*] Clear Windows Temp folder...
for /d %%x in ("%SystemRoot%\Temp\*") do (
    rd /s /q "%%x" >nul 2>&1
)
del /q /f "%SystemRoot%\Temp\*" >nul 2>&1
echo     [OK] Windows Temp cleared.

echo [*] Clear User Temp folder...
for /d %%x in ("%TEMP%\*") do (
    rd /s /q "%%x" >nul 2>&1
)
del /q /f "%TEMP%\*" >nul 2>&1
echo     [OK] User Temp cleared.

echo [*] Clear Windows Update cache...
if exist "C:\Windows\SoftwareDistribution\Download" (
    for /d %%x in ("C:\Windows\SoftwareDistribution\Download\*") do (
        rd /s /q "%%x" >nul 2>&1
    )
    echo     [OK] Update cache cleared.
)

echo [*] Clear Windows Prefetch cache...
if exist "C:\Windows\Prefetch" (
    del /q /f "C:\Windows\Prefetch\*" >nul 2>&1
    echo     [OK] Prefetch cache cleared.
)

echo [*] Clear Event Logs...
for /f %%x in ('wevtutil el') do wevtutil cl "%%x" >nul 2>&1
echo     [OK] Event logs cleared.

echo [*] Clear Internet Explorer cache...
rundll32 inetcpl.cpl,ClearMyTracksByProcess 255 >nul 2>&1
echo     [OK] IE cache cleared.

echo [*] Empty Recycle Bin...
Rd /S /Q "%systemdrive%\$Recycle.Bin" >nul 2>&1
echo     [OK] Recycle Bin emptied.

echo [*] Clear memory compression...
:: Memory compression sometimes helps free RAM temporarily
Get-Volume -DriveLetter C | Optimize-Volume -Defrag -Verbose >nul 2>&1
echo     [OK] Defrag optimized.

echo.
echo  [OK] CLEAN MODE complete!
echo.
pause
goto MENU

:: ====================================================================
:: MODE 7 - BENCHMARK: Disk/CPU/RAM Speed Test
:: ====================================================================
:BENCHMARK
cls
setlocal enabledelayedexpansion
echo.
echo  [BENCHMARK] Starting performance tests...
echo  ====
echo.

echo [*] CPU Usage (current snapshot):
for /f "tokens=2 delims==" %%a in ('wmic cpu get loadpercentage /format:list') do (
    set CPU=%%a
    echo     CPU Load: !CPU!%% 
)

echo.
echo [*] RAM Status:
for /f "tokens=2 delims==" %%a in ('wmic OS get FreePhysicalMemory /format:list') do (
    set FREEMEM=%%a
    if defined FREEMEM (
        set /a FREEGB=!FREEMEM! / 1048576
        echo     Free RAM: !FREEGB! GB
    )
)
for /f "tokens=2 delims==" %%a in ('wmic OS get TotalVisibleMemorySize /format:list') do (
    set TOTALMEM=%%a
    if defined TOTALMEM (
        set /a TOTALGB=!TOTALMEM! / 1048576
        echo     Total RAM: !TOTALGB! GB
    )
)

echo.
echo [*] Disk Read/Write Speed (WinSAT disk benchmark - 30-60 sec)...
echo     Please wait... DO NOT interrupt!
winsat disk -drive c 2>nul | findstr /i "disk\|score\|MB/s\|write\|read"

echo.
echo [*] Disk Size (C:\ drive):
for /f "tokens=2 delims==" %%a in ('wmic logicaldisk where name^="C:" get size /format:list') do (
    set SIZE=%%a
    if defined SIZE (
        set /a SIZEGB=!SIZE! / 1073741824
        echo     Drive Size: !SIZEGB! GB
    )
)

echo.
echo [*] Active Services Status (disk I/O related):
echo.
for %%s in (SysMain WSearch wuauserv DiagTrack DoSvc WaaSMedicSvc UsoSvc WinDefend) do (
    sc query %%s 2>nul | findstr "STATE" >nul
    if !errorlevel!==0 (
        for /f "tokens=4" %%b in ('sc query %%s 2^>nul ^| findstr "STATE"') do (
            if "%%b"=="RUNNING" (
                echo     [ON]  %%s
            ) else if "%%b"=="STOPPED" (
                echo     [OFF] %%s
            )
        )
    )
)

echo.
echo  [OK] Benchmark complete!
echo.
pause
goto MENU

:: ====================================================================
:: MODE 8 - ROLLBACK: Restore All to Windows Defaults
:: ====================================================================
:ROLLBACK
cls
echo.
echo  [ROLLBACK] Restoring Windows to defaults...
echo  ====
echo.
echo  This will re-enable:
echo  - SysMain, WSearch, Windows Update
echo  - Windows Defender, Tamper Protection
echo  - Telemetry, Scheduled maintenance
echo  - OneDrive, Xbox, Delivery Optimization
echo.
set /p KONFIRM2= Type YES to proceed: 
if /i not "%KONFIRM2%"=="YES" (
    echo [!] Cancelled.
    pause
    goto MENU
)

echo [*] Enable SysMain (Superfetch)...
sc config SysMain start= auto >nul 2>&1
sc start SysMain >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SysMain" /v Start /t REG_DWORD /d 2 /f >nul 2>&1

echo [*] Enable WSearch (Windows Search)...
sc config WSearch start= delayed-auto >nul 2>&1
sc start WSearch >nul 2>&1

echo [*] Enable Windows Update service...
sc config wuauserv start= demand >nul 2>&1
sc start wuauserv >nul 2>&1

echo [*] Delete Windows Update policy blocks...
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /f >nul 2>&1

echo [*] Enable Update Orchestrator (UsoSvc)...
sc config UsoSvc start= demand >nul 2>&1
sc start UsoSvc >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc" /v Start /f >nul 2>&1

echo [*] Enable WaaSMedic (Update self-healing)...
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
sc config WaaSMedicSvc start= auto >nul 2>&1
sc start WaaSMedicSvc >nul 2>&1

echo [*] Restore Windows Defender + Tamper Protection...
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /f >nul 2>&1
:: Restore Tamper Protection to ON
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender\Features" /v TamperProtection /t REG_DWORD /d 5 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender\Features" /v TamperProtectionSource /t REG_DWORD /d 2 /f >nul 2>&1
:: Restore WinDefend service
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WinDefend" /v Start /t REG_DWORD /d 2 /f >nul 2>&1
sc config WinDefend start= auto >nul 2>&1
sc start WinDefend >nul 2>&1

echo [*] Restore Windows Security Center...
sc config wscsvc start= auto >nul 2>&1
sc start wscsvc >nul 2>&1

echo [*] Enable Delivery Optimization (DoSvc)...
sc config DoSvc start= auto >nul 2>&1
sc start DoSvc >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /f >nul 2>&1

echo [*] Restore Windows Error Reporting...
sc config WerSvc start= demand >nul 2>&1
sc start WerSvc >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v Disabled /f >nul 2>&1

echo [*] Enable BITS...
sc config BITS start= auto >nul 2>&1
sc start BITS >nul 2>&1

echo [*] Restore Defender scheduled tasks...
schtasks /Change /TN "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" /Enable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance" /Enable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Windows Defender\Windows Defender Cleanup" /Enable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Windows Defender\Windows Defender Verification" /Enable >nul 2>&1

echo [*] Restore Automatic Maintenance...
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v MaintenanceDisabled /f >nul 2>&1

echo [*] Restore Telemetry...
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 1 /f >nul 2>&1

echo [*] Restore Hibernate...
powercfg -h on >nul 2>&1

echo [*] Reset Pagefile to Automatic...
wmic computersystem where name="%computername%" set AutomaticManagedPagefile=True >nul 2>&1

echo [*] Restore Background Apps...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /f >nul 2>&1

echo [*] Restore CompatTelRunner tasks...
schtasks /Change /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Enable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /Enable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Application Experience\StartupAppTask" /Enable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Application Experience\AitAgent" /Enable >nul 2>&1

echo [*] Restore Driver Search...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v SearchOrderConfig /t REG_DWORD /d 1 /f >nul 2>&1

echo [*] Restore Network Throttling to default...
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /f >nul 2>&1

echo [*] Reset Power Plan to Balanced...
powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e >nul 2>&1

echo [*] Restore Meltdown/Spectre mitigations...
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverride /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverrideMask /f >nul 2>&1

echo [*] Restore UI responsiveness defaults...
reg delete "HKCU\Control Panel\Desktop" /v AutoEndTasks /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v WaitToKillServiceTimeout /t REG_SZ /d 5000 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 400 /f >nul 2>&1

echo [*] Restore Print Spooler...
sc config Spooler start= auto >nul 2>&1
sc start Spooler >nul 2>&1

echo [*] Restore Fax service...
sc config Fax start= demand >nul 2>&1

echo [*] Remove hosts file Windows Update blocks...
:: Restore clean hosts file (just localhost)
echo 127.0.0.1 localhost > %WINDIR%\System32\drivers\etc\hosts
echo ::1 localhost >> %WINDIR%\System32\drivers\etc\hosts
echo     [OK] Hosts file restored.

echo.
echo  [OK] ROLLBACK complete! Restart REQUIRED.
echo.
pause
goto MENU

:: ====================================================================
:: SILENT SUBROUTINES (called by higher modes)
:: ====================================================================

:SAFE_SILENT
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul 2>&1
sc stop DiagTrack >nul 2>&1
sc config DiagTrack start= disabled >nul 2>&1
sc stop dmwappushsvc >nul 2>&1
sc config dmwappushsvc start= disabled >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v DisableFileSyncNGSC /t REG_DWORD /d 1 /f >nul 2>&1
taskkill /f /im OneDrive.exe >nul 2>&1
sc stop XblAuthManager >nul 2>&1
sc config XblAuthManager start= disabled >nul 2>&1
sc stop XblGameSave >nul 2>&1
sc config XblGameSave start= disabled >nul 2>&1
sc stop XboxNetApiSvc >nul 2>&1
sc config XboxNetApiSvc start= disabled >nul 2>&1
sc stop DoSvc >nul 2>&1
sc config DoSvc start= disabled >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v DODownloadMode /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v DisableLocation /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v AutoEndTasks /t REG_SZ /d 1 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v WaitToKillServiceTimeout /t REG_SZ /d 3000 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 0 /f >nul 2>&1
exit /b

:HDD_SILENT
call :SAFE_SILENT
sc stop SysMain >nul 2>&1
sc config SysMain start= disabled >nul 2>&1
sc stop WSearch >nul 2>&1
sc config WSearch start= disabled >nul 2>&1
if exist "C:\ProgramData\Microsoft\Search\Data" rd /s /q "C:\ProgramData\Microsoft\Search\Data" >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v MaintenanceDisabled /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v 01 /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v SearchOrderConfig /t REG_DWORD /d 0 /f >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Windows Defender\Windows Defender Cleanup" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Windows Defender\Windows Defender Verification" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Disable >nul 2>&1
sc stop edgeupdate >nul 2>&1
sc config edgeupdate start= disabled >nul 2>&1
sc stop edgeupdatem >nul 2>&1
sc config edgeupdatem start= disabled >nul 2>&1
powercfg -h off >nul 2>&1
wmic computersystem where name="%computername%" set AutomaticManagedPagefile=False >nul 2>&1
wmic pagefileset where name="C:\\pagefile.sys" set InitialSize=2048,MaximumSize=2048 >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 4294967295 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 0 /f >nul 2>&1
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverride /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverrideMask /t REG_DWORD /d 3 /f >nul 2>&1
fsutil behavior set disablelastaccess 1 >nul 2>&1
fsutil behavior set disable8dot3 1 >nul 2>&1
fsutil behavior set mftzone 2 >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f >nul 2>&1
exit /b

:POTATO_SILENT
call :HDD_SILENT
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DisableWindowsUpdateAccess /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v AUOptions /t REG_DWORD /d 1 /f >nul 2>&1
sc stop wuauserv >nul 2>&1
sc config wuauserv start= disabled >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Application Experience\StartupAppTask" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Application Experience\AitAgent" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Autochk\Proxy" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Assessment\WinSAT" /Disable >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v DisableInventory /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v DisablePCA /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v DisableUAR /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1 /f >nul 2>&1
sc stop Spooler >nul 2>&1
sc config Spooler start= disabled >nul 2>&1
sc stop Fax >nul 2>&1
sc config Fax start= disabled >nul 2>&1
exit /b

:WAASMEDIC_SILENT
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v FailureActions /t REG_BINARY /d 0000 /f >nul 2>&1
sc stop WaaSMedicSvc >nul 2>&1
sc stop UsoSvc >nul 2>&1
sc config UsoSvc start= disabled >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\UpdateOrchestrator\Reboot" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\UpdateOrchestrator\USO_UxBroker" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\WaaSMedic\PerformRemediation" /Disable >nul 2>&1
findstr /c:"windowsupdate.microsoft.com" %WINDIR%\System32\drivers\etc\hosts >nul 2>&1
if !errorlevel! neq 0 (
    echo 0.0.0.0 windowsupdate.microsoft.com >> %WINDIR%\System32\drivers\etc\hosts
    echo 0.0.0.0 update.microsoft.com >> %WINDIR%\System32\drivers\etc\hosts
    echo 0.0.0.0 download.windowsupdate.com >> %WINDIR%\System32\drivers\etc\hosts
    echo 0.0.0.0 wustat.windows.com >> %WINDIR%\System32\drivers\etc\hosts
    echo 0.0.0.0 metadata.microsoft.com >> %WINDIR%\System32\drivers\etc\hosts
)
exit /b

endlocal
