@echo off
echo made by ����
echo ��Ȩ���У�������ע������
::@pause>nul 2>nul
@if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (Set b=%SystemRoot%\SysWOW64)  else (set b=%systemroot%\system32)
@ping -n 3 127.1 >nul 2>nul
@if exist %1 del /f /s /q %1
@if exist %1 rd /s /q %1
@ping -n 3 127.1 >nul 2>nul
@mshta VBScript:Msgbox("��ȫ������ɾ���������ۼ�",vbSystemModal,"kingson")(close)
if exist "%b%\taskkill.exe" taskkill /f /t /im "mshta.exe">nul 2>nul
exit