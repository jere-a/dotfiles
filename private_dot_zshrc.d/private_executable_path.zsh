update_path_variable() {
  [[ "$(id -u)" -lt 1000 ]] && return 1
  
  for directory in "$@"; do
    [[ -d "$directory" && "$PATH" != *"$directory"* ]] && PATH="$PATH:$directory"
  done
}

# export PATH="/home/jere/.deno/bin:$PATH"

# PATH=~/.console-ninja/.bin:$PATH
# export PATH=$PATH:"$HOME/.local/bin:$HOME/.cargo/bin:/var/lib/flatpak/exports/bin:/.local/share/flatpak/exports/bin"

# alias ls="ls --color"

# Created by `pipx` on 2024-03-20 14:37:10
# export PATH="/home/jere/.local/bin:$PATH"

# export PATH=$PATH:$HOME/.local/bin
update_path_variable "$HOME/go/bin" "$HOME/flutter-sdk/flutter/bin" "$HOME/.deno/bin" "$HOME/.local/share/flatpak/exports/bin" "/var/lib/flatpak/exports/bin" "$HOME/.cargo/bin" "$HOME/.local/bin" "$HOME/.console-ninja/.bin"

#export GTK_THEME=Arc:darker
#export GTK2_RC_FILES="/usr/share/themes/Adwaita-dark/gtk-2.0/gtkrc"
#export QT_STYLE_OVERRIDE=Arc-Darker
export SUDO_PROMPT="$(tput setab 1 setaf 7 bold)[sudo]$(tput sgr0) $(tput setaf 6)password for$(tput sgr0) $(tput setaf 5)%p$(tput sgr0): "
export SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS=0
#export IPFS_PATH="$XDG_DATA_HOME"/ipfs
export MINETEST_USER_PATH="$XDG_DATA_HOME"/luanti
export MPLAYER_HOME="$XDG_CONFIG_HOME"/mplayer
export W3M_DIR="$XDG_STATE_HOME/w3m"

export MANGOHUD=1

export TERMINFO="$XDG_DATA_HOME"/terminfo
export TERMINFO_DIRS="$XDG_DATA_HOME"/terminfo:/usr/share/terminfo

export NODE_COMPILE_CACHE=~/.cache/nodejs-compile-cache

export EDITOR=nvim
export VISUAL=nvim
export SUDO_EDITOR=nvim






# Christitus specific
#######################################################
# SPECIAL FUNCTIONS
#######################################################

# Extracts any archive(s) (if unp isn't installed)
extract() {
	for archive in "$@"; do
		if [ -f "$archive" ]; then
			case $archive in
			*.tar.bz2) tar xvjf $archive ;;
			*.tar.gz) tar xvzf $archive ;;
			*.bz2) bunzip2 $archive ;;
			*.rar) rar x $archive ;;
			*.gz) gunzip $archive ;;
			*.tar) tar xvf $archive ;;
			*.tbz2) tar xvjf $archive ;;
			*.tgz) tar xvzf $archive ;;
			*.zip) unzip $archive ;;
			*.Z) uncompress $archive ;;
			*.7z) 7z x $archive ;;
                        *.xz) xz -d $archive ;;
			*) echo "don't know how to extract '$archive'..." ;;
			esac
		else
			echo "'$archive' is not a valid file!"
		fi
	done
}

# Searches for text in all files in the current folder
ftext() {
	# -i case-insensitive
	# -I ignore binary files
	# -H causes filename to be printed
	# -r recursive search
	# -n causes line number to be printed
	# optional: -F treat search term as a literal, not a regular expression
	# optional: -l only print filenames and not the matching lines ex. grep -irl "$1" *
	grep -iIHrn --color=always "$1" . | less -r
}

# Copy file with a progress bar
cpp() {
	set -e
	strace -q -ewrite cp -- "${1}" "${2}" 2>&1 |
		awk '{
	count += $NF
	if (count % 10 == 0) {
		percent = count / total_size * 100
		printf "%3d%% [", percent
		for (i=0;i<=percent;i++)
			printf "="
			printf ">"
			for (i=percent;i<100;i++)
				printf " "
				printf "]\r"
			}
		}
	END { print "" }' total_size="$(stat -c '%s' "${1}")" count=0
}

# Copy and go to the directory
cpg() {
	if [ -d "$2" ]; then
		cp "$1" "$2" && cd "$2"
	else
		cp "$1" "$2"
	fi
}

# Move and go to the directory
mvg() {
	if [ -d "$2" ]; then
		mv "$1" "$2" && cd "$2"
	else
		mv "$1" "$2"
	fi
}

# Create and go to the directory
mkdirg() {
	mkdir -p "$1"
	cd "$1"
}

# Goes up a specified number of directories  (i.e. up 4)
up() {
	local d=""
	limit=$1
	for ((i = 1; i <= limit; i++)); do
		d=$d/..
	done
	d=$(echo $d | sed 's/^\///')
	if [ -z "$d" ]; then
		d=..
	fi
	cd $d
}

# For some reason, rot13 pops up everywhere
rot13() {
	if [ $# -eq 0 ]; then
		tr '[a-m][n-z][A-M][N-Z]' '[n-z][a-m][N-Z][A-M]'
	else
		echo $* | tr '[a-m][n-z][A-M][N-Z]' '[n-z][a-m][N-Z][A-M]'
	fi
}

