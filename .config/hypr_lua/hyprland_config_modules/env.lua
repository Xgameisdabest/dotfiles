-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
local home = os.getenv("HOME")
-- Basic Apps & Rendering
hl.env("TERMINAL", "kitty")
hl.env("WLR_RENDERER", "vulkan")
-- Path & Custom Paths
-- We concatenate strings in Lua using '..'
hl.env("PATH", home .. "/.local/bin:" .. os.getenv("PATH"))
hl.env("CUSTOM_SOUND_PATH", home .. "/.config/dunst/scripts/sounds/")
hl.env("XDG_DATA_DIRS", home .. "/.local/share/flatpak/exports/share:" .. (os.getenv("XDG_DATA_DIRS") or ""))
-- Cursors
hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("XCURSOR_SIZE", "24")
-- Firefox (Wayland)
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("MOZ_USE_XINPUT2", "1")
hl.env("MOZ_DISABLE_RDD_SANDBOX", "1")
-- Toolkit Backends
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")
-- Input Methods (fcitx)
hl.env("SDK_IM_MODULE", "fcitx")
hl.env("QT_IM_MODULE", "fcitx")
hl.env("XMODIFIERS", "@im,fcitx")
-- QT Settings
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_CURSOR_THEME", "Bibata-Modern-Ice")
hl.env("QT_CURSOR_SIZE", "24")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
