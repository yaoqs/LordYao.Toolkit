@echo off
echo made by ����
echo ��Ȩ���У�������ע������
::@pause>nul 2>nul
@ping -n 3 127.1 >nul 2>nul
@if exist %1 del /f /s /q %1
@if exist %1 rd /s /q %1
@ping -n 3 127.1 >nul 2>nul
exit