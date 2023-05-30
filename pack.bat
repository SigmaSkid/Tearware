@echo off
REM thank you gpt-sama

IF EXIST release (
    RD /S /Q release
    echo Deleting release directory.
)

echo Recreating release directory.
mkdir release

echo Copying base files.
copy main.lua release\main.lua
copy LICENSE release\LICENSE
copy id.txt release\id.txt
copy info.txt release\info.txt
copy preview.jpg release\preview.jpg

echo Creating source directory.
mkdir release\source

echo Copying project files.
xcopy /E /Y "source" "release\source\"

echo Removing comments, unnecessary spaces, and newlines from .lua files.
for /R "release\source" %%f in (*.lua) do (
    echo %%f
    powershell -Command "(Get-Content '%%f') | ForEach-Object { $_.TrimStart() } | Set-Content -Path '%%f'" 
    powershell -Command "Get-Content '%%f' | Select-String '^\s*--' | ForEach-Object { $_.Line }" 
    powershell -Command "(Get-Content '%%f') | ForEach-Object { $_ -replace '^\s*--.*$', '' } | Set-Content -Path '%%f'" 
    powershell -Command "(Get-Content '%%f') | Where-Object { $_ -ne '' } | Set-Content -Path '%%f'" 
    echo.
)
echo Updating local.lua

REM Location of local.lua file
set file=release\source\utils\local.lua

REM Get the current date
set date=%date%

REM Check if file exists
IF EXIST %file% (
    REM Replace the line
    powershell -Command "(Get-Content %file%) | ForEach-Object { $_ -replace 'fProjectName = "Tearware Github Preview"', 'fProjectName = "Tearware"' } | Set-Content -Path %file%"
    echo Line replaced successfully in %file%
) ELSE (
    echo Error: %file% not found
)

echo Adding 'Packaged on %date%' to main.lua
set file=release\main.lua
IF EXIST %file% (
    echo. >> %file%
    echo -- Packaged on %date% >> %file%
    echo Line added successfully in %file%
) ELSE (
    echo Error: %file% not found
)

echo Finished.