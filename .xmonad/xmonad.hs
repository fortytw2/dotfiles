-- Imports.
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Layout.Spacing
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.NoBorders
import XMonad.Layout.Tabbed

-- The main function.
main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig

-- Command to launch the bar.
myBar = "xmobar"

-- Custom PP, configure it as you like. It determines what is being written to the bar.
myPP = xmobarPP { ppCurrent = xmobarColor "#268bd2" "" . wrap "<" ">"
	, ppTitle = xmobarColor "#268bd2" ""
	, ppHiddenNoWindows = xmobarColor "#eee8d5" ""
	 }

-- Key binding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

-- Main configuration, override the defaults to your liking.
myConfig = defaultConfig { terminal = "urxvt"
	, layoutHook = myLayoutHook
	, normalBorderColor = "#002b36"
	, focusedBorderColor = "#cb4b16"
	, handleEventHook = fullscreenEventHook
	-- , workspaces = myWorkspaces
	, manageHook = composeOne [
             isKDETrayWindow -?> doIgnore,
             transience,
             isFullscreen -?> doFullFloat,
             resource =? "stalonetray" -?> doIgnore
        ]
	}

-- myWorkspaces = ["term","subl","web","spotify"]

myLayoutHook = smartBorders $ smartSpacing 4 $ Tall 1 (3/100) (1/4) ||| noBorders Full ||| simpleTabbed
