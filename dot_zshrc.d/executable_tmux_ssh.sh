if [[ -z $TMUX ]] && [[ -n $SSH_TTY ]]; then
    exec byobu-tmux new-session -A -s ssh_session
fi
