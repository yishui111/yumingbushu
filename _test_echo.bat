@echo on
rem Start local duihuamoxing services (Open WebUI 8088, Ollama 11434, TTS 8061, Avatar 48620).
rem Requires the duihuamoxing project folder placed next to this repo
rem (same parent directory). Candidate entry names (incl. Chinese ones) are
rem probed via find_entry.ps1.
setlocal
set "PROJECT=%~dp0..\duihuamoxing"
if not exist "%PROJECT%\" (
    echo [ERROR] duihuamoxing not found next to this repo: %PROJECT%
    echo Put the duihuamoxing folder in the same parent directory as this repo.
    exit /b 1
)

set "ENTRY="
for /f "usebackq delims=" %%E in (`powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0find_entry.ps1" -Project "%PROJECT%" -Mode start`) do set "ENTRY=%%E"

if not defined ENTRY (
    echo [WARN] No known start script found under: %PROJECT%
    echo Starting base services (Open WebUI + Ollama) via silent_start_local.bat...
    call "%~dp0silent_start_local.bat" < nul
    echo [HINT] Avatar (48620) and TTS (8061) were NOT started. Start them manually if needed.
) else (
    echo Found project entry: %ENTRY%
    call "%ENTRY%" < nul
)

echo.
echo Local services started. Open WebUI: http://localhost:8088
start "" "http://localhost:8088"
exit /b 0
