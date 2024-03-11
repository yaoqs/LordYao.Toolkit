@echo off
echo Windows Registry Editor Version 5.00 >temp.reg
echo 正在启用ie浏览器的下载功能
pause
echo [HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\zones\3]>>temp.reg
echo "1803"=dword:00000000 >>temp.reg
echo 设置ie浏览器的默认下载保存目录为d:\iedownload
echo [HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer]>>temp.reg
echo "Download Directory"="d:\iedownload" >>temp.reg
echo 开启ie浏览器的多线程下载功能，并设置最大下载线程数为10
echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings] >>temp.reg
echo "MaxConnectionsPerServer"="10" >>temp.reg
echo 禁止ie下载文件完成后弹出通知对话框
echo [HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Main]>>temp.reg
echo "NotifyDownloadComplete"="yes" >>temp.reg
echo.
pause
regedit /s temp.reg
del /q /f temp.reg >nul 