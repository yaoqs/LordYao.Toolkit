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
Title ϵͳ��������
cls
echo.
echo   ����������������������������������
echo   ��                                                              ��
echo   ��               ϵ ͳ �� �� �� ��                              ��
echo   ��                                                              ��
echo   ��                                            �� ʽ ��   V3.03  ��
echo   ��                                                              ��
echo   ��                               Author ��     ��Ӱ����         ��
echo   ��                                E-Mail��  bluewing009@tom.com ��
echo   ��                                    QQ��     961881006        ��
echo   ��                                                              ��
echo   ����������������������������������
echo.&&echo.
echo       ˵����
echo.
echo            �����ڽ���������߰�ȫ����޷�����ʱ����ϵͳ�����޸�
echo.&&echo.
echo                      %version% 
echo.
echo                 %date:~0,4%��%date:~5,2%��%date:~8,2%��  ����%date:~-1,1%    %time:~0,2%ʱ%time:~3,2%��
echo.
echo.
ping /n 5 127.1>nul



:Permission_Test
Mode con cols=50 lines=10
Title Ȩ��ȷ��
cls
echo.&&echo.&&echo.
echo                ���ڲ��������Ȩ��
echo.
echo                   ...���Ժ�...
echo.>%SystemRoot%\System32\Ȩ�޲���.dat
if not exist %SystemRoot%\System32\Ȩ�޲���.dat (
    cls
    echo.&&echo.
    echo                     Ȩ���쳣
    echo.
    echo                ���Թ���ԱȨ������
    echo.&&echo.
    echo                    ������˳�
    pause>nul
    exit
)
del /f/s/q %SystemRoot%\System32\Ȩ�޲���.dat >nul 2>nul



:Safe_Environment
Mode con cols=50 lines=10
Title ������ȫ����
cls
echo     �����Զ��رճ�ϵͳ������н��̱��ⲡ��פ��
echo.
echo   ���������ʱ�����ã����˵�ѡ���˳������Զ��ָ�
echo.
echo                �뱣��δ��ɵĹ���
echo.
echo                Y ��ʼ  ����������
echo.
set choose=~
set /p choose=��ѡ��
if /I %choose%==Y goto Build_Safe
goto Build_Safe_Jump

:Build_Safe
set /a NO._All=NO._Succeed=NO.=0
cls
echo.
echo                     ���ڹ���
echo.
echo                       �Ժ�
taskkill /f /im explorer.exe>nul 2>nul
for /f "skip=5 tokens=1" %%p in ('tasklist^|findstr /v /i "wininit.exe cmd.exe svchost.exe lsass.exe services.exe winlogon.exe csrss.exe smss.exe lsm.exe conhost.exe WmiPrvSE.exe"') do (
    taskkill /f /im %%p >nul 2>nul||(
        start /min ntsd -c q -pn %%p >nul 2>nul
        ping /n 1 127.1>nul
        tasklist /fi "IMAGENAME eq ntsd.exe"|findstr /i "û������"  && set /a NO._Succeed+=1
        taskkill /f /im ntsd.exe >nul 2>nul
    )
)
if %version_mark%==win7 taskkill /f /t /im cmd.exe /FI "WINDOWTITLE ne ����Ա:  ������ȫ����" >nul 2>nul
if %version_mark%==xp taskkill /f /t /im cmd.exe /FI "WINDOWTITLE ne ������ȫ����" >nul 2>nul
set /a NO.=%NO._All%-%NO._Succeed%
echo.&&echo.
echo                     �������
if not %NO.%==0 (
    echo.&&echo.
    echo            ���� %NO.% �����޷��ر�
)
ping /n 3 127.1>nul
goto Preparation_Log

:Build_Safe_Jump
cls
echo.&&echo.&&echo.&&echo.
echo                       ����
ping /n 2 127.1>nul
goto Preparation_Log



:Preparation_Log
if exist %windir%\System_Repair.log copy /y %windir%\System_Repair.log %windir%\System_Repair_Last.log>nul 2>nul
echo.>%windir%\System_Repair.log
echo %date% >>%windir%\System_Repair.log
echo.>>%windir%\System_Repair.log
echo ������ϵͳ�������߲�����¼>>%windir%\System_Repair.log
echo.>>%windir%\System_Repair.log
echo.>>%windir%\System_Repair.log
goto Main



:Main
Mode con cols=70 lines=25
Title ϵͳ��������
cls
echo.
echo                         �� �� �� ��
echo.
echo  �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� ��
echo                             ����
echo                             ����
echo       A. ϵͳɨ��           ����     B. ϵͳ�޸�
echo                             ����
echo                             ����
echo       C. ϵͳ����           ����     D. ϵͳ��Ϣ
echo                             ����
echo                             ����
echo       E. ������           ����     Q.   �˳�
echo                             ����
echo                             ����
echo  �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� ��
echo.&&echo.&&echo.
set choose=~
set /p choose=��ѡ��
if /I %choose%==a goto System_Scan
if /I %choose%==b goto System_Repair
if /I %choose%==c goto System_Assistant
if /I %choose%==d goto System_Information
if /I %choose%==e goto Check_Updates
if /I %choose%==q goto Exit
if /I %choose%==~ (
    echo.
    echo                         ��Ч��ѡ�����������
    ping /n 2 127.1>nul
    goto Main
)
echo.
echo                         ��Ч��ѡ�����������
ping /n 2 127.1>nul
goto Main



:System_Scan
Mode con cols=70 lines=25
Title  ϵͳɨ��
cls
echo.
echo                         �� �� �� ��
echo.
echo  �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� ��
echo                            ����
echo                            ����
echo    A. ע���ɨ��           ����     B. ������ɨ��
echo                            ����
echo                            ����
echo    C. ���ɶ˿�ɨ��         ����     D. IEFO�ٳ�ɨ��
echo                            ����
echo                            ����
echo    E. ϵͳ�ؼ�λ�ÿ���     ����
echo                            ����
echo                            ����
echo  �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� ��
echo.&&echo.
echo                       Q.�������˵�
echo.&&echo.
set choose=~
set /p choose=��ѡ��
if /I %choose%==a goto Registry_Scan
if /I %choose%==b goto Startup_Items_Scan
if /I %choose%==c goto Doubtful_Port_Scan
if /I %choose%==d goto IEFO_Hijack_Scan
if /I %choose%==e goto Key_Position_Photograph
if /I %choose%==q goto Main
if /I %choose%==~ (
    echo.
    echo                         ��Ч��ѡ�����������
    ping /n 2 127.1>nul
    goto System_Scan
)
echo.
echo                         ��Ч��ѡ�����������
ping /n 2 127.1>nul
goto System_Scan



:System_Repair
Mode con cols=70 lines=25
Title  ϵͳ�޸�
cls
echo.
echo                         �� �� �� ��
echo.
echo  �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� ��
echo                            ����
echo                            ����
echo    A. �ļ���αװ�޸�       ����     B. ��ȫģʽ�޸�
echo                            ����
echo                            ����
echo  �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� ��
echo.&&echo.
echo                       Q.�������˵�
echo.&&echo.
set choose=~
set /p choose=��ѡ��
if /I %choose%==a goto Camouflage_Folder_Repair
if /I %choose%==b goto Safemode_Repair
if /I %choose%==q goto Main
if /I %choose%==~ (
    echo.
    echo                         ��Ч��ѡ�����������
    ping /n 2 127.1>nul
    goto System_Repair
)
echo.
echo                         ��Ч��ѡ�����������
ping /n 2 127.1>nul
goto System_Repair



:System_Assistant
Mode con cols=70 lines=25
Title  ϵͳ����
cls
echo.
echo                         �� �� �� ��
echo.
echo  �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� ��
echo                            ����
echo                            ����
echo    A. ǿ��ɾ������         ����     B. ϵͳ��¼֪ͨ
echo                            ����
echo                            ����
echo    C. ��������¼����/�ָ�  ����     D. ��������
echo                            ����
echo                            ����
echo    E. ����ϵͳ����         ����     
echo                            ����
echo                            ����
echo  �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� ��
echo.&&echo.
echo                       Q.�������˵�
echo.&&echo.
set choose=~
set /p choose=��ѡ��
if /I %choose%==a goto Force_Delete
if /I %choose%==b goto Login_Message_Send
if /I %choose%==c goto MBR_Backup_Recovery
if /I %choose%==d goto Virus_Immune
if /I %choose%==e goto System_Garbage_clean
if /I %choose%==q goto Main
if /I %choose%==~ (
    echo.
    echo                         ��Ч��ѡ�����������
    ping /n 2 127.1>nul
    goto System_Assistant
)
echo.
echo                         ��Ч��ѡ�����������
ping /n 2 127.1>nul
goto System_Assistant



:System_Information
Mode con cols=50 lines=10
Title ϵͳ��Ϣ
cls
echo.&&echo.
echo                 ���ڼ��ϵͳ��Ϣ
echo.
echo.
systeminfo>>%temp%\System_Information.txt
start "" %temp%\System_Information.txt
goto Main



:Registry_Scan
Title ע���ɨ��
Mode con cols=70 lines=15
set /a NO.=NO._=NO._Abnormal=NO._Succeed=NO._Fail=0
cls
for %%x in (
    "ForceClassicControlPanel :         ��������塱��ʽ����                 "
    "HideClock :           ϵͳ֪ͨ����ʱ��                   "
    "LockTaskbar :           ���������޸�����                   "
    "NoActiveDesktop :             �������Ŀ                     "
    "NoActiveDesktopChanges :             ��������                     "
    "NoAddPrinter :             ��Ӵ�ӡ��                       "
    "NoDeletePrinter :             ɾ����ӡ��                       "
    "NoAutoUpdate :           Windows�Զ�����                    "
    "NoBandCustomize :      ���鿴���еġ�������������              "
    "NoCDBurning :             CD��¼����                       "
    "NoCloseDragDropBands :      ���鿴���еġ���������ѡ��              "
    "NoComputersNearMe :  �������ھӡ��еġ��Ҹ����ļ������ѡ��      "
    "NoDesktop :             �����桱״̬                     "
    "NoExpandedNewMenu :     �ļ�ѡ���еġ��½���ѡ��                 "
    "NoFileAssociate :          �ļ�ѡ�����ļ�����                  "
    "NoFileMenu :         ��Դ�������е��ļ��˵�               "
    "NoHardwareTab :     ��������塱�еġ�Ӳ����ѡ��             "
    "NoInternetIcon :           ���桰IE��ͼ��                     "
    "NoLowDiskSpaceChecks :           Ӳ�̿ռ䲻�㾯��                   "
    "NoManageMyComputerVerb :      ���ҵĵ��ԡ��Ҽ�������ѡ��            "
    "NoMovingBands :              �����桱������                  "
    "NoNetConnectDisconnect :           ����������ѡ��                     "
    "NoNetHood :        ����ġ������ھӡ�ͼ��                "
    "NoThumbnailCache :              ����ͼ����                      "
    "NoTrayContextMenu :              �������Ҽ�                      "
    "NoTrayItemsDisplay :             ϵͳ����ͼ��                     "
    "NoViewContextMenu :              �����Ҽ�                        "
    "Noviewondrive :            ��ֹ�����̷�                      "
    "NoWebView :            Webҳ�鿴��ʽ                     "
    "NoWelcomeScreen :          ��¼ʱ����ӭ��Ļ��                  "
    "NoWindowsUpdate :    ��WindowsUpdate���ķ��ʺ�����             "
    "NoWinKeys :             WinKeys��                        "
    "NoPrinterTabs :              ��ӡ��������                    "
    "NoPropertiesMyComputer :      ���ҵĵ��ԡ��Ҽ������ԡ�ѡ��            "
    "NoPropertiesMyDocuments :      ���ҵ��ĵ����Ҽ������ԡ�ѡ��            "
    "NoPropertiesRecycleBin :     ������վ���Ҽ��˵��ġ����ԡ�ѡ��         "
    "NoSetTaskbar :            �˵������޸�����                  "
    "NoSharedDocuments :    ���ҵĵ��ԡ��еġ������ĵ���              "
    "NoRunasInstallPrompt :           �������û���װ����                 "
    "NoShellSearchButton :    ����Դ���������еġ���������ť            "
    "NoRecentDocsNetHood :    �������ھӡ��ġ������ļ��С�ѡ��          "
    "NoChangeStartMenu :       ����ʼ���˵��е��޸�����               "
    "NoClose :    ����ʼ���˵��еġ��ر�ϵͳ��ѡ��          "
    "NoFavoritesMenu :    ����ʼ���˵��еġ��ղؼС�ѡ��            "
    "NoFolderOptions :    ����ʼ���˵��еġ��ļ��С�ѡ��            "
    "NoFind :    ����ʼ���˵��еġ����ҡ�ѡ��              "
    "NoLogOff :    ����ʼ���˵��еġ�ע����ѡ��              "
    "NoNetworkConnections :    ����ʼ���˵��еġ��������ӡ�ѡ��          "
    "NoUserNameInStartMenu :     ����ʼ���˵��еġ��û�����ѡ��           "
    "NoRecentDocsMenu :     ����ʼ���˵��еġ���������ĵ���ѡ��     "
    "NoRun :    ����ʼ���˵��еġ����С�ѡ��              "
    "NoSetActiveDesktop :    ����ʼ���˵��С�����桱ѡ��            "
    "NoSetFolders :    ����ʼ���˵��еġ����á�ѡ��              "
    "NoSMHelp :    ����ʼ���˵��еġ�������֧�֡�ѡ��        "
    "NoSMMyDocs :    ����ʼ���˵��еġ��ҵ��ĵ���ѡ��          "
    "NoSMMyPictures :    ����ʼ���˵��еġ��ҵ�ͼƬ��ѡ��          "
    "NoStartMenuMFUProgramsList :    ����ʼ���˵��еġ����ó����б�ѡ��      "
    "NoStartMenuMorePrograms :    ����ʼ���˵��еġ����г���ѡ��          "
    "NoStartMenuMyMusic :    ����ʼ���˵��еġ��ҵ����֡�ѡ��          "
    "NoStartMenuSubFolders :    ����ʼ���еġ��û��ļ��С�ѡ��            "
    "Start_ShowControlPanel :    ����ʼ���˵��еġ�������塱ѡ��          "
    "Start_ShowMyComputer :    ����ʼ���˵��еġ��ҵĵ��ԡ�ѡ��          "
    "Start_ShowNetConn :    ����ʼ���˵��еġ������ھӡ�ѡ��          "
    "StartMenuLogOff :    ����ʼ���˵��еġ�ע����ѡ��              "

) do (
    for /f "tokens=1,* delims=:" %%e in ("%%x") do (
        set Value_temp=%%e
        set Registry_Scan_Value=!Value_temp:~1,-1!
        set Name_temp=%%f
        set Registry_Scan_Name=!Name_temp:~1,-1!
        set v%Registry_Scan_Value%=����
        set dv%Registry_Scan_Value%=����Ҫ
        set /a NO.+=1
        for /f "usebackq tokens=3" %%i in (`"reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" 2>nul"^|findstr /i !Registry_Scan_Value!`) do (
            if "%%i"=="0x1" (
                set v!Registry_Scan_Value!=�쳣
                set /a NO._Abnormal+=1
                reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v !Registry_Scan_Value! /f >nul 2>nul
                if !errorlevel!==1 (
                    set dv!Registry_Scan_Value!=  ��
                    set /a NO._Fail+=1
                )
                if !errorlevel!==0 (
                    set dv!Registry_Scan_Value!=  ��
                    set /a NO._Succeed+=1
                )
                echo "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\!Registry_Scan_Value!" !errorlevel! >>%windir%\System_Repair.log
            )
        )
        for /f "usebackq tokens=3" %%i in (`"reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" 2>nul"^|findstr /i !Registry_Scan_Value!`) do (
            if "%%i"=="0x1" (
                set v!Registry_Scan_Value!=�쳣
                set /a NO._Abnormal+=1
                reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v !Registry_Scan_Value! /f >nul 2>nul
                if !errorlevel!==1 (
                    set dv!Registry_Scan_Value!=  ��
                    set /a NO._Fail+=1
                )
                if !errorlevel!==0 (
                    set dv!Registry_Scan_Value!=  ��
                    set /a NO._Succeed+=1
                )
                echo "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explore\!Registry_Scan_Value!" !errorlevel! >>%windir%\System_Repair.log
            )
        )
    call :Registry_Scan_Monitor "!Registry_Scan_Name!" !v%Registry_Scan_Value%! !dv%Registry_Scan_Value%! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!         
    )
)

for %%x in (
    "NoDrives :             ������ʾ                         "
    "Noviewondrive :             �������                         "

) do (
    for /f "tokens=1,* delims=:" %%e in ("%%x") do (
        set Value_temp=%%e
        set Registry_Scan_Value=!Value_temp:~1,-1!
        set Name_temp=%%f
        set Registry_Scan_Name=!Name_temp:~1,-1!
        set v%Registry_Scan_Value%=����
        set dv%Registry_Scan_Value%=����Ҫ
        set /a NO.+=1
        for /f "usebackq tokens=3" %%i in (`"reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" 2>nul"^|findstr /i !Registry_Scan_Value!`) do (
            set v!Registry_Scan_Value!=�쳣
            set /a NO._Abnormal+=1
            reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v !Registry_Scan_Value! /f >nul 2>nul
            if !errorlevel!==1 (
                set dv!Registry_Scan_Value!=  ��
                set /a NO._Fail+=1
            )
            if !errorlevel!==0 (
                set dv!Registry_Scan_Value!=  ��
                set /a NO._Succeed+=1
            )
            echo "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\!Registry_Scan_Value!" !errorlevel! >>%windir%\System_Repair.log
        )
        for /f "usebackq tokens=3" %%i in (`"reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" 2>nul"^|findstr /i !Registry_Scan_Value!`) do (
            set v!Registry_Scan_Value!=�쳣
            set /a NO._Abnormal+=1
            reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v !Registry_Scan_Value! /f >nul 2>nul
            if !errorlevel!==1 (
                set dv!Registry_Scan_Value!=  ��
                set /a NO._Fail+=1
            )
            if !errorlevel!==0 (
                set dv!Registry_Scan_Value!=  ��
                set /a NO._Succeed+=1
            )
            echo "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\%%e" !errorlevel! >>%windir%\System_Repair.log
        )
    call :Registry_Scan_Monitor "!Registry_Scan_Name!" !v%Registry_Scan_Value%! !dv%Registry_Scan_Value%! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!         
    )
)

for %%x in (
    "Disableregistrytools :                ע���                        "
    "DisableSR :                ϵͳ��ԭ                      "
    "DisableTaskmgr :              ���������                      "
    "NoConfigPage :            ϵͳ���ԡ�Ӳ�����á�              "
    "Nocontrolpanel :   ��������塱�еġ����/ɾ������Ŀ          "
    "NoDevMgrPage :           ϵͳ���ԡ��豸����               "
    "NoDispAppearancePage :         �Ի����С���ۡ�ѡ��                 "
    "NoDispBackgroundPage :         �Ի����С�������ѡ��                 "
    "NoDispScrSavPage :       �Ի����С���Ļ������ѡ��               "
    "NoDispSettingsPage :         �Ի����С����á�ѡ��                 "
    "NoFileSysPage :          ϵͳ���ԡ��ļ�ϵͳ��                "
    "NoVirtMemPage :          ϵͳ���ԡ������ڴ桱                "
) do (
    for /f "tokens=1,* delims=:" %%e in ("%%x") do (
        set Value_temp=%%e
        set Registry_Scan_Value=!Value_temp:~1,-1!
        set Name_temp=%%f
        set Registry_Scan_Name=!Name_temp:~1,-1!
        set v%Registry_Scan_Value%=����
        set dv%Registry_Scan_Value%=����Ҫ
        set /a NO.+=1
        for /f "usebackq tokens=3" %%i in (`"reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System" 2>nul"^|findstr /i !Registry_Scan_Value!`) do (
            if "%%i"=="0x1" (
                set v%%s=�쳣
                set /a NO._Abnormal+=1
                reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v !Registry_Scan_Value! /f >nul 2>nul
                if !errorlevel!==1 (
                    set dv!Registry_Scan_Value!=  ��
                    set /a NO._Fail+=1
                )
                if !errorlevel!==0 (
                    set dv!Registry_Scan_Value!=  ��
                    set /a NO._Succeed+=1
                )
                echo "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System\!Registry_Scan_Value!" !errorlevel! >>%windir%\System_Repair.log
            )
        )
            for /f "usebackq tokens=3" %%i in (`"reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System" 2>nul"^|findstr /i !Registry_Scan_Value!`) do (
            if "%%i"=="0x1" (
                set v!Registry_Scan_Value!=�쳣
                set /a NO._Abnormal+=1
                reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v !Registry_Scan_Value! /f >nul 2>nul
                if !errorlevel!==1 (
                    set dv!Registry_Scan_Value!=  ��
                    set /a NO._Fail+=1
                )
                if !errorlevel!==0 (
                    set dv!Registry_Scan_Value!=  ��
                    set /a NO._Succeed+=1
                )
                echo "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\!Registry_Scan_Value!" !errorlevel! >>%windir%\System_Repair.log
            )
        )
    call :Registry_Scan_Monitor "!Registry_Scan_Name!" !v%Registry_Scan_Value%! !dv%Registry_Scan_Value%! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!
    )
)


for %%x in (
    "accessibility :           IE���������ܡ���ť                 "
    "advanced :          Internet�߼�ҳ�������              "
    "advancedTab :   ��Internetѡ��еġ��߼�����             "
    "Autoconfig :        �����������е��Զ���������            "
    "cache :             IE��ʱ�ļ�                       "
    "CalendarContact :         ��������ϵ������                     "
    "Certificates :               IE֤������                     "
    "Check_If_Default :             Ĭ����������                   "
    "colour :           IE����ɫ����ť                     "
    "ConnectionsTab :   ��Internetѡ��еġ����ӡ���             "
    "ContentTab :   ��Internetѡ��еġ����ݡ���             "
    "fonts :           IE�����塱��ť                     "
    "FormSuggest :             �����Զ����                   "
    "GeneralTab :   ��Internetѡ��еġ����桱��             "
    "history :       IE�������ʷ��¼����ť                 "
    "HomePage :             IE��ҳ����                       "
    "languages :           IE�����ԡ���ť                     "
    "Messaging :    �����ʼ����������Internet��������        "
    "PrivacyTab :   ��Internetѡ��еġ���˽����             "
    "Profiles :         IE�����ļ���������                   "
    "ProgramsTab :   ��Internetѡ��еġ�������             "
    "Proxy :     �����������еĴ������������             "
    "Ratings :              IE�ּ�����                      "
    "ResetWebSettings :              ����Web����                     "
    "SecurityTab :   ��Internetѡ��еġ���ȫ����             "
    "settings :           IE�����á���ť                     "
) do (
    for /f "tokens=1,* delims=:" %%e in ("%%x") do (
        set Value_temp=%%e
        set Registry_Scan_Value=!Value_temp:~1,-1!
        set Name_temp=%%f
        set Registry_Scan_Name=!Name_temp:~1,-1!
        set v%Registry_Scan_Value%=����
        set dv%Registry_Scan_Value%=����Ҫ
        set /a NO.+=1
        for /f "usebackq tokens=3" %%i in (`"reg query "HKEY_CURRENT_USER\Software\Policies\Microsoft\Internet Explorer\Control Panel" 2>nul"^|findstr /i !Registry_Scan_Value!`) do (
            if "%%i"=="0x1" (
                set v!Registry_Scan_Value!=�쳣
                set /a NO._Abnormal+=1
                reg delete "HKEY_CURRENT_USER\Software\Policies\Microsoft\Internet Explorer\Control Panel" /v !Registry_Scan_Value! /f >nul 2>nul
                if !errorlevel!==1 (
                    set dv!Registry_Scan_Value!=  ��
                    set /a NO._Fail+=1
                )
                if !errorlevel!==0 (
                    set dv!Registry_Scan_Value!=  ��
                    set /a NO._Succeed+=1
                )
                echo "HKEY_CURRENT_USER\Software\Policies\Microsoft\Internet Explorer\Control Panel\!Registry_Scan_Value!" !errorlevel! >>%windir%\System_Repair.log
            )
        )
            for /f "usebackq tokens=3" %%i in (`"reg query "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Internet Explorer\Control Panel" 2>nul"^|findstr /i !Registry_Scan_Value!`) do (
            if "%%i"=="0x1" (
                set v!Registry_Scan_Value!=�쳣
                set /a NO._Abnormal+=1
                reg delete "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Internet Explorer\Control Panel" /v !Registry_Scan_Value! /f >nul 2>nul
                if !errorlevel!==1 (
                    set dv!Registry_Scan_Value!=  ��
                    set /a NO._Fail+=1
                )
                if !errorlevel!==0 (
                    set dv!Registry_Scan_Value!=  ��
                    set /a NO._Succeed+=1
                )
                echo "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Internet Explorer\Control Panel\!Registry_Scan_Value!" !errorlevel! >>%windir%\System_Repair.log
            )
        )                                 
    call :Registry_Scan_Monitor "!Registry_Scan_Name!" !v%Registry_Scan_Value%! !dv%Registry_Scan_Value%! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!
    )
)

for %%x in (
    "NoBrowserClose :     IE���ļ����еġ��رա�����               "
    "NoBrowserOptions :  IE�����ߡ��еġ�Internetѡ�����          "
    "NoFileNew :   IE���鿴���еġ�Դ�ļ�������               "
    "NoFileNew :  IE���ļ����еġ����´��ڡ�����            "
    "NoFileOpen :     IE���ļ����еġ��򿪡�����               "
    "NoTheaterMode :   IE���鿴���еġ�ȫ����ʾ������             "

) do (
    for /f "tokens=1,* delims=:" %%e in ("%%x") do (
        set Value_temp=%%e
        set Registry_Scan_Value=!Value_temp:~1,-1!
        set Name_temp=%%f
        set Registry_Scan_Name=!Name_temp:~1,-1!
        set v%Registry_Scan_Value%=����
        set dv%Registry_Scan_Value%=����Ҫ
        set /a NO.+=1
        for /f "usebackq tokens=3" %%i in (`"reg query "HKEY_CURRENT_USER\Software\Policies\Microsoft\Internet Explorer\Restrictions" 2>nul"^|findstr /i !Registry_Scan_Value!`) do (
            if "%%i"=="0x1" (
                set v!Registry_Scan_Value!=�쳣
                set /a NO._Abnormal+=1
                reg delete "HKEY_CURRENT_USER\Software\Policies\Microsoft\Internet Explorer\Restrictions" /v !Registry_Scan_Value! /f >nul 2>nul
                if !errorlevel!==1 (
                    set dv!Registry_Scan_Value!=  ��
                    set /a NO._Fail+=1
                )
                if !errorlevel!==0 (
                    set dv!Registry_Scan_Value!=  ��
                    set /a NO._Succeed+=1
                )
                echo "HKEY_CURRENT_USER\Software\Policies\Microsoft\Internet Explorer\Restrictions\!Registry_Scan_Value!" !errorlevel! >>%windir%\System_Repair.log
            )
        )
            for /f "usebackq tokens=3" %%i in (`"reg query "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Internet Explorer\Restrictions" 2>nul"^|findstr /i !Registry_Scan_Value!`) do (
            if "%%i"=="0x1" (
                set v!Registry_Scan_Value!=�쳣
                set /a NO._Abnormal+=1
                reg delete "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Internet Explorer\Restrictions" /v !Registry_Scan_Value! /f >nul 2>nul
                if !errorlevel!==1 (
                    set dv!Registry_Scan_Value!=  ��
                    set /a NO._Fail+=1
                )
                if !errorlevel!==0 (
                    set dv!Registry_Scan_Value!=  ��
                    set /a NO._Succeed+=1
                )
                echo "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Internet Explorer\Restrictions\!Registry_Scan_Value!" !errorlevel! >>%windir%\System_Repair.log
            )
        )
    call :Registry_Scan_Monitor "!Registry_Scan_Name!" !v%Registry_Scan_Value%! !dv%Registry_Scan_Value%! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!
    )
)

set dvexe=����Ҫ
set dvbat=����Ҫ
set dvtxt=����Ҫ
set dvini=����Ҫ
set dvvbs=����Ҫ
set dvcom=����Ҫ

for /f "tokens=3" %%i in ('reg query "HKEY_CLASSES_ROOT\.exe" ^| find /i "(Ĭ��)"') do (
    set /a NO.+=1
    if "%%i"=="exefile" (
        set vexe=����
    ) else (
        set vexe=�쳣
        set /a NO._Abnormal+=1
        assoc .exe=exefile >nul 2>nul
        if !errorlevel!==1 (
            set dvexe=  ��
            set /a NO._Fail+=1
        )
        if !errorlevel!==0 (
            set dvexe=  ��
            set /a NO._Succeed+=1
        )
        echo exe�ļ����� !errorlevel! >>%windir%\System_Repair.log
    )
    set Key_Name=            exe�ļ�����                      
    call :Registry_Scan_Monitor "!Key_Name!" !vexe! !dvexe! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!
)

for /f "tokens=3" %%i in ('reg query "HKEY_CLASSES_ROOT\.bat"^| find /i "(Ĭ��)"') do (
    set /a NO.+=1
    if "%%i"=="batfile" (
        set vbat=����
        ) else (
        set vbat=�쳣
        set /a NO._Abnormal+=1
        assoc .bat=batfile >nul 2>nul
        if !errorlevel!==1 (
            set dvbat=  ��
            set /a NO._Fail+=1
        )
        if !errorlevel!==0 (
            set dvbat=  ��
            set /a NO._Succeed+=1
        )
        echo bat�ļ����� !errorlevel! >>%windir%\System_Repair.log
    )
    set Key_Name=            bat�ļ�����                      
    call :Registry_Scan_Monitor "!Key_Name!" !vbat! !dvbat! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!
)


for /f "tokens=3" %%i in ('reg query "HKEY_CLASSES_ROOT\.txt"^| find /i "(Ĭ��)"') do (
    set /a NO.+=1
    if "%%i"=="txtfile" (
        set vtxt=����
        ) else (
        set vtxt=�쳣
        set /a NO._Abnormal+=1
        assoc .txt=txtfile >nul 2>nul
        if !errorlevel!==1 (
            set dvtxt=  ��
            set /a NO._Fail+=1
        )
        if !errorlevel!==0 (
            set dvtxt=  ��
            set /a NO._Succeed+=1
        )
        echo txt�ļ����� !errorlevel! >>%windir%\System_Repair.log
    )
    set Key_Name=            txt�ļ�����                      
    call :Registry_Scan_Monitor "!Key_Name!" !vtxt! !dvtxt! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!
)


for /f "tokens=3" %%i in ('reg query "HKEY_CLASSES_ROOT\.ini"^| find /i "(Ĭ��)"') do (
    set /a NO.+=1
    if "%%i"=="inifile" (
        set vini=����
        ) else (
        set vini=�쳣
        set /a NO._Abnormal+=1
        assoc .ini=inifile >nul 2>nul
        if !errorlevel!==1 (
            set dvini=  ��
            set /a NO._Fail+=1
        )
        if !errorlevel!==0 (
            set dvini=  ��
            set /a NO._Succeed+=1
        )
        echo ini�ļ����� !errorlevel! >>%windir%\System_Repair.log
    )
    set Key_Name=            ini�ļ�����                      
    call :Registry_Scan_Monitor "!Key_Name!" !vini! !dvini! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!
)


for /f "tokens=3" %%i in ('reg query "HKEY_CLASSES_ROOT\.vbs"^| find /i "(Ĭ��)"') do (
    set /a NO.+=1
    if "%%i"=="vbsfile" (
    set vvbs=����
    ) else (
        set vvbs=�쳣
        set /a NO._Abnormal+=1
        assoc .vbs=vbsfile >nul 2>nul
        if !errorlevel!==1 (
            set dvvbs=  ��
            set /a NO._Fail+=1
        )
        if !errorlevel!==0 (
            set dvvbs=  ��
            set /a NO._Succeed+=1
        )
        echo vbs�ļ����� !errorlevel! >>%windir%\System_Repair.log
    )
    set Key_Name=            vbs�ļ�����                      
    call :Registry_Scan_Monitor "!Key_Name!" !vvbs! !dvvbs! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!
)


for /f "tokens=3" %%i in ('reg query "HKEY_CLASSES_ROOT\.com"^| find /i "(Ĭ��)"') do (
    set /a NO.+=1
    if "%%i"=="comfile" (
    set vcom=����
    ) else (
        set vcom=�쳣
        set /a NO._Abnormal+=1
        assoc .com=comfile >nul 2>nul
        if !errorlevel!==1 (
            set dvcom=  ��
            set /a NO._Fail+=1
        )
        if !errorlevel!==0 (
            set dvcom=  ��
            set /a NO._Succeed+=1
        )
        echo com�ļ����� !errorlevel! >>%windir%\System_Repair.log
    )
    set Key_Name=            com�ļ�����                      
    call :Registry_Scan_Monitor "!Key_Name!" !vcom! !dvcom! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!
)

cls
echo.&&echo.&&echo.&&echo.
echo        ɨ�裺116         �쳣��!NO._Abnormal!         �޸���!NO._Succeed!     ʧ�� !NO._Fail!
ping /n 5 127.1>nul
goto Main


:Registry_Scan_Monitor
cls
echo.
echo            ��  ��  ��  Ŀ                       ״̬          �޸�
echo =====================================================================
echo %~1   %2         %3
echo =====================================================================
echo.
echo        ɨ�裺%4/116         �쳣��%5          �޸���%6     ʧ�� %7
goto :eof



:Startup_Items_Scan
Title ϵͳ������ɨ��
Mode con cols=70 lines=25
cls
set /a NO.=0
echo.
echo     �� �� �� �� �� ��
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
echo     ͳ  ��           ɨ�裺%NO.% ��
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo.&&echo.

:Startup_Items_Scan_Choose
set /a NO._max=%NO.%
echo    Q �������˵�   ? ��ø����������
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
    echo                 �������
    ping /n 2 127.1>nul
    goto Startup_Items_Scan
)
echo                 �������
ping /n 2 127.1>nul
goto Startup_Items_Scan

:Startup_Items_Scan_Delete
Mode con cols=50 lines=10
cls
if %Choose_NO.% equ 0 (
    echo.
    echo                ָ����Ŵ���
    ping /n 2 127.1>nul
    goto Startup_Items_Scan
)
if %Choose_NO.% leq %NO._max% (
    echo.
    echo ɾ����Ŀ�� !Delete_Registry_Value_%Choose_NO.%!
    echo.
    echo Ŀ��·���� !Delete_Registry_Path_%Choose_NO.%!
    echo.
    echo        ȷ�� Y       ȡ�� N
    set choose=~
    set /p choose=
    if /I !choose!==y goto Startup_Items_Scan_Delete_Execution
    if /I !choose!==n goto Startup_Items_Scan
    if /I !choose!==~ (
        echo.
        echo           ��Ч��ѡ�����������
        ping /n 2 127.1>nul
        goto Startup_Items_Scan_Delete
    )
    echo.
    echo              ��Ч��ѡ�����������
    ping /n 2 127.1>nul
    goto Startup_Items_ScanDelete

:Startup_Items_Scan_Delete_Execution
    reg delete !Delete_Registry_Entries_%Choose_NO.%! /v !Delete_Registry_Value_%Choose_NO.%! /f >nul 2>nul
    if %errorlevel%==1 (
        echo.
        echo                 ɾ��ʧ��
    )
    if %errorlevel%==0 (
        echo.
        echo                ɾ���ɹ�
    )
    ping /n 2 127.1>nul
    goto Startup_Items_Scan
    ) else (
        echo.
        echo                 ָ����Ŵ���
        ping /n 2 127.1>nul
        goto Startup_Items_Scan
    )

:Startup_Items_Scan_Help
Title �������
Mode con cols=70 lines=25
cls
echo                   ϵͳ������ɨ�衪������
echo.
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo         ������ʾ�� �������ѡ����� Q ������һ��
echo.&&echo.
echo  ��� del ���
echo  ˵���� ɾ��ָ����ŵ�������
echo  ��ʾ�� ɾ����9��  del 9
echo.&&echo.
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo                            �����������һ��
pause>nul
goto Startup_Items_Scan



:Doubtful_Port_Scan
Title ���ɶ˿�ɨ��
cls
echo.
echo                              �� �� ɨ ��
echo.
echo                          ......���Ժ�......
echo.&&echo.
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo     �˿ں�           ��������                 Ŀ���ַ IP:Port
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
for /F "usebackq skip=4 tokens=2,3,5" %%i in (`"netstat -ano -p TCP"`) do (
    call :Doubtful_Port_Scan_Analysis %%i TCP %%k
    for /f "tokens=1,2 delims=:" %%1 in ('echo !TCP_Port!:!TCP_Process_Name!^|findstr /v /i "System svchost.exe Thunder.exe ThunderService.exe ThunderLiveUD.exe ThunderPlatform.exe 360SE.exe iexplore.exe QQ.exe TTPlayer.exe"') do (
        echo       %%1         %%2                  %%j
    )
)
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo.&&echo.
echo                            ������������˵�
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
Title IEFO�ٳ���ɨ��
cls
set /a NO.=0
echo.
echo     IEFO �� �� �� �� �� ��
echo.
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo     ���ٳֵĳ�����                     ָ��ĳ���
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
echo     ͳ  ��           ɨ�裺%NO.% ��
ping /n 3 127.1>nul
if %NO.%==0 (
    echo.&&echo.
    echo                            ������������˵�
    pause>nul
    goto Main
) else (
    Mode con cols=50 lines=10
    cls
    echo.&&echo.
    echo              ׼���������IEFO�ٳ���Ŀ
    echo.
    echo              ����������߲�����������
    echo.
    echo              Y ��ʼ  �������������˵�
    echo.
    set choose=~
    set /p choose=��ѡ��
    if /I !choose!==y goto IEFO_Hijack_Scan_clean
    goto IEFO_Hijack_Scan_clean_Pass

:IEFO_Hijack_Scan_clean_Pass
    cls
    echo.&&echo.
    echo                     ����
    echo.&&echo.
    echo                  �������˵�
    ping /n 2 127.1>nul
    goto Main

:IEFO_Hijack_Scan_clean
    cls
    reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options" /f >nul 2>nul
    echo.&&echo.
    echo                   ɾ�����
    echo.&&echo.
    echo                  �������˵�
    ping /n 2 127.1>nul
    goto Main
)



:Camouflage_Folder_Repair
Mode con cols=70 lines=15
Title �ļ���αװ�����޸�
cls
echo.
echo           ���޸��������� autorun.inf �����ಡ��
echo.
echo    ���ж�����Ϊ��
echo.
echo         1. �ļ��б���������
echo.
echo         2. ����: ͬ��.exe ; ͬ��.lnk ; ͬ�� .exe ; ͬ�� .lnk ��
echo.&&echo.
echo                           �������ʼȫ��ɨ��
pause>nul
cls
echo.&&echo.&&echo.&&echo.
echo                                ��������
echo.
echo                           �ռ������ļ�����Ϣ
echo.
echo                              ...���Ժ�...
set mark=��
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
        set mark=��
        set /a NO.+=1
        if exist "%%m.lnk" (
            set mark=��
            set /a NO._Abnormal+=1
            del /f /q "%%m.lnk" 
        )
        if exist "%%m.exe" (
            set mark=��
            set /a NO._Abnormal+=1
            del /f /q "%%m.exe"
        )
        if exist "%%m .lnk" (
            set mark=��
            set /a NO._Abnormal+=1
            del /f /q "%%m .lnk"
        )
        if exist "%%m .exe" (
            set mark=��
            set /a NO._Abnormal+=1
            del /f /q "%%m .exe"
        )
        if !mark!==�� attrib "%%m" -h
        cls
        echo.
        echo       ״̬                  ����ļ�
        echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
        echo       !mark!          "%%m"   
        echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
        echo.
        echo     ɨ�������ļ��� ��!NO.!          ���ֲ��� : !NO._Abnormal!
    )
)
cls
echo.
echo                                 ͳ  ��
echo.
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo.
echo         ɨ�������ļ��� ��!NO.!           ������ : !NO._Abnormal!     
echo.
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo.&&echo.
echo                            ������������˵�
pause>nul
goto Main



:Safemode_Repair
rem �޸���׼���ԣ��ٶȰٿ�
Title �޸�ϵͳ��ȫģʽ
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
echo                          ϵͳ��ȫģʽ�޸����
echo.
echo.
echo                               �������˵�
ping /n 3 127.1>nul
goto Main



:Force_Delete
Mode con cols=50 lines=10
Title ǿ��ɾ������
set mark_=δ����
cls
echo.
echo         ����ǿ��ɾ��һЩ��̵��ļ����ļ���
echo.
echo                 ��Ҫʱ��Ҫ��������
echo.
echo      �κ�ǿ��ɾ��������һ���ķ���  �롾���ء�ʹ��
ping /n 5 127.1>nul

:Force_Delete_Path
cls
echo.
echo        �뽫��Ҫɾ�����ļ����ļ����Ϸ�������
echo.&&echo.
set Delete_Path=~
set /p Delete_Path=
set "Delete_Path=%Delete_Path:"=%"
cd %Delete_Path% >nul 2>nul
set Delete_Path_Type=~
if %errorlevel%==0 set Delete_Path_Type=�ļ���
if %errorlevel%==1 set Delete_Path_Type=�ļ�
cd .. >nul 2>nul
if "%Delete_Path%"=="~" goto Force_Delete_Path
if not exist "%Delete_Path%" (
    cls
    echo.&&echo.&&echo.
    echo                     ·������ 
    ping /n 2 127.1>nul
    goto Force_Delete_Path
)
if "%Delete_Path_Type%"=="~" (
    cls
    echo.&&echo.&&echo.
    echo                     ·������ 
    ping /n 2 127.1>nul
    goto Force_Delete_Path
)
cls
echo.
echo                 ����ɾ�������ļ�
echo.
echo "%Delete_Path%"        
echo.&&echo.
echo                Y ��ʼ  ����������
echo.
set choose=~
set /p choose=��ѡ��
if /I "%choose%"=="Y" goto Force_Delete_Do
goto Force_Delete_Jump

:Force_Delete_Jump
cls
echo.&&echo.&&echo.
echo                       ��  �� 
ping /n 2 127.1>nul
goto Main

:Force_Delete_Do
if "%Delete_Path_Type%"=="�ļ�" (
    del /f /s /q "!Delete_Path!" >nul 2>nul
)
if "%Delete_Path_Type%"=="�ļ���" (
    rd /s /q "%Delete_Path%" >nul 2>nul
)
if exist "%Delete_Path%" (
    cls
    echo.
    echo                     ɾ��ʧ��
    echo.
    echo              ��������ɾ�����ļ�
    echo.
    if "!Delete_Path_Type!"=="�ļ���" (
        for /f "usebackq delims=" %%j in (`"dir /a /b /s "%Delete_Path%\*.*""`) do (
            cacls %%j /d everyone /e>nul 2>nul
        )
    )
    if "!Delete_Path_Type!"=="�ļ�" (
            cacls "%Delete_Path%" /d everyone /e>nul 2>nul
    )
    echo @echo off>%temp%\Force_Delete.bat
    echo Mode con cols=50 lines=10>>%temp%\Force_Delete.bat
    echo Title ǿ��ɾ������>>%temp%\Force_Delete.bat
    echo rem By bluewing009 for Batch Delete Any File >>%temp%\Force_Delete.bat
    if "%Delete_Path_Type%"=="�ļ���" (
    echo for /f "usebackq delims=" %%%%j in ^(`"dir /a /b /s "!Delete_Path!\*.*" 2>nul"`^) do ^( >>%temp%\Force_Delete.bat
    echo  echo y^|cacls "%%%%j" /g everyone:f^>nul 2^>nul>>%temp%\Force_Delete.bat
    echo ^)>>%temp%\Force_Delete.bat
    echo rd /s/q "%Delete_Path%"^>nul 2^>nul>>%temp%\Force_Delete.bat   
    )
    if "%Delete_Path_Type%"=="�ļ�" (
    echo echo y^|cacls "!Delete_Path!" /g everyone:f^>nul 2^>nul>>%temp%\Force_Delete.bat
    echo del /f/s/q "%Delete_Path%"^>nul 2^>nul>>%temp%\Force_Delete.bat
    )
    echo if exist "%Delete_Path%" ^( >>%temp%\Force_Delete.bat
    echo     echo.>>%temp%\Force_Delete.bat
    echo     echo.>>%temp%\Force_Delete.bat
    echo     echo                    ǿ��ɾ��ʧ��>>%temp%\Force_Delete.bat
    echo ^) else ^( >>%temp%\Force_Delete.bat
    echo     echo.>>%temp%\Force_Delete.bat
    echo     echo.>>%temp%\Force_Delete.bat
    echo     echo                    ǿ��ɾ���ɹ�>>%temp%\Force_Delete.bat
    echo ^)>>%temp%\Force_Delete.bat
    echo reg delete HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run /v Force_Delete /f ^>nul 2^>nul>>%temp%\Force_Delete.bat
    echo ping /n 5 127.1^>nul>>%temp%\Force_Delete.bat
    echo del /f/s/q %%0>>%temp%\Force_Delete.bat
    echo exit>>%temp%\Force_Delete.bat
    reg add HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run /v Force_Delete /t REG_SZ /d "%temp%\Force_Delete.bat" /f >nul
    cls
    echo.
    echo               ����а�ȫ������ʾ
    echo.
    echo        ��������� ��Force_Delete�� ������
    ping /n 3 127.1>nul
    cls
    for /f "usebackq tokens=2 delims=:" %%i in (`"reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run" 2>nul"^|findstr /i Force_Delete`) do (
        if exist "%temp%\Force_Delete.bat" (
            for /f "tokens=2 delims=:" %%j in ('echo %temp%\Force_Delete.bat') do (
                if "%%i"=="%%j" set mark_=����
            )
        )
    )
    if "!mark_!"=="δ����" (
        echo.
        echo.
        echo                    ʧ�ܣ�������
        ping /n 3 127.1>nul
        goto Force_Delete
    )
    if "!mark_!"=="����" (
        echo.
        echo.
        echo                  �ɹ�������������
        ping /n 3 127.1>nul
        goto Main
    )
) else (
    cls
    echo.
    echo.
    echo                      ɾ���ɹ�
    ping /n 3 127.1>nul
    goto Main
)



:Login_Message_Send
Title ϵͳ��¼֪ͨ
cls
set mark_exist=δ����
for /f "usebackq tokens=2 delims=:" %%i in (`"reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run" 2>nul"^|findstr /i Login_message_send`) do (
    if exist "%windir%\System32\send.bat" (
        if "%%i"=="\winsows\system32\Login_message_send.vbs" set mark_exist=����
    )
)
echo.
echo             ��ϵͳ��¼ʱ���Զ���IP�����ڵط��͵�ָ��������
echo.
echo      �Ƽ�ʹ�� tom ���䲢��ͨ�������ʡ����ܣ���ѣ��������ʹ��ֻ�
echo.
echo             �����ȫ�����ʾ����������䶯����ѡ��ͨ��
echo.&&echo.
echo                   ��ǰ״̬�� %mark_exist%
echo.
if "%mark_exist%"=="δ����" (
    echo.
    echo                    A.  ���õ�¼֪ͨ   
    echo.
)
if "%mark_exist%"=="����" (
    echo.
    echo         A. �������õ�¼֪ͨ       B. �鿴����
    echo.
    echo         C. ȡ����¼֪ͨ           D. ��������
    echo.
)
echo                    Q.  �������˵�
echo.
set choose=~
set /p choose=��ѡ��
if "%mark_exist%"=="δ����" (
    if /I %choose%==a goto Login_Message_send_Do
)
if "%mark_exist%"=="����" (
    if /I %choose%==a goto Login_Message_send_Do
    if /I %choose%==b goto Login_Message_send_Check
    if /I %choose%==c goto Login_Message_Send_Cancle
    if /I %choose%==d goto Login_Message_Send_Test
)
if /I %choose%==q goto Main
if /I %choose%==~ (
    echo.
    echo                         ��Ч��ѡ�����������
    ping /n 2 127.1>nul
    goto Login_message_send
    exit
)
echo.
echo                         ��Ч��ѡ�����������
ping /n 2 127.1>nul
goto Login_message_send

:Login_Message_Send_Do
Mode con cols=50 lines=10
:Login_Message_Send_Do_Name
cls
echo.
set /p m=��������յ�����:
if "%m%"=="" goto Login_Message_Send_Do_Name
if not "%m:~-4,4%"==".com" (
    echo.
    echo �����ʽ�������������롣
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
echo  �����¼���û���: %n%
echo.
echo        �����������smtp.%s%
ping /n 5 127.1>nul
:Login_Message_Send_Do_Password
cls
echo.
set /p p=�����������¼������:
if "%p%"=="" (
    echo.
    echo ������Ч�����������롣
    ping /n 3 127.1>nul
    goto Login_Message_Send_Do_Password
)
echo ���յ�����: %m%>"%windir%\System32\send.txt"
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
echo for /f "tokens=3,6,7 delims=<> " %%%%1 in ('findstr /r "�ٷ����ݲ�ѯ���" ip.txt') do ( >>"%windir%\System32\send.bat"
echo     set ip=%%%%1 >>"%windir%\System32\send.bat"
echo     set address=%%%%2 %%%%3 >>"%windir%\System32\send.bat"
echo )>>"%windir%\System32\send.bat"
echo echo On Error Resume Next^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo f="%m%"^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo smtp="smtp.%s%"^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo u="%n%"^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo p="%p%"^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo t="%m%"^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo m="ϵͳ��¼��¼:  ����IP:  %%ip%% ����λ�ã� %%address%%"^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo msg="ϵͳ��¼��¼ BY bluewing009 ����ϵͳ"^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
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
    echo                      ����ʧ��
    echo.
    echo                        ����
    ping /n 3 127.1>nul
    goto Login_Message_Send
)
if %errorlevel%==0 (
    echo.&&echo.
    echo                      ���óɹ�
    echo.
    echo                 �Ƿ��������״̬ ��
    echo.
    echo               Y ��ʼ  �������������˵�
    echo.
    set choose=~
    set /p choose=��ѡ��
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
    echo                      ȡ��ʧ��
    echo.
    echo                        ����
    ping /n 3 127.1>nul
    goto Login_Message_Send
)
if %errorlevel%==0 (
    echo.&&echo.
    echo                      ȡ���ɹ�
    echo.
    echo                     �������˵�
    ping /n 3 127.1>nul
    goto Main
)

:Login_Message_Send_Test
Mode con cols=50 lines=10
echo.
echo                    ���ڷ����ʼ�
echo.
echo                    ...���Ժ�...
call "%windir%\System32\send.bat"
echo.
echo                        �ɹ�
echo.
echo                    ���¼����鿴
ping /n 3 127.1>nul
goto Main



:MBR_Backup_Recovery
Mode con cols=70 lines=20
Title Ӳ����������¼����/�ָ�
cls
set mark_exist=δ����
if exist %SystemRoot%\System32\MBR����.bin set mark_exist=�ѱ���
echo.
echo                        ����/�ָ�Ӳ����������¼
echo.
echo             ����Ӧ���ָ��쳣�򲡶���ɵ���������¼�쳣
echo.
echo                      �����ʾ�޸ģ���ѡ�񡰺��ԡ�
echo.
echo.
echo                        ��ǰ״̬�� %mark_exist%
echo.
if "%mark_exist%"=="δ����" (
    echo.
    echo                         A.  ����Ӳ��������¼  
    echo.
)
if "%mark_exist%"=="�ѱ���" (
    echo.
    echo                 A. ���±���       B. �ָ�Ӳ��������¼ 
    echo.
    echo.
)
echo                         Q.  �������˵�
echo.
set choose=~
set /p choose=��ѡ��
if "%mark_exist%"=="δ����" (
    if /I %choose%==a goto MBR_Backup
)
if "%mark_exist%"=="�ѱ���" (
    if /I %choose%==a goto MBR_Backup
    if /I %choose%==b goto MBR_Recovery
)
if /I %choose%==q goto Main
if /I %choose%==~ (
    echo.
    echo                         ��Ч��ѡ�����������
    ping /n 2 127.1>nul
    goto MBR_Backup_Recovery
    exit
)
echo.
echo                         ��Ч��ѡ�����������
ping /n 2 127.1>nul
goto MBR_Backup_Recovery

:MBR_Backup
Mode con cols=50 lines=10
cls
echo.
echo.
echo.
echo        ...���ڱ���...
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
echo n %SystemRoot%\System32\MBR����.bin>>%temp%\mbr_backup.code
echo w >>%temp%\mbr_backup.code
echo q >>%temp%\mbr_backup.code
debug<%temp%\mbr_backup.code >nul 2>nul
graftabl 936>nul 2>nul
if exist %SystemRoot%\System32\MBR����.bin (
    cacls " %SystemRoot%\System32\MBR����.bin" /d everyone /e>nul 2>nul
    echo.
    echo.
    echo                     ���ݳɹ�
    echo.
    echo              �����ļ��ѱ���ȫ����
) else (
    echo.
    echo.
    echo                δ֪���󣬱���ʧ��
)
ping /n 2 127.1>nul
goto Main

:MBR_Recovery
Mode con cols=50 lines=10
cls
echo.
echo.
echo.
echo                  ...���ڻָ�...
echo y|cacls "%SystemRoot%\System32\MBR����.bin" /g everyone:f>nul
echo n %SystemRoot%\System32\MBR����.bin >%temp%\mbr_restoration.code
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
echo                     �ָ��ɹ�
ping /n 2 127.1>nul
goto Main



:Virus_Immune
Mode con cols=70 lines=20
Title �������߹���
cls
set /a NO.=0
set /a NEW_NO.=0
echo.
echo.
echo                                  ͨ��
echo.
echo                      �����ļ���  ��  ���ʿ����б�
echo.
echo                           �ﵽ���߲���������
echo.
echo.
echo                        Q �������˵�  ����������
echo.
set choose=~
set /p choose=��ѡ��
if /I %choose%==q goto main
cls
echo.
echo.
echo.
echo                               �� �� �� ��
echo.
echo                           ......���Ժ�......
::���𲡶�
if not exist "%commonprogramfiles%\Microsoft Shared\MSInfo\06E3DD06.DAT\��Ӱ��������       �����𲡶���" (
    if exist "%commonprogramfiles%\Microsoft Shared\MSInfo\06E3DD06.DAT" del /f/s/q"%commonprogramfiles%\Microsoft Shared\MSInfo\06E3DD06.DAT">nul 2>nul
    md "%commonprogramfiles%\Microsoft Shared\MSInfo\06E3DD06.DAT\��Ӱ��������       �����𲡶���"
    md "%commonprogramfiles%\Microsoft Shared\MSInfo\06E3DD06.DAT\��Ӱ��������       �����𲡶���\��������..\"
    attrib "%commonprogramfiles%\Microsoft Shared\MSInfo\06E3DD06.DAT" +S +R +H
    cacls "%commonprogramfiles%\Microsoft Shared\MSInfo\06E3DD06.DAT\��Ӱ��������       �����𲡶���" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1

if not exist "%commonprogramfiles%\Microsoft Shared\MSInfo\06E3DD06.DLL\��Ӱ��������       �����𲡶���" (
    if exist "%commonprogramfiles%\Microsoft Shared\MSInfo\06E3DD06.DLL" del /f/s/q "C:\Program Files\Common Files\Microsoft Shared\MSInfo\06E3DD06.DLL">nul 2>nul
    md "%commonprogramfiles%\Microsoft Shared\MSInfo\06E3DD06.DLL\��Ӱ��������       �����𲡶���"
    md "%commonprogramfiles%\Microsoft Shared\MSInfo\06E3DD06.DLL\��Ӱ��������       �����𲡶���\��������..\"
    attrib "%commonprogramfiles%\Microsoft Shared\MSInfo\06E3DD06.DLL" +S +R +H
    cacls "%commonprogramfiles%\Microsoft Shared\MSInfo\06E3DD06.DLL\��Ӱ��������       �����𲡶���" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1

if not exist "%systemroot%\HELP\06E3DD06.CHM\��Ӱ��������       �����𲡶���" (
    if exist "%systemroot%\HELP\06E3DD06.CHM" del /f/s/q "%systemroot%\HELP\06E3DD06.CHM">nul 2>nul
    md "%systemroot%\HELP\06E3DD06.CHM\��Ӱ��������       �����𲡶���"
    md "%systemroot%\HELP\06E3DD06.CHM\��Ӱ��������       �����𲡶���\��������..\"
    attrib "%systemroot%\HELP\06E3DD06.CHM" +S +R +H
    cacls "%systemroot%\HELP\06E3DD06.CHM\��Ӱ��������       �����𲡶���" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1

if not exist "%SystemRoot%\rundl132.exe\��Ӱ��������       �����𲡶���" (
    if exist "%SystemRoot%\rundl132.exe" del /f/s/q "%SystemRoot%\rundl132.exe">nul 2>nul
    md "%SystemRoot%\rundl132.exe\��Ӱ��������       �����𲡶���"
    md "%SystemRoot%\rundl132.exe\��Ӱ��������       �����𲡶���\��������..\"
    attrib "%SystemRoot%\rundl132.exe" +S +R +H
    cacls "%SystemRoot%\rundl132.exe\��Ӱ��������       �����𲡶���" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1

if not exist "%SystemRoot%\logo_1.exe\��Ӱ��������       �����𲡶���" (
    if exist "%SystemRoot%\logo_1.exe" del /f/s/q "%SystemRoot%\logo_1.exe">nul 2>nul
    md "%SystemRoot%\logo_1.exe\��Ӱ��������       �����𲡶���"
    md "%SystemRoot%\logo_1.exe\��Ӱ��������       �����𲡶���\��������..\"
    attrib "%SystemRoot%\logo_1.exe" +S +R +H
    cacls "%SystemRoot%\logo_1.exe\��Ӱ��������       �����𲡶���" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1

if not exist "%SystemRoot%\Sy.exe\��Ӱ��������       �����𲡶���" (
    if exist "%SystemRoot%\Sy.exe" del /f/s/q "%SystemRoot%\Sy.exe">nul 2>nul
    md "%SystemRoot%\Sy.exe\��Ӱ��������       �����𲡶���"
    md "%SystemRoot%\Sy.exe\��Ӱ��������       �����𲡶���\��������..\"
    attrib "%SystemRoot%\Sy.exe" +S +R +H
    cacls "%SystemRoot%\Sy.exe\��Ӱ��������       �����𲡶���" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1

for /l %%i in (0,1,9) do (
    if not exist "%SystemRoot%\%%iSy.exe\��Ӱ��������       �����𲡶���" (
        if exist "%SystemRoot%\%%iSy.exe" del /f/s/q "%SystemRoot%\%%iSy.exe">nul 2>nul
        md "%SystemRoot%\%%iSy.exe\��Ӱ��������       �����𲡶���"
        md "%SystemRoot%\%%iSy.exe\��Ӱ��������       �����𲡶���\��������..\"
        attrib "%SystemRoot%\%%iSy.exe" +S +R +H
        cacls "%SystemRoot%\%%iSy.exe\��Ӱ��������       �����𲡶���" /d everyone /e>nul 2>nul
        set /a NEW_NO.+=1
    )
    set /a NO.+=1
)



::Trojan-PSW.Win32.QQPass.vm����
if not exist "%programfiles%\Internet Explorer\PLUGINS\SystemKb.bak\��Ӱ��������       ��Trojan-PSW.Win32.QQPass.vm������" (
    if exist "%programfiles%\Internet Explorer\PLUGINS\SystemKb.bak" del /f/s/q "%programfiles%\Internet Explorer\PLUGINS\SystemKb.bak">nul 2>nul
    md "%programfiles%\Internet Explorer\PLUGINS\SystemKb.bak\��Ӱ��������       ��Trojan-PSW.Win32.QQPass.vm������"
    md "%programfiles%\Internet Explorer\PLUGINS\SystemKb.bak\��Ӱ��������       ��Trojan-PSW.Win32.QQPass.vm������\��������..\"
    attrib "%programfiles%\Internet Explorer\PLUGINS\SystemKb.bak" +S +R +H
    cacls "%programfiles%\Internet Explorer\PLUGINS\SystemKb.bak\��Ӱ��������       ��Trojan-PSW.Win32.QQPass.vm������" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1

if not exist "%programfiles%\Internet Explorer\PLUGINS\SystemKb.sys\��Ӱ��������       ��Trojan-PSW.Win32.QQPass.vm������" (
    if exist "%programfiles%\Internet Explorer\PLUGINS\SystemKb.sys" del /f/s/q "%programfiles%\Internet Explorer\PLUGINS\SystemKb.sys">nul 2>nul
    md "%programfiles%\Internet Explorer\PLUGINS\SystemKb.sys\��Ӱ��������       ��Trojan-PSW.Win32.QQPass.vm������"
    md "%programfiles%\Internet Explorer\PLUGINS\SystemKb.sys\��Ӱ��������       ��Trojan-PSW.Win32.QQPass.vm������\��������..\"
    attrib "%programfiles%\Internet Explorer\PLUGINS\SystemKb.sys" +S +R +H
    cacls "%programfiles%\Internet Explorer\PLUGINS\SystemKb.sys\��Ӱ��������       ��Trojan-PSW.Win32.QQPass.vm������" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1

if not exist "%programfiles%\Internet Explorer\PLUGINS\system2.jmp\��Ӱ��������       ��Trojan-PSW.Win32.QQPass.vm������" (
    if exist "%programfiles%\Internet Explorer\PLUGINS\system2.jmp" del /f/s/q "%programfiles%\Internet Explorer\PLUGINS\system2.jmp">nul 2>nul
    md "%programfiles%\Internet Explorer\PLUGINS\system2.jmp\��Ӱ��������       ��Trojan-PSW.Win32.QQPass.vm������"
    md "%programfiles%\Internet Explorer\PLUGINS\system2.jmp\��Ӱ��������       ��Trojan-PSW.Win32.QQPass.vm������\��������..\"
    attrib "%programfiles%\Internet Explorer\PLUGINS\system2.jmp" +S +R +H
    cacls "%programfiles%\Internet Explorer\PLUGINS\system2.jmp\��Ӱ��������       ��Trojan-PSW.Win32.QQPass.vm������" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1

if not exist "%WINDOWS%\intrenat.exe\��Ӱ��������       ��Trojan-PSW.Win32.QQPass.vm������" (
    if exist "%WINDOWS%\intrenat.exe" del /f/s/q "%WINDOWS%\intrenat.exe">nul 2>nul
    md "%WINDOWS%\intrenat.exe\��Ӱ��������       ��Trojan-PSW.Win32.QQPass.vm������"
    md "%WINDOWS%\intrenat.exe\��Ӱ��������       ��Trojan-PSW.Win32.QQPass.vm������\��������..\"
    attrib "%WINDOWS%\intrenat.exe" +S +R +H
    cacls "%WINDOWS%\intrenat.exe\��Ӱ��������       ��Trojan-PSW.Win32.QQPass.vm������" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1

if not exist "%SYSTEM%\WinSocks.dll\��Ӱ��������       ��Trojan-PSW.Win32.QQPass.vm������" (
    if exist "%SYSTEM%\WinSocks.dll" del /f/s/q "%SYSTEM%\WinSocks.dll">nul 2>nul
    md "%SYSTEM%\WinSocks.dll\��Ӱ��������       ��Trojan-PSW.Win32.QQPass.vm������"
    md "%SYSTEM%\WinSocks.dll\��Ӱ��������       ��Trojan-PSW.Win32.QQPass.vm������\��������..\"
    attrib "%SYSTEM%\WinSocks.dll" +S +R +H
    cacls "%SYSTEM%\WinSocks.dll\��Ӱ��������       ��Trojan-PSW.Win32.QQPass.vm������" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1

if not exist "%WINDOWS%\exp1orer.dll\��Ӱ��������       ��Trojan-PSW.Win32.QQPass.vm������" (
    if exist "%WINDOWS%\exp1orer.dll" del /f/s/q "%WINDOWS%\exp1orer.dll">nul 2>nul
    md "%WINDOWS%\exp1orer.dll\��Ӱ��������       ��Trojan-PSW.Win32.QQPass.vm������"
    md "%WINDOWS%\exp1orer.dll\��Ӱ��������       ��Trojan-PSW.Win32.QQPass.vm������\��������..\"
    attrib "%WINDOWS%\exp1orer.dll" +S +R +H
    cacls "%WINDOWS%\exp1orer.dll\��Ӱ��������       ��Trojan-PSW.Win32.QQPass.vm������" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1



::����ľ������������Gameservet.exe
if not exist "%temp%\RAVWM.exe\��Ӱ��������       ������ľ��������������" (
    if exist "%temp%\RAVWM.exe" dle /f/s/q "%temp%\RAVWM.exe">nul 2>nul
    md "%temp%\RAVWM.exe\��Ӱ��������       ������ľ��������������"
    md "%temp%\RAVWM.exe\��Ӱ��������       ������ľ��������������\��������..\"
    attrib "%temp%\RAVWM.exe" +S +R +H
    cacls "%temp%\RAVWM.exe\��Ӱ��������       ������ľ��������������" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1

if not exist "%temp%\qjso.exe\��Ӱ��������       ������ľ��������������" (
    if exist "%temp%\qjso.exe" del /f/s/q "%temp%\qjso.exe">nul 2>nul
    md "%temp%\qjso.exe\��Ӱ��������       ������ľ��������������"
    md "%temp%\qjso.exe\��Ӱ��������       ������ľ��������������\��������..\"
    attrib "%temp%\qjso.exe" +S +R +H
    cacls "%temp%\qjso.exe\��Ӱ��������       ������ľ��������������" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1

if not exist "%systemroot%\system32\8888-521ww.exe\��Ӱ��������       ������ľ��������������" (
    if exist "%systemroot%\system32\8888-521ww.exe" del /f/s/q "%systemroot%\system32\8888-521ww.exe">nul 2>nul
    md "%systemroot%\system32\8888-521ww.exe\��Ӱ��������       ������ľ��������������"
    md "%systemroot%\system32\8888-521ww.exe\��Ӱ��������       ������ľ��������������\��������..\"
    attrib "%systemroot%\system32\8888-521ww.exe" +S +R +H
    cacls "%systemroot%\system32\8888-521ww.exe\��Ӱ��������       ������ľ��������������" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1

for /l %%i in (0,1,9) do (
    if not exist "%systemroot%\system32\game%%i.exe\��Ӱ��������       ������ľ��������������" (
        if exist "%systemroot%\system32\game%%i.exe" del /f/s/q "%systemroot%\system32\game%%i.exe">nul 2>nul
        md "%systemroot%\system32\game%%i.exe\��Ӱ��������       ������ľ��������������"
        md "%systemroot%\system32\game%%i.exe\��Ӱ��������       ������ľ��������������\��������..\"
        attrib "%systemroot%\system32\game%%i.exe" +S +R +H
        cacls "%systemroot%\system32\game%%i.exe\��Ӱ��������       ������ľ��������������" /d everyone /e>nul 2>nul
        set /a NEW_NO.+=1
    )
    set /a NO.+=1
)

if not exist "%systemroot%\system32\nwizqqfo.dll\��Ӱ��������       ������ľ��������������" (
    if exist "%systemroot%\system32\nwizqqfo.dll" del /f/s/q "%systemroot%\system32\nwizqqfo.dll">nul 2>nul
    md "%systemroot%\system32\nwizqqfo.dll\��Ӱ��������       ������ľ��������������"
    md "%systemroot%\system32\nwizqqfo.dll\��Ӱ��������       ������ľ��������������\��������..\"
    attrib "%systemroot%\system32\nwizqqfo.dll" +S +R +H
    cacls "%systemroot%\system32\nwizqqfo.dll\��Ӱ��������       ������ľ��������������" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1

if not exist "%systemroot%\system32\gameservet.exe\��Ӱ��������       ������ľ��������������" (
    if exist "%systemroot%\system32\gameservet.exe" del /f/s/q "%systemroot%\system32\gameservet.exe">nul 2>nul
    md "%systemroot%\system32\gameservet.exe\��Ӱ��������       ������ľ��������������"
    md "%systemroot%\system32\gameservet.exe\��Ӱ��������       ������ľ��������������\��������..\"
    attrib "%systemroot%\system32\gameservet.exe" +S +R +H
    cacls "%systemroot%\system32\gameservet.exe\��Ӱ��������       ������ľ��������������" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1



::Trojan/Win32.IEprot.jdo����
for /l %%i in (0,1,9) do (
    if not exist "%temp%\[%%i].gif\��Ӱ��������       ��Trojan/Win32.IEprot������" (
        if exist "%temp%\[%%i].gif" del /f/s/q "%temp%\[%%i].gif">nul 2>nul
        md "%temp%\[%%i].gif\��Ӱ��������       ��Trojan/Win32.IEprot������"
        md "%temp%\[%%i].gif\��Ӱ��������       ��Trojan/Win32.IEprot������\��������..\"
        attrib "%temp%\[%%i].gif" +S +R +H
        cacls "%temp%\[%%i].gif\��Ӱ��������       ��Trojan/Win32.IEprot������" /d everyone /e>nul 2>nul
        set /a NEW_NO.+=1
    )
    set /a NO.+=1
)



::Backdoor.Win32.Agent.ahj
for /l %%i in (0,1,9) do (
    if not exist "%temp%\db_%%i.exe\��Ӱ��������       ��Backdoor.Win32.Agent.ahj������" (
        if exist "%temp%\db_%%i.exe" del /f /s/q "%temp%\db_%%i.exe"
        md "%temp%\db_%%i.exe\��Ӱ��������       ��Backdoor.Win32.Agent.ahj������"
        md "%temp%\db_%%i.exe\��Ӱ��������       ��Backdoor.Win32.Agent.ahj������\��������..\"
        attrib "%temp%\db_%%i.exe" +S +R +H
        cacls "%temp%\db_%%i.exe\��Ӱ��������       ��Backdoor.Win32.Agent.ahj������" /d everyone /e>nul 2>nul
        set /a NEW_NO.+=1
    )
    set /a NO.+=1
)

if not exist "%system32%\92219FBE.DLL\��Ӱ��������       ��Backdoor.Win32.Agent.ahj������" (
    if exist "%system32%\92219FBE.DLL" del /f /s/q "%system32%\92219FBE.DLL"
    md "%system32%\92219FBE.DLL\��Ӱ��������       ��Backdoor.Win32.Agent.ahj������"
    md "%system32%\92219FBE.DLL\��Ӱ��������       ��Backdoor.Win32.Agent.ahj������\��������..\"
    attrib "%system32%\92219FBE.DLL" +S +R +H
    cacls "%system32%\92219FBE.DLL\��Ӱ��������       ��Backdoor.Win32.Agent.ahj������" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1

if not exist "%system32%\92219FBE.exe\��Ӱ��������       ��Backdoor.Win32.Agent.ahj������" (
    if exist "%system32%\92219FBE.exe" del /f /s/q "%system32%\92219FBE.exe"
    md "%system32%\92219FBE.exe\��Ӱ��������       ��Backdoor.Win32.Agent.ahj������"
    md "%system32%\92219FBE.exe\��Ӱ��������       ��Backdoor.Win32.Agent.ahj������\��������..\"
    attrib "%system32%\92219FBE.exe" +S +R +H
    cacls "%system32%\92219FBE.exe\��Ӱ��������       ��Backdoor.Win32.Agent.ahj������" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1

if not exist "%system32%\92219FBET.exe\��Ӱ��������       ��Backdoor.Win32.Agent.ahj������" (
    if exist "%system32%\92219FBET.exe" del /f /s/q "%system32%\92219FBET.exe"
    md "%system32%\92219FBET.exe\��Ӱ��������       ��Backdoor.Win32.Agent.ahj������"
    md "%system32%\92219FBET.exe\��Ӱ��������       ��Backdoor.Win32.Agent.ahj������\��������..\"
    attrib "%system32%\92219FBET.exe" +S +R +H
    cacls "%system32%\92219FBET.exe\��Ӱ��������       ��Backdoor.Win32.Agent.ahj������" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1

for /l %%i in (0,1,9) do (
    if not exist "%HOMEPATH%\Local Settings\Temporary Internet Files\Content.IE5\CHUFWD67\i[%%i].exe\��Ӱ��������       ��Backdoor.Win32.Agent.ahj������" (
        if exist "%HOMEPATH%\Local Settings\Temporary Internet Files\Content.IE5\CHUFWD67\i[%%i].exe" del /f /s/q "%HOMEPATH%\Local Settings\Temporary Internet Files\Content.IE5\CHUFWD67\i[%%i].exe"
        md "%HOMEPATH%\Local Settings\Temporary Internet Files\Content.IE5\CHUFWD67\i[%%i].exe\��Ӱ��������       ��Backdoor.Win32.Agent.ahj������"
        md "%HOMEPATH%\Local Settings\Temporary Internet Files\Content.IE5\CHUFWD67\i[%%i].exe\��Ӱ��������       ��Backdoor.Win32.Agent.ahj������\��������..\"
        attrib "%HOMEPATH%\Local Settings\Temporary Internet Files\Content.IE5\CHUFWD67\i[%%i].exe" +S +R +H
        cacls "%HOMEPATH%\Local Settings\Temporary Internet Files\Content.IE5\CHUFWD67\i[%%i].exe\��Ӱ��������       ��Backdoor.Win32.Agent.ahj������" /d everyone /e>nul 2>nul
        set /a NEW_NO.+=1
    )
    set /a NO.+=1
)



::����U�̲���
if not exist "%Temp%\testexe.exe\��Ӱ��������       ������U�̲�����" (
    if exist "%Temp%\testexe.exe" del /f/s/q "%Temp%\testexe.exe"
    md "%Temp%\testexe.exe\��Ӱ��������       ������U�̲�����"
    md "%Temp%\testexe.exe\��Ӱ��������       ������U�̲�����\��������..\"
    attrib "%Temp%\testexe.exe" +S +R +H
    cacls "%Temp%\testexe.exe\��Ӱ��������       ������U�̲�����" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1

if not exist "%Temp%\testexe.dll\��Ӱ��������       ������U�̲�����" (
    if exist "%Temp%\testexe.dll" del /f/s/q "%Temp%\testexe.dll"
    md "%Temp%\testexe.dll\��Ӱ��������       ������U�̲�����"
    md "%Temp%\testexe.dll\��Ӱ��������       ������U�̲�����\��������..\"
    attrib "%Temp%\testexe.dll" +S +R +H
    cacls "%Temp%\testexe.dll\��Ӱ��������       ������U�̲�����" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1



::woso.exe
if not exist "%Temp%\woso.exe\��Ӱ��������       ��woso.exe������" (
    if exist "%Temp%\woso.exe" del /f/s/q "%Temp%\woso.exe"
    md "%Temp%\woso.exe\��Ӱ��������       ��woso.exe������"
    md "%Temp%\woso.exe\��Ӱ��������       ��woso.exe������\��������..\"
    attrib "%Temp%\woso.exe" +S +R +H
    cacls "%Temp%\woso.exe\��Ӱ��������       ��woso.exe������" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1



::������漰����֣�Dasher.B��
for /l %%i in (0,1,9) do (
    if not exist "%systemroot%\system32\Sqlexp%%i.exe\��Ӱ��������       ��������漰����� Dasher.B��" (
        if exist "%systemroot%\system32\Sqlexp%%i.exe" del /f /s/q "%systemroot%\system32\Sqlexp%%i.exe"
        md "%systemroot%\system32\Sqlexp%%i.exe\��Ӱ��������       ��������漰����� Dasher.B��"
        md "%systemroot%\system32\Sqlexp%%i.exe\��Ӱ��������       ��������漰����� Dasher.B��\��������..\"
        attrib "%systemroot%\system32\Sqlexp%%i.exe" +S +R +H
        cacls "%systemroot%\system32\Sqlexp%%i.exe\��Ӱ��������       ��������漰����� Dasher.B��" /d everyone /e>nul 2>nul
        set /a NEW_NO.+=1
    )
    set /a NO.+=1
)

if not exist "%systemroot%\system32\Sqlexp.exe\��Ӱ��������       ��������漰����� Dasher.B��" (
    if exist "%systemroot%\system32\Sqlexp.exe" del /f/s/q "%systemroot%\system32\Sqlexp.exe"
    md "%systemroot%\system32\Sqlexp.exe\��Ӱ��������       ��������漰����� Dasher.B��"
    md "%systemroot%\system32\Sqlexp.exe\��Ӱ��������       ��������漰����� Dasher.B��\��������..\"
    attrib "%systemroot%\system32\Sqlexp.exe" +S +R +H
    cacls "%systemroot%\system32\Sqlexp.exe\��Ӱ��������       ��������漰����� Dasher.B��" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1

if not exist "%systemroot%\system32\Sqlscan.exe\��Ӱ��������       ��������漰����� Dasher.B��" (
    if exist "%systemroot%\system32\Sqlscan.exe" del /f/s/q "%systemroot%\system32\Sqlscan.exe"
    md "%systemroot%\system32\Sqlscan.exe\��Ӱ��������       ��������漰����� Dasher.B��"
    md "%systemroot%\system32\Sqlscan.exe\��Ӱ��������       ��������漰����� Dasher.B��\��������..\"
    attrib "%systemroot%\system32\Sqlscan.exe" +S +R +H
    cacls "%systemroot%\system32\Sqlscan.exe\��Ӱ��������       ��������漰����� Dasher.B��" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1

if not exist "%systemroot%\system32\Sqltob.exe\��Ӱ��������       ��������漰����� Dasher.B��" (
    if exist "%systemroot%\system32\Sqltob.exe" del /f/s/q "%Temp%\Sqltob.exe"
    md "%systemroot%\system32\Sqltob.exe.exe\��Ӱ��������       ��������漰����� Dasher.B��"
    md "%systemroot%\system32\Sqltob.exe.exe\��Ӱ��������       ��������漰����� Dasher.B��\��������..\"
    attrib "%systemroot%\system32\Sqltob.exe.exe" +S +R +H
    cacls "%systemroot%\system32\Sqltob.exe\��Ӱ��������       ��������漰����� Dasher.B��" /d everyone /e>nul 2>nul
    set /a NEW_NO.+=1
)
set /a NO.+=1





cls
echo.
echo                                  ͳ  ��
echo.
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo.
echo          �����ߣ�%NO.% ������          �����������ߣ�%NEW_NO.% ������
echo.
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo.
echo.
echo                            ������������˵�
pause>nul
goto Main



:System_Garbage_clean
Mode con cols=50 lines=10
Title ����ϵͳ����
for %%x in (
    "��������Recent�ļ���     : %APPDATA%\Microsoft\Windows\Recent"
    "�û���ʱ�ļ���           : %temp%"
    "Windows��ʱĿ¼          : %windir%\temp"
    "�����صĳ���             : %windir%\download program files"
    "windowsԤ��              : %windir%\prefetch"
    "windows���²���          : %windir%\softwaredistribution\download"
    "�ڴ�ת���ļ�             : %windir%\Minidump"
    "office ��װ����          : %SYSTEMDRIVE%\MSOCache" 
    "IE��ʱ�ļ���             : %userprofile%\Local Settings\Temporary Internet Files"
) do (
    for /f "tokens=1,* delims=:" %%i in ("%%x") do (
        set name_temp=%%i
        set name_=!name_temp:~1,-1!
        set path_temp=%%j
        set path_=!path_temp:~1,-1!
        if exist "!path_!" for /f "tokens=3" %%i in ('dir /a /s /-c "!path_!" ^|findstr "���ļ�"') do set size_=%%i
        set /a size+=!size_!
        cls  
        echo.
        echo.
        echo.
        echo ��������  !name_!...
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
echo ������ɣ����ͷſռ� !size_all! MB
ping /n 5 127.1>nul
goto Main



:Registry_Garbage_clean
Mode con cols=50 lines=10
Title ����ϵͳ����
set /a NO.=NO._=0
if %version_mark%==win7 set path_=Documents
if %version_mark%==xp set path_=My Documents
if not exist "%Userprofile%\!path_!\ע���������" md "%Userprofile%\!path_!\ע���������"
pause
if exist "%Userprofile%\!path_!\ע���������\�������.reg" (
    copy /y "%Userprofile%\!path_!\ע���������\�������.reg" "%Userprofile%\!path_!\ע���������\�ɵı���.reg" >nul
    del /f/s/q "%Userprofile%\!path_!\ע���������\�������.reg" >nul
)
reg export "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\SharedDLLs" "%Userprofile%\!path_!\ע���������\�������.reg" >nul
for /F "usebackq skip=%version_skip% tokens=* delims=" %%i in (`" reg query HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\SharedDLLs"`) do call :Registry_Garbage_clean_Analyze "%%i"
ping /n 3 127.1>nul
cls
echo.
echo.
echo.
echo            �������
ping /n 2 127.1>nul
cls
echo.
echo.
echo     ������ɾ������ �ҵ��ĵ�\ע��������� ��
echo.
echo    �������.reg  �ָ�  ���ϴα��ݣ��ɵı���.reg��
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
echo           �Ѽ����Ŀ�� %NO.% 
echo.
echo       ��ɾ��������Ŀ�� %NO._%
goto :eof



:Key_Position_Photograph
Title ϵͳ�ؼ�λ�� system32 �ļ�����
cls
set mark_exist=������
set mark_date=δ֪
if exist "%windir%\System32\system32_Photograph.txt" (
    set mark_exist=����
    for /f "usebackq delims=" %%d in ("%windir%\System32\system32_Photograph.txt") do (
        set /a n+=1
        if !n! EQU 1 set mark_date=%%d
    )
)
echo.
echo            ͨ����ϵͳ�ؼ�Ŀ¼ system32 ���п��ա��Ա�
echo.
echo                  ���㼰ʱ����ϵͳ�ļ��ı仯
echo.
echo.
echo      ��׼��¼��%mark_exist%         ��¼ʱ�䣺%mark_date%
echo.
echo                         ��ǰϵͳʱ�䣺%date%
echo.
echo    ����ѡ�
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo          A.��ʼ�Ա�
echo.
echo          B.�Ե�ǰ��ϵͳ���ã����±�׼��¼
echo.
echo          C.�鿴��׼��¼
echo.
echo          Q.�������˵�
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo.
set choose=~
set /p choose=��ѡ��
if /i %choose%==a goto Key_Position_Photograph_Differ
if /i %choose%==b goto Key_Position_Photograph_Update
if /i %choose%==c goto Key_Position_Photograph_Standard
if /i %choose%==q goto Main
if /i %choose%==~ (
    echo.
    echo                         ��Ч��ѡ�����������
    ping /n 2 127.1>nul
    goto Key_position_Photograph
)
echo.
echo                         ��Ч��ѡ�����������
ping /n 2 127.1>nul
goto Key_position_Photograph

:Key_Position_Photograph_Differ
cls
if not exist "%windir%\System32\system32_Photograph.txt" (
    echo.
    echo.
    echo                         δ���ֱ�׼��¼������¡�
    ping /n 3 127.1>nul
    goto Key_position_Photograph
)
echo %date%>%temp%\mark_mow.txt
dir %windir%\System32\*.*/b >>%temp%\mark_mow.txt
findstr /x /v /g:"%windir%\System32\system32_Photograph.txt" %temp%\mark_mow.txt >%temp%\differ.txt
echo.
echo                                  ��  ��
echo.
echo                            ��ʾ������ļ���
echo.
ping /n 3 127.1>nul
start %temp%\differ.txt
echo.
echo.
echo                 û����ʾ�ļ���˵��ϵͳ�ؼ�λ��δ�����ı�
pause>nul
del /f/q/s %temp%\mark_mow.txt>nul 2>nul
del /f/q/s %temp%\differ.txt>nul 2>nul
goto Key_position_Photograph

:Key_Position_Photograph_Update
cls
echo %date% >"%windir%\System32\system32_Photograph.txt"
dir %windir%\System32\*.*/b >>"%windir%\System32\system32_Photograph.txt"
echo.
echo                             ��׼��¼�Ѹ���
echo.
echo                               ������һ��
ping /n 3 127.1>nul
goto Key_position_Photograph

:Key_Position_Photograph_Standard
cls
if not exist "%windir%\System32\system32_Photograph.txt" (
    echo.
    echo.
    echo                         δ���ֱ�׼��¼������¡�
    pause>nul
    goto Key_position_Photograph
)
start "��׼��¼" "%windir%\System32\system32_Photograph.txt"
goto Key_position_Photograph



:Check_Updates
Mode con cols=50 lines=10
Title ���߸���
set version_New=δ֪
cls
echo.
echo.
echo.
echo                    ���ڼ�����
echo.
echo                    ...���Ժ�...
echo Set oDOM = WScript.GetObject(WScript.Arguments(0)) >%temp%/Updates_.vbs
echo do until oDOM.readyState = "complete" >>%temp%/Updates_.vbs
echo WScript.sleep 200 >>%temp%/Updates_.vbs
echo loop >>%temp%/Updates_.vbs
echo WScript.echo oDOM.documentElement.outerText >>%temp%/Updates_.vbs
cscript //NoLogo /e:vbscript %temp%/Updates_.vbs "http://www.bluewing009.co.cc/�汾���.txt" >%temp%/�汾���.txt 2>nul
for /f %%i in (%temp%\�汾���.txt) do set version_New=%%i
if "%version_New%"=="δ֪" goto Check_Updates_Error
for /f "tokens=1* delims=:" %%i in ('findstr /n .* %0') do if %%i==22 for /f "tokens=5" %%m in ('%%j') do set version_Now=%%m
cls
echo.
echo.
echo         ��ǰ�汾��  %version_Now%
echo.
echo         ���°汾��  %version_New%
echo.
echo.
if %version_Now%==%version_New% (
    echo              �汾���£�����Ҫ����
    ping /n 3 127.1>nul
    goto Main
) else (
echo              �����°汾���Ƿ���£�
echo.
echo              Y ��ʼ����  ����������
    set choose=~
    set /p choose=��ѡ��
    if /I !choose!==Y goto Check_Updates_Do
    goto Main
)

:Check_Updates_Do
cls
echo.
echo.
echo.
echo                    �������ظ���
echo.
echo                    ...���Ժ�...
cscript //NoLogo /e:vbscript %temp%/Updates_.vbs "http://www.bluewing009.co.cc/Դ��.txt">%temp%\ϵͳ��������.bat
echo @echo off>%temp%\ϵͳ��������_����.bat
echo Mode con cols=50 lines=10>>%temp%\ϵͳ��������_����.bat
echo Color 3F>>%temp%\ϵͳ��������_����.bat
echo Title ���߸���>>%temp%\ϵͳ��������_����.bat
echo echo.>>%temp%\ϵͳ��������_����.bat
echo echo.>>%temp%\ϵͳ��������_����.bat
echo echo.>>%temp%\ϵͳ��������_����.bat
echo echo.>>%temp%\ϵͳ��������_����.bat
echo echo                   ...��������...>>%temp%\ϵͳ��������_����.bat
echo ping /n 3 127.1^>nul>>%temp%\ϵͳ��������_����.bat
echo copy /y "%temp%\ϵͳ��������.bat" "%~dp0\%~n0.bat"^>nul >>%temp%\ϵͳ��������_����.bat
echo start "" "%~dp0\%~n0.bat">>%temp%\ϵͳ��������_����.bat
echo Exit>>%temp%\ϵͳ��������_����.bat
start %temp%\ϵͳ��������_����.bat
exit

:Check_Updates_Error
cls
echo.
echo.
echo                 �޷����Ӹ��·�����
echo.
echo                     �����ظ���
ping /n 3 127.1>nul
goto Main 



:Exit
Mode con cols=50 lines=10
Title ��лʹ��
cls
echo.
echo           ллʹ��      o���� _ �ɣ�o
echo.
echo.           ����кõĽ��飬����ϵ��
echo.
echo.
echo         E-Mail:  bluewing009@tom.com
echo             QQ:      961881006
echo.
ping /n 5 127.0.0.1>nul
endlocal
start explorer.exe>nul 2>nul
Exit
