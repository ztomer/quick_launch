RunActivateOrSwitch(Target, WinTitle = "")
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


; Example for running a website
; ^+!F:: ;Facebook
; Run C:\Program Files (x86)\Google\Chrome\Application\chrome.exe facebook.com
; Return

; Launching Firefox
^+#f:: ;Firefox
;Run C:\Program Files\Mozilla Firefox\firefox.exe
RunActivateOrSwitch("C:\Program Files\Mozilla Firefox\firefox.exe", "Mozilla Firefox")
Return

; Launch Cron
^+#c:: ;Cron
RunActivateOrSwitch("C:\Users\ztome\AppData\Local\Programs\cron\Cron.exe", "Cron")
Return

; Launch Spotify
^+#s:: ; Spotify
RunActivateOrSwitch("C:\Program Files\WindowsApps\SpotifyAB.SpotifyMusic_1.190.859.0_x86__zpdnekdrzrea0\Spotify.exe", "Spotify")
Return

; Launch VSCode
^+#v:: ; Spotify
RunActivateOrSwitch("C:\Users\ztome\AppData\Local\Programs\Microsoft VS Code\Code.exe", "Visual Studio Code")
Return

; Launch Chrome
^+#w:: ; Chrome
RunActivateOrSwitch("C:\Program Files (x86)\Google\Chrome\Application\chrome.exe", "Google Chrome")
Return