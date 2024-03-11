@echo off
echo Windows Registry Editor Version 5.00 >temp.reg
echo 正在定制。。。
echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment] >>temp.reg
echo "PROMPT"="11:" >>temp.reg
echo [HKEY_CURRENT_USER\Console] >>temp.reg
echo "FullScreen"=dword:00000000 >>temp.reg
echo "FastName"="楷体" >>temp.reg
echo "HistoryBufferSize"=dword:00000038 >>temp.reg
echo "InsertMode"=dword:00000001 >>temp.reg
echo "NumberOfHistoryBuffers"=dword:00000006 >>temp.reg
echo "QuickEdit"=dword:00000001 >>temp.reg
echo "PopupColors"=dword:FFFFFF >>temp.reg
echo "CompletionChar"=dword:00000009 >>temp.reg
echo "WindowSize"=dword:00190050 >>temp.reg
echo 成功
echo.
pause
regedit /s temp.reg
del /q /f temp.reg >nul 