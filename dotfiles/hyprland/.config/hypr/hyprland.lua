local keyboard_layout = "us,fr"
local terminal = "ghostty"
local menu = "rofi -combi-modi window,drun -show drun"
local file_manager = "nautilus"
local screen_off_cmd = [[hyprctl dispatch 'hl.dsp.dpms({ action = "off", monitor = "eDP-1" })']]
local lock_and_screen_off_cmd = "hyprlock & sleep 1; " .. screen_off_cmd

hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = 1.6,
    bitdepth = 8,
})

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XCURSOR_SIZE", "24")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_SCALE_FACTOR", "1.6")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GL_GSYNC_ALLOWED", "1")
hl.env("__GL_VRR_ALLOWED", "0")

hl.on("hyprland.start", function()
    for _, cmd in ipairs({
        "waybar",
        "dunst",
        "systemctl --user start hyprpolkitagent",
        "hypridle",
        "hyprpaper",
        "dbus-update-activation-environment --systemd --all",
    }) do
        hl.exec_cmd(cmd)
    end
end)

hl.config({
    general = {
        border_size = 0,
    },

    decoration = {
        rounding = 12,
    },

    input = {
        kb_layout = keyboard_layout,
        kb_options = "grp:win_space_toggle",
        follow_mouse = 1,
        float_switch_override_focus = 1,

        touchpad = {
            natural_scroll = true,
        },
    },

    dwindle = {
        force_split = 2,
        preserve_split = true,
    },

    xwayland = {
        force_zero_scaling = true,
    },

    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        mouse_move_enables_dpms = true,
        animate_mouse_windowdragging = true,
        animate_manual_resizes = true,
    },
})

hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.curve("noBezier", { type = "bezier", points = { { 0.1, 0.9 }, { 0.1, 1 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 10, bezier = "myBezier", style = "popin 40%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 7, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 20, bezier = "myBezier", style = "popin 60%" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "default", style = "slide" })

local mod = "SUPER"
local shift = "SHIFT"
local alt = "ALT"
local mod_shift = mod .. " + " .. shift
local mod_alt = mod .. " + " .. alt

for i = 1, 9 do
    hl.bind(mod .. " + " .. i, hl.dsp.focus({ workspace = i }))
    hl.bind(mod_shift .. " + " .. i, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + P", hl.dsp.window.pseudo())
hl.bind(mod .. " + A", hl.dsp.layout("togglesplit"))

hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(mod .. " + h", hl.dsp.focus({ direction = "l" }))
hl.bind(mod .. " + l", hl.dsp.focus({ direction = "r" }))
hl.bind(mod .. " + k", hl.dsp.focus({ direction = "u" }))
hl.bind(mod .. " + j", hl.dsp.focus({ direction = "d" }))

hl.bind(mod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mod .. " + E", hl.dsp.exec_cmd(file_manager))

hl.bind(mod_shift .. " + M", hl.dsp.exit())
hl.bind(mod .. " + S", hl.dsp.exec_cmd("hyprshot -m output -m active --clipboard-only"))
hl.bind(mod_shift .. " + S", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))
hl.bind(mod_alt .. " + S", hl.dsp.exec_cmd("hyprshot -m window --clipboard-only"))
hl.bind(mod_shift .. " + C", hl.dsp.exec_cmd("hyprpicker --no-fancy --autocopy --render-inactive"))
hl.bind(mod_shift .. " + O", hl.dsp.dpms({ action = "off", monitor = "eDP-1" }))
hl.bind(mod_shift .. " + L", hl.dsp.exec_cmd(lock_and_screen_off_cmd))

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -dnvidia_0 -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -dnvidia_0 -e4 -n2 set 5%-"), { locked = true, repeating = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
