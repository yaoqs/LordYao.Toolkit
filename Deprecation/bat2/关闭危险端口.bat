@echo off
echo 正在关闭win的internet服务
iisreset /stop 2>&0 >err
echo http 端口80、ftp端口21、stmp端口25已经被成功关闭
echo 政治关闭telnet服务
net stop telnet 2>&0 >err
echo telnet 端口23关闭
pause

del /q /f err >nul 