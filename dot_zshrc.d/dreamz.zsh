# Set the directory we want to store zinit and plugins
#ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
#if [ ! -d "$ZINIT_HOME" ]; then
#   mkdir -p "$(dirname $ZINIT_HOME)"
#   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
#fi

# Source/Load zinit
#source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
# zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
#zinit ice wait lucid; zinit light zsh-users/zsh-syntax-highlighting
#zinit light zsh-users/zsh-completions
#zinit light zsh-users/zsh-autosuggestions
#zinit ice wait lucid; zinit light Aloxaf/fzf-tab

# Add in snippets
#zinit ice wait lucid; zinit snippet OMZP::git
#zinit ice wait lucid; zinit snippet OMZP::sudo
#zinit ice wait lucid; zinit snippet OMZP::archlinux
# zinit snippet OMZP::aws
# zinit snippet OMZP::kubectl
# zinit snippet OMZP::kubectx
#zinit ice wait lucid; zinit snippet OMZP::command-not-found

#zinit cdreplay -q


# History
HISTSIZE=50000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'
alias vim='nvim'
alias c='clear'

# Shell integrations
#eval "$(fzf --zsh)"
#eval "$(zoxide init zsh)"
