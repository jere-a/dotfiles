#!/bin/bash
# Refresh script for wallpaper and system state
# Called when gamemode is disabled to restore normal state

# Refresh swww wallpaper if it's running
if pgrep -x "swww-daemon" >/dev/null; then
    swww img "$HOME/.config/rofi/.current_wallpaper" 2>/dev/null || true
fi

# Small delay to ensure everything loads
sleep 0.1