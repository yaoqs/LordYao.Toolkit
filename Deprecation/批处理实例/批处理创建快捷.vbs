批处理创建快捷方式


本程序由批处理结合VBS编程实现


:On Error Resume Next
Sub bat
echo off & cls
echo create_shortcut & pause
start wscript -e:vbs "%~f0"
Exit Sub
End Sub
set WshShell = WScript.CreateObject("WScript.Shell")
strDesktop = WshShell.SpecialFolders("Desktop")
set ShellLink = WshShell.CreateShortcut(strDesktop & "\快捷方式.lnk")
ShellLink.TargetPath = WScript.ScriptFullName
ShellLink.WindowStyle = 1
ShellLink.Hotkey = "CTRL+SHIFT+C"
ShellLink.IconLocation = "cmd.exe, 0"
ShellLink.Description = "由批处理产生的快捷方式"
ShellLink.WorkingDirectory = strDesktop
ShellLink.Save
