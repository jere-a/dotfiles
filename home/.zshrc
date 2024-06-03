# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
# HISTFILE=~/.histfile
# HISTSIZE=10000
# SAVEHIST=1000
setopt autocd
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/jere/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall



if [ ! -d "$HOME/.zshrc.d" ]; then
	mkdir -p "$HOME/.zshrc.d";
fi

for cfg in $HOME/.zshrc.d/*.zsh; do
    . "$cfg"
done

if [ -d "$HOME/.zshrc.d/christitustech" ]; then
  for cfgCTT in $HOME/.zshrc.d/christitustech/*.zsh; do
      . "$cfgCTT"
  done
fi
unset -v cfg
unset -v cfgCTT

#######################################################
# MACHINE SPECIFIC ALIAS'S
#######################################################

# Alias's for SSH
# alias SERVERNAME='ssh YOURWEBSITE.com -l USERNAME -p PORTNUMBERHERE'

# Alias's to change the directory
# alias web='cd /var/www/html'

# Alias's to mount ISO files
# mount -o loop /home/NAMEOFISO.iso /home/ISOMOUNTDIR/
# umount /home/NAMEOFISO.iso
# (Both commands done as root only.)

#######################################################
# GENERAL ALIAS'S
#######################################################
# To temporarily bypass an alias, we precede the command with a \
# EG: the ls command is aliased, but to use the normal ls command you would type \ls

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
# alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# KITTY - alias to be able to use kitty features when connecting to remote servers(e.g use tmux on remote server)

# alias kssh="kitty +kitten ssh"


alias rr="curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash"
alias cls="clear"

export PATH="/home/jere/.deno/bin:$PATH"

PATH=~/.console-ninja/.bin:$PATH
export PATH=$PATH:"$HOME/.local/bin:$HOME/.cargo/bin:/var/lib/flatpak/exports/bin:/.local/share/flatpak/exports/bin"

eval "$(starship init zsh)"

# alias ls="ls --color"

# Created by `pipx` on 2024-03-20 14:37:10
export PATH="/home/jere/.local/bin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source "$HOME/.homesick/repos/homeshick/homeshick.sh"
fpath=($HOME/.homesick/repos/homeshick/completions $fpath)