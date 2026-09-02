@echo off
rem Start ZhiYin Ops Dashboard (local web console, http://127.0.0.1:8090).
rem Requires duihuamoxing placed next to this repo (its venv python is reused).
setlocal
set "PYEXE=%~dp0..\duihuamoxing\venv\Scripts\python.exe"
if not exist "%PYEXE%" (
    echo [ERROR] Python not found: %PYEXE%
    echo Put the duihuamoxing folder in the same parent directory as this repo.
    exit /b 1
)
echo Starting ZhiYin Ops Dashboard...
start "ZhiYin-OpsDashboard" "%PYEXE%" -m uvicorn main:app --host 127.0.0.1 --port 8090 --app-dir "%~dp0ops_dashboard"
timeout /t 3 /nobreak >nul
start "" "http://127.0.0.1:8090"
exit /b 0
