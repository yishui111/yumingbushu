@echo off
rem Stop local duihuamoxing services (Open WebUI / Ollama / TTS / Avatar).
rem Requires the duihuamoxing project folder placed next to this repo.
rem Candidate stop names (incl. Chinese ones) are probed via find_entry.ps1.
setlocal
set "PROJECT=%~dp0..\duihuamoxing"
if not exist "%PROJECT%\" (
    echo [ERROR] duihuamoxing not found next to this repo: %PROJECT%
    exit /b 1
)

set "ENTRY="
for /f "usebackq delims=" %%E in (`powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0find_entry.ps1" -Project "%PROJECT%" -Mode stop`) do set "ENTRY=%%E"

if not defined ENTRY (
    echo [ERROR] No known stop script found under: %PROJECT%
    echo Nothing was stopped - please stop the services manually.
    exit /b 1
)

echo Stopping duihuamoxing local services via: %ENTRY%
call "%ENTRY%" < nul
echo.
echo Local services stopped.
exit /b 0
