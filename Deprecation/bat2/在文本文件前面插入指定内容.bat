@echo off
if "%1"=="" (
echo 命令语法：%0 filename
echo   filename 表示要插入的内容的文件
echo.
goto end
)
if not exist %1 (
echo.
echo 指定要插入内容的文件%1不存在，请仔细检查
goto end
)
echo 正在进行插入操作
echo.
cd.>content.temp
echo %date%>>content.temp
echo %time%>>content.temp
copy content.temp+%1 temp >nul
del /f /q %1 >nul
del /f /q content.temp >nul
ren temp %1
echo 成功在%1文件前插入当前日期及时间
：end