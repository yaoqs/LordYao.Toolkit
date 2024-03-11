@echo off
echo 请输入要修改文件夹属性的盘符（带冒号）：
set /p drivename=
if exist %drivename%\ (
    for /f "delims=" %%i in ('dir %drivename%\ /ad/b') do attrib -s -h -r "%drivename%\%%i" /s /d
    echo.
    echo %drivename%\处理完毕
    echo.
) else (
    echo 无此路径
)
pause