@echo off
setlocal
set "PROJECT=D:\xm\duihuamoxing"
set "ENTRY="
for /f "usebackq delims=" %%E in (`powershell -NoProfile -ExecutionPolicy Bypass -File "D:\xm\yumingbushu\find_entry.ps1" -Project "%PROJECT%" -Mode start`) do set "ENTRY=%%E"
echo ENTRY=[%ENTRY%]