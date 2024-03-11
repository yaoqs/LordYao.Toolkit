@echo off
echo Windows Registry Editor Version 5.00 >temp.reg
echo 在文件夹及驱动器右击菜单中添加菜单命令
pause
echo [+HKEY_LOCAL_MACHINE\SOFTWARE\CLASSES\Directory\shell\重启计算机]>>temp.reg
echo [+HKEY_LOCAL_MACHINE\SOFTWARE\CLASSES\Directory\shell\重启计算机\command]>>temp.reg
echo [HKEY_LOCAL_MACHINE\SOFTWARE\CLASSES\Directory\shell\重启计算机\command]>>temp.reg
echo @="C:\WINDOWS\RUNDLL.EXE USER.EXE,EXIT WINDOWS EXEC" >>temp.reg
echo 在任意类型文件的右击菜单中添加菜单命令
echo [+HKEY_CLASSES_ROOT\*\SHELL] >>temp.reg
echo [+HKEY_CLASSES_ROOT\*\SHELL\记事本] >>temp.reg
echo [+HKEY_CLASSES_ROOT\*\SHELL\记事本\command] >>temp.reg
echo [HKEY_CLASSES_ROOT\*\SHELL\记事本\command] >>temp.reg
echo @="notepad %1" >>temp.reg
echo.
pause
regedit /s temp.reg
del /q /f temp.reg >nul 