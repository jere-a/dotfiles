-- AGS framework style binds

-- Essentials for beginners

-- bind = Super, T, exec, foot
-- bind = , Super, exec, true
-- bind = Ctrl+Super, T, exec, ~/.config/ags/scripts/color_generation/switchwall.sh

-- Actions

-- Screenshot, Record, OCR, Color picker, Clipboard history
-- bind = Super, V, exec, pkill fuzzel || cliphist list | fuzzel --no-fuzzy --dmenu | cliphist decode | wl-copy
hl.bind("SUPER + Period", hl.dsp.exec_cmd("pkill fuzzel || ~/.local/bin/fuzzel-emoji"))
-- bind = Ctrl+Shift+Alt, Delete, exec, pkill wlogout || wlogout -p layer-shell
-- bind = Super+Shift, S, exec, ~/.config/ags/scripts/grimblast.sh --freeze copy area
-- bind = Super+Shift+Alt, S, exec, grim -g \"$(slurp)\" - | swappy -f -
-- OCR
-- bind = Super+Shift,T,exec,grim -g \"$(slurp $SLURP_ARGS)\" \"tmp.png\" && tesseract -l eng \"tmp.png\" - | wl-copy && rm \"tmp.png\"
-- bind = Ctrl+Super+Shift,S,exec,grim -g \"$(slurp $SLURP_ARGS)\" \"tmp.png\" && tesseract \"tmp.png\" - | wl-copy && rm \"tmp.png\"
hl.bind("SUPER + SHIFT + C", hl.dsp.exec_cmd("hyprpicker -a"))
hl.bind("Print", hl.dsp.exec_cmd("grim - | wl-copy"), { locked = true })
hl.bind("CTRL + Print", hl.dsp.exec_cmd([[mkdir -p ~/Kuvat/Kuvakaappaukset && ~/.config/ags/scripts/grimblast.sh copysave screen ~/Kuvat/Kuvakaappaukset/Screenshot_"$(date '+%Y-%m-%d_%H.%M.%S')".png]]), { locked = true })
-- Recording stuff
-- bind = Super+Alt, R, exec, ~/.config/ags/scripts/record-script.sh
-- bind = Ctrl+Alt, R, exec, ~/.config/ags/scripts/record-script.sh --fullscreen
-- bind = Super+Shift+Alt, R, exec, ~/.config/ags/scripts/record-script.sh --fullscreen-sound

-- Session

-- bind = Ctrl+Super, L, exec, ags run-js 'lock.lock()'
hl.bind("SUPER + L", hl.dsp.exec_cmd("loginctl lock-session"))
-- bind = Super+Shift, L, exec, loginctl lock-session
-- bindl = Super+Shift, L, exec, sleep 0.1 && systemctl suspend || loginctl suspend
-- bind = Ctrl+Shift+Alt+Super, Delete, exec, systemctl poweroff || loginctl poweroff

-- Apps

-- bind = Super, T, exec,
-- bind = Super, Z, exec, Zed
hl.bind("SUPER + C", hl.dsp.exec_cmd("code"))
-- bind = Super, E, exec, nautilus --new-window
-- bind = Super+Alt, E, exec, thunar
-- bind = Super, W, exec, google-chrome-stable
-- bind = Ctrl+Super, W, exec, firefox
-- bind = Super, X, exec, gnome-text-editor --new-window
-- bind = Super+Shift, W, exec, wps
hl.bind("SUPER + I", hl.dsp.exec_cmd([[XDG_CURRENT_DESKTOP="gnome" gnome-control-center]]))
hl.bind("CTRL + SUPER + V", hl.dsp.exec_cmd("pwvucontrol"))
hl.bind("CTRL + SUPER + SHIFT + V", hl.dsp.exec_cmd("easyeffects"))
-- bind = Ctrl+Shift, Escape, exec, gnome-system-monitor
-- bind = Ctrl+Super, Slash, exec, pkill anyrun || anyrun
