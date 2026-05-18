-- Local vars
local scriptsDir = os.getenv("HOME") .. "/.config/hypr/scripts"
local configs = os.getenv("HOME") .. "/.config/hypr/configs"

-- See https://wiki.hyprland.org/Configuring/Keywords/
local mainMod = "SUPER"

-- See also Laptops.conf for laptops keybinds

--------------------
-- KEYBINDINGS --
--------------------

-- pypr gamemode
hl.bind(mainMod .. " + SHIFT + G", hl.dsp.exec_cmd("pypr gamemode"))

-- Terminal
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))

-- Groups
hl.bind(mainMod .. " + G", hl.dsp.group.toggle())
hl.bind(mainMod .. " + code:23", hl.dsp.group.active({ index = 1 }))
hl.bind(mainMod .. " + SHIFT + code:23", hl.dsp.group.active({ index = -1 }))

-- Window ops
hl.bind(mainMod .. " + K", hl.dsp.layout("swapsplit"))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.exec_cmd("hyprctl kill"))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd("hyprshutdown"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + SPACE", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(vicinae))
-- hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())  # dwindle
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- dwindle
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("hyprctl dispatch workspaceopt allfloat"))

-- Clipboard
hl.bind(
	mainMod .. " + V",
	hl.dsp.exec_cmd(
		"clipvault --database /tmp/db list | rofi -dmenu -display-columns 2 | clipvault --database /tmp/db get | wl-copy"
	)
)

-- Cycle windows
hl.bind(mainMod .. " + ALT + right", hl.dsp.window.cycle_next())
hl.bind(mainMod .. " + ALT + left", hl.dsp.window.cycle_next("prev"))

-- System
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("reboot"))
hl.bind(mainMod .. " + CTRL + SHIFT + S", hl.dsp.exec_cmd("shutdown -P 0"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd(suspend_cmd))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd(lock_cmd))

-- Toggle control center
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd("swaync-client -t -sw"))

-- Screenshot
hl.bind(
	"Print",
	hl.dsp.exec_cmd(
		[[sh -c 'REGION=$(slurp) || exit; grim -g "$REGION" - | wl-copy && wl-paste > ~/Kuvat/Kuvakaappaukset/Screenshot-$(date +%F_%T).png && notify-send "Screenshot of the region taken" -t 1000']]
	)
)
hl.bind(
	"SHIFT + Print",
	hl.dsp.exec_cmd(
		[[grim - | wl-copy && wl-paste > ~/Kuvat/Kuvakaappaukset/Screenshot-$(date +%F_%T).png && notify-send "Screenshot of the whole screen taken" -t 1000]]
	)
)

-- Audio keys
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })

-- Sleep / Airplane
hl.bind("XF86Sleep", hl.dsp.exec_cmd("systemctl suspend"), { locked = true })
hl.bind("XF86Rfkill", hl.dsp.exec_cmd(scriptsDir .. "/AirplaneMode.sh"), { locked = true })

-- Emoji picker
hl.bind(
	mainMod .. " + period",
	hl.dsp.exec_cmd(
		[[killall rofi || rofi -show emoji -emoji-format "{emoji}" -modi emoji -theme ~/.config/rofi/global/emoji]]
	)
)

-- Wlogout
hl.bind(mainMod .. " + escape", hl.dsp.exec_cmd("wlogout --protocol layer-shell -b 5 -T 400 -B 400"))

-- Start apps
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("uwsm-app -s a -- brave"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("uwsm-app -s a -- vesktop --wayland"))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("uwsm-app -s a -- ario"))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("uwsm-app -- mangohud /usr/bin/steam-native"))

-- Source AGS framework binds
require("hyprland.binds")

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Cycle monitor focus
hl.bind(mainMod .. " + Tab", hl.dsp.focus({ monitor = "+1" }))
hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.focus({ monitor = "-1" }))

-- Fullscreen
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + CTRL + F", hl.dsp.window.fullscreen(1))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i, on_current_monitor = true }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
-- hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
-- hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Scrolling layout: move columns
local scroll_mods = { "ALT", "ALT + SHIFT", "CTRL + ALT" }
local scroll_actions = {
	["ALT"] = {
		{ "comma", "move -col" },
		{ "period", "move +col" },
		{ "mouse_down", "move -col" },
		{ "mouse_up", "move +col" },
	},
	["ALT + SHIFT"] = {
		{ "comma", "colresize -conf" },
		{ "period", "colresize +conf" },
		{ "mouse_up", "colresize -conf" },
		{ "mouse_down", "colresize +conf" },
	},
	["CTRL + ALT"] = {
		{ "comma", "swapcol l" },
		{ "period", "swapcol r" },
		{ "mouse_down", "swapcol l" },
		{ "mouse_up", "swapcol r" },
	},
}

for _, mod in ipairs(scroll_mods) do
	for _, a in ipairs(scroll_actions[mod]) do
		hl.bind(mod .. " + " .. a[1], hl.dsp.layout(a[2]))
	end
end

-- █▀▄▀█ █▀█ █░█ █▀ █▀▀   █▄▄ █ █▄░█ █▀▄ █ █▄░█ █▀▀
-- █░▀░█ █▄█ █▄█ ▄█ ██▄   █▄█ █ █░▀█ █▄▀ █ █░▀█ █▄█
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Quick resize with mainMod + SHIFT + h/j/k/l
hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.resize({ x = -20, y = 0 }))
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.resize({ x = 0, y = 20 }))
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.resize({ x = 0, y = -20 }))
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.resize({ x = 20, y = 0 }))

-- For passthrough keyboard into a VM
-- hl.bind(mainMod .. " + ALT + P", hl.dsp.submap("passthru"))
-- hl.bind(mainMod .. " + ALT + P", hl.dsp.submap("reset"))
