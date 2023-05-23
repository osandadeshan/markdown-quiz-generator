@echo off

:: Check if the script is running with admin privileges
net session >nul 2>&1
if errorlevel 1 (
    echo This script requires administrative privileges.
    echo Please run the script as an administrator.
    pause
    exit /b
)

:: Change the default path to the current folder
set "batchPath=%~dp0"
pushd %batchPath%
@REM pushd %USERPROFILE%\Downloads

:: ------------ Python ------------
python --version >nul 2>&1
if errorlevel 1 (
    echo:
    echo ":: :: Python : NOT installed :: ::"

    echo:
    echo ":Download latest Python installer:"
    echo Python is NOT installed.
    
    :: This script enables delayed variable expansion, allowing to use the !variable! syntax for variables that are set within the for loop. 
    :: This resolve the issue with the invalid URI and correctly download the Python installer to the local folder as python.exe.
    @echo off
    setlocal enabledelayedexpansion

    for /f "delims=" %%i in ('powershell -Command "Get-Content -Raw -Path 'get_python_url.ps1' | PowerShell.exe -NoProfile -"') do (
        set "pythonUrl=%%i"
        echo Python URL: %%i
    )

    :: Download the Python installer to the local folder
    powershell -Command "Invoke-WebRequest -Uri '!pythonUrl!' -OutFile '.\python.exe'"

    endlocal

    :: Install Python without user interaction and with privileged access
    echo ":Install Python:"
    powershell -Command "Start-Process -FilePath '.\python.exe' -ArgumentList '/quiet InstallAllUsers=1 PrependPath=1 Include_test=0' -NoNewWindow -Wait"
    :: Remove Python installer
    echo ":Remove Python installer:"
    del .\python.exe

) else (
    echo:
    echo ":: :: Python : Installed :: ::"
)

:: ------------ PIP ------------
python -m pip --version >nul 2>&1
if errorlevel 1 (
    echo:
    echo ":: :: PIP : NOT installed :: ::"

    echo:
    echo ":Download get-pip.py:"
    powershell -Command "Invoke-WebRequest -Uri 'https://bootstrap.pypa.io/get-pip.py' -OutFile '.\get-pip.py'"
    :: Install pip silently
    echo ":Install PIP:"
    powershell -Command "Start-Process -FilePath 'python' -ArgumentList '-m', 'ensurepip', '--default-pip' -NoNewWindow -Wait"
    :: Remove get-pip.py
    echo ":Remove PIP installer:"
    del .\get-pip.py

) else (
    echo:
    echo ":: :: PIP : installed :: ::"
)

:: ------------ Requirements ------------    
@echo off
setlocal enabledelayedexpansion

:: Your previous code for downloading and installing Python here

:: Use the 'where' command to find the Python executable and assign it to the pythonExe variable
where python > temp_python_path.txt
set /p pythonExe=<temp_python_path.txt
del temp_python_path.txt

echo Python executable path: !pythonExe!

:: Install the required packages
"%pythonExe%" -m pip install -r requirements.txt

:: Check if all packages from requirements.txt are installed 
"%pythonExe%" -m pip freeze > installed_packages.txt
fc /w requirements.txt installed_packages.txt > nul
if errorlevel 1 (
    echo Some PIP packages are missing.
) else (
    echo All PIP packages are installed.
)
del .\installed_packages.txt

endlocal

:: Add "Press enter to continue" prompt
echo:
echo "Done: "
echo "Press enter to continue."
pause > nul

:: Once done, exit the batch file
goto:eof