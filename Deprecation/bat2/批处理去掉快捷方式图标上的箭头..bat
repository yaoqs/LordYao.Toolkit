for /f "tokens=2 delims=\" %%i in ('reg query "hku" ^| findstr  /r "S-1-5-[0-9]*-[0-9-]*$"') do ( reg add "HKU\%%i\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v "ListviewShadow" /t REG_DWORD /d 1 )
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewShadow /t reg_dword /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v ForceActiveDesktopOn /t reg_dword /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /f /v "ShellState" /t REG_BINARY /d 2400000028280000000000000000000000000000010000000d0000000000000002020000
reg delete "HKLM\Software\CLASSES\lnkfile" /f /v "IsShortcut"
reg delete "HKLM\Software\CLASSES\piffile" /f /v "IsShortcut"
reg delete "HKCR\lnkfile" /f /v "IsShortcut"
reg delete "HKCR\piffile" /f /v "IsShortcut"
reg delete "HKCR\Lnkfile" /f /v "IsShortcut"
taskkill /f /im explorer.exe
start explorer.exe