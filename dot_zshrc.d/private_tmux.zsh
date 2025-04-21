if [[ -z "$TMUX" && "$TERM_PROGRAM" != "vscode" && -n "$PS1" ]]; then
  if [[ -n "$SSH_CLIENT" ]]; then
    client_id=$(echo $SSH_CLIENT | awk '{print $1}' | tr '.' '_')
    session_name="ssh_${USER}_${client_id}"
  else
    session_name="main_${USER}"
  fi

  if tmux has-session -t "$session_name" 2>/dev/null; then
    exec tmux attach-session -t "$session_name"
  else
    exec tmux new-session -s "$session_name"
  fi
fi

