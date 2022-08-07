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
  Else ; Run the program if the process is not already running
  {
    Run, %Target%, , , PID
    Return
  }

  ; If the active window is focues, minimize it
  WinGetTitle, active_title, A
  IfInString, active_title, %WinTitle%
  {
    WinMinimize A
    Return
  }

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
  {
    WinMinimize, A
    Return
  }

  SetTitleMatchMode, 3
  exist := WinExist(name)
  if %exist%
  {
    WinActivate, %name%
    Return
  }

  if (windowType = "-")
    Run %exeName%
  else
    Run, %exeName%,, max

}

SwitchToWindowsTerminal()
{
  ; TODO: merge SwitchToWindowsTerminal with RunActiveteOrSwitchProcess
  windowHandleId := WinExist("ahk_exe WindowsTerminal.exe")
  windowExistsAlready := windowHandleId > 0

  ; If the Windows Terminal is already open, determine if we should put it in focus or minimize it.
  if (windowExistsAlready = true)
  {
    activeWindowHandleId := WinExist("A")
    windowIsAlreadyActive := activeWindowHandleId == windowHandleId

    if (windowIsAlreadyActive)
    {
      ; Minimize the window.
      WinMinimize, "ahk_id %windowHandleId%"
    }
    else
    {
      ; Put the window in focus.
      WinActivate, "ahk_id %windowHandleId%"
      WinShow, "ahk_id %windowHandleId%"
    }
    Return
  }

  ; Else it's not already open, so launch it.
  Run, wt
}

RunActivateOrSwitchTitleWeb(url, name)
{
  ; Search for the webapp by title
  SetTitleMatchMode, 2
  WinWait, %name%, , 3
  ; Open a new instance if there's no existing one
  IfWinNotExist, %name%
  {
    Run C:\Program Files (x86)\Google\Chrome\Application\chrome.exe --new-window --app=%url%
    Return
  }

  ; If the active window is focues, minimize it
  WinGetTitle, active_title, A
  IfInString, active_title, %name%
  {
    WinMinimize A
    Return
  }

  ; If the active window is focues, minimize it
  WinGetTitle, active_title, A
  IfInString, active_title, %name%
  {
    WinMinimize A
    Return
  }

  ; Inactive window, focus
  IfWinActive, %name%
    WinActivateBottom, %name%
  Else
    WinActivate, %name%
}

RunSpotify()
{
  WinGet, spotifyHwnd, ID, ahk_exe spotify.exe
  if ( spotifyHwnd = "" )
  {
    run "C:\Program Files\WindowsApps\SpotifyAB.SpotifyMusic_1.191.824.0_x86__zpdnekdrzrea0\Spotify.exe"
    Return
  }

  If WinActive("ahk_id" spotifyHwnd){
    WinMinimize A
    Return
  }
  WinActivate, % "ahk_id " spotifyHwnd
  Return
}

; ^ - Control
; + - Shift
; # - Win key

; Example for running a website
^+#q:: ;Cronometer
  RunActivateOrSwitchTitleWeb("https://cronometer.com/", "Cronometer")
Return

; Launch Gmal
^+#g::
  RunActivateOrSwitchTitleWeb("https://mail.google.com/mail/u/0/#inbox", " - Gmail")
Return

; Launching Firefox
^+#f:: ;Firefox
  ;Run C:\Program Files\Mozilla Firefox\firefox.exe
  RunActivateOrSwitchTitle("C:\Program Files\Mozilla Firefox\firefox.exe", "Mozilla Firefox")
Return

; Launching Double commander
^+#d:: ;
RunActivateOrSwitchTitle("C:\Program Files\Double Commander\doublecmd.exe", "Double Commander")
Return

; Launch Cron
^+#c:: ;Cron
  RunActivateOrSwitchProcess("C:\Users\ztome\AppData\Local\Programs\cron\Cron.exe", "Cron")
Return

; Launch Spotify
^+#s:: ; Spotify
  RunSpotify()
Return

; Launch VSCode
^+#v::
  RunActivateOrSwitchTitle("C:\Users\ztome\AppData\Local\Programs\Microsoft VS Code\Code.exe", "Visual Studio Code")
Return

; Launch Chrome
^+#w:: ; Chrome
  RunActivateOrSwitchProcess("C:\Program Files (x86)\Google\Chrome\Application\chrome.exe", "Google Chrome")
Return

; Launch WhatsApp
^+#r:: ;
RunActivateOrSwitchTitle("C:\Program Files\WindowsApps\5319275A.WhatsAppDesktop_2.2226.6.0_x64__cv1g1gvanyjgm\app\WhatsApp.exe", "WhatsApp")
Return

; Notion
^+#a::
  RunActivateOrSwitchProcess("C:\Users\ztome\AppData\Local\Programs\Notion\Notion.exe", "Notion")
Return

; Launch Terminal
^+#t::SwitchToWindowsTerminal()
Return

; Process Explorer
^+Esc::
  RunActivateOrSwitchTitle("C:\Program Files\WindowsApps\Microsoft.SysinternalsSuite_2022.7.0.0_x64__8wekyb3d8bbwe\Tools\procexp.exe", "Process Explorer")
Return

