alias rr="curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash"
alias cls="clear"
alias npm="pnpm"
alias open="xdg-open"

[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"
# global


compile_then_source source "$HOME/.zshrc.d/christitustech/aliases.zsh"
