# Quick launch

## Why?

My workflow mostly consist of using the same applications over and over again. Hunting for the applications on the taskbar is bothersome and slows me down (the taskbar is auto-hidden anyways)

## How?

Keyboard based application shortcuts.

Assign a hot key to launch or open a specific application or website.
Focus on tasks rather than the taskbar.

## Examples

* Notion (application): to launch Notion, press Control+Shift+Win+A, Notion is launched and focused (if it was already running, the existing instance will be brought into focus). Pressing Control+Shift+Win+A again will minimize the Notion window.
* Gmail (website): to read email, press Control+Shift+Win+G. Gmail is launched in a window. Press Control+Shift+Win+G again to minimize the window.

Uses AutoHotKey and copy-pastes from across the web.

Public domain

## Notes

* Use quick_launch.ahk, the other file is for reference
* There's no GUI, you'd probably want and need to edit the script for your own needs
* I'm using Process Explorer to find the target binary, so YMMV. Some applications works only with the PID, some others with the window title the terminal requires special handling, etc.
* To start the script on log-in, use the task scheduler, schedule a task using the AutoHotKey.exe binary, and add the full path + quick_launch.ahk as a parameter
* There are five different launch functions since there's no unified way to get a consistent identifier for windows in Windows. This is sub-optimal, but at least works.
* Hammerspoon for Mac is better. Alas.

## Q&A

* Q: Why AutoHotKey?

  A: Please propose an alternative.

* Q: What about window management?

  A: Powertoys FancyZones is good enough

* Q: It doesn't fit my workflow!

  A: Build your own then, it's public domain

* Q: Your AHK code sucks!

  A: Patches welcome
