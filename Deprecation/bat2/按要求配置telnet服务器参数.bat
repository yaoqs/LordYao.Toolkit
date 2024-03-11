@echo off
echo 正在配置
echo.
tlntadmn config ctrlakeymap=yes >nul
tlntadmn config maxconn=10 >nul
tlntadmn config maxfail=3 >nul
tlntadmn config mode=stream >nul
tlntadmn config port=2100>nul
tlntadmn config sec=+ntlm +passwd >nul
tlntadmn config timeout=00:30:00 >nul
echo 成功