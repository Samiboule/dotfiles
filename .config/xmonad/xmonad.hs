import Data.List
import qualified Data.Map as M
import Data.Ratio
import Graphics.X11.ExtraTypes.XF86
import System.Exit
import XMonad
import XMonad.Actions.CopyWindow
import XMonad.Actions.CycleWS
import XMonad.Actions.FloatKeys
import XMonad.Actions.Warp
import XMonad.Hooks.EwmhDesktops (ewmh, ewmhFullscreen)
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.WindowSwallowing
import XMonad.Layout.BoringWindows
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.Simplest
import XMonad.Layout.SubLayouts
import XMonad.Layout.Tabbed
import XMonad.Layout.WindowNavigation
import qualified XMonad.StackSet as W
import XMonad.Util.Loggers
import XMonad.Util.Run (safeSpawn, spawnPipe)
import XMonad.Util.SpawnOnce
import XMonad.Util.WorkspaceCompare

myTerminal = "alacritty"

myModMask = mod4Mask

myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

floatBranch :: X () -> X () -> Window -> X ()
floatBranch t f w = do
  XState {windowset = s} <- get
  if M.member w (W.floating s)
    then t
    else f

toggleFloat :: Window -> X ()
toggleFloat w =
  windows
    ( \s ->
      if M.member w (W.floating s)
        then W.sink w s
        else (W.float w (W.RationalRect (1/4) (1/4) (1/2) (1/2)) s))

myKeys conf@(XConfig {XMonad.modMask = modm}) =
  M.fromList $
    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf),
      -- launch dmenu
      ((modm, xK_p), spawn "rofi -show drun -theme Arc-Dark -config ~/.config/rofi/rofi.rasi"),
      -- launch gmrun
      ((modm .|. shiftMask, xK_p), spawn "rofi -show window -theme Arc-Dark -config ~/.config/rofi/rofi.rasi"),
      -- close focused window
      ((modm .|. shiftMask, xK_c), kill1),
      ((modm, xK_v), windows copyToAll), -- @@ Make focused window always visible
      ((modm .|. shiftMask, xK_v), killAllOtherCopies), -- @@ Toggle window state back

      -- Rotate through the available layout algorithms
      ((modm, xK_space), sendMessage NextLayout),
      --  Reset the layouts on the current workspace to default
      ((modm .|. shiftMask, xK_space), setLayout $ XMonad.layoutHook conf),
      -- Resize viewed windows to the correct size
      ((modm, xK_n), refresh),
      -- Move focus to the next window
      ((modm, xK_Tab), windows W.focusDown),
      -- Move focus to the next window
      ((modm, xK_j), windows W.focusDown),
      -- Move focus to the previous window
      ((modm, xK_k), windows W.focusUp),
      -- Move focus to the master window
      ((modm, xK_m), windows W.focusMaster),
      -- Swap the focused window and the master window
      ((modm, xK_Return), windows W.swapMaster),
      -- Move floating windows
      ((modm .|. shiftMask, xK_h), withFocused (keysMoveWindow (-80, 0))),
      ((modm .|. shiftMask, xK_l), withFocused (keysMoveWindow (80, 0))),
      -- Swap the focused window with the next window
      ( (modm .|. shiftMask, xK_j),
        (withFocused (floatBranch (withFocused (keysMoveWindow (0, 80))) (windows W.swapDown)))
      ),
      -- Swap the focused window with the previous window
      ( (modm .|. shiftMask, xK_k),
        (withFocused (floatBranch (withFocused (keysMoveWindow (0, -80))) (windows W.swapUp)))
      ),
      -- Shrink the master area
      ((modm, xK_h), sendMessage Shrink),
      -- Expand the master area
      ((modm, xK_l), sendMessage Expand),
      -- Push window back into tiling
      ((modm, xK_t), withFocused $ toggleFloat),
      -- Increment the number of windows in the master area
      ((modm, xK_comma), sendMessage (IncMasterN 1)),
      -- Deincrement the number of windows in the master area
      ((modm, xK_period), sendMessage (IncMasterN (-1))),
      -- Add windows to tab group or resize floating window
      ( (modm .|. controlMask, xK_h),
        (withFocused (floatBranch (withFocused ((keysResizeWindow (-80, 0)) (0, 0))) (sendMessage (pullGroup L))))
      ),
      ( (modm .|. controlMask, xK_l),
        (withFocused (floatBranch (withFocused ((keysResizeWindow (80, 0)) (0, 0))) (sendMessage (pullGroup R))))
      ),
      ( (modm .|. controlMask, xK_k),
        (withFocused (floatBranch (withFocused ((keysResizeWindow (0, -80)) (0, 0))) (sendMessage (pullGroup U))))
      ),
      ( (modm .|. controlMask, xK_j),
        (withFocused (floatBranch (withFocused ((keysResizeWindow (0, 80)) (0, 0))) (sendMessage (pullGroup D))))
      ),
      -- Merge and unmerge tab group
      ((modm .|. controlMask, xK_m), withFocused (sendMessage . MergeAll)),
      ((modm .|. controlMask, xK_u), withFocused (sendMessage . UnMerge)),
      -- Skip over tab group
      ((modm .|. controlMask, xK_period), onGroup W.focusUp'),
      ((modm .|. controlMask, xK_comma), onGroup W.focusDown'),
      -- Toggle the status bar gap
      -- Use this binding with avoidStruts from Hooks.ManageDocks.
      -- See also the statusBar function from Hooks.DynamicLog.
      --
      ((modm, xK_b), sendMessage ToggleStruts),
      -- Audio hotkeys
      ((0, xF86XK_AudioMute), spawn "amixer sset Master toggle"),
      ((0, xF86XK_AudioRaiseVolume), spawn "amixer sset Master unmute ; pactl set-sink-volume 0 +5%"),
      ((0, xF86XK_AudioLowerVolume), spawn "amixer sset Master unmute ; pactl set-sink-volume 0 -5%"),
      -- Screenshot hotkeys
      ((0, xK_Print), spawn "date --iso-8601=seconds | xargs -I {} sh -c 'maim -B ~/screenshots/{}.png && notify-send \"Screenshot saved to ~/screenshots/{}.png!\"'"),
      ((controlMask, xK_Print), spawn "date --iso-8601=seconds | xargs -I {} sh -c 'maim -B -s ~/screenshots/{}.png && notify-send \"Screenshot saved to ~/screenshots/{}.png!\"'"),
      ((modm, xK_Print), spawn "date --iso-8601=seconds | xargs -I {} sh -c 'maim -B -i $(xdotool getactivewindow) ~/screenshots/{}.png && notify-send \"Screenshot saved to ~/screenshots/{}.png!\"'"),
      ((shiftMask, xK_Print), spawn "maim -B | xclip -selection clipboard -t image/png -i && notify-send 'Screenshot saved to clipboard!'"),
      ((controlMask .|. shiftMask, xK_Print), spawn "maim -B -s | xclip -selection clipboard -t image/png -i && notify-send 'Screenshot saved to clipboard!'"),
      ((modm .|. shiftMask, xK_Print), spawn "maim -B -i $(xdotool getactivewindow) | xclip -selection clipboard -t image/png -i && notify-send 'Screenshot saved to clipboard!'"),
      -- Mount drives
      ((modm, xK_u), spawn "mountscript"),
      ((modm .|. shiftMask, xK_u), spawn "~/.config/xmonad/scripts/unmountscript"),
      -- Quit xmonad
      ((modm .|. shiftMask, xK_q), io exitSuccess),
      -- Restart xmonad
      ((modm, xK_q), spawn "xmonad --recompile && xmonad --restart && notify-send recompiled!"),
      -- Run xmessage with a summary of the default keybindings (useful for beginners)
      ((modm .|. shiftMask, xK_slash), xmessage help),
      -- CycleWS setup
      ((modm, xK_Down), nextWS),
      ((modm, xK_Up), prevWS),
      ((modm .|. shiftMask, xK_Down), shiftToNext),
      ((modm .|. shiftMask, xK_Up), shiftToPrev),
      -- , ((modm .|. shiftMask, xK_Down), shiftToNext >> nextWS)
      -- , ((modm .|. shiftMask, xK_Up),   shiftToPrev >> prevWS)
      ((modm, xK_Right), nextScreen),
      ((modm, xK_Left), prevScreen),
      ((modm .|. shiftMask, xK_Right), shiftNextScreen),
      ((modm .|. shiftMask, xK_Left), shiftPrevScreen),
      ((modm, xK_y), toggleWS),
      ((modm, xK_f), moveTo Next emptyWS), -- find a free workspace
      ((modm .|. shiftMask, xK_f), shiftTo Next emptyWS), -- find a free workspace

      -- @@ Move pointer to currently focused window
      ((modm, xK_z), warpToWindow (1 % 2) (1 % 2))
    ]
      ++
      -- mod-ctrl-{w,e,r} @@ Move mouse pointer to screen 1, 2, or 3
      [ ((modm .|. controlMask, key), warpToScreen sc (1 % 2) (1 % 2))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0 ..]
      ]
      ++
      --
      -- mod-[1..9] @@ Switch to workspace N
      -- mod-shift-[1..9] @@ Move client to workspace N
      -- mod-control-shift-[1..9] @@ Copy client to workspace N
      [ ((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9],
          (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask), (copy, shiftMask .|. controlMask)]
      ]
      ++
      --
      -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
      -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
      --
      [ ((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0 ..],
          (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
      ]

myMouseBindings (XConfig {XMonad.modMask = modm}) =
  M.fromList
    -- mod-button1, Set the window to floating mode and move by dragging
    [ ( (modm, button1),
        \w ->
          focus w
            >> mouseMoveWindow w
            >> windows W.shiftMaster
      ),
      -- mod-button2, Raise the window to the top of the stack
      ((modm, button2), \w -> focus w >> windows W.shiftMaster),
      -- mod-button3, Set the window to floating mode and resize by dragging
      ( (modm, button3),
        \w ->
          focus w
            >> mouseResizeWindow w
            >> windows W.shiftMaster
      )
      -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

myLayout = lessBorders OnlyScreenFloat $ fullscreenFull $ avoidStruts $ (tiled ||| mtiled ||| tabular)
  where
    -- default tiling algorithm partitions the screen into two panes
    tiled = windowNavigation $ addTabs shrinkText myTabConfig $ subLayout [] (Simplest) $ boringWindows $ Tall nmaster delta ratio
    mtiled = windowNavigation $ addTabs shrinkText myTabConfig $ subLayout [] (Simplest) $ boringWindows $ Mirror $ Tall nmaster delta ratio

    -- tabbed layout
    tabular = tabbed shrinkText myTabConfig

    -- The default number of windows in the master pane
    nmaster = 1

    -- Default proportion of screen occupied by master pane
    ratio = 1 / 2

    -- Percent of screen to increment by when resizing panes
    delta = 3 / 100

    -- tab decorations
    myTabConfig =
      def
        { decoHeight = 40
        }

myManageHook =
  composeAll
    [ className =? "mpv" --> doFloat,
      className =? "Pcmanfm" --> (doRectFloat ((((W.RationalRect (1/4)) (1/4)) (1/2)) (1/2))),
      className =? "Xfce-polkit" --> doCenterFloat,
      className =? "fAlacritty" --> (doRectFloat ((((W.RationalRect (1/4)) (1/4)) (1/2)) (1/2))),
      className =? "Gimp" --> doFloat,
      className =? "lemonbar" --> doIgnore,
      resource =? "lemonbar" --> doIgnore,
      resource =? "desktop_window" --> doIgnore,
      resource =? "kdesktop" --> doIgnore
    ]

myLogHook = return ()

myStartupHook :: X ()
myStartupHook = do
  spawnOnce "startupscript &"
  setWMName "LG3D"

myHandleEventHook = swallowEventHook (className =? "Alacritty") (return True)

curr :: WorkspaceId -> String
curr a = ""

myPPLayout :: String -> String
myPPLayout x =
  if isInfixOf "Mirror" x
    then "M"
    else
      if isInfixOf "Tall" x
        then "D"
        else
          if isInfixOf "Tabbed" x
            then "T"
            else
              if isInfixOf "Full" x
                then "F"
                else ""

myPP =
  def
    { ppCurrent = wrap "[" "]",
      ppVisible = wrap "<" ">",
      ppHidden = id,
      ppHiddenNoWindows = const "",
      ppVisibleNoWindows = Nothing,
      ppUrgent = id,
      ppRename = pure,
      ppSep = " : ",
      ppWsSep = " ",
      ppTitle = shorten 80,
      ppLayout = myPPLayout,
      ppOrder = id,
      ppOutput = putStrLn,
      ppSort = getSortByIndex,
      ppExtras = [logCmd "lemonbarscript"]
    }

main = do
  mySB <- statusBarPipe "lemonbar -g 2760x40 -d -B \\#000000 -f \"JetBrains Mono\"" (pure myPP)
  xmonad . ewmhFullscreen . ewmh . docks . withSB mySB $
    def
      { terminal = myTerminal,
        modMask = myModMask,
        borderWidth = 6,
        normalBorderColor = "#444444",
        focusedBorderColor = "#aaaafd",
        keys = myKeys,
        mouseBindings = myMouseBindings,
        workspaces = myWorkspaces,
        layoutHook = myLayout,
        manageHook = myManageHook,
        logHook = myLogHook,
        startupHook = myStartupHook,
        handleEventHook = myHandleEventHook
      }

-- | Finally, a copy of the default bindings in simple textual tabular format.
help :: String
help =
  unlines
    [ "The modifier key is 'super'. Keybindings:",
      "",
      "-- launching and killing programs",
      "mod-Shift-Enter  Launch terminal",
      "mod-p            Launch application launcher",
      "mod-Shift-p      Launch window switcher",
      "mod-Shift-c      Close/kill the focused window",
      "mod-v            Copy the focused window to all workspaces",
      "mod-Shift-v      Remove all instances of the focused window in other workspaces",
      "mod-Space        Rotate through the available layout algorithms",
      "mod-Shift-Space  Reset the layouts on the current workSpace to default",
      "mod-n            Resize/refresh viewed windows to the correct size",
      "mod-Shift-/      Show this help message with the default keybindings",
      "",
      "-- move focus up or down the window stack",
      "mod-Tab        Move focus to the next window",
      "mod-Shift-Tab  Move focus to the previous window",
      "mod-j          Move focus to the next window",
      "mod-k          Move focus to the previous window",
      "mod-m          Move focus to the master window",
      "",
      "-- modifying the window order",
      "mod-Return   Swap the focused window and the master window",
      "mod-Shift-j  Swap the focused window with the next window",
      "mod-Shift-k  Swap the focused window with the previous window",
      "",
      "-- tab group operations",
      "mod-Ctrl-{h,j,k,l} Merge into window",
      "mod-Ctrl-m         Merge all windows",
      "mod-Ctrl-u         Unmerge all windows",
      "mod-Ctrl-.         Skip over group upwards",
      "mod-Ctrl-,         Skip over group downwards",
      "",
      "-- resizing the master/slave ratio",
      "mod-h  Shrink the master area",
      "mod-l  Expand the master area",
      "",
      "-- floating layer support",
      "mod-t               Push window back into tiling; unfloat and re-tile it",
      "mod-Shift-{h,j,k,l} Move window in corresponding direction",
      "mod-Ctrl-{h,j,k,l}  Resize window in corresponding direction",
      "",
      "-- increase or decrease number of windows in the master area",
      "mod-comma  (mod-,)   Increment the number of windows in the master area",
      "mod-period (mod-.)   Deincrement the number of windows in the master area",
      "",
      "-- quit, or restart",
      "mod-Shift-q  Quit xmonad",
      "mod-q        Restart xmonad",
      "",
      "-- Workspaces & screens",
      "mod-[1..9]   Switch to workSpace N",
      "mod-Shift-[1..9]   Move client to workspace N",
      "mod-Shift-Ctrl-[1..9]   Copy client to workspace N",
      "mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3",
      "mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3",
      "mod-down           Switch to next workspace",
      "mod-up             Switch to previous workspace",
      "mod-right          Switch to next screen",
      "mod-left           Switch to previous screen",
      "mod-Shift-right    Move client to next screen",
      "mod-Shift-left     Move client to previous screen",
      "mod-Shift-down     Move client to next workspace",
      "mod-Shift-up       Move client to previous workspace",
      "mod-y              Switch to latest workspace",
      "mod-f              Switch to first empty workspace",
      "mod-Shift-f        Move client to first empty workspace",
      "mod-z              Move cursor to the focused window",
      "mod-Ctrl-{w,e,r}   Move cursor to the given screen",
      "",
      "-- Mouse bindings: default actions bound to mouse events",
      "mod-button1  Set the window to floating mode and move by dragging",
      "mod-button2  Raise the window to the top of the stack",
      "mod-button3  Set the window to floating mode and resize by dragging",
      "",
      "-- Mount and unmount",
      "mod-u              Mount drive",
      "mod-Shift-u        Unmount drive",
      "",
      "-- Audio hotkeys",
      "Mute key           Simply mutes audio",
      "Raise Volume key   Raise volume by 5%",
      "Lower Volume key   Lower volume by 5%",
      "",
      "-- Screenshot hotkeys",
      "prtscr             Fullscreen screenshot saved to the default screenshot directory",
      "Ctrl-prtscr        Region screenshot saved to the default screenshot directory",
      "mod-prtscr         Current window screenshot saved to the default screenshot directory",
      "Shift-prtscr       Fullscreen screenshot saved to the clipboard",
      "Shift-Ctrl-prtscr  Region screenshot saved to the clipboard",
      "mod-Shift-prtscr   Current window screenshot saved to the clipboard"
    ]
