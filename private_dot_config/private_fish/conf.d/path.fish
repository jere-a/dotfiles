# Bun environment
set -gx BUN_INSTALL (set -q XDG_DATA_HOME; and echo $XDG_DATA_HOME; or echo "$HOME/.local/share")/bun

# Add your paths
fish_add_path --append $HOME/go/bin
fish_add_path --append $HOME/flutter-sdk/flutter/bin
fish_add_path --append $HOME/.deno/bin
fish_add_path --append $HOME/.local/share/flatpak/exports/bin
fish_add_path --append /var/lib/flatpak/exports/bin
fish_add_path --append $HOME/.cargo/bin
fish_add_path --append $HOME/.local/bin
fish_add_path --append $HOME/.console-ninja/.bin
fish_add_path --append $BUN_INSTALL/bin
fish_add_path --append $HOME/.npm-global/bin

# libvirt default URI
set -gx LIBVIRT_DEFAULT_URI "qemu:///system"

# Load Bun if it exists
if test -s "$HOME/.bun/_bun"
    source "$HOME/.bun/_bun"
end

# Cargo environment
set -gx CARGO_HOME (set -q XDG_DATA_HOME; and echo $XDG_DATA_HOME; or echo "$HOME/.local/share")/cargo

# Podman/Docker host socket
set -gx DOCKER_HOST "unix://$XDG_RUNTIME_DIR/podman/podman.sock"

# Environment variables
set -gx SUDO_PROMPT (tput setab 1; tput setaf 7; tput bold)"[sudo]"(tput sgr0)" "(tput setaf 6)"password for"(tput sgr0)" "(tput setaf 5)"%p"(tput sgr0)": "

set -gx SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS 0
set -gx MINETEST_USER_PATH "$XDG_DATA_HOME/luanti"
set -gx MPLAYER_HOME "$XDG_CONFIG_HOME/mplayer"
set -gx W3M_DIR "$XDG_STATE_HOME/w3m"

set -gx MANGOHUD 1

set -gx TERMINFO "$XDG_DATA_HOME/terminfo"
set -gx TERMINFO_DIRS "$XDG_DATA_HOME/terminfo:/usr/share/terminfo"

set -gx NODE_COMPILE_CACHE ~/.cache/nodejs-compile-cache

set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx SUDO_EDITOR nvim
