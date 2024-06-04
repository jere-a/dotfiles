#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
[ -r /home/jere/.byobu/prompt ] && . /home/jere/.byobu/prompt   #byobu-prompt#

PATH=~/.console-ninja/.bin:$PATH