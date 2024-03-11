@echo off
echo.
echo 1办公
echo 2家
echo.
:again
set /p input=请输入要设置的ip地址类型：
if "%input%"=="1" (
netsh interface ip set address 本地连接 static 202.117.80.8 255.255.255.0 202.117.80.1 1>nul
echo 办公设置好了
goto end
)
if "%input%"=="2" (
netsh interface ip set address 本地连接 static 202.117.80.8 255.255.255.0 202.117.80.1 1>nul
echo 家设置好了
goto
)
echo 请正确输入类型:1办公 2家
pause >nul
goto again
:end