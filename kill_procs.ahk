; Kill proccess with vbs wrapper for ahk executable

; Init
Process,Priority,,High
SetBatchLines, -1
#NoTrayIcon
SetWorkingDir, %A_ScriptDir%

; Vars
If !A_IsAdmin {
	Try Run *RunAs %A_ScriptFullPath% %1%
	Catch err {
		MsgBox,16,Proc Killer Error,%	InStr(err.Extra,"The operation was canceled by the user.")
									?	"You denied administrative rights to Proc Killer,n"
									.	"you can not start it without administrative access.`n"
									.	"If this was an accident then please try again."
									:	"Please make sure you have administrative priveledges`n"
									.	"and try again. You can not start it`n"
									.	"without administrative access."
		ExitApp
	}
	ExitApp
}
pVar=%1%
vbsFile:="kill_proc.vbs"
If !pVar
	ExitApp
vbsText=
(
Option Explicit
Dim fsObj,strFile,UB,cmd
Set fsObj = CreateObject("Scripting.FileSystemObject")
If (fsObj.FileExists(WScript.Arguments.Item(0))) Then
	Dim exe
	exe = WScript.Arguments.Item(0)
End If
If (WScript.Arguments.Count < 1 Or IsEmpty(exe)) Then
	WScript.Quit
End If
strFile = Split(exe, "\")
UB = UBound(strFile)
exe = strfile(UB)
cmd = "cmd /c taskkill /im """ & exe & """ /f"
CreateObject("WScript.Shell").Run cmd, 0, True
)

; Run
OnExit, CleanUp
If !FileExist(vbsFile)
	FileAppend,%vbsText%,%vbsFile%
Try, RunWait, "%vbsFile%" "%pVar%",,UseErrorLevel
Catch vbsErr {
	MsgBox % ErrorArray(vbsErr,1)
	ExitApp
}
Return

; Functions
ErrorArray(var,format:=0){
	n:="NA"
	arr:=[var.Message?var.Message:n
			,var.What?var.What:n
			,var.Extra?var.Extra:n
			,var.File?var.File:n
			,var.Line?var.Line:n]
	If format {
		For a, b in arr {
			pre:=(A_Index = 1)?"Message:`n"
				:(A_Index = 2)?"What:`n"
				:(A_Index = 3)?"Extra:`n"
				:(A_Index = 4)?"File:`n"
				:"Line:`n"
			msg:=msg pre b "`n`n"
		}
	}
	Return format?msg:arr
}
CleanUp:
	If FileExist(vbsFile)
		FileDelete, %vbsFile%
