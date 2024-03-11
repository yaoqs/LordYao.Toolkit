@echo off
echo Windows Registry Editor Version 5.00 >temp.reg
echo 正在调整系统整体参数，以便系统性能得到综合性的提高
pause
echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Messager\Memory management] >>temp.reg
echo "DisablePagingExecutive"=dword:00000001 >>temp.reg
echo "LargeSystemCache"=dword:00000001 >>temp.reg
echo "SecondLevelDataCache"=dword:00000400 >>temp.reg
echo "IoPageLockLimit"=dword:00010000 >>temp.reg
echo 成功调整相关系统参数
echo.
pause
regedit /s temp.reg
del /q /f temp.reg >nul 