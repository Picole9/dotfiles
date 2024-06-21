@echo off
winget list --id curl.curl >nul 2>&1
if %errorlevel% neq 0 (
    echo Paket curl.curl ist nicht installiert. Installiere es jetzt...
    winget install --id curl.curl --accept-package-agreements --accept-source-agreements
)
echo setze curl-path...
for /f "delims=" %%A in ('where curl') do set "LAST_CURL=%%A"
set "LAST_CURL_DIR=%LAST_CURL%"
set PATH=%LAST_CURL_DIR%;%PATH%
echo %LAST_CURL_DIR%
