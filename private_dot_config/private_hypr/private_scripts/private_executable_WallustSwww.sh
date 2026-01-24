#!/bin/bash
# Apply color scheme based on current wallpaper using wallust
# This script is called when gamemode is disabled to restore wallpaper colors

# Check if wallust is available and run it
if command -v wallust >/dev/null 2>&1; then
    wallust run "$HOME/.config/rofi/.current_wallpaper" 2>/dev/null || true
fi