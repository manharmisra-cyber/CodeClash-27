@echo off
cd /d "%~dp0"

echo Enter password:
for /f "usebackq delims=" %%p in (`powershell -Command "$pword = read-host -AsSecureString ; $BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pword); [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)"`) do set "pwd=%%p"

if "%pwd%"=="201320122011" (
    echo.
    echo Password correct. Starting client...
    call gradlew.bat runClient
) else (
    echo.
    echo Incorrect password. Exiting...
)

pause