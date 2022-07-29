# Quick launch

Keyboard based application shortcuts.
Assign a hot key to launch or open specific applications or websites, no need to remember if the application was already launched.
Focus on tasks rather then window management.

Examples: 
* Notion: to launch Notion, press Control+Shift+Win+A, Notion is launched and focused (if it was already running, the existing instance will be brought into focus). Pressing Control+Shift+Win+A again will minimize the Notion window. 
* Gmail: to read email, press Control+Shift+Win+G. Gmail is launched in a window. Press Control+Shoft+Win+A again to minimize the window.

Uses AutoHotKey and copy-pastes from across the web.

Public domain

Notes:

* Use quick_launch.ahk, the other file is for reference
* There's no GUI, you'd probably want and need to edit the script for your own needs
* I'm using Process Explorer to find the target binary YMMV. Some applications works only with the PID, some other with the window title. The terminal requires special handling.
* To start the script on log-in, use the task scheduler, schedule a task using the AutoHotKey.exe binary, and add the full path + quick_launch.ahk as a parameter
* Hammerspoon for Mac is better. Alas.
