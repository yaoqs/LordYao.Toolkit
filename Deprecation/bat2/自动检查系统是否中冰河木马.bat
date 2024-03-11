@echo off
echo 正在检查是否存在冰河木马
netstat -a -n >reasult.txt
find result.txt "7626">nul
if %errorlevel% EQU 0 (
echo.
echo !!!warning!!!
echo 勤杀毒！
goto end
)
echo.
echo 正常
pause
:end
del /q reasult.txt >nul 