@echo off
setlocal

cd /d "%~dp0"

echo ====================================
echo      CodeClash 27 Setup / Launcher
echo ====================================
echo.

echo Enter password:
for /f "usebackq delims=" %%p in (`powershell -Command "$pword = read-host -AsSecureString ; $BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pword); [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)"`) do set "pwd=%%p"

if "%pwd%"=="201320122011" (
    echo.
    echo Password correct. Starting client...
    echo.

    set "JAVA_HOME=%LOCALAPPDATA%\CodeClash27\jdk"
    set "PATH=%JAVA_HOME%\bin;%PATH%"

    if not exist "%JAVA_HOME%\bin\java.exe" (
        echo.
        echo Error: Bundled Java 25 was not found.
        echo Expected:
        echo %JAVA_HOME%\bin\java.exe
        echo.
        pause
        exit /b 1
    )

    echo Using Java:
    echo %JAVA_HOME%
    echo.

    call "%~dp0gradlew.bat" runClient

    if errorlevel 1 (
        echo.
        echo Error: Gradle execution failed.
        echo.
        pause
        exit /b 1
    )

) else (
    echo.
    echo Incorrect password. Exiting...
)

pause
