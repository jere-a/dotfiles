# Environment variables (fast, no -U!)

set -gx CLICOLOR 1

set -gx LS_COLORS 'no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32'

# Man page colors
set -gx MANPAGER 'bat -l man -p'
