����������ݷ�ʽ


����������������VBS���ʵ��


:On Error Resume Next
Sub bat
echo off & cls
echo create_shortcut & pause
start wscript -e:vbs "%~f0"
Exit Sub
End Sub
set WshShell = WScript.CreateObject("WScript.Shell")
strDesktop = WshShell.SpecialFolders("Desktop")
set ShellLink = WshShell.CreateShortcut(strDesktop & "\��ݷ�ʽ.lnk")
ShellLink.TargetPath = WScript.ScriptFullName
ShellLink.WindowStyle = 1
ShellLink.Hotkey = "CTRL+SHIFT+C"
ShellLink.IconLocation = "cmd.exe, 0"
ShellLink.Description = "������������Ŀ�ݷ�ʽ"
ShellLink.WorkingDirectory = strDesktop
ShellLink.Save
