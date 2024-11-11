export DESKTOP_ENV="hyprland"

# AutoStart startx
if [ "$DESKTOP_ENV" = "startx" ] && [ -z "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
  mkdir -p ~/.cache
  exec startx >> ~/.cache/startx.log 2>&1
fi

# Auto start Hyprland on tty1
if [ "$DESKTOP_ENV" = "hyprland" ] && [ -z "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
  mkdir -p ~/.cache
  exec Hyprland > ~/.cache/hyprland.log 2>&1
fi

# Created by `pipx` on 2024-03-20 14:37:10
export PATH="$PATH:/home/jere/.local/bin"
