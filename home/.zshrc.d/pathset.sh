set_path(){

    # Check if user id is 1000 or higher
    [ "$(id -u)" -ge 1000 ] || return

    for i in "$@";
    do
        # Check if the directory exists
        [ -d "$i" ] || continue

        # Check if it is not already in your $PATH.
        echo "$PATH" | grep -Eq "(^|:)$i(:|$)" && continue

        # Then append it to $PATH and export it
        export PATH="${PATH}:$i"
    done
}

# export PATH="/home/jere/.deno/bin:$PATH"

# PATH=~/.console-ninja/.bin:$PATH
# export PATH=$PATH:"$HOME/.local/bin:$HOME/.cargo/bin:/var/lib/flatpak/exports/bin:/.local/share/flatpak/exports/bin"

# alias ls="ls --color"

# Created by `pipx` on 2024-03-20 14:37:10
# export PATH="/home/jere/.local/bin:$PATH"

# export PATH=$PATH:$HOME/.local/bin

set_path "$HOME/.console-ninja/.bin"
set_path "$HOME/.local/bin"
set_path "$HOME/.cargo/bin"
set_path "/var/lib/flatpak/exports/bin"
set_path "/.local/share/flatpak/exports/bin"
set_path "$HOME/.deno/bin"
set_path "$HOME/flutter-sdk/flutter/bin"
set_path "$HOME/go/bin"

export GTK_THEME=Adwaita:dark
export GTK2_RC_FILES="/usr/share/themes/Adwaita-dark/gtk-2.0/gtkrc"
export QT_STYLE_OVERRIDE=Adwaita-Dark
export SUDO_PROMPT="$(tput setab 1 setaf 7 bold)[sudo]$(tput sgr0) $(tput setaf 6)password for$(tput sgr0) $(tput setaf 5)%p$(tput sgr0): "
