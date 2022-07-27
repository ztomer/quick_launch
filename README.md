# Quick launch

Keyboard based application launcher - assign a hot key to launch or open specific applications or websites.
Uses AutoHotKey and copy-pastes from across the web

Public domain

Notes:
* Use quick_launch.ahk, the other file is for reference
* There's no GUI, you'd probably want and need to edit the script for your own needs
* I'm using Process Explorer to find the target binary YMMV. Some applications works only with the PID, some other with the window title. The terminal requires special handling.
* To start the script on log-in, use the task scheduler, schedule a task using the AutoHotKey.exe binary, and add the full path + quick_launch.ahk as a parameter
* Hammerspoon for Mac is better. Alas.

