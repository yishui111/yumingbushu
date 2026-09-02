@echo off
rem Start ZhiYin Login Gateway (http://127.0.0.1:8091) in front of Open WebUI.
rem Requires duihuamoxing placed next to this repo (its venv python is reused).
setlocal
set "PYEXE=%~dp0..\duihuamoxing\venv\Scripts\python.exe"
if not exist "%PYEXE%" (
    echo [ERROR] Python not found: %PYEXE%
    echo Put the duihuamoxing folder in the same parent directory as this repo.
    exit /b 1
)
if not exist "%~dp0login_gateway\config.json" (
    echo [ERROR] login_gateway\config.json not found.
    echo Copy login_gateway\config.json.example to login_gateway\config.json and set a strong password.
    exit /b 1
)
echo Starting ZhiYin Login Gateway...
start "ZhiYin-LoginGateway" "%PYEXE%" -m uvicorn main:app --host 127.0.0.1 --port 8091 --app-dir "%~dp0login_gateway"
timeout /t 3 /nobreak >nul
start "" "http://127.0.0.1:8091"
exit /b 0
