RunActivateOrSwitchTitle(Target, WinTitle = "")
{
   ; Get the filename without a path
   SplitPath, Target, TargetNameOnly

   ; Process returns the PID of a matching process exists, or 0 otherwise
   Process, Exist, %TargetNameOnly%
   ; Get the PID and the class if the process is already running
   If ErrorLevel > 0
   {
      PID = %ErrorLevel%
      WinGetClass, ClassID, ahk_pid %PID%
   }
   ; Run the program if the process is not already running
   Else
      Run, %Target%, , , PID

   ; At least one app  wouldn't always become the active
   ; window after using Run, so we always force a window activate.
   ; Activate by title if given, otherwise use class ID. Activating by class ID
   ; appears more robust for switching than using PID.
   If WinTitle <>
   {
      SetTitleMatchMode, 2
      WinWait, %WinTitle%, , 3
      IfWinActive, %WinTitle%
		WinActivateBottom, %WinTitle%
      Else
		WinActivate, %WinTitle%
   }
   Else
   {
      WinWait, ahk_class %ClassID%, , 3
      IfWinActive, ahk_class %ClassID%
        WinActivateBottom, ahk_class %ClassID%
      Else
		WinActivate, ahk_class %ClassID%
   }
}

; Function that either activates the window, if it exists or
; launches the exe given
RunActivateOrSwitchProcess(exeName, name, windowType:="max")
{
  WinGet, currProcessPath, ProcessPath, A
  if (currProcessPath = exeName)
    WinMinimize, A
  else
  {
    exist := WinExist(name)
    if %exist%
      WinActivate, %name%
    else
      if (windowType = "-")
        Run %exeName%
      else
        Run, %exeName%,, max
  }
}

; Example for running a website
; ^+!F:: ;Facebook
; Run C:\Program Files (x86)\Google\Chrome\Application\chrome.exe facebook.com
; Return

; Launching Firefox
^+#f:: ;Firefox
;Run C:\Program Files\Mozilla Firefox\firefox.exe
RunActivateOrSwitchTitle("C:\Program Files\Mozilla Firefox\firefox.exe", "Firefox")
Return

; Launch Cron
^+#c:: ;Cron
RunActivateOrSwitchTitle("C:\Users\ztome\AppData\Local\Programs\cron\Cron.exe", "Cron")
Return

; Launch Spotify
^+#s:: ; Spotify
RunActivateOrSwitchTitle("C:\Program Files\WindowsApps\SpotifyAB.SpotifyMusic_1.190.859.0_x86__zpdnekdrzrea0\Spotify.exe", "Spotify")
Return

; Launch VSCode
^+#v:: ; Spotify
RunActivateOrSwitchTitle("C:\Users\ztome\AppData\Local\Programs\Microsoft VS Code\Code.exe", "Visual Studio Code")
Return

; Launch Chrome
^+#w:: ; Chrome
RunActivateOrSwitchTitle("C:\Program Files (x86)\Google\Chrome\Application\chrome.exe", "Google Chrome")
Return

; Notion
^+#a::
RunActivateOrSwitchProcess("C:\Users\ztome\AppData\Local\Programs\Notion\Notion.exe", "Notion")
Return