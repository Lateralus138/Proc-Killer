## Proc Killer

Proc Killer is a command line utility that can be used to kill processes by passing the name of the process or its' full path to the utility, Can be use with cmd or drag and dropped.

## Example Code - vbscript to kill the process, ran as admin with AHK wrapper.
```
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
```
## Motivation

I created this to help work on clients computers; to kill processes when the task manager is disabled or the it just can't be killed from the task manager.

## Installation

Portable program (Plans for installer and portable option).


## Test
I have tested on Windows 10 32 Bit and Windows 7 64 Bit.

## Contributors

Ian Pride @ faithnomoread@yahoo.com - [Lateralus138] @ New Pride Services 

## License

	This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

	License provided in gpl.txt
