autorun病毒的危害相信中过招的人都有体会。其最大的特点就在于很难清除干净，现在可以提前对系统分区做一次免疫工作，而那些已经中了autorun病毒的用户也能顺便将病毒清除。 
有人曾经使用系统组策略的方法，不过对于初学者来说有点复杂。现在复制以下代码到文本文件中，保存为bat文件即可。 

 
  Quote:
@echo off 
cls 
echo 按 S 键删除Autorun.inf并进行免疫 
echo. 
echo 按 D 键删除免疫程序 
echo. 
echo 按其他任意键退出 
echo. 
echo. 
SET Choice= 
SET /P Choice= 请选择要进行的操作： 
IF /I '%Choice:~0,1%'=='s' GOTO setup 
IF /I '%Choice:~0,1%'=='d' GOTO Delset 
IF /I '%Choice:~0,1%'=='q' GOTO Exit 
exit 
:Setup 
taskkill /im explorer.exe /f 
for %%a in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do @( 
if exist %%a: ( 
rd %%a:\autorun.inf /s /q 
del %%a:\autorun.inf /f /q 
mkdir %%a:\autorun.inf 
mkdir %%a:\autorun.inf\"病毒免疫勿删除../" 
attrib +h +r +s %%a:\autorun.inf 

  ) 
) 
start explorer.exe 
for %%a in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do ( 
if exist %%a:\nul ( 
1.vbs echo msgbox^ "%%a:免疫成功",64,"提示:" 
1.vbs 
) 
) 
del 1.vbs 
echo. 
echo. 
echo 按任意键退出... 
pause nul 
exit 

  :delset 
For %%a In (C D E F G H I J K L M N O P Q R S T U V W X Y Z) Do @( 
If Exist %%a: ( 
rd %%a:\autorun.inf /s /q 

  ) 
) 
echo. 
echo. 
echo 操作完毕，按任意键退出... 
pause nul 
exit 
