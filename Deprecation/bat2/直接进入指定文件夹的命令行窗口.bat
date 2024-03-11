@echo off
echo Windows Registry Editor Version 5.00>temp.reg
echo 正在添加命令到文件夹快捷菜单
echo [HEKEY_CLASSES_ROOT\Directory\shell\cmd] >>temp.reg
echo @="在&cmd窗口打开文件夹" >>temp.reg
echo [HEKEY_CLASSES_ROOT\Directory\shell\cmd\command]>>temp.reg
echo @="cmd /k cd "%~dp1">>temp.reg
echo 成功添加命令行窗口打开文件夹命令
echo.
regedit /s temp.reg
del /q /f temp.reg >nul 