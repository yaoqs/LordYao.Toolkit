reg /?
pause
reg add "HKCR\*\shell\打开" /ve /d "notepad开她"
reg add "HKCR\*\shell\打开\command" /ve /d "notepad.exe \"%%1%\""
pause
@echo ---------------------------------------------
@goto end
 1、鼠标右键桌面空白处，新建菜单中的项目在注册表中的位置 
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Discardable\PostSetup\ShellNew] 

2、鼠标右键文件，弹出的菜单明细在注册表中的位置 
[HKEY_CLASSES_ROOT\*\shellex\ContextMenuHandlers] 

3、鼠标右键文件夹，弹出的菜单明细在注册表中的位置 
[HKEY_CLASSES_ROOT\Directory\shellex\ContextMenuHandlers] 

4、鼠标右键在IE浏览器里，弹出的菜单明细在注册表中的位置 
[HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\MenuExt] 

注意： 
1、某些软件所添加的鼠标右键可能在 
[HKEY_CLASSES_ROOT\Folder\shell] 
[HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers] 
:end
exit