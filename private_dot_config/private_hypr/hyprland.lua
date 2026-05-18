-- This is an example Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")

------------------
---- MONITORS ----
------------------

local home = os.getenv("HOME")

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
	output = "desc:LG Electronics LG ULTRAGEAR 511BNBJ1G717",
	mode = "2560x1440@200.00",
	position = "0x0",
	scale = "1",
	bitdepth = 10,
	vrr = 1,
})

hl.monitor({
	output = "desc:Lenovo Group Limited D24-20 UR6060LH",
	mode = "1920x1080@74.97",
	position = "2560x0",
	scale = "1",
	icc = home .. "/.config/hypr/D24-20.icm",
})

hl.monitor({
	output = "",
	mode = "preferred",
	scale = "1",
})

---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
terminal = "app2unit -- ghostty +new-window"
fileManager = "thunar"
menu = ""
vicinae = "vicinae toggle"

uwsm_cmd = "app2unit "

lock_cmd = "pidof hyprlock || hyprlock"
suspend_cmd = "systemctl suspend || loginctl suspend"

-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:

local autostart_apps = {
	{ cmd = "waypaper --restore", type = "background" },
	{ cmd = "swaync", type = "background" },
	{ cmd = "wl-paste --watch clipvault store --database /tmp/db --max-entry-length 0", type = "background" },
	{ cmd = "qpwgraph", type = "foreground" },
}

hl.on("hyprland.start", function()
	hl.exec_cmd(terminal)
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
	hl.exec_cmd("systemctl --user start waybar.service")
	hl.exec_cmd("systemctl --user start xsettingsd.service")

	for _, app in ipairs(autostart_apps) do
		local flag = app.type == "background" and "-s b" or ""
		hl.exec_cmd(uwsm_cmd .. flag .. " -- " .. app.cmd)
	end
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

hl.config({
	ecosystem = {
		enforce_permissions = true,
	},
})

hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
hl.permission("/usr/(bin|local/bin)/hyprlock", "screencopy", "allow")
hl.permission("/usr/(bin|local/bin)/wayvr", "screencopy", "allow")
hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")

-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 5,

		border_size = 2,

		col = {
			active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
			inactive_border = "rgba(595959aa)",
		},

		-- Set to true to enable resizing windows by clicking and dragging on borders and gaps
		resize_on_border = true,

		-- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
		allow_tearing = true,

		layout = "scrolling",
	},

	decoration = {
		rounding = 10,
		rounding_power = 2,

		-- Change transparency of focused and unfocused windows
		active_opacity = 1.0,
		inactive_opacity = 0.8,

		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = 0xee1a1a1a,
		},

		blur = {
			enabled = true,
			size = 3,
			passes = 1,
			vibrancy = 0.1696,
		},
	},

	animations = {
		enabled = true,
	},
})

-- Bezier curves from hyprland.conf
hl.curve("wind", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1 } } })
hl.curve("winIn", { type = "bezier", points = { { 0.1, 1.1 }, { 0.1, 1.1 } } })
hl.curve("winOut", { type = "bezier", points = { { 0.3, -0.3 }, { 0, 1 } } })
hl.curve("liner", { type = "bezier", points = { { 1, 1 }, { 1, 1 } } })

-- Animations from hyprland.conf
hl.animation({ leaf = "windows", enabled = true, speed = 6, bezier = "wind", style = "slide" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 6, bezier = "winIn", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 5, bezier = "winOut", style = "slide" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 5, bezier = "wind", style = "slide" })
hl.animation({ leaf = "border", enabled = true, speed = 1, bezier = "liner" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 30, bezier = "liner", style = "loop" })
hl.animation({ leaf = "fade", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "wind" })

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
	dwindle = {
		preserve_split = true, -- You probably want this
	},
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
	master = {
		new_status = "master",
	},
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
	scrolling = {
		fullscreen_on_one_column = true,
	},
})

----------------
----  MISC  ----
----------------

hl.config({
	misc = {
		force_default_wallpaper = -1, -- Set to 0 or 1 to disable the anime mascot wallpapers
		disable_hyprland_logo = true, -- If true disables the random hyprland logo / anime girl background. :(
		disable_splash_rendering = true,
		focus_on_activate = true,
		mouse_move_enables_dpms = true,
		key_press_enables_dpms = true,

		enable_swallow = true,
		swallow_regex = "^(com.mitchellh.ghostty)$",
		swallow_exception_regex = "^(sudo|less|man|htop|btop|nvim|vim|nano)$",
	},
})

hl.config({
	ecosystem = {
		no_donation_nag = true,
	},
})

------------------
---- RENDER ------
------------------

hl.config({
	opengl = {
		nvidia_anti_flicker = false,
	},
})

hl.config({
	render = {
		new_render_scheduling = true,
	},
})

-----------------
---- DEBUG ------
-----------------

hl.config({
	debug = {
		disable_logs = true,
	},
})

---------------
---- INPUT ----
---------------

hl.config({
	input = {
		kb_layout = "fi",
		kb_variant = "",
		kb_model = "",
		kb_options = "",
		kb_rules = "evdev",

		repeat_delay = 300,
		repeat_rate = 30,

		follow_mouse = 1,

		sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

		accel_profile = "flat",
		numlock_by_default = true,

		touchpad = {
			natural_scroll = false,
		},
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
	name = "epic-mouse-v1",
	sensitivity = -0.5,
})

----------------
---- CURSOR ----
----------------

hl.config({
	cursor = {
		default_monitor = "DP-1",
		min_refresh_rate = 48,
	},
})

---------------------
---- KEYBINDINGS ----
---------------------
-- All keybinds defined in UserConfigs/UserKeybinds.lua (loaded at end).
-- hyprland.lua keeps only binds NOT in UserKeybinds.

local mainMod = "SUPER"

-- Pseudo (dwindle) — not in UserKeybinds
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

-- Brightness — not in UserKeybinds
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Mic mute — not in UserKeybinds
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)

-- AudioPause — extra playerctl variant not in UserKeybinds
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },

	move = "20 monitor_h-120",
	float = true,
})

hl.window_rule({
	name = "silent firefox",
	workspace = "2 silent",
	match = { class = "(firefox)", title = "(.*)(Mozilla Firefox)(.*)$" },
})

hl.window_rule({
	name = "Silent Brave",
	workspace = "2 silent",
	match = { class = "(Brave-browser)" },
})

hl.window_rule({
	name = "celluloid",
	tag = "+media",
	match = { class = "(Celluloid)", title = "(.*)(Celluloid)(.*)$" },
})

hl.window_rule({
	name = "Hyprland color",
	border_color = "rgb(FFFF00)",
	match = { title = "^(.*Hyprland.*)$" },
})

hl.window_rule({
	name = "Terminal to workspace 1",
	workspace = "1",
	match = { class = "(.*ghostty)" },
})

hl.window_rule({
	name = "No color terminal border",
	border_color = "rgba(00000000)",
	match = { class = "(.*ghostty)" },
})

hl.window_rule({
	name = "Games",
	border_color = "rgb(FF0000)",
	immediate = true,
	content = "game",
	match = { tag = "game" },
})

-- KeePassXC dialog windows
hl.window_rule({
	name = "KeePassXC",
	float = true,
	no_screen_share = true,
	match = { class = "(org.keepassxc.KeePassXC)", title = "(.*)(Luo salasana)(.*)$" },
})

hl.window_rule({
	name = "KeePassXC-no-share",
	no_screen_share = true,
	match = { class = "(org.keepassxc.KeePassXC)" },
})

-- Brave browser opacity override
hl.window_rule({
	name = "brave-opacity",
	opacity = "1.0 override",
	match = { class = "brave-browser" },
})

-- Brave browser YouTube border
hl.window_rule({
	name = "brave-youtube-border",
	border_color = "rgb(FF0000)",
	match = { class = "brave-browser", title = ".*- [yY]ou[tT]ube.*- Brave" },
})

-- virt-manager opacity
hl.window_rule({
	name = "virt-manager-opacity",
	opacity = "1.0 override",
	match = { class = "virt-manager" },
})

-- Steam workspace
hl.window_rule({
	name = "Steam",
	workspace = "3 silent",
	match = { class = "steam" },
})

-- Steam settings
hl.window_rule({
	name = "Steam-settings",
	no_screen_share = true,
	match = { title = "Steam-asetukset" },
})

-- Discord
hl.window_rule({
	name = "Discord",
	workspace = "4 silent",
	no_screen_share = true,
	match = { class = "vesktop" },
})

-- Shimeji mascot
hl.window_rule({
	name = "shimeji",
	float = true,
	no_blur = true,
	no_focus = true,
	no_shadow = true,
	border_size = 0,
	match = { class = "com-group_finity-mascot-Main" },
})

-- Gamescope Steam
hl.window_rule({
	name = "gamescope-steam",
	monitor = 1,
	match = { class = "(gamescope)", title = "(.*)(Steam)(.*)$" },
})

-- Game tags
hl.window_rule({
	name = "Counter-Strike",
	tag = "+game",
	immediate = true,
	match = { class = "^(cs2)$" },
})

hl.window_rule({
	name = "Minecraft",
	tag = "+game",
	opacity = "1.0 override",
	match = { title = "(Minecraft*)(.*)$" },
})

hl.window_rule({
	name = "Hytale",
	tag = "+game",
	match = { class = "HytaleClient" },
})

hl.window_rule({
	name = "Steam-games",
	tag = "+game",
	immediate = true,
	match = { class = "^(steam_app_\\d+)$" },
})

hl.window_rule({
	name = "Goat Simulator 3",
	tag = "+game",
	immediate = true,
	match = { class = "steam_app_850190" },
})

hl.window_rule({
	name = "BeamNG",
	tag = "+game",
	match = { class = "BeamNG.drive.x64" },
})

hl.window_rule({
	name = "hyprland share picker",
	float = true,
	match = { class = "hyprland-share-picker" },
})

-- Dialog float rules (loop)
local dialog_classes =
	{ "file_progress", "confirm", "dialog", "download", "notification", "error", "splash", "confirmreset" }
for _, cls in ipairs(dialog_classes) do
	hl.window_rule({ name = cls .. "-float", float = true, match = { class = "(" .. cls .. ")" } })
end

hl.window_rule({
	name = "open-file-float",
	float = true,
	size = "900 500",
	match = { title = "Open File" },
})

hl.window_rule({
	name = "branchdialog-float",
	float = true,
	match = { title = "branchdialog" },
})

hl.window_rule({
	name = "lxappearance-float",
	float = true,
	match = { class = "(Lxappearance)" },
})

hl.window_rule({
	name = "rofi-float",
	float = true,
	animation = "none",
	match = { class = "(Rofi)" },
})

hl.window_rule({
	name = "viewnior-float",
	float = true,
	match = { class = "(viewnior)" },
})

hl.window_rule({
	name = "feh-float",
	float = true,
	match = { class = "(feh)" },
})

hl.window_rule({
	name = "pavucontrol-qt-float",
	float = true,
	match = { class = "(pavucontrol-qt)" },
})

hl.window_rule({
	name = "pavucontrol-float",
	float = true,
	match = { class = "(pavucontrol)" },
})

hl.window_rule({
	name = "file-roller-float",
	float = true,
	size = "900 500",
	match = { class = "(file-roller)" },
})

hl.window_rule({
	name = "wlogout-fullscreen",
	fullscreen = true,
	match = { class = "(wlogout)" },
})

hl.window_rule({
	name = "wlogout-float",
	float = true,
	fullscreen = true,
	match = { title = "wlogout" },
})

hl.window_rule({
	name = "mpv-idle-inhibit",
	idle_inhibit = "focus",
	match = { class = "(mpv)" },
})

hl.window_rule({
	name = "celluloid-idle-inhibit",
	idle_inhibit = "focus",
	match = { class = "(celluloid)" },
})

hl.window_rule({
	name = "firefox-idle-inhibit",
	idle_inhibit = "fullscreen",
	match = { class = "(firefox)" },
})

hl.window_rule({
	name = "media-viewer-float",
	float = true,
	match = { title = "^(Media viewer)$" },
})

hl.window_rule({
	name = "volume-control-float",
	float = true,
	size = "800 600",
	move = "(75) ((monitor_h*0.44))",
	match = { title = "^(Volume Control)$" },
})

hl.window_rule({
	name = "pip-float",
	float = true,
	match = { title = "^(Picture-in-Picture)$" },
})

-- XWayland video bridge fixes
hl.window_rule({
	name = "xwayland-video-bridge-fixes",
	match = { class = "xwaylandvideobridge" },
	no_initial_focus = true,
	no_focus = true,
	no_anim = true,
	no_blur = true,
	max_size = "1 1",
	opacity = 0.0,
})

---
---- LAYER RULES ----
---

hl.layer_rule({
	name = "vicinae-blur",
	match = { namespace = "vicinae" },
	blur = true,
	ignore_alpha = 0,
})

---
---- WORKSPACES ----
---

-- Workspace for LG TV
hl.workspace_rule({
	workspace = "tv",
	monitor = "desc:LG Electronics LG TV SSCR2 0x01010101",
	default = true,
})

-------------------------
---- BINDS & PLUGINS ----
-------------------------

require("UserConfigs.UserKeybinds")
require("hyprland-gui")
-- require("UserConfigs.ENVariables")  -- commented out in original hyprland.conf
