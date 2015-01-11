import xbmc, xbmcgui

xbmc.executebuiltin('xbmc.ActivateWindow(videobookmarks)')
xbmc.executebuiltin('ActivateWindowAndFocus(10125,2,0)')
xbmc.executebuiltin('Action(Right)')
xbmc.executebuiltin('Action(Select)')
xbmc.executebuiltin('xbmc.action(previousmenu)')