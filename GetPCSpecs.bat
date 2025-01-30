@echo off
chcp 65001 >nul 2>&1  :: Set UTF-8 encoding

:: Set output file path
set "OutputFile=%USERPROFILE%\Desktop\PC_Specs.txt"

:: Clear previous file
echo. > "%OutputFile%"

:: Write system specs
echo ====== PC Specifications ====== >> "%OutputFile%"
echo. >> "%OutputFile%"

:: Serial Number
echo Serial Number: >> "%OutputFile%"
wmic bios get serialnumber | findstr /v "SerialNumber" >> "%OutputFile%"
echo. >> "%OutputFile%"

:: Device Name
echo Device Name: %COMPUTERNAME% >> "%OutputFile%"
echo. >> "%OutputFile%"

:: Processor
echo Processor: >> "%OutputFile%"
wmic cpu get name | findstr /v "Name" >> "%OutputFile%"
echo. >> "%OutputFile%"

:: Installed RAM
echo Installed RAM (GB): >> "%OutputFile%"
wmic computersystem get totalphysicalmemory | findstr /v "TotalPhysicalMemory" | powershell -NoProfile -Command "& { [math]::Round($(Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB, 2) }" >> "%OutputFile%"
echo. >> "%OutputFile%"

:: Operating System
echo Operating System: >> "%OutputFile%"
wmic os get caption, version | findstr /v "Caption Version" >> "%OutputFile%"
echo. >> "%OutputFile%"

:: System Manufacturer & Model
echo Manufacturer : >> "%OutputFile%"
wmic computersystem get manufacturer | findstr /v "Manufacturer Model" >> "%OutputFile%"
echo. >> "%OutputFile%"

:: Disk Space
echo Disk Space Information: >> "%OutputFile%"
wmic logicaldisk get deviceid, volumename, size, freespace | findstr /v "DeviceID" >> "%OutputFile%"
echo. >> "%OutputFile%"

:: Installed Graphics Card
echo Graphics Card: >> "%OutputFile%"
wmic path win32_videocontroller get caption | findstr /v "Caption" >> "%OutputFile%"
echo. >> "%OutputFile%"

:: Network Adapters
echo Network Adapters (Enabled): >> "%OutputFile%"
wmic nic where "NetEnabled=True" get Name, MACAddress | findstr /v "Name MACAddress" >> "%OutputFile%"
echo. >> "%OutputFile%"

:: Notify user
echo PC specifications have been saved to %OutputFile%
pause
