@Echo off
Setlocal enabledelayedexpansion
Color 3F

:Parameters
for /f "usebackq tokens=1,2,*" %%1 in (`"reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" 2>nul"^|findstr /i ProductName`) do (
    set version=%%3 
    set version_mark=xp&&set version_skip=4
    echo !version!|findstr "XP"|| (set version_mark=win7&&set version_skip=2)
)


:Welcome
Mode con cols=70 lines=25
Title 系统辅助工具
cls
echo.
echo   ★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★
echo   ☆                                                              ☆
echo   ★               系 统 辅 助 工 具                              ★
echo   ☆                                                              ☆
echo   ★                                            正 式 版   V3.03  ★
echo   ☆                                                              ☆
echo   ★                               Author ：     九影蓝翼         ★
echo   ☆                                E-Mail：  bluewing009@tom.com ☆
echo   ★                                    QQ：     961881006        ★
echo   ☆                                                              ☆
echo   ★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★
echo.&&echo.
echo       说明：
echo.
echo            用于在紧急情况或者安全软件无法启动时，对系统进行修复
echo.&&echo.
echo                      %version% 
echo.
echo                 %date:~0,4%年%date:~5,2%月%date:~8,2%日  星期%date:~-1,1%    %time:~0,2%时%time:~3,2%分
echo.
echo.
ping /n 5 127.1>nul



:Permission_Test
Mode con cols=50 lines=10
Title 权限确认
cls
echo.&&echo.&&echo.
echo                正在测试所需的权限
echo.
echo                   ...请稍后...
echo.>%SystemRoot%\System32\权限测试.dat
if not exist %SystemRoot%\System32\权限测试.dat (
    cls
    echo.&&echo.
    echo                     权限异常
    echo.
    echo                请以管理员权限运行
    echo.&&echo.
    echo                    任意键退出
    pause>nul
    exit
)
del /f/s/q %SystemRoot%\System32\权限测试.dat >nul 2>nul



:Safe_Environment
Mode con cols=50 lines=10
Title 构建安全环境
cls
echo     即将自动关闭除系统外的所有进程避免病毒驻留
echo.
echo   桌面管理暂时不可用，主菜单选择“退出”后自动恢复
echo.
echo                请保存未完成的工作
echo.
echo                Y 开始  其他键跳过
echo.
set choose=~
set /p choose=请选择：
if /I %choose%==Y goto Build_Safe
goto Build_Safe_Jump

:Build_Safe
set /a NO._All=NO._Succeed=NO.=0
cls
echo.
echo                     正在构建
echo.
echo                       稍后
taskkill /f /im explorer.exe>nul 2>nul
for /f "skip=5 tokens=1" %%p in ('tasklist^|findstr /v /i "wininit.exe cmd.exe svchost.exe lsass.exe services.exe winlogon.exe csrss.exe smss.exe lsm.exe conhost.exe WmiPrvSE.exe"') do (
    taskkill /f /im %%p >nul 2>nul||(
        start /min ntsd -c q -pn %%p >nul 2>nul
        ping /n 1 127.1>nul
        tasklist /fi "IMAGENAME eq ntsd.exe"|findstr /i "没有运行"  && set /a NO._Succeed+=1
        taskkill /f /im ntsd.exe >nul 2>nul
    )
)
if %version_mark%==win7 taskkill /f /t /im cmd.exe /FI "WINDOWTITLE ne 管理员:  构建安全环境" >nul 2>nul
if %version_mark%==xp taskkill /f /t /im cmd.exe /FI "WINDOWTITLE ne 构建安全环境" >nul 2>nul
set /a NO.=%NO._All%-%NO._Succeed%
echo.&&echo.
echo                     构建完成
if not %NO.%==0 (
    echo.&&echo.
    echo            残留 %NO.% 进程无法关闭
)
ping /n 3 127.1>nul
goto Preparation_Log

:Build_Safe_Jump
cls
echo.&&echo.&&echo.&&echo.
echo                       放弃
ping /n 2 127.1>nul
goto Preparation_Log



:Preparation_Log
if exist %windir%\System_Repair.log copy /y %windir%\System_Repair.log %windir%\System_Repair_Last.log>nul 2>nul
echo.>%windir%\System_Repair.log
echo %date% >>%windir%\System_Repair.log
echo.>>%windir%\System_Repair.log
echo 批处理系统辅助工具操作记录>>%windir%\System_Repair.log
echo.>>%windir%\System_Repair.log
echo.>>%windir%\System_Repair.log
goto Main



:Main
Mode con cols=70 lines=25
Title 系统辅助工具
cls
echo.
echo                         功 能 列 表
echo.
echo  ┏ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ┓
echo                             ┇┇
echo                             ┇┇
echo       A. 系统扫描           ┇┇     B. 系统修复
echo                             ┇┇
echo                             ┇┇
echo       C. 系统辅助           ┇┇     D. 系统信息
echo                             ┇┇
echo                             ┇┇
echo       E. 检查更新           ┇┇     Q.   退出
echo                             ┇┇
echo                             ┇┇
echo  ┗ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ┛
echo.&&echo.&&echo.
set choose=~
set /p choose=请选择：
if /I %choose%==a goto System_Scan
if /I %choose%==b goto System_Repair
if /I %choose%==c goto System_Assistant
if /I %choose%==d goto System_Information
if /I %choose%==e goto Check_Updates
if /I %choose%==q goto Exit
if /I %choose%==~ (
    echo.
    echo                         无效的选项，请重新输入
    ping /n 2 127.1>nul
    goto Main
)
echo.
echo                         无效的选项，请重新输入
ping /n 2 127.1>nul
goto Main



:System_Scan
Mode con cols=70 lines=25
Title  系统扫描
cls
echo.
echo                         功 能 列 表
echo.
echo  ┏ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ┓
echo                            ┇┇
echo                            ┇┇
echo    A. 注册表扫描           ┇┇     B. 启动项扫描
echo                            ┇┇
echo                            ┇┇
echo    C. 可疑端口扫描         ┇┇     D. IEFO劫持扫描
echo                            ┇┇
echo                            ┇┇
echo    E. 系统关键位置快照     ┇┇
echo                            ┇┇
echo                            ┇┇
echo  ┗ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ┛
echo.&&echo.
echo                       Q.返回主菜单
echo.&&echo.
set choose=~
set /p choose=请选择：
if /I %choose%==a goto Registry_Scan
if /I %choose%==b goto Startup_Items_Scan
if /I %choose%==c goto Doubtful_Port_Scan
if /I %choose%==d goto IEFO_Hijack_Scan
if /I %choose%==e goto Key_Position_Photograph
if /I %choose%==q goto Main
if /I %choose%==~ (
    echo.
    echo                         无效的选项，请重新输入
    ping /n 2 127.1>nul
    goto System_Scan
)
echo.
echo                         无效的选项，请重新输入
ping /n 2 127.1>nul
goto System_Scan



:System_Repair
Mode con cols=70 lines=25
Title  系统修复
cls
echo.
echo                         功 能 列 表
echo.
echo  ┏ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ┓
echo                            ┇┇
echo                            ┇┇
echo    A. 文件夹伪装修复       ┇┇     B. 安全模式修复
echo                            ┇┇
echo                            ┇┇
echo  ┗ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ┛
echo.&&echo.
echo                       Q.返回主菜单
echo.&&echo.
set choose=~
set /p choose=请选择：
if /I %choose%==a goto Camouflage_Folder_Repair
if /I %choose%==b goto Safemode_Repair
if /I %choose%==q goto Main
if /I %choose%==~ (
    echo.
    echo                         无效的选项，请重新输入
    ping /n 2 127.1>nul
    goto System_Repair
)
echo.
echo                         无效的选项，请重新输入
ping /n 2 127.1>nul
goto System_Repair



:System_Assistant
Mode con cols=70 lines=25
Title  系统辅助
cls
echo.
echo                         功 能 列 表
echo.
echo  ┏ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ┓
echo                            ┇┇
echo                            ┇┇
echo    A. 强制删除工具         ┇┇     B. 系统登录通知
echo                            ┇┇
echo                            ┇┇
echo    C. 主引导记录备份/恢复  ┇┇     D. 病毒免疫
echo                            ┇┇
echo                            ┇┇
echo    E. 清理系统垃圾         ┇┇     
echo                            ┇┇
echo                            ┇┇
echo  ┗ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ┛
echo.&&echo.
echo                       Q.返回主菜单
echo.&&echo.
set choose=~
set /p choose=请选择：
if /I %choose%==a goto Force_Delete
if /I %choose%==b goto Login_Message_Send
if /I %choose%==c goto MBR_Backup_Recovery
if /I %choose%==d goto Virus_Immune
if /I %choose%==e goto System_Garbage_clean
if /I %choose%==q goto Main
if /I %choose%==~ (
    echo.
    echo                         无效的选项，请重新输入
    ping /n 2 127.1>nul
    goto System_Assistant
)
echo.
echo                         无效的选项，请重新输入
ping /n 2 127.1>nul
goto System_Assistant



:System_Information
Mode con cols=50 lines=10
Title 系统信息
cls
echo.&&echo.
echo                 正在检测系统信息
echo.
echo.
systeminfo>>%temp%\System_Information.txt
start "" %temp%\System_Information.txt
goto Main



:Registry_Scan
Title 注册表扫描
Mode con cols=70 lines=15
set /a NO.=NO._=NO._Abnormal=NO._Succeed=NO._Fail=0
cls
for %%x in (
    "ForceClassicControlPanel :         “控制面板”样式锁定                 "
    "HideClock :           系统通知区域时钟                   "
    "LockTaskbar :           任务栏的修改锁定                   "
    "NoActiveDesktop :             活动桌面项目                     "
    "NoActiveDesktopChanges :             活动桌面更改                     "
    "NoAddPrinter :             添加打印机                       "
    "NoDeletePrinter :             删除打印机                       "
    "NoAutoUpdate :           Windows自动更新                    "
    "NoBandCustomize :      “查看”中的“工具栏”命令              "
    "NoCDBurning :             CD刻录功能                       "
    "NoCloseDragDropBands :      “查看”中的“工具栏”选项              "
    "NoComputersNearMe :  “网上邻居”中的“我附近的计算机”选项      "
    "NoDesktop :             “桌面”状态                     "
    "NoExpandedNewMenu :     文件选项中的“新建”选项                 "
    "NoFileAssociate :          文件选项中文件类型                  "
    "NoFileMenu :         资源管理器中的文件菜单               "
    "NoHardwareTab :     “控制面板”中的“硬件”选项             "
    "NoInternetIcon :           桌面“IE”图标                     "
    "NoLowDiskSpaceChecks :           硬盘空间不足警告                   "
    "NoManageMyComputerVerb :      “我的电脑”右键“管理”选项            "
    "NoMovingBands :              “桌面”工具栏                  "
    "NoNetConnectDisconnect :           网络驱动器选项                     "
    "NoNetHood :        桌面的“网上邻居”图标                "
    "NoThumbnailCache :              缩略图缓存                      "
    "NoTrayContextMenu :              任务栏右键                      "
    "NoTrayItemsDisplay :             系统托盘图标                     "
    "NoViewContextMenu :              桌面右键                        "
    "Noviewondrive :            禁止访问盘符                      "
    "NoWebView :            Web页查看方式                     "
    "NoWelcomeScreen :          登录时“欢迎屏幕”                  "
    "NoWindowsUpdate :    “WindowsUpdate”的访问和链接             "
    "NoWinKeys :             WinKeys键                        "
    "NoPrinterTabs :              打印机属性项                    "
    "NoPropertiesMyComputer :      “我的电脑”右键“属性”选项            "
    "NoPropertiesMyDocuments :      “我的文档”右键“属性”选项            "
    "NoPropertiesRecycleBin :     “回收站”右键菜单的“属性”选项         "
    "NoSetTaskbar :            菜单设置修改锁定                  "
    "NoSharedDocuments :    “我的电脑”中的“共享文档”              "
    "NoRunasInstallPrompt :           以其他用户安装程序                 "
    "NoShellSearchButton :    “资源管理器”中的“搜索”按钮            "
    "NoRecentDocsNetHood :    “网上邻居”的“共享文件夹”选项          "
    "NoChangeStartMenu :       “开始”菜单中的修改锁定               "
    "NoClose :    “开始”菜单中的“关闭系统”选项          "
    "NoFavoritesMenu :    “开始”菜单中的“收藏夹”选项            "
    "NoFolderOptions :    “开始”菜单中的“文件夹”选项            "
    "NoFind :    “开始”菜单中的“查找”选项              "
    "NoLogOff :    “开始”菜单中的“注销”选项              "
    "NoNetworkConnections :    “开始”菜单中的“网络连接”选项          "
    "NoUserNameInStartMenu :     “开始”菜单中的“用户名”选项           "
    "NoRecentDocsMenu :     “开始”菜单中的“我最近的文档”选项     "
    "NoRun :    “开始”菜单中的“运行”选项              "
    "NoSetActiveDesktop :    “开始”菜单中“活动桌面”选项            "
    "NoSetFolders :    “开始”菜单中的“设置”选项              "
    "NoSMHelp :    “开始”菜单中的“帮助和支持”选项        "
    "NoSMMyDocs :    “开始”菜单中的“我的文档”选项          "
    "NoSMMyPictures :    “开始”菜单中的“我的图片”选项          "
    "NoStartMenuMFUProgramsList :    “开始”菜单中的“常用程序列表”选项      "
    "NoStartMenuMorePrograms :    “开始”菜单中的“所有程序”选项          "
    "NoStartMenuMyMusic :    “开始”菜单中的“我的音乐”选项          "
    "NoStartMenuSubFolders :    “开始”中的“用户文件夹”选项            "
    "Start_ShowControlPanel :    “开始”菜单中的“控制面板”选项          "
    "Start_ShowMyComputer :    “开始”菜单中的“我的电脑”选项          "
    "Start_ShowNetConn :    “开始”菜单中的“网上邻居”选项          "
    "StartMenuLogOff :    “开始”菜单中的“注销”选项              "

) do (
    for /f "tokens=1,* delims=:" %%e in ("%%x") do (
        set Value_temp=%%e
        set Registry_Scan_Value=!Value_temp:~1,-1!
        set Name_temp=%%f
        set Registry_Scan_Name=!Name_temp:~1,-1!
        set v%Registry_Scan_Value%=正常
        set dv%Registry_Scan_Value%=不需要
        set /a NO.+=1
        for /f "usebackq tokens=3" %%i in (`"reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" 2>nul"^|findstr /i !Registry_Scan_Value!`) do (
            if "%%i"=="0x1" (
                set v!Registry_Scan_Value!=异常
                set /a NO._Abnormal+=1
                reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v !Registry_Scan_Value! /f >nul 2>nul
                if !errorlevel!==1 (
                    set dv!Registry_Scan_Value!=  ×
                    set /a NO._Fail+=1
                )
                if !errorlevel!==0 (
                    set dv!Registry_Scan_Value!=  √
                    set /a NO._Succeed+=1
                )
                echo "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\!Registry_Scan_Value!" !errorlevel! >>%windir%\System_Repair.log
            )
        )
        for /f "usebackq tokens=3" %%i in (`"reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" 2>nul"^|findstr /i !Registry_Scan_Value!`) do (
            if "%%i"=="0x1" (
                set v!Registry_Scan_Value!=异常
                set /a NO._Abnormal+=1
                reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v !Registry_Scan_Value! /f >nul 2>nul
                if !errorlevel!==1 (
                    set dv!Registry_Scan_Value!=  ×
                    set /a NO._Fail+=1
                )
                if !errorlevel!==0 (
                    set dv!Registry_Scan_Value!=  √
                    set /a NO._Succeed+=1
                )
                echo "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explore\!Registry_Scan_Value!" !errorlevel! >>%windir%\System_Repair.log
            )
        )
    call :Registry_Scan_Monitor "!Registry_Scan_Name!" !v%Registry_Scan_Value%! !dv%Registry_Scan_Value%! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!         
    )
)

for %%x in (
    "NoDrives :             磁盘显示                         "
    "Noviewondrive :             磁盘浏览                         "

) do (
    for /f "tokens=1,* delims=:" %%e in ("%%x") do (
        set Value_temp=%%e
        set Registry_Scan_Value=!Value_temp:~1,-1!
        set Name_temp=%%f
        set Registry_Scan_Name=!Name_temp:~1,-1!
        set v%Registry_Scan_Value%=正常
        set dv%Registry_Scan_Value%=不需要
        set /a NO.+=1
        for /f "usebackq tokens=3" %%i in (`"reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" 2>nul"^|findstr /i !Registry_Scan_Value!`) do (
            set v!Registry_Scan_Value!=异常
            set /a NO._Abnormal+=1
            reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v !Registry_Scan_Value! /f >nul 2>nul
            if !errorlevel!==1 (
                set dv!Registry_Scan_Value!=  ×
                set /a NO._Fail+=1
            )
            if !errorlevel!==0 (
                set dv!Registry_Scan_Value!=  √
                set /a NO._Succeed+=1
            )
            echo "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\!Registry_Scan_Value!" !errorlevel! >>%windir%\System_Repair.log
        )
        for /f "usebackq tokens=3" %%i in (`"reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" 2>nul"^|findstr /i !Registry_Scan_Value!`) do (
            set v!Registry_Scan_Value!=异常
            set /a NO._Abnormal+=1
            reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v !Registry_Scan_Value! /f >nul 2>nul
            if !errorlevel!==1 (
                set dv!Registry_Scan_Value!=  ×
                set /a NO._Fail+=1
            )
            if !errorlevel!==0 (
                set dv!Registry_Scan_Value!=  √
                set /a NO._Succeed+=1
            )
            echo "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\%%e" !errorlevel! >>%windir%\System_Repair.log
        )
    call :Registry_Scan_Monitor "!Registry_Scan_Name!" !v%Registry_Scan_Value%! !dv%Registry_Scan_Value%! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!         
    )
)

for %%x in (
    "Disableregistrytools :                注册表                        "
    "DisableSR :                系统还原                      "
    "DisableTaskmgr :              任务管理器                      "
    "NoConfigPage :            系统属性“硬件配置”              "
    "Nocontrolpanel :   “控制面板”中的“添加/删除”项目          "
    "NoDevMgrPage :           系统属性“设备管理”               "
    "NoDispAppearancePage :         对话框中“外观”选项                 "
    "NoDispBackgroundPage :         对话框中“背景”选项                 "
    "NoDispScrSavPage :       对话框中“屏幕保护”选项               "
    "NoDispSettingsPage :         对话框中“设置”选项                 "
    "NoFileSysPage :          系统属性“文件系统”                "
    "NoVirtMemPage :          系统属性“虚拟内存”                "
) do (
    for /f "tokens=1,* delims=:" %%e in ("%%x") do (
        set Value_temp=%%e
        set Registry_Scan_Value=!Value_temp:~1,-1!
        set Name_temp=%%f
        set Registry_Scan_Name=!Name_temp:~1,-1!
        set v%Registry_Scan_Value%=正常
        set dv%Registry_Scan_Value%=不需要
        set /a NO.+=1
        for /f "usebackq tokens=3" %%i in (`"reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System" 2>nul"^|findstr /i !Registry_Scan_Value!`) do (
            if "%%i"=="0x1" (
                set v%%s=异常
                set /a NO._Abnormal+=1
                reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v !Registry_Scan_Value! /f >nul 2>nul
                if !errorlevel!==1 (
                    set dv!Registry_Scan_Value!=  ×
                    set /a NO._Fail+=1
                )
                if !errorlevel!==0 (
                    set dv!Registry_Scan_Value!=  √
                    set /a NO._Succeed+=1
                )
                echo "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System\!Registry_Scan_Value!" !errorlevel! >>%windir%\System_Repair.log
            )
        )
            for /f "usebackq tokens=3" %%i in (`"reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System" 2>nul"^|findstr /i !Registry_Scan_Value!`) do (
            if "%%i"=="0x1" (
                set v!Registry_Scan_Value!=异常
                set /a NO._Abnormal+=1
                reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v !Registry_Scan_Value! /f >nul 2>nul
                if !errorlevel!==1 (
                    set dv!Registry_Scan_Value!=  ×
                    set /a NO._Fail+=1
                )
                if !errorlevel!==0 (
                    set dv!Registry_Scan_Value!=  √
                    set /a NO._Succeed+=1
                )
                echo "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\!Registry_Scan_Value!" !errorlevel! >>%windir%\System_Repair.log
            )
        )
    call :Registry_Scan_Monitor "!Registry_Scan_Name!" !v%Registry_Scan_Value%! !dv%Registry_Scan_Value%! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!
    )
)


for %%x in (
    "accessibility :           IE“辅助功能”按钮                 "
    "advanced :          Internet高级页面的设置              "
    "advancedTab :   “Internet选项”中的“高级”项             "
    "Autoconfig :        局域网设置中的自动配置设置            "
    "cache :             IE临时文件                       "
    "CalendarContact :         日历和联系人设置                     "
    "Certificates :               IE证书设置                     "
    "Check_If_Default :             默认浏览器检查                   "
    "colour :           IE“颜色”按钮                     "
    "ConnectionsTab :   “Internet选项”中的“连接”项             "
    "ContentTab :   “Internet选项”中的“内容”项             "
    "fonts :           IE“字体”按钮                     "
    "FormSuggest :             表单的自动完成                   "
    "GeneralTab :   “Internet选项”中的“常规”项             "
    "history :       IE“清除历史纪录”按钮                 "
    "HomePage :             IE首页锁定                       "
    "languages :           IE“语言”按钮                     "
    "Messaging :    电子邮件、新闻组和Internet呼叫设置        "
    "PrivacyTab :   “Internet选项”中的“隐私”项             "
    "Profiles :         IE配置文件助理设置                   "
    "ProgramsTab :   “Internet选项”中的“程序”项             "
    "Proxy :     局域网设置中的代理服务器设置             "
    "Ratings :              IE分级设置                      "
    "ResetWebSettings :              重置Web设置                     "
    "SecurityTab :   “Internet选项”中的“安全”项             "
    "settings :           IE“设置”按钮                     "
) do (
    for /f "tokens=1,* delims=:" %%e in ("%%x") do (
        set Value_temp=%%e
        set Registry_Scan_Value=!Value_temp:~1,-1!
        set Name_temp=%%f
        set Registry_Scan_Name=!Name_temp:~1,-1!
        set v%Registry_Scan_Value%=正常
        set dv%Registry_Scan_Value%=不需要
        set /a NO.+=1
        for /f "usebackq tokens=3" %%i in (`"reg query "HKEY_CURRENT_USER\Software\Policies\Microsoft\Internet Explorer\Control Panel" 2>nul"^|findstr /i !Registry_Scan_Value!`) do (
            if "%%i"=="0x1" (
                set v!Registry_Scan_Value!=异常
                set /a NO._Abnormal+=1
                reg delete "HKEY_CURRENT_USER\Software\Policies\Microsoft\Internet Explorer\Control Panel" /v !Registry_Scan_Value! /f >nul 2>nul
                if !errorlevel!==1 (
                    set dv!Registry_Scan_Value!=  ×
                    set /a NO._Fail+=1
                )
                if !errorlevel!==0 (
                    set dv!Registry_Scan_Value!=  √
                    set /a NO._Succeed+=1
                )
                echo "HKEY_CURRENT_USER\Software\Policies\Microsoft\Internet Explorer\Control Panel\!Registry_Scan_Value!" !errorlevel! >>%windir%\System_Repair.log
            )
        )
            for /f "usebackq tokens=3" %%i in (`"reg query "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Internet Explorer\Control Panel" 2>nul"^|findstr /i !Registry_Scan_Value!`) do (
            if "%%i"=="0x1" (
                set v!Registry_Scan_Value!=异常
                set /a NO._Abnormal+=1
                reg delete "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Internet Explorer\Control Panel" /v !Registry_Scan_Value! /f >nul 2>nul
                if !errorlevel!==1 (
                    set dv!Registry_Scan_Value!=  ×
                    set /a NO._Fail+=1
                )
                if !errorlevel!==0 (
                    set dv!Registry_Scan_Value!=  √
                    set /a NO._Succeed+=1
                )
                echo "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Internet Explorer\Control Panel\!Registry_Scan_Value!" !errorlevel! >>%windir%\System_Repair.log
            )
        )                                 
    call :Registry_Scan_Monitor "!Registry_Scan_Name!" !v%Registry_Scan_Value%! !dv%Registry_Scan_Value%! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!
    )
)

for %%x in (
    "NoBrowserClose :     IE“文件”中的“关闭”命令               "
    "NoBrowserOptions :  IE“工具”中的“Internet选项”命令          "
    "NoFileNew :   IE“查看”中的“源文件”命令               "
    "NoFileNew :  IE“文件”中的“打开新窗口”命令            "
    "NoFileOpen :     IE“文件”中的“打开”命令               "
    "NoTheaterMode :   IE“查看”中的“全屏显示”命令             "

) do (
    for /f "tokens=1,* delims=:" %%e in ("%%x") do (
        set Value_temp=%%e
        set Registry_Scan_Value=!Value_temp:~1,-1!
        set Name_temp=%%f
        set Registry_Scan_Name=!Name_temp:~1,-1!
        set v%Registry_Scan_Value%=正常
        set dv%Registry_Scan_Value%=不需要
        set /a NO.+=1
        for /f "usebackq tokens=3" %%i in (`"reg query "HKEY_CURRENT_USER\Software\Policies\Microsoft\Internet Explorer\Restrictions" 2>nul"^|findstr /i !Registry_Scan_Value!`) do (
            if "%%i"=="0x1" (
                set v!Registry_Scan_Value!=异常
                set /a NO._Abnormal+=1
                reg delete "HKEY_CURRENT_USER\Software\Policies\Microsoft\Internet Explorer\Restrictions" /v !Registry_Scan_Value! /f >nul 2>nul
                if !errorlevel!==1 (
                    set dv!Registry_Scan_Value!=  ×
                    set /a NO._Fail+=1
                )
                if !errorlevel!==0 (
                    set dv!Registry_Scan_Value!=  √
                    set /a NO._Succeed+=1
                )
                echo "HKEY_CURRENT_USER\Software\Policies\Microsoft\Internet Explorer\Restrictions\!Registry_Scan_Value!" !errorlevel! >>%windir%\System_Repair.log
            )
        )
            for /f "usebackq tokens=3" %%i in (`"reg query "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Internet Explorer\Restrictions" 2>nul"^|findstr /i !Registry_Scan_Value!`) do (
            if "%%i"=="0x1" (
                set v!Registry_Scan_Value!=异常
                set /a NO._Abnormal+=1
                reg delete "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Internet Explorer\Restrictions" /v !Registry_Scan_Value! /f >nul 2>nul
                if !errorlevel!==1 (
                    set dv!Registry_Scan_Value!=  ×
                    set /a NO._Fail+=1
                )
                if !errorlevel!==0 (
                    set dv!Registry_Scan_Value!=  √
                    set /a NO._Succeed+=1
                )
                echo "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Internet Explorer\Restrictions\!Registry_Scan_Value!" !errorlevel! >>%windir%\System_Repair.log
            )
        )
    call :Registry_Scan_Monitor "!Registry_Scan_Name!" !v%Registry_Scan_Value%! !dv%Registry_Scan_Value%! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!
    )
)

set dvexe=不需要
set dvbat=不需要
set dvtxt=不需要
set dvini=不需要
set dvvbs=不需要
set dvcom=不需要

for /f "tokens=3" %%i in ('reg query "HKEY_CLASSES_ROOT\.exe" ^| find /i "(默认)"') do (
    set /a NO.+=1
    if "%%i"=="exefile" (
        set vexe=正常
    ) else (
        set vexe=异常
        set /a NO._Abnormal+=1
        assoc .exe=exefile >nul 2>nul
        if !errorlevel!==1 (
            set dvexe=  ×
            set /a NO._Fail+=1
        )
        if !errorlevel!==0 (
            set dvexe=  √
            set /a NO._Succeed+=1
        )
        echo exe文件关联 !errorlevel! >>%windir%\System_Repair.log
    )
    set Key_Name=            exe文件关联                      
    call :Registry_Scan_Monitor "!Key_Name!" !vexe! !dvexe! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!
)

for /f "tokens=3" %%i in ('reg query "HKEY_CLASSES_ROOT\.bat"^| find /i "(默认)"') do (
    set /a NO.+=1
    if "%%i"=="batfile" (
        set vbat=正常
        ) else (
        set vbat=异常
        set /a NO._Abnormal+=1
        assoc .bat=batfile >nul 2>nul
        if !errorlevel!==1 (
            set dvbat=  ×
            set /a NO._Fail+=1
        )
        if !errorlevel!==0 (
            set dvbat=  √
            set /a NO._Succeed+=1
        )
        echo bat文件关联 !errorlevel! >>%windir%\System_Repair.log
    )
    set Key_Name=            bat文件关联                      
    call :Registry_Scan_Monitor "!Key_Name!" !vbat! !dvbat! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!
)


for /f "tokens=3" %%i in ('reg query "HKEY_CLASSES_ROOT\.txt"^| find /i "(默认)"') do (
    set /a NO.+=1
    if "%%i"=="txtfile" (
        set vtxt=正常
        ) else (
        set vtxt=异常
        set /a NO._Abnormal+=1
        assoc .txt=txtfile >nul 2>nul
        if !errorlevel!==1 (
            set dvtxt=  ×
            set /a NO._Fail+=1
        )
        if !errorlevel!==0 (
            set dvtxt=  √
            set /a NO._Succeed+=1
        )
        echo txt文件关联 !errorlevel! >>%windir%\System_Repair.log
    )
    set Key_Name=            txt文件关联                      
    call :Registry_Scan_Monitor "!Key_Name!" !vtxt! !dvtxt! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!
)


for /f "tokens=3" %%i in ('reg query "HKEY_CLASSES_ROOT\.ini"^| find /i "(默认)"') do (
    set /a NO.+=1
    if "%%i"=="inifile" (
        set vini=正常
        ) else (
        set vini=异常
        set /a NO._Abnormal+=1
        assoc .ini=inifile >nul 2>nul
        if !errorlevel!==1 (
            set dvini=  ×
            set /a NO._Fail+=1
        )
        if !errorlevel!==0 (
            set dvini=  √
            set /a NO._Succeed+=1
        )
        echo ini文件关联 !errorlevel! >>%windir%\System_Repair.log
    )
    set Key_Name=            ini文件关联                      
    call :Registry_Scan_Monitor "!Key_Name!" !vini! !dvini! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!
)


for /f "tokens=3" %%i in ('reg query "HKEY_CLASSES_ROOT\.vbs"^| find /i "(默认)"') do (
    set /a NO.+=1
    if "%%i"=="vbsfile" (
    set vvbs=正常
    ) else (
        set vvbs=异常
        set /a NO._Abnormal+=1
        assoc .vbs=vbsfile >nul 2>nul
        if !errorlevel!==1 (
            set dvvbs=  ×
            set /a NO._Fail+=1
        )
        if !errorlevel!==0 (
            set dvvbs=  √
            set /a NO._Succeed+=1
        )
        echo vbs文件关联 !errorlevel! >>%windir%\System_Repair.log
    )
    set Key_Name=            vbs文件关联                      
    call :Registry_Scan_Monitor "!Key_Name!" !vvbs! !dvvbs! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!
)


for /f "tokens=3" %%i in ('reg query "HKEY_CLASSES_ROOT\.com"^| find /i "(默认)"') do (
    set /a NO.+=1
    if "%%i"=="comfile" (
    set vcom=正常
    ) else (
        set vcom=异常
        set /a NO._Abnormal+=1
        assoc .com=comfile >nul 2>nul
        if !errorlevel!==1 (
            set dvcom=  ×
            set /a NO._Fail+=1
        )
        if !errorlevel!==0 (
            set dvcom=  √
            set /a NO._Succeed+=1
        )
        echo com文件关联 !errorlevel! >>%windir%\System_Repair.log
    )
    set Key_Name=            com文件关联                      
    call :Registry_Scan_Monitor "!Key_Name!" !vcom! !dvcom! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!
)

cls
echo.&&echo.&&echo.&&echo.
echo        扫描：116         异常：!NO._Abnormal!         修复：!NO._Succeed!     失败 !NO._Fail!
ping /n 5 127.1>nul
goto Main


:Registry_Scan_Monitor
cls
echo.
echo            检  查  项  目                       状态          修复
echo =====================================================================
echo %~1   %2         %3
echo =====================================================================
echo.
echo        扫描：%4/116         异常：%5          修复：%6     失败 %7
goto :eof



:Startup_Items_Scan
Title 系统启动项扫描
Mode con cols=70 lines=25
cls
set /a NO.=0
echo.
echo     启 动 项 列 表 ：
echo.
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo.
for %%x in (
    HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run
    HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run
    HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\RunOnce
    HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\RunOnce
    HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\RunServices
    HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\RunServices
    HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce
    HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce
    HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnceEx
    HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnceEx
    HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\RunOnceSetup
    HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\RunOnceSetup
    HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run
    HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run
    HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\Shell
    HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System\Shell
    HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ShellServiceObjectDelayLoad
    HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ShellServiceObjectDelayLoad
    HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\System\Scripts
    HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\System\Scripts
) do (
    for /f "usebackq  tokens=1* delims=:" %%i in (`"reg query %%x 2>nul"`) do (
        set str=%%i
        set var=%%j
        set "var=!var:"=!"
        if not "!var:~-1!"=="=" (
            set /a NO.+=1
            echo !NO.! !str:~-1!:!var!
            for /f "tokens=1" %%a in ('echo !str!') do (
                set Delete_Registry_Entries_!NO.!=%%m
                set Delete_Registry_Value_!NO.!=%%a
                set Delete_Registry_Path_!NO.!=!str:~-1!:!var!
            )
        )
    )
)
echo.
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo     统  计           扫描：%NO.% 项
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo.&&echo.

:Startup_Items_Scan_Choose
set /a NO._max=%NO.%
echo    Q 返回主菜单   ? 获得更多命令帮助
set choose=~
set /p choose=
for /f "usebackq tokens=1,2" %%1 in (`"echo !choose!"`) do (
    set Choose_Order=%%1
    set Choose_NO.=%%2
)
if /I %Choose_Order%==q goto Main
if %Choose_Order%==? goto Startup_Items_Scan_Help
if /I %Choose_Order%==del goto Startup_Items_Scan_Delete
if /I %Choose_Order%==~ (
    echo                 命令错误
    ping /n 2 127.1>nul
    goto Startup_Items_Scan
)
echo                 命令错误
ping /n 2 127.1>nul
goto Startup_Items_Scan

:Startup_Items_Scan_Delete
Mode con cols=50 lines=10
cls
if %Choose_NO.% equ 0 (
    echo.
    echo                指定序号错误
    ping /n 2 127.1>nul
    goto Startup_Items_Scan
)
if %Choose_NO.% leq %NO._max% (
    echo.
    echo 删除项目： !Delete_Registry_Value_%Choose_NO.%!
    echo.
    echo 目标路径： !Delete_Registry_Path_%Choose_NO.%!
    echo.
    echo        确定 Y       取消 N
    set choose=~
    set /p choose=
    if /I !choose!==y goto Startup_Items_Scan_Delete_Execution
    if /I !choose!==n goto Startup_Items_Scan
    if /I !choose!==~ (
        echo.
        echo           无效的选项，请重新输入
        ping /n 2 127.1>nul
        goto Startup_Items_Scan_Delete
    )
    echo.
    echo              无效的选项，请重新输入
    ping /n 2 127.1>nul
    goto Startup_Items_ScanDelete

:Startup_Items_Scan_Delete_Execution
    reg delete !Delete_Registry_Entries_%Choose_NO.%! /v !Delete_Registry_Value_%Choose_NO.%! /f >nul 2>nul
    if %errorlevel%==1 (
        echo.
        echo                 删除失败
    )
    if %errorlevel%==0 (
        echo.
        echo                删除成功
    )
    ping /n 2 127.1>nul
    goto Startup_Items_Scan
    ) else (
        echo.
        echo                 指定序号错误
        ping /n 2 127.1>nul
        goto Startup_Items_Scan
    )

:Startup_Items_Scan_Help
Title 更多帮助
Mode con cols=70 lines=25
cls
echo                   系统启动项扫描——帮助
echo.
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo         友情提示： 在任意可选情况下 Q 返回上一层
echo.&&echo.
echo  命令： del 序号
echo  说明： 删除指定序号的启动项
echo  例示： 删除第9项  del 9
echo.&&echo.
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo                            任意键返回上一层
pause>nul
goto Startup_Items_Scan



:Doubtful_Port_Scan
Title 可疑端口扫描
cls
echo.
echo                              正 在 扫 描
echo.
echo                          ......请稍后......
echo.&&echo.
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo     端口号           进程名称                 目标地址 IP:Port
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
for /F "usebackq skip=4 tokens=2,3,5" %%i in (`"netstat -ano -p TCP"`) do (
    call :Doubtful_Port_Scan_Analysis %%i TCP %%k
    for /f "tokens=1,2 delims=:" %%1 in ('echo !TCP_Port!:!TCP_Process_Name!^|findstr /v /i "System svchost.exe Thunder.exe ThunderService.exe ThunderLiveUD.exe ThunderPlatform.exe 360SE.exe iexplore.exe QQ.exe TTPlayer.exe"') do (
        echo       %%1         %%2                  %%j
    )
)
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo.&&echo.
echo                            任意键返回主菜单
pause>nul
goto Main

:Doubtful_Port_Scan_Analysis
for /F "tokens=2 delims=:" %%e in ("%1") do (
    set  %2_Port=%%e
)
for /F "usebackq skip=2 tokens=1" %%a in (`"tasklist /FI "PID eq %3" 2>nul"`) do (
    set %2_Process_Name=%%a
)
goto :eof



:IEFO_Hijack_Scan
Title IEFO劫持项扫描
cls
set /a NO.=0
echo.
echo     IEFO 劫 持 项 列 表 ：
echo.
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo     被劫持的程序名                     指向的程序
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
for /f "usebackq delims=:" %%i in (`"reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options" 2>nul"`) do (
    set /a NO.+=1
    set IEFO=%%i
    set IEFO_exe=!IEFO:*ons\=!
    for /f "usebackq tokens=3" %%m in (`"reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\!IEFO_exe!" 2>nul"`) do (
        set IEFO_exe_Debugger=%%m
        echo         !IEFO_exe!                     !IEFO_exe_Debugger!
    )
)
echo.
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo.
echo     统  计           扫描：%NO.% 项
ping /n 3 127.1>nul
if %NO.%==0 (
    echo.&&echo.
    echo                            任意键返回主菜单
    pause>nul
    goto Main
) else (
    Mode con cols=50 lines=10
    cls
    echo.&&echo.
    echo              准备清除所有IEFO劫持项目
    echo.
    echo              如果用来免疫病毒，请跳过
    echo.
    echo              Y 开始  其他键返回主菜单
    echo.
    set choose=~
    set /p choose=请选择：
    if /I !choose!==y goto IEFO_Hijack_Scan_clean
    goto IEFO_Hijack_Scan_clean_Pass

:IEFO_Hijack_Scan_clean_Pass
    cls
    echo.&&echo.
    echo                     放弃
    echo.&&echo.
    echo                  返回主菜单
    ping /n 2 127.1>nul
    goto Main

:IEFO_Hijack_Scan_clean
    cls
    reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options" /f >nul 2>nul
    echo.&&echo.
    echo                   删除完成
    echo.&&echo.
    echo                  返回主菜单
    ping /n 2 127.1>nul
    goto Main
)



:Camouflage_Folder_Repair
Mode con cols=70 lines=15
Title 文件夹伪装病毒修复
cls
echo.
echo           此修复工具用于 autorun.inf 启动类病毒
echo.
echo    其中毒表现为：
echo.
echo         1. 文件夹被恶意隐藏
echo.
echo         2. 生成: 同名.exe ; 同名.lnk ; 同名 .exe ; 同名 .lnk 等
echo.&&echo.
echo                           任意键开始全盘扫描
pause>nul
cls
echo.&&echo.&&echo.&&echo.
echo                                正在启动
echo.
echo                           收集隐藏文件夹信息
echo.
echo                              ...请稍后...
set mark=√
set /a NO.=0
set /a NO._Abnormal=0
for /f "tokens=1*" %%a in ('fsutil fsinfo drives') do set disk_list=%%b
for %%i in (%disk_list%) do (
    set disk=%%i
    attrib -h -s -r !disk!autorun.inf>nul
    if exist "!disk!autorun.inf" (
        for /f "tokens=1,2,3 delims== " %%1 in ('findstr /i "Shellexecute" "!disk!autorun.inf"') do (
            del /f /q !disk!%%2>nul 2>nul
            del /f /q !disk!%%3>nul 2>nul
        )
        del /f /q "!disk!autorun.inf">nul 2>nul
    )
    for /f "usebackq delims=" %%m in (`"dir /adh /b /s !disk! 2>nul"`) do (
        set mark=√
        set /a NO.+=1
        if exist "%%m.lnk" (
            set mark=×
            set /a NO._Abnormal+=1
            del /f /q "%%m.lnk" 
        )
        if exist "%%m.exe" (
            set mark=×
            set /a NO._Abnormal+=1
            del /f /q "%%m.exe"
        )
        if exist "%%m .lnk" (
            set mark=×
            set /a NO._Abnormal+=1
            del /f /q "%%m .lnk"
        )
        if exist "%%m .exe" (
            set mark=×
            set /a NO._Abnormal+=1
            del /f /q "%%m .exe"
        )
        if !mark!==× attrib "%%m" -h
        cls
        echo.
        echo       状态                  检查文件
        echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
        echo       !mark!          "%%m"   
        echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
        echo.
        echo     扫描隐藏文件夹 ：!NO.!          发现病毒 : !NO._Abnormal!
    )
)
cls
echo.
echo                                 统  计
echo.
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo.
echo         扫描隐藏文件夹 ：!NO.!           清理病毒 : !NO._Abnormal!     
echo.
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo.&&echo.
echo                            任意键返回主菜单
pause>nul
goto Main



:Safemode_Repair
rem 修复标准来自：百度百科
Title 修复系统安全模式
cls
if exist safe.reg del /f/s/q safe.reg
echo Windows Registry Editor Version 5.00>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot]>>safe.reg
echo "AlternateShell"="cmd.exe">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal]>>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\AppMgmt]>>safe.reg
echo @="Service">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\Base]>>safe.reg
echo @="Driver Group">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\Boot Bus Extender]>>safe.reg
echo @="Driver Group">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\Boot file system]>>safe.reg
echo @="Driver Group">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\CryptSvc]>>safe.reg
echo @="Service">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\DcomLaunch]>>safe.reg
echo @="Service">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\dmadmin]>>safe.reg
echo @="Service">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\dmboot.sys]>>safe.reg
echo @="Driver">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\dmio.sys]>>safe.reg
echo @="Driver">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\dmload.sys]>>safe.reg
echo @="Driver">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\dmserver]>>safe.reg
echo @="Service">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\EventLog]>>safe.reg
echo @="Service">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\File system]>>safe.reg
echo @="Driver Group">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\Filter]>>safe.reg
echo @="Driver Group">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\HelpSvc]>>safe.reg
echo @="Service">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\Netlogon]>>safe.reg
echo @="Service">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\PCI Configuration]>>safe.reg
echo @="Driver Group">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\PlugPlay]>>safe.reg
echo @="Service">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\PNP Filter]>>safe.reg
echo @="Driver Group">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\Primary disk]>>safe.reg
echo @="Driver Group">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\RpcSs]>>safe.reg
echo @="Service">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\SCSI Class]>>safe.reg
echo @="Driver Group">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\sermouse.sys]>>safe.reg
echo @="Driver">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\sr.sys]>>safe.reg
echo @="FSFilter System Recovery">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\SRService]>>safe.reg
echo @="Service">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\System Bus Extender]>>safe.reg
echo @="Driver Group">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\vga.sys]>>safe.reg
echo @="Driver">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\vgasave.sys]>>safe.reg
echo @="Driver">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\WinMgmt]>>safe.reg
echo @="Service">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\{36FC9E60-C465-11CF-8056-444553540000}]>>safe.reg
echo @="Universal Serial Bus controllers">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\{4D36E965-E325-11CE-BFC1-08002BE10318}]>>safe.reg
echo @="CD-ROM Drive">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\{4D36E967-E325-11CE-BFC1-08002BE10318}]>>safe.reg
echo @="DiskDrive">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\{4D36E969-E325-11CE-BFC1-08002BE10318}]>>safe.reg
echo @="Standard floppy disk controller">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\{4D36E96A-E325-11CE-BFC1-08002BE10318}]>>safe.reg
echo @="Hdc">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\{4D36E96B-E325-11CE-BFC1-08002BE10318}]>>safe.reg
echo @="Keyboard">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\{4D36E96F-E325-11CE-BFC1-08002BE10318}]>>safe.reg
echo @="Mouse">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\{4D36E977-E325-11CE-BFC1-08002BE10318}]>>safe.reg
echo @="PCMCIA Adapters">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\{4D36E97B-E325-11CE-BFC1-08002BE10318}]>>safe.reg
echo @="SCSIAdapter">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\{4D36E97D-E325-11CE-BFC1-08002BE10318}]>>safe.reg
echo @="System">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\{4D36E980-E325-11CE-BFC1-08002BE10318}]>>safe.reg
echo @="Floppy disk drive">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\{71A27CDD-812A-11D0-BEC7-08002BE2092F}]>>safe.reg
echo @="Volume">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\{745A17A0-74D3-11D0-B6FE-00A0C90F57DA}]>>safe.reg
echo @="Human Interface Devices">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network]>>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\AFD]>>safe.reg
echo @="Service">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\AppMgmt]>>safe.reg
echo @="Service">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\Base]>>safe.reg
echo @="Driver Group">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\Boot Bus Extender]>>safe.reg
echo @="Driver Group">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\Boot file system]>>safe.reg
echo @="Driver Group">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\Browser]>>safe.reg
echo @="Service">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\CryptSvc]>>safe.reg
echo @="Service">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\DcomLaunch]>>safe.reg
echo @="Service">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\Dhcp]>>safe.reg
echo @="Service">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\dmadmin]>>safe.reg
echo @="Service">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\dmboot.sys]>>safe.reg
echo @="Driver">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\dmio.sys]>>safe.reg
echo @="Driver">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\dmload.sys]>>safe.reg
echo @="Driver">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\dmserver]>>safe.reg
echo @="Service">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\DnsCache]>>safe.reg
echo @="Service">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\EventLog]>>safe.reg
echo @="Service">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\File system]>>safe.reg
echo @="Driver Group">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\Filter]>>safe.reg
echo @="Driver Group">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\HelpSvc]>>safe.reg
echo @="Service">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\ip6fw.sys]>>safe.reg
echo @="Driver">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\ipnat.sys]>>safe.reg
echo @="Driver">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\LanmanServer]>>safe.reg
echo @="Service">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\LanmanWorkstation]>>safe.reg
echo @="Service">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\LmHosts]>>safe.reg
echo @="Service">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\Messenger]>>safe.reg
echo @="Service">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\NDIS]>>safe.reg
echo @="Driver Group">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\NDIS Wrapper]>>safe.reg
echo @="Driver Group">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\Ndisuio]>>safe.reg
echo @="Service">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\NetBIOS]>>safe.reg
echo @="Service">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\NetBIOSGroup]>>safe.reg
echo @="Driver Group">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\NetBT]>>safe.reg
echo @="Service">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\NetDDEGroup]>>safe.reg
echo @="Driver Group">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\Netlogon]>>safe.reg
echo @="Service">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\NetMan]>>safe.reg
echo @="Service">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\Network]>>safe.reg
echo @="Driver Group">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\NetworkProvider]>>safe.reg
echo @="Driver Group">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\NtLmSsp]>>safe.reg
echo @="Service">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\PCI Configuration]>>safe.reg
echo @="Driver Group">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\PlugPlay]>>safe.reg
echo @="Service">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\PNP Filter]>>safe.reg
echo @="Driver Group">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\PNP_TDI]>>safe.reg
echo @="Driver Group">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\Primary disk]>>safe.reg
echo @="Driver Group">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\rdpcdd.sys]>>safe.reg
echo @="Driver">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\rdpdd.sys]>>safe.reg
echo @="Driver">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\rdpwd.sys]>>safe.reg
echo @="Driver">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\rdsessmgr]>>safe.reg
echo @="Service">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\RpcSs]>>safe.reg
echo @="Service">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\SCSI Class]>>safe.reg
echo @="Driver Group">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\sermouse.sys]>>safe.reg
echo @="Driver">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\SharedAccess]>>safe.reg
echo @="Service">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\sr.sys]>>safe.reg
echo @="FSFilter System Recovery">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\SRService]>>safe.reg
echo @="Service">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\Streams Drivers]>>safe.reg
echo @="Driver Group">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\System Bus Extender]>>safe.reg
echo @="Driver Group">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\Tcpip]>>safe.reg
echo @="Service">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\TDI]>>safe.reg
echo @="Driver Group">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\tdpipe.sys]>>safe.reg
echo @="Driver">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\tdtcp.sys]>>safe.reg
echo @="Driver">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\termservice]>>safe.reg
echo @="Service">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\vga.sys]>>safe.reg
echo @="Driver">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\vgasave.sys]>>safe.reg
echo @="Driver">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\WinMgmt]>>safe.reg
echo @="Service">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\WZCSVC]>>safe.reg
echo @="Service">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\{36FC9E60-C465-11CF-8056-444553540000}]>>safe.reg
echo @="Universal Serial Bus controllers">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\{4D36E965-E325-11CE-BFC1-08002BE10318}]>>safe.reg
echo @="CD-ROM Drive">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\{4D36E967-E325-11CE-BFC1-08002BE10318}]>>safe.reg
echo @="DiskDrive">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\{4D36E969-E325-11CE-BFC1-08002BE10318}]>>safe.reg
echo @="Standard floppy disk controller">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\{4D36E96A-E325-11CE-BFC1-08002BE10318}]>>safe.reg
echo @="Hdc">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\{4D36E96B-E325-11CE-BFC1-08002BE10318}]>>safe.reg
echo @="Keyboard">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\{4D36E96F-E325-11CE-BFC1-08002BE10318}]>>safe.reg
echo @="Mouse">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\{4D36E972-E325-11CE-BFC1-08002BE10318}]>>safe.reg
echo @="Net">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\{4D36E973-E325-11CE-BFC1-08002BE10318}]>>safe.reg
echo @="NetClient">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\{4D36E974-E325-11CE-BFC1-08002BE10318}]>>safe.reg
echo @="NetService">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\{4D36E975-E325-11CE-BFC1-08002BE10318}]>>safe.reg
echo @="NetTrans">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\{4D36E977-E325-11CE-BFC1-08002BE10318}]>>safe.reg
echo @="PCMCIA Adapters">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\{4D36E97B-E325-11CE-BFC1-08002BE10318}]>>safe.reg
echo @="SCSIAdapter">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\{4D36E97D-E325-11CE-BFC1-08002BE10318}]>>safe.reg
echo @="System">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\{4D36E980-E325-11CE-BFC1-08002BE10318}]>>safe.reg
echo @="Floppy disk drive">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\{71A27CDD-812A-11D0-BEC7-08002BE2092F}]>>safe.reg
echo @="Volume">>safe.reg

echo.>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\{745A17A0-74D3-11D0-B6FE-00A0C90F57DA}]>>safe.reg
echo @="Human Interface Devices">>safe.reg
regedit.exe/s safe.reg
del /f/s/q safe.reg>nul 2>nul
echo.&&echo.&&echo.
echo                          系统安全模式修复完成
echo.
echo.
echo                               返回主菜单
ping /n 3 127.1>nul
goto Main



:Force_Delete
Mode con cols=50 lines=10
Title 强制删除工具
set mark_=未启动
cls
echo.
echo         用于强制删除一些顽固的文件或文件夹
echo.
echo                 必要时需要重新启动
echo.
echo      任何强制删除都含有一定的风险  请【慎重】使用
ping /n 5 127.1>nul

:Force_Delete_Path
cls
echo.
echo        请将需要删除的文件或文件夹拖放至框中
echo.&&echo.
set Delete_Path=~
set /p Delete_Path=
set "Delete_Path=%Delete_Path:"=%"
cd %Delete_Path% >nul 2>nul
set Delete_Path_Type=~
if %errorlevel%==0 set Delete_Path_Type=文件夹
if %errorlevel%==1 set Delete_Path_Type=文件
cd .. >nul 2>nul
if "%Delete_Path%"=="~" goto Force_Delete_Path
if not exist "%Delete_Path%" (
    cls
    echo.&&echo.&&echo.
    echo                     路径错误 
    ping /n 2 127.1>nul
    goto Force_Delete_Path
)
if "%Delete_Path_Type%"=="~" (
    cls
    echo.&&echo.&&echo.
    echo                     路径错误 
    ping /n 2 127.1>nul
    goto Force_Delete_Path
)
cls
echo.
echo                 即将删除以下文件
echo.
echo "%Delete_Path%"        
echo.&&echo.
echo                Y 开始  其他键放弃
echo.
set choose=~
set /p choose=请选择：
if /I "%choose%"=="Y" goto Force_Delete_Do
goto Force_Delete_Jump

:Force_Delete_Jump
cls
echo.&&echo.&&echo.
echo                       放  弃 
ping /n 2 127.1>nul
goto Main

:Force_Delete_Do
if "%Delete_Path_Type%"=="文件" (
    del /f /s /q "!Delete_Path!" >nul 2>nul
)
if "%Delete_Path_Type%"=="文件夹" (
    rd /s /q "%Delete_Path%" >nul 2>nul
)
if exist "%Delete_Path%" (
    cls
    echo.
    echo                     删除失败
    echo.
    echo              重启后尝试删除该文件
    echo.
    if "!Delete_Path_Type!"=="文件夹" (
        for /f "usebackq delims=" %%j in (`"dir /a /b /s "%Delete_Path%\*.*""`) do (
            cacls %%j /d everyone /e>nul 2>nul
        )
    )
    if "!Delete_Path_Type!"=="文件" (
            cacls "%Delete_Path%" /d everyone /e>nul 2>nul
    )
    echo @echo off>%temp%\Force_Delete.bat
    echo Mode con cols=50 lines=10>>%temp%\Force_Delete.bat
    echo Title 强制删除工具>>%temp%\Force_Delete.bat
    echo rem By bluewing009 for Batch Delete Any File >>%temp%\Force_Delete.bat
    if "%Delete_Path_Type%"=="文件夹" (
    echo for /f "usebackq delims=" %%%%j in ^(`"dir /a /b /s "!Delete_Path!\*.*" 2>nul"`^) do ^( >>%temp%\Force_Delete.bat
    echo  echo y^|cacls "%%%%j" /g everyone:f^>nul 2^>nul>>%temp%\Force_Delete.bat
    echo ^)>>%temp%\Force_Delete.bat
    echo rd /s/q "%Delete_Path%"^>nul 2^>nul>>%temp%\Force_Delete.bat   
    )
    if "%Delete_Path_Type%"=="文件" (
    echo echo y^|cacls "!Delete_Path!" /g everyone:f^>nul 2^>nul>>%temp%\Force_Delete.bat
    echo del /f/s/q "%Delete_Path%"^>nul 2^>nul>>%temp%\Force_Delete.bat
    )
    echo if exist "%Delete_Path%" ^( >>%temp%\Force_Delete.bat
    echo     echo.>>%temp%\Force_Delete.bat
    echo     echo.>>%temp%\Force_Delete.bat
    echo     echo                    强制删除失败>>%temp%\Force_Delete.bat
    echo ^) else ^( >>%temp%\Force_Delete.bat
    echo     echo.>>%temp%\Force_Delete.bat
    echo     echo.>>%temp%\Force_Delete.bat
    echo     echo                    强制删除成功>>%temp%\Force_Delete.bat
    echo ^)>>%temp%\Force_Delete.bat
    echo reg delete HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run /v Force_Delete /f ^>nul 2^>nul>>%temp%\Force_Delete.bat
    echo ping /n 5 127.1^>nul>>%temp%\Force_Delete.bat
    echo del /f/s/q %%0>>%temp%\Force_Delete.bat
    echo exit>>%temp%\Force_Delete.bat
    reg add HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run /v Force_Delete /t REG_SZ /d "%temp%\Force_Delete.bat" /f >nul
    cls
    echo.
    echo               如果有安全拦截提示
    echo.
    echo        请允许添加 “Force_Delete” 启动项
    ping /n 3 127.1>nul
    cls
    for /f "usebackq tokens=2 delims=:" %%i in (`"reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run" 2>nul"^|findstr /i Force_Delete`) do (
        if exist "%temp%\Force_Delete.bat" (
            for /f "tokens=2 delims=:" %%j in ('echo %temp%\Force_Delete.bat') do (
                if "%%i"=="%%j" set mark_=启动
            )
        )
    )
    if "!mark_!"=="未启动" (
        echo.
        echo.
        echo                    失败，请重试
        ping /n 3 127.1>nul
        goto Force_Delete
    )
    if "!mark_!"=="启动" (
        echo.
        echo.
        echo                  成功，请重新启动
        ping /n 3 127.1>nul
        goto Main
    )
) else (
    cls
    echo.
    echo.
    echo                      删除成功
    ping /n 3 127.1>nul
    goto Main
)



:Login_Message_Send
Title 系统登录通知
cls
set mark_exist=未启动
for /f "usebackq tokens=2 delims=:" %%i in (`"reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run" 2>nul"^|findstr /i Login_message_send`) do (
    if exist "%windir%\System32\send.bat" (
        if "%%i"=="\winsows\system32\Login_message_send.vbs" set mark_exist=启动
    )
)
echo.
echo             当系统登录时，自动将IP及所在地发送到指定邮箱中
echo.
echo      推荐使用 tom 邮箱并开通“随身邮”功能（免费），方便送达手机
echo.
echo             如果安全软件提示开机启动项变动，请选择通过
echo.&&echo.
echo                   当前状态： %mark_exist%
echo.
if "%mark_exist%"=="未启动" (
    echo.
    echo                    A.  设置登录通知   
    echo.
)
if "%mark_exist%"=="启动" (
    echo.
    echo         A. 重新设置登录通知       B. 查看设置
    echo.
    echo         C. 取消登录通知           D. 测试收信
    echo.
)
echo                    Q.  返回主菜单
echo.
set choose=~
set /p choose=请选择：
if "%mark_exist%"=="未启动" (
    if /I %choose%==a goto Login_Message_send_Do
)
if "%mark_exist%"=="启动" (
    if /I %choose%==a goto Login_Message_send_Do
    if /I %choose%==b goto Login_Message_send_Check
    if /I %choose%==c goto Login_Message_Send_Cancle
    if /I %choose%==d goto Login_Message_Send_Test
)
if /I %choose%==q goto Main
if /I %choose%==~ (
    echo.
    echo                         无效的选项，请重新输入
    ping /n 2 127.1>nul
    goto Login_message_send
    exit
)
echo.
echo                         无效的选项，请重新输入
ping /n 2 127.1>nul
goto Login_message_send

:Login_Message_Send_Do
Mode con cols=50 lines=10
:Login_Message_Send_Do_Name
cls
echo.
set /p m=请输入接收的邮箱:
if "%m%"=="" goto Login_Message_Send_Do_Name
if not "%m:~-4,4%"==".com" (
    echo.
    echo 邮箱格式错误，请重新输入。
    ping /n 3 127.1>nul
    goto Login_Message_Send_Do_Name
)
echo.
for /f "tokens=1,2 delims=@" %%i in ('echo %m%') do (
    set n=%%i
    set s=%%j
)
cls
echo.
echo  邮箱登录的用户名: %n%
echo.
echo        邮箱服务器：smtp.%s%
ping /n 5 127.1>nul
:Login_Message_Send_Do_Password
cls
echo.
set /p p=请输入邮箱登录的密码:
if "%p%"=="" (
    echo.
    echo 密码无效，请重新输入。
    ping /n 3 127.1>nul
    goto Login_Message_Send_Do_Password
)
echo 接收的邮箱: %m%>"%windir%\System32\send.txt"
echo @echo off^&setlocal enabledelayedexpansion>"%windir%\System32\send.bat"
echo :contest>>"%windir%\System32\send.bat"
echo ping www.ip138.com -n 2 -w 1000^>nul>>"%windir%\System32\send.bat"
echo IF %%ERRORLEVEL%% == 0 goto pass>>"%windir%\System32\send.bat"
echo IF %%ERRORLEVEL%% == 1 goto contest>>"%windir%\System32\send.bat"
echo goto contest>>"%windir%\System32\send.bat"
echo :pass>>"%windir%\System32\send.bat"
echo echo Set oDOM = WScript.GetObject(WScript.Arguments(0)) ^>getip.vbs>>"%windir%\System32\send.bat"
echo echo do until oDOM.readyState = "complete" ^>^>getip.vbs>>"%windir%\System32\send.bat"
echo echo WScript.sleep 200 ^>^>getip.vbs>>"%windir%\System32\send.bat"
echo echo loop ^>^>getip.vbs>>"%windir%\System32\send.bat"
echo echo WScript.echo oDOM.documentElement.outerHTML ^>^>getip.vbs>>"%windir%\System32\send.bat"
echo cscript //NoLogo /e:vbscript getip.vbs "http://ip.loveroot.com"^>ip.txt>>"%windir%\System32\send.bat"
echo for /f "tokens=3,6,7 delims=<> " %%%%1 in ('findstr /r "官方数据查询结果" ip.txt') do ( >>"%windir%\System32\send.bat"
echo     set ip=%%%%1 >>"%windir%\System32\send.bat"
echo     set address=%%%%2 %%%%3 >>"%windir%\System32\send.bat"
echo )>>"%windir%\System32\send.bat"
echo echo On Error Resume Next^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo f="%m%"^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo smtp="smtp.%s%"^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo u="%n%"^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo p="%p%"^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo t="%m%"^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo m="系统登录记录:  所在IP:  %%ip%% 所在位置： %%address%%"^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo msg="系统登录记录 BY bluewing009 保护系统"^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo NameSpace = "http://schemas.microsoft.com/cdo/configuration/" ^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo Set Email = createObject("CDO.Message") ^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo Email.From = f ^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo Email.To = t ^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo Email.Subject = m ^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo Email.Textbody = msg ^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo With Email.Configuration.Fields^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo .Item(NameSpace^^^&"sendusing") = 2 ^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo .Item(NameSpace^^^&"smtpserver") = smtp ^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo .Item(NameSpace^^^&"smtpserverport") = 25 ^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo .Item(NameSpace^^^&"smtpauthenticate") = 1 ^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo .Item(NameSpace^^^&"sendusername") = u ^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo .Item(NameSpace^^^&"sendpassword") = p ^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo .update^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo End With^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo Email.Send^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo "%%windir%%\System32\\send.vbs"^>nul>>"%windir%\System32\send.bat"
echo exit>>"%windir%\System32\send.bat"
echo CreateObject("WScript.Shell").Run "cmd /c send.bat",0 >"%windir%\System32\Login_message_send.vbs"
reg add HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run /v Login_message_send /t REG_SZ /d "%windir%\System32\Login_message_send.vbs" /f >nul
cls
if %errorlevel%==1 (
    echo.&&echo.
    echo                      配置失败
    echo.
    echo                        返回
    ping /n 3 127.1>nul
    goto Login_Message_Send
)
if %errorlevel%==0 (
    echo.&&echo.
    echo                      配置成功
    echo.
    echo                 是否测试邮箱状态 ？
    echo.
    echo               Y 开始  其他键返回主菜单
    echo.
    set choose=~
    set /p choose=请选择：
    if /I !choose!==y goto Login_Message_Send_Test
    goto Main
)

:Login_Message_Send_Check
cls
start "" "%windir%\System32\send.txt"
goto Login_Message_Send

:Login_Message_Send_Cancle
Mode con cols=50 lines=10
reg delete HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run /v Login_message_send /f >nul
if %errorlevel%==1 (
    echo.&&echo.
    echo                      取消失败
    echo.
    echo                        返回
    ping /n 3 127.1>nul
    goto Login_Message_Send
)
if %errorlevel%==0 (
    echo.&&echo.
    echo                      取消成功
    echo.
    echo                     返回主菜单
    ping /n 3 127.1>nul
    goto Main
)

:Login_Message_Send_Test
Mode con cols=50 lines=10
echo.
echo                    正在发送邮件
echo.
echo                    ...请稍后...
call "%windir%\System32\send.bat"
echo.
echo                        成功
echo.
echo                    请登录邮箱查看
ping /n 3 127.1>nul
goto Main



:MBR_Backup_Recovery
Mode con cols=70 lines=20
Title 硬盘主引导记录备份/恢复
cls
set mark_exist=未备份
if exist %SystemRoot%\System32\MBR备份.bin set mark_exist=已备份
echo.
echo                        备份/恢复硬盘主引导记录
echo.
echo             用于应急恢复异常或病毒造成的主引导记录异常
echo.
echo                      如果提示修改，请选择“忽略”
echo.
echo.
echo                        当前状态： %mark_exist%
echo.
if "%mark_exist%"=="未备份" (
    echo.
    echo                         A.  备份硬盘引导记录  
    echo.
)
if "%mark_exist%"=="已备份" (
    echo.
    echo                 A. 更新备份       B. 恢复硬盘引导记录 
    echo.
    echo.
)
echo                         Q.  返回主菜单
echo.
set choose=~
set /p choose=请选择：
if "%mark_exist%"=="未备份" (
    if /I %choose%==a goto MBR_Backup
)
if "%mark_exist%"=="已备份" (
    if /I %choose%==a goto MBR_Backup
    if /I %choose%==b goto MBR_Recovery
)
if /I %choose%==q goto Main
if /I %choose%==~ (
    echo.
    echo                         无效的选项，请重新输入
    ping /n 2 127.1>nul
    goto MBR_Backup_Recovery
    exit
)
echo.
echo                         无效的选项，请重新输入
ping /n 2 127.1>nul
goto MBR_Backup_Recovery

:MBR_Backup
Mode con cols=50 lines=10
cls
echo.
echo.
echo.
echo        ...正在备份...
echo a 100 >%temp%\mbr_backup.code
echo mov ax,0201 >>%temp%\mbr_backup.code
echo mov bx,200  >>%temp%\mbr_backup.code
echo mov cx,0001 >>%temp%\mbr_backup.code
echo mov dx,0080 >>%temp%\mbr_backup.code
echo int 13 >>%temp%\mbr_backup.code
echo int 20 >>%temp%\mbr_backup.code
echo.>>%temp%\mbr_backup.code
echo g >>%temp%\mbr_backup.code
echo m 1000 11FF 100 >>%temp%\mbr_backup.code
echo rcx >>%temp%\mbr_backup.code
echo 200 >>%temp%\mbr_backup.code
echo.>>%temp%\mbr_backup.code
echo n %SystemRoot%\System32\MBR备份.bin>>%temp%\mbr_backup.code
echo w >>%temp%\mbr_backup.code
echo q >>%temp%\mbr_backup.code
debug<%temp%\mbr_backup.code >nul 2>nul
graftabl 936>nul 2>nul
if exist %SystemRoot%\System32\MBR备份.bin (
    cacls " %SystemRoot%\System32\MBR备份.bin" /d everyone /e>nul 2>nul
    echo.
    echo.
    echo                     备份成功
    echo.
    echo              备份文件已被安全锁定
) else (
    echo.
    echo.
    echo                未知错误，备份失败
)
ping /n 2 127.1>nul
goto Main

:MBR_Recovery
Mode con cols=50 lines=10
cls
echo.
echo.
echo.
echo                  ...正在恢复...
echo y|cacls "%SystemRoot%\System32\MBR备份.bin" /g everyone:f>nul
echo n %SystemRoot%\System32\MBR备份.bin >%temp%\mbr_restoration.code
echo l 200 >>%temp%\mbr_restoration.code
echo a 100 >>%temp%\mbr_restoration.code
echo mov ax,0301 >>%temp%\mbr_restoration.code
echo mov bx,0200  >>%temp%\mbr_restoration.code
echo mov cx,0001 >>%temp%\mbr_restoration.code
echo mov dx,0080 >>%temp%\mbr_restoration.code
echo int 13 >>%temp%\mbr_restoration.code
echo int 20 >>%temp%\mbr_restoration.code
echo.>>%temp%\mbr_restoration.code
echo g >>%temp%\mbr_restoration.code
echo q >>%temp%\mbr_restoration.code
debug<%temp%\mbr_restoration.code >nul 2>nul
graftabl 936>nul 2>nul
cls
echo.
echo.
echo.
echo                     恢复成功
ping /n 2 127.1>nul
goto Main



:Virus_Immune
Mode con cols=70 lines=20
Title 病毒免疫工具
cls
set /a NO.=0
set /a NEW_NO.=0
echo.
echo.
echo                                  通过
echo.
echo                      畸形文件夹  和  访问控制列表
echo.
echo                           达到免疫病毒的作用
echo.
echo.
echo                        Q 返回主菜单  其他键继续
echo.
set choose=~
set /p choose=请选择：
if /I %choose%==q goto main
cls
echo.
echo.
echo.
echo                               正 在 免 疫
echo.
echo                           ......请稍后......
::威金病毒
if not exist "%commonprogramfiles%\Microsoft Shared\MSInfo\06E3DD06.DAT\九影病毒免疫       （威金病毒）" (
    if exist "%commonprogramfiles%\Microsoft Shared\MSInfo\06E3DD06.DAT" del /f/s/q"%commonprogramfiles%\Microsoft Shared\MSInfo\06E3DD06.DAT">nul 2>nul
    md "%commonprogramfiles%\Microsoft Shared\MSInfo\06E3DD06.DAT\九影病毒免疫       （威金病毒）"
    md "%commonprogramfiles%\Microsoft Shared\MSInfo\06E3DD06.DAT\九影病毒免疫       （威金病毒）\病毒免疫..\"
    attrib "%commonprogramfiles%\Microsoft Shared\MSInfo\06E3DD06.DAT" +S +R +H
    cacls "%commonprogramfiles%\Microsoft Shared\MSInfo\06E3DD06.DAT\九影病毒免疫       （威金病毒）" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1

if not exist "%commonprogramfiles%\Microsoft Shared\MSInfo\06E3DD06.DLL\九影病毒免疫       （威金病毒）" (
    if exist "%commonprogramfiles%\Microsoft Shared\MSInfo\06E3DD06.DLL" del /f/s/q "C:\Program Files\Common Files\Microsoft Shared\MSInfo\06E3DD06.DLL">nul 2>nul
    md "%commonprogramfiles%\Microsoft Shared\MSInfo\06E3DD06.DLL\九影病毒免疫       （威金病毒）"
    md "%commonprogramfiles%\Microsoft Shared\MSInfo\06E3DD06.DLL\九影病毒免疫       （威金病毒）\病毒免疫..\"
    attrib "%commonprogramfiles%\Microsoft Shared\MSInfo\06E3DD06.DLL" +S +R +H
    cacls "%commonprogramfiles%\Microsoft Shared\MSInfo\06E3DD06.DLL\九影病毒免疫       （威金病毒）" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1

if not exist "%systemroot%\HELP\06E3DD06.CHM\九影病毒免疫       （威金病毒）" (
    if exist "%systemroot%\HELP\06E3DD06.CHM" del /f/s/q "%systemroot%\HELP\06E3DD06.CHM">nul 2>nul
    md "%systemroot%\HELP\06E3DD06.CHM\九影病毒免疫       （威金病毒）"
    md "%systemroot%\HELP\06E3DD06.CHM\九影病毒免疫       （威金病毒）\病毒免疫..\"
    attrib "%systemroot%\HELP\06E3DD06.CHM" +S +R +H
    cacls "%systemroot%\HELP\06E3DD06.CHM\九影病毒免疫       （威金病毒）" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1

if not exist "%SystemRoot%\rundl132.exe\九影病毒免疫       （威金病毒）" (
    if exist "%SystemRoot%\rundl132.exe" del /f/s/q "%SystemRoot%\rundl132.exe">nul 2>nul
    md "%SystemRoot%\rundl132.exe\九影病毒免疫       （威金病毒）"
    md "%SystemRoot%\rundl132.exe\九影病毒免疫       （威金病毒）\病毒免疫..\"
    attrib "%SystemRoot%\rundl132.exe" +S +R +H
    cacls "%SystemRoot%\rundl132.exe\九影病毒免疫       （威金病毒）" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1

if not exist "%SystemRoot%\logo_1.exe\九影病毒免疫       （威金病毒）" (
    if exist "%SystemRoot%\logo_1.exe" del /f/s/q "%SystemRoot%\logo_1.exe">nul 2>nul
    md "%SystemRoot%\logo_1.exe\九影病毒免疫       （威金病毒）"
    md "%SystemRoot%\logo_1.exe\九影病毒免疫       （威金病毒）\病毒免疫..\"
    attrib "%SystemRoot%\logo_1.exe" +S +R +H
    cacls "%SystemRoot%\logo_1.exe\九影病毒免疫       （威金病毒）" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1

if not exist "%SystemRoot%\Sy.exe\九影病毒免疫       （威金病毒）" (
    if exist "%SystemRoot%\Sy.exe" del /f/s/q "%SystemRoot%\Sy.exe">nul 2>nul
    md "%SystemRoot%\Sy.exe\九影病毒免疫       （威金病毒）"
    md "%SystemRoot%\Sy.exe\九影病毒免疫       （威金病毒）\病毒免疫..\"
    attrib "%SystemRoot%\Sy.exe" +S +R +H
    cacls "%SystemRoot%\Sy.exe\九影病毒免疫       （威金病毒）" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1

for /l %%i in (0,1,9) do (
    if not exist "%SystemRoot%\%%iSy.exe\九影病毒免疫       （威金病毒）" (
        if exist "%SystemRoot%\%%iSy.exe" del /f/s/q "%SystemRoot%\%%iSy.exe">nul 2>nul
        md "%SystemRoot%\%%iSy.exe\九影病毒免疫       （威金病毒）"
        md "%SystemRoot%\%%iSy.exe\九影病毒免疫       （威金病毒）\病毒免疫..\"
        attrib "%SystemRoot%\%%iSy.exe" +S +R +H
        cacls "%SystemRoot%\%%iSy.exe\九影病毒免疫       （威金病毒）" /d everyone /e>nul 2>nul
        set /a NEW_NO.+=1
    )
    set /a NO.+=1
)



::Trojan-PSW.Win32.QQPass.vm病毒
if not exist "%programfiles%\Internet Explorer\PLUGINS\SystemKb.bak\九影病毒免疫       （Trojan-PSW.Win32.QQPass.vm病毒）" (
    if exist "%programfiles%\Internet Explorer\PLUGINS\SystemKb.bak" del /f/s/q "%programfiles%\Internet Explorer\PLUGINS\SystemKb.bak">nul 2>nul
    md "%programfiles%\Internet Explorer\PLUGINS\SystemKb.bak\九影病毒免疫       （Trojan-PSW.Win32.QQPass.vm病毒）"
    md "%programfiles%\Internet Explorer\PLUGINS\SystemKb.bak\九影病毒免疫       （Trojan-PSW.Win32.QQPass.vm病毒）\病毒免疫..\"
    attrib "%programfiles%\Internet Explorer\PLUGINS\SystemKb.bak" +S +R +H
    cacls "%programfiles%\Internet Explorer\PLUGINS\SystemKb.bak\九影病毒免疫       （Trojan-PSW.Win32.QQPass.vm病毒）" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1

if not exist "%programfiles%\Internet Explorer\PLUGINS\SystemKb.sys\九影病毒免疫       （Trojan-PSW.Win32.QQPass.vm病毒）" (
    if exist "%programfiles%\Internet Explorer\PLUGINS\SystemKb.sys" del /f/s/q "%programfiles%\Internet Explorer\PLUGINS\SystemKb.sys">nul 2>nul
    md "%programfiles%\Internet Explorer\PLUGINS\SystemKb.sys\九影病毒免疫       （Trojan-PSW.Win32.QQPass.vm病毒）"
    md "%programfiles%\Internet Explorer\PLUGINS\SystemKb.sys\九影病毒免疫       （Trojan-PSW.Win32.QQPass.vm病毒）\病毒免疫..\"
    attrib "%programfiles%\Internet Explorer\PLUGINS\SystemKb.sys" +S +R +H
    cacls "%programfiles%\Internet Explorer\PLUGINS\SystemKb.sys\九影病毒免疫       （Trojan-PSW.Win32.QQPass.vm病毒）" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1

if not exist "%programfiles%\Internet Explorer\PLUGINS\system2.jmp\九影病毒免疫       （Trojan-PSW.Win32.QQPass.vm病毒）" (
    if exist "%programfiles%\Internet Explorer\PLUGINS\system2.jmp" del /f/s/q "%programfiles%\Internet Explorer\PLUGINS\system2.jmp">nul 2>nul
    md "%programfiles%\Internet Explorer\PLUGINS\system2.jmp\九影病毒免疫       （Trojan-PSW.Win32.QQPass.vm病毒）"
    md "%programfiles%\Internet Explorer\PLUGINS\system2.jmp\九影病毒免疫       （Trojan-PSW.Win32.QQPass.vm病毒）\病毒免疫..\"
    attrib "%programfiles%\Internet Explorer\PLUGINS\system2.jmp" +S +R +H
    cacls "%programfiles%\Internet Explorer\PLUGINS\system2.jmp\九影病毒免疫       （Trojan-PSW.Win32.QQPass.vm病毒）" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1

if not exist "%WINDOWS%\intrenat.exe\九影病毒免疫       （Trojan-PSW.Win32.QQPass.vm病毒）" (
    if exist "%WINDOWS%\intrenat.exe" del /f/s/q "%WINDOWS%\intrenat.exe">nul 2>nul
    md "%WINDOWS%\intrenat.exe\九影病毒免疫       （Trojan-PSW.Win32.QQPass.vm病毒）"
    md "%WINDOWS%\intrenat.exe\九影病毒免疫       （Trojan-PSW.Win32.QQPass.vm病毒）\病毒免疫..\"
    attrib "%WINDOWS%\intrenat.exe" +S +R +H
    cacls "%WINDOWS%\intrenat.exe\九影病毒免疫       （Trojan-PSW.Win32.QQPass.vm病毒）" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1

if not exist "%SYSTEM%\WinSocks.dll\九影病毒免疫       （Trojan-PSW.Win32.QQPass.vm病毒）" (
    if exist "%SYSTEM%\WinSocks.dll" del /f/s/q "%SYSTEM%\WinSocks.dll">nul 2>nul
    md "%SYSTEM%\WinSocks.dll\九影病毒免疫       （Trojan-PSW.Win32.QQPass.vm病毒）"
    md "%SYSTEM%\WinSocks.dll\九影病毒免疫       （Trojan-PSW.Win32.QQPass.vm病毒）\病毒免疫..\"
    attrib "%SYSTEM%\WinSocks.dll" +S +R +H
    cacls "%SYSTEM%\WinSocks.dll\九影病毒免疫       （Trojan-PSW.Win32.QQPass.vm病毒）" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1

if not exist "%WINDOWS%\exp1orer.dll\九影病毒免疫       （Trojan-PSW.Win32.QQPass.vm病毒）" (
    if exist "%WINDOWS%\exp1orer.dll" del /f/s/q "%WINDOWS%\exp1orer.dll">nul 2>nul
    md "%WINDOWS%\exp1orer.dll\九影病毒免疫       （Trojan-PSW.Win32.QQPass.vm病毒）"
    md "%WINDOWS%\exp1orer.dll\九影病毒免疫       （Trojan-PSW.Win32.QQPass.vm病毒）\病毒免疫..\"
    attrib "%WINDOWS%\exp1orer.dll" +S +R +H
    cacls "%WINDOWS%\exp1orer.dll\九影病毒免疫       （Trojan-PSW.Win32.QQPass.vm病毒）" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1



::超级木马下载器病毒Gameservet.exe
if not exist "%temp%\RAVWM.exe\九影病毒免疫       （超级木马下载器病毒）" (
    if exist "%temp%\RAVWM.exe" dle /f/s/q "%temp%\RAVWM.exe">nul 2>nul
    md "%temp%\RAVWM.exe\九影病毒免疫       （超级木马下载器病毒）"
    md "%temp%\RAVWM.exe\九影病毒免疫       （超级木马下载器病毒）\病毒免疫..\"
    attrib "%temp%\RAVWM.exe" +S +R +H
    cacls "%temp%\RAVWM.exe\九影病毒免疫       （超级木马下载器病毒）" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1

if not exist "%temp%\qjso.exe\九影病毒免疫       （超级木马下载器病毒）" (
    if exist "%temp%\qjso.exe" del /f/s/q "%temp%\qjso.exe">nul 2>nul
    md "%temp%\qjso.exe\九影病毒免疫       （超级木马下载器病毒）"
    md "%temp%\qjso.exe\九影病毒免疫       （超级木马下载器病毒）\病毒免疫..\"
    attrib "%temp%\qjso.exe" +S +R +H
    cacls "%temp%\qjso.exe\九影病毒免疫       （超级木马下载器病毒）" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1

if not exist "%systemroot%\system32\8888-521ww.exe\九影病毒免疫       （超级木马下载器病毒）" (
    if exist "%systemroot%\system32\8888-521ww.exe" del /f/s/q "%systemroot%\system32\8888-521ww.exe">nul 2>nul
    md "%systemroot%\system32\8888-521ww.exe\九影病毒免疫       （超级木马下载器病毒）"
    md "%systemroot%\system32\8888-521ww.exe\九影病毒免疫       （超级木马下载器病毒）\病毒免疫..\"
    attrib "%systemroot%\system32\8888-521ww.exe" +S +R +H
    cacls "%systemroot%\system32\8888-521ww.exe\九影病毒免疫       （超级木马下载器病毒）" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1

for /l %%i in (0,1,9) do (
    if not exist "%systemroot%\system32\game%%i.exe\九影病毒免疫       （超级木马下载器病毒）" (
        if exist "%systemroot%\system32\game%%i.exe" del /f/s/q "%systemroot%\system32\game%%i.exe">nul 2>nul
        md "%systemroot%\system32\game%%i.exe\九影病毒免疫       （超级木马下载器病毒）"
        md "%systemroot%\system32\game%%i.exe\九影病毒免疫       （超级木马下载器病毒）\病毒免疫..\"
        attrib "%systemroot%\system32\game%%i.exe" +S +R +H
        cacls "%systemroot%\system32\game%%i.exe\九影病毒免疫       （超级木马下载器病毒）" /d everyone /e>nul 2>nul
        set /a NEW_NO.+=1
    )
    set /a NO.+=1
)

if not exist "%systemroot%\system32\nwizqqfo.dll\九影病毒免疫       （超级木马下载器病毒）" (
    if exist "%systemroot%\system32\nwizqqfo.dll" del /f/s/q "%systemroot%\system32\nwizqqfo.dll">nul 2>nul
    md "%systemroot%\system32\nwizqqfo.dll\九影病毒免疫       （超级木马下载器病毒）"
    md "%systemroot%\system32\nwizqqfo.dll\九影病毒免疫       （超级木马下载器病毒）\病毒免疫..\"
    attrib "%systemroot%\system32\nwizqqfo.dll" +S +R +H
    cacls "%systemroot%\system32\nwizqqfo.dll\九影病毒免疫       （超级木马下载器病毒）" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1

if not exist "%systemroot%\system32\gameservet.exe\九影病毒免疫       （超级木马下载器病毒）" (
    if exist "%systemroot%\system32\gameservet.exe" del /f/s/q "%systemroot%\system32\gameservet.exe">nul 2>nul
    md "%systemroot%\system32\gameservet.exe\九影病毒免疫       （超级木马下载器病毒）"
    md "%systemroot%\system32\gameservet.exe\九影病毒免疫       （超级木马下载器病毒）\病毒免疫..\"
    attrib "%systemroot%\system32\gameservet.exe" +S +R +H
    cacls "%systemroot%\system32\gameservet.exe\九影病毒免疫       （超级木马下载器病毒）" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1



::Trojan/Win32.IEprot.jdo病毒
for /l %%i in (0,1,9) do (
    if not exist "%temp%\[%%i].gif\九影病毒免疫       （Trojan/Win32.IEprot病毒）" (
        if exist "%temp%\[%%i].gif" del /f/s/q "%temp%\[%%i].gif">nul 2>nul
        md "%temp%\[%%i].gif\九影病毒免疫       （Trojan/Win32.IEprot病毒）"
        md "%temp%\[%%i].gif\九影病毒免疫       （Trojan/Win32.IEprot病毒）\病毒免疫..\"
        attrib "%temp%\[%%i].gif" +S +R +H
        cacls "%temp%\[%%i].gif\九影病毒免疫       （Trojan/Win32.IEprot病毒）" /d everyone /e>nul 2>nul
        set /a NEW_NO.+=1
    )
    set /a NO.+=1
)



::Backdoor.Win32.Agent.ahj
for /l %%i in (0,1,9) do (
    if not exist "%temp%\db_%%i.exe\九影病毒免疫       （Backdoor.Win32.Agent.ahj病毒）" (
        if exist "%temp%\db_%%i.exe" del /f /s/q "%temp%\db_%%i.exe"
        md "%temp%\db_%%i.exe\九影病毒免疫       （Backdoor.Win32.Agent.ahj病毒）"
        md "%temp%\db_%%i.exe\九影病毒免疫       （Backdoor.Win32.Agent.ahj病毒）\病毒免疫..\"
        attrib "%temp%\db_%%i.exe" +S +R +H
        cacls "%temp%\db_%%i.exe\九影病毒免疫       （Backdoor.Win32.Agent.ahj病毒）" /d everyone /e>nul 2>nul
        set /a NEW_NO.+=1
    )
    set /a NO.+=1
)

if not exist "%system32%\92219FBE.DLL\九影病毒免疫       （Backdoor.Win32.Agent.ahj病毒）" (
    if exist "%system32%\92219FBE.DLL" del /f /s/q "%system32%\92219FBE.DLL"
    md "%system32%\92219FBE.DLL\九影病毒免疫       （Backdoor.Win32.Agent.ahj病毒）"
    md "%system32%\92219FBE.DLL\九影病毒免疫       （Backdoor.Win32.Agent.ahj病毒）\病毒免疫..\"
    attrib "%system32%\92219FBE.DLL" +S +R +H
    cacls "%system32%\92219FBE.DLL\九影病毒免疫       （Backdoor.Win32.Agent.ahj病毒）" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1

if not exist "%system32%\92219FBE.exe\九影病毒免疫       （Backdoor.Win32.Agent.ahj病毒）" (
    if exist "%system32%\92219FBE.exe" del /f /s/q "%system32%\92219FBE.exe"
    md "%system32%\92219FBE.exe\九影病毒免疫       （Backdoor.Win32.Agent.ahj病毒）"
    md "%system32%\92219FBE.exe\九影病毒免疫       （Backdoor.Win32.Agent.ahj病毒）\病毒免疫..\"
    attrib "%system32%\92219FBE.exe" +S +R +H
    cacls "%system32%\92219FBE.exe\九影病毒免疫       （Backdoor.Win32.Agent.ahj病毒）" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1

if not exist "%system32%\92219FBET.exe\九影病毒免疫       （Backdoor.Win32.Agent.ahj病毒）" (
    if exist "%system32%\92219FBET.exe" del /f /s/q "%system32%\92219FBET.exe"
    md "%system32%\92219FBET.exe\九影病毒免疫       （Backdoor.Win32.Agent.ahj病毒）"
    md "%system32%\92219FBET.exe\九影病毒免疫       （Backdoor.Win32.Agent.ahj病毒）\病毒免疫..\"
    attrib "%system32%\92219FBET.exe" +S +R +H
    cacls "%system32%\92219FBET.exe\九影病毒免疫       （Backdoor.Win32.Agent.ahj病毒）" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1

for /l %%i in (0,1,9) do (
    if not exist "%HOMEPATH%\Local Settings\Temporary Internet Files\Content.IE5\CHUFWD67\i[%%i].exe\九影病毒免疫       （Backdoor.Win32.Agent.ahj病毒）" (
        if exist "%HOMEPATH%\Local Settings\Temporary Internet Files\Content.IE5\CHUFWD67\i[%%i].exe" del /f /s/q "%HOMEPATH%\Local Settings\Temporary Internet Files\Content.IE5\CHUFWD67\i[%%i].exe"
        md "%HOMEPATH%\Local Settings\Temporary Internet Files\Content.IE5\CHUFWD67\i[%%i].exe\九影病毒免疫       （Backdoor.Win32.Agent.ahj病毒）"
        md "%HOMEPATH%\Local Settings\Temporary Internet Files\Content.IE5\CHUFWD67\i[%%i].exe\九影病毒免疫       （Backdoor.Win32.Agent.ahj病毒）\病毒免疫..\"
        attrib "%HOMEPATH%\Local Settings\Temporary Internet Files\Content.IE5\CHUFWD67\i[%%i].exe" +S +R +H
        cacls "%HOMEPATH%\Local Settings\Temporary Internet Files\Content.IE5\CHUFWD67\i[%%i].exe\九影病毒免疫       （Backdoor.Win32.Agent.ahj病毒）" /d everyone /e>nul 2>nul
        set /a NEW_NO.+=1
    )
    set /a NO.+=1
)



::恶性U盘病毒
if not exist "%Temp%\testexe.exe\九影病毒免疫       （恶性U盘病毒）" (
    if exist "%Temp%\testexe.exe" del /f/s/q "%Temp%\testexe.exe"
    md "%Temp%\testexe.exe\九影病毒免疫       （恶性U盘病毒）"
    md "%Temp%\testexe.exe\九影病毒免疫       （恶性U盘病毒）\病毒免疫..\"
    attrib "%Temp%\testexe.exe" +S +R +H
    cacls "%Temp%\testexe.exe\九影病毒免疫       （恶性U盘病毒）" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1

if not exist "%Temp%\testexe.dll\九影病毒免疫       （恶性U盘病毒）" (
    if exist "%Temp%\testexe.dll" del /f/s/q "%Temp%\testexe.dll"
    md "%Temp%\testexe.dll\九影病毒免疫       （恶性U盘病毒）"
    md "%Temp%\testexe.dll\九影病毒免疫       （恶性U盘病毒）\病毒免疫..\"
    attrib "%Temp%\testexe.dll" +S +R +H
    cacls "%Temp%\testexe.dll\九影病毒免疫       （恶性U盘病毒）" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1



::woso.exe
if not exist "%Temp%\woso.exe\九影病毒免疫       （woso.exe病毒）" (
    if exist "%Temp%\woso.exe" del /f/s/q "%Temp%\woso.exe"
    md "%Temp%\woso.exe\九影病毒免疫       （woso.exe病毒）"
    md "%Temp%\woso.exe\九影病毒免疫       （woso.exe病毒）\病毒免疫..\"
    attrib "%Temp%\woso.exe" +S +R +H
    cacls "%Temp%\woso.exe\九影病毒免疫       （woso.exe病毒）" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1



::黛蛇蠕虫及其变种（Dasher.B）
for /l %%i in (0,1,9) do (
    if not exist "%systemroot%\system32\Sqlexp%%i.exe\九影病毒免疫       （黛蛇蠕虫及其变种 Dasher.B）" (
        if exist "%systemroot%\system32\Sqlexp%%i.exe" del /f /s/q "%systemroot%\system32\Sqlexp%%i.exe"
        md "%systemroot%\system32\Sqlexp%%i.exe\九影病毒免疫       （黛蛇蠕虫及其变种 Dasher.B）"
        md "%systemroot%\system32\Sqlexp%%i.exe\九影病毒免疫       （黛蛇蠕虫及其变种 Dasher.B）\病毒免疫..\"
        attrib "%systemroot%\system32\Sqlexp%%i.exe" +S +R +H
        cacls "%systemroot%\system32\Sqlexp%%i.exe\九影病毒免疫       （黛蛇蠕虫及其变种 Dasher.B）" /d everyone /e>nul 2>nul
        set /a NEW_NO.+=1
    )
    set /a NO.+=1
)

if not exist "%systemroot%\system32\Sqlexp.exe\九影病毒免疫       （黛蛇蠕虫及其变种 Dasher.B）" (
    if exist "%systemroot%\system32\Sqlexp.exe" del /f/s/q "%systemroot%\system32\Sqlexp.exe"
    md "%systemroot%\system32\Sqlexp.exe\九影病毒免疫       （黛蛇蠕虫及其变种 Dasher.B）"
    md "%systemroot%\system32\Sqlexp.exe\九影病毒免疫       （黛蛇蠕虫及其变种 Dasher.B）\病毒免疫..\"
    attrib "%systemroot%\system32\Sqlexp.exe" +S +R +H
    cacls "%systemroot%\system32\Sqlexp.exe\九影病毒免疫       （黛蛇蠕虫及其变种 Dasher.B）" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1

if not exist "%systemroot%\system32\Sqlscan.exe\九影病毒免疫       （黛蛇蠕虫及其变种 Dasher.B）" (
    if exist "%systemroot%\system32\Sqlscan.exe" del /f/s/q "%systemroot%\system32\Sqlscan.exe"
    md "%systemroot%\system32\Sqlscan.exe\九影病毒免疫       （黛蛇蠕虫及其变种 Dasher.B）"
    md "%systemroot%\system32\Sqlscan.exe\九影病毒免疫       （黛蛇蠕虫及其变种 Dasher.B）\病毒免疫..\"
    attrib "%systemroot%\system32\Sqlscan.exe" +S +R +H
    cacls "%systemroot%\system32\Sqlscan.exe\九影病毒免疫       （黛蛇蠕虫及其变种 Dasher.B）" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1

if not exist "%systemroot%\system32\Sqltob.exe\九影病毒免疫       （黛蛇蠕虫及其变种 Dasher.B）" (
    if exist "%systemroot%\system32\Sqltob.exe" del /f/s/q "%Temp%\Sqltob.exe"
    md "%systemroot%\system32\Sqltob.exe.exe\九影病毒免疫       （黛蛇蠕虫及其变种 Dasher.B）"
    md "%systemroot%\system32\Sqltob.exe.exe\九影病毒免疫       （黛蛇蠕虫及其变种 Dasher.B）\病毒免疫..\"
    attrib "%systemroot%\system32\Sqltob.exe.exe" +S +R +H
    cacls "%systemroot%\system32\Sqltob.exe\九影病毒免疫       （黛蛇蠕虫及其变种 Dasher.B）" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1





cls
echo.
echo                                  统  计
echo.
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo.
echo          共免疫：%NO.% 病毒体          本次新增免疫：%NEW_NO.% 病毒体
echo.
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo.
echo.
echo                            任意键返回主菜单
pause>nul
goto Main



:System_Garbage_clean
Mode con cols=50 lines=10
Title 清理系统垃圾
for %%x in (
    "正在清理Recent文件夹     : %APPDATA%\Microsoft\Windows\Recent"
    "用户临时文件夹           : %temp%"
    "Windows临时目录          : %windir%\temp"
    "已下载的程序             : %windir%\download program files"
    "windows预读              : %windir%\prefetch"
    "windows更新补丁          : %windir%\softwaredistribution\download"
    "内存转储文件             : %windir%\Minidump"
    "office 安装缓存          : %SYSTEMDRIVE%\MSOCache" 
    "IE临时文件夹             : %userprofile%\Local Settings\Temporary Internet Files"
) do (
    for /f "tokens=1,* delims=:" %%i in ("%%x") do (
        set name_temp=%%i
        set name_=!name_temp:~1,-1!
        set path_temp=%%j
        set path_=!path_temp:~1,-1!
        if exist "!path_!" for /f "tokens=3" %%i in ('dir /a /s /-c "!path_!" ^|findstr "个文件"') do set size_=%%i
        set /a size+=!size_!
        cls  
        echo.
        echo.
        echo.
        echo 正在清理  !name_!...
        ping /n 2 127.1>nul
        rd /s /q "!path_!">nul 2>nul
        md "!path_!">nul 2>nul
    )
)
cls
set /a size_all=!size!/1048576
cls
echo.
echo.
echo.
echo 清理完成，共释放空间 !size_all! MB
ping /n 5 127.1>nul
goto Main



:Registry_Garbage_clean
Mode con cols=50 lines=10
Title 清理系统垃圾
set /a NO.=NO._=0
if %version_mark%==win7 set path_=Documents
if %version_mark%==xp set path_=My Documents
if not exist "%Userprofile%\!path_!\注册表清理备份" md "%Userprofile%\!path_!\注册表清理备份"
pause
if exist "%Userprofile%\!path_!\注册表清理备份\最近备份.reg" (
    copy /y "%Userprofile%\!path_!\注册表清理备份\最近备份.reg" "%Userprofile%\!path_!\注册表清理备份\旧的备份.reg" >nul
    del /f/s/q "%Userprofile%\!path_!\注册表清理备份\最近备份.reg" >nul
)
reg export "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\SharedDLLs" "%Userprofile%\!path_!\注册表清理备份\最近备份.reg" >nul
for /F "usebackq skip=%version_skip% tokens=* delims=" %%i in (`" reg query HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\SharedDLLs"`) do call :Registry_Garbage_clean_Analyze "%%i"
ping /n 3 127.1>nul
cls
echo.
echo.
echo.
echo            清理完成
ping /n 2 127.1>nul
cls
echo.
echo.
echo     若有误删，请至 我的文档\注册表清理备份 下
echo.
echo    最近备份.reg  恢复  （上次备份：旧的备份.reg）
ping /n 5 127.1>nul
goto Main
 
:Registry_Garbage_clean_Analyze
set /a NO.+=1
set var=%1
set var=!var:    =!   
set var=!var:REG_DWORD=+!
for /f "tokens=1 delims=+" %%i in (%var%) do (
    if not exist %%i (   
        reg delete HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\SharedDLLs /v "%%i" /f 
        set /a NO._+=1
        )
)
cls
echo.
echo.
echo           已检查项目： %NO.% 
echo.
echo       已删除废弃项目： %NO._%
goto :eof



:Key_Position_Photograph
Title 系统关键位置 system32 文件快照
cls
set mark_exist=不存在
set mark_date=未知
if exist "%windir%\System32\system32_Photograph.txt" (
    set mark_exist=存在
    for /f "usebackq delims=" %%d in ("%windir%\System32\system32_Photograph.txt") do (
        set /a n+=1
        if !n! EQU 1 set mark_date=%%d
    )
)
echo.
echo            通过对系统关键目录 system32 进行快照、对比
echo.
echo                  方便及时发现系统文件的变化
echo.
echo.
echo      标准记录：%mark_exist%         记录时间：%mark_date%
echo.
echo                         当前系统时间：%date%
echo.
echo    操作选项：
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo          A.开始对比
echo.
echo          B.以当前的系统设置，更新标准记录
echo.
echo          C.查看标准记录
echo.
echo          Q.返回主菜单
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo.
set choose=~
set /p choose=请选择：
if /i %choose%==a goto Key_Position_Photograph_Differ
if /i %choose%==b goto Key_Position_Photograph_Update
if /i %choose%==c goto Key_Position_Photograph_Standard
if /i %choose%==q goto Main
if /i %choose%==~ (
    echo.
    echo                         无效的选项，请重新输入
    ping /n 2 127.1>nul
    goto Key_position_Photograph
)
echo.
echo                         无效的选项，请重新输入
ping /n 2 127.1>nul
goto Key_position_Photograph

:Key_Position_Photograph_Differ
cls
if not exist "%windir%\System32\system32_Photograph.txt" (
    echo.
    echo.
    echo                         未发现标准记录，请更新。
    ping /n 3 127.1>nul
    goto Key_position_Photograph
)
echo %date%>%temp%\mark_mow.txt
dir %windir%\System32\*.*/b >>%temp%\mark_mow.txt
findstr /x /v /g:"%windir%\System32\system32_Photograph.txt" %temp%\mark_mow.txt >%temp%\differ.txt
echo.
echo                                  完  成
echo.
echo                            显示多出的文件名
echo.
ping /n 3 127.1>nul
start %temp%\differ.txt
echo.
echo.
echo                 没有显示文件则说明系统关键位置未发生改变
pause>nul
del /f/q/s %temp%\mark_mow.txt>nul 2>nul
del /f/q/s %temp%\differ.txt>nul 2>nul
goto Key_position_Photograph

:Key_Position_Photograph_Update
cls
echo %date% >"%windir%\System32\system32_Photograph.txt"
dir %windir%\System32\*.*/b >>"%windir%\System32\system32_Photograph.txt"
echo.
echo                             标准记录已更新
echo.
echo                               返回上一层
ping /n 3 127.1>nul
goto Key_position_Photograph

:Key_Position_Photograph_Standard
cls
if not exist "%windir%\System32\system32_Photograph.txt" (
    echo.
    echo.
    echo                         未发现标准记录，请更新。
    pause>nul
    goto Key_position_Photograph
)
start "标准记录" "%windir%\System32\system32_Photograph.txt"
goto Key_position_Photograph



:Check_Updates
Mode con cols=50 lines=10
Title 在线更新
set version_New=未知
cls
echo.
echo.
echo.
echo                    正在检查更新
echo.
echo                    ...请稍后...
echo Set oDOM = WScript.GetObject(WScript.Arguments(0)) >%temp%/Updates_.vbs
echo do until oDOM.readyState = "complete" >>%temp%/Updates_.vbs
echo WScript.sleep 200 >>%temp%/Updates_.vbs
echo loop >>%temp%/Updates_.vbs
echo WScript.echo oDOM.documentElement.outerText >>%temp%/Updates_.vbs
cscript //NoLogo /e:vbscript %temp%/Updates_.vbs "http://www.bluewing009.co.cc/版本标记.txt" >%temp%/版本标记.txt 2>nul
for /f %%i in (%temp%\版本标记.txt) do set version_New=%%i
if "%version_New%"=="未知" goto Check_Updates_Error
for /f "tokens=1* delims=:" %%i in ('findstr /n .* %0') do if %%i==22 for /f "tokens=5" %%m in ('%%j') do set version_Now=%%m
cls
echo.
echo.
echo         当前版本：  %version_Now%
echo.
echo         最新版本：  %version_New%
echo.
echo.
if %version_Now%==%version_New% (
    echo              版本最新，不需要更新
    ping /n 3 127.1>nul
    goto Main
) else (
echo              发现新版本，是否更新？
echo.
echo              Y 开始更新  其他键返回
    set choose=~
    set /p choose=请选择：
    if /I !choose!==Y goto Check_Updates_Do
    goto Main
)

:Check_Updates_Do
cls
echo.
echo.
echo.
echo                    正在下载更新
echo.
echo                    ...请稍后...
cscript //NoLogo /e:vbscript %temp%/Updates_.vbs "http://www.bluewing009.co.cc/源码.txt">%temp%\系统辅助工具.bat
echo @echo off>%temp%\系统辅助工具_更新.bat
echo Mode con cols=50 lines=10>>%temp%\系统辅助工具_更新.bat
echo Color 3F>>%temp%\系统辅助工具_更新.bat
echo Title 在线更新>>%temp%\系统辅助工具_更新.bat
echo echo.>>%temp%\系统辅助工具_更新.bat
echo echo.>>%temp%\系统辅助工具_更新.bat
echo echo.>>%temp%\系统辅助工具_更新.bat
echo echo.>>%temp%\系统辅助工具_更新.bat
echo echo                   ...重新启动...>>%temp%\系统辅助工具_更新.bat
echo ping /n 3 127.1^>nul>>%temp%\系统辅助工具_更新.bat
echo copy /y "%temp%\系统辅助工具.bat" "%~dp0\%~n0.bat"^>nul >>%temp%\系统辅助工具_更新.bat
echo start "" "%~dp0\%~n0.bat">>%temp%\系统辅助工具_更新.bat
echo Exit>>%temp%\系统辅助工具_更新.bat
start %temp%\系统辅助工具_更新.bat
exit

:Check_Updates_Error
cls
echo.
echo.
echo                 无法连接更新服务器
echo.
echo                     请下载更新
ping /n 3 127.1>nul
goto Main 



:Exit
Mode con cols=50 lines=10
Title 感谢使用
cls
echo.
echo           谢谢使用      o（∩ _ ∩）o
echo.
echo.           如果有好的建议，请联系：
echo.
echo.
echo         E-Mail:  bluewing009@tom.com
echo             QQ:      961881006
echo.
ping /n 5 127.0.0.1>nul
endlocal
start explorer.exe>nul 2>nul
Exit
