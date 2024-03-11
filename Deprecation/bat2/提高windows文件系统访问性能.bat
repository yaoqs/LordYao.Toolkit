@echo off
echo Windows Registry Editor Version 5.00 >temp.reg
echo 打开windows的应用程序预读功能
pause
echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\control\Session Manager\Memory Management\PrefetchParameters]>>temp.reg
echo "EnablePrefetcher"=dword:00000001 >>temp.reg
echo 启用windows磁盘自动优化功能
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Dfrg\BootOptimizeFunction]>>temp.reg
echo "Enable"="yes" >>temp.reg
echo 增加windows执行文件i/o操作的缓存容量
echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\session Manager\Memory Management] >>temp.reg
echo 增加文件系统缓存提高文件访问速度
echo.
pause
regedit /s temp.reg
del /q /f temp.reg >nul 