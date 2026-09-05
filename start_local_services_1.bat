@echo off
rem Start local duihuamoxing services (Open WebUI 8088, Ollama 11434, TTS 8061, Avatar 48620).
rem Requires the duihuamoxing project folder placed next to this repo (same parent).
rem Entry probing runs inside PowerShell because cmd cannot safely parse the
rem non-ASCII path (Chinese entry name) captured via for /f.
setlocal
set "PROJECT=%~dp0..\duihuamoxing"
if not exist "%PROJECT%\" (
    echo [ERROR] duihuamoxing not found next to this repo: %PROJECT%
    echo Put the duihuamoxing folder in the same parent directory as this repo.
    exit /b 1
)

powershell -NoProfile -ExecutionPolicy Bypass -Command "$e = & '%~dp0find_entry.ps1' -Project '%PROJECT%' -Mode start; if ($e) { Write-Host ('Found entry: ' + $e); Start-Process -FilePath $e -NoNewWindow -Wait } else { Write-Host '[WARN] no entry script found - starting base services only (Open WebUI + Ollama)...'; cmd /c call '%~dp0silent_start_local.bat' }"

echo.
echo Local services started. Open WebUI: http://localhost:8088
start "" "http://localhost:8088"
exit /b 0
