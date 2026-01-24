export DESKTOP_ENV="null"

# AutoStart startx
if [ "$DESKTOP_ENV" = "startx" ] && [ -z "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
  mkdir -p ~/.cache
  exec startx >> ~/.cache/startx.log 2>&1
fi

# Auto start Hyprland on tty1
if [ "$DESKTOP_ENV" = "hyprland" ] && [ -z "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
  exec Hyprland > ~/.cache/hyprland.log 2>&1
fi

if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" -eq 6 ]; then
  exec gamescope -e -- /usr/bin/steam -tenfoot
fi

# Created by `pipx` on 2024-03-20 14:37:10
export PATH="$PATH:/home/jere/.local/bin"
