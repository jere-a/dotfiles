update_path_variable() {
  # Check if user id is 1000 or higher
  if [ "$(id -u)" -ge 1000 ]; then
    for directory in "$@"; do
      # Check if the directory exists
      if [ ! -d "$directory" ]; then
        continue
      fi

      # Check if it is already in your $PATH.
      if [[ "$PATH" == *"$directory"* ]]; then
        continue
      fi

      # Then append it to $PATH and export it
      PATH=$PATH:$directory
    done
  else
    echo "Error: User ID must be 1000 or higher."
  fi
}

# export PATH="/home/jere/.deno/bin:$PATH"

# PATH=~/.console-ninja/.bin:$PATH
# export PATH=$PATH:"$HOME/.local/bin:$HOME/.cargo/bin:/var/lib/flatpak/exports/bin:/.local/share/flatpak/exports/bin"

# alias ls="ls --color"

# Created by `pipx` on 2024-03-20 14:37:10
# export PATH="/home/jere/.local/bin:$PATH"

# export PATH=$PATH:$HOME/.local/bin
update_path_variable "$HOME/go/bin" "$HOME/flutter-sdk/flutter/bin" "$HOME/.deno/bin" "$HOME/.local/share/flatpak/exports/bin" "/var/lib/flatpak/exports/bin" "$HOME/.cargo/bin" "$HOME/.local/bin" "$HOME/.console-ninja/.bin"

export GTK_THEME=Arc:darker
export GTK2_RC_FILES="/usr/share/themes/Adwaita-dark/gtk-2.0/gtkrc"
export QT_STYLE_OVERRIDE=Arc-Darker
export SUDO_PROMPT="$(tput setab 1 setaf 7 bold)[sudo]$(tput sgr0) $(tput setaf 6)password for$(tput sgr0) $(tput setaf 5)%p$(tput sgr0): "
export SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS=0
export IPFS_PATH="$XDG_DATA_HOME"/ipfs
export MINETEST_USER_PATH="$XDG_DATA_HOME"/luanti
export MPLAYER_HOME="$XDG_CONFIG_HOME"/mplayer
export W3M_DIR="$XDG_STATE_HOME/w3m"

export TERMINFO="$XDG_DATA_HOME"/terminfo
export TERMINFO_DIRS="$XDG_DATA_HOME"/terminfo:/usr/share/terminfo

export NODE_COMPILE_CACHE=~/.cache/nodejs-compile-cache

export EDITOR=nvim
export VISUAL=nvim
export SUDO_EDITOR=nvim

compile_then_source source "$HOME/.zshrc.d/christitustech/special.zsh"
