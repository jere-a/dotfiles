if [ -z "$TMUX" ] && [ "$TERM_PROGRAM" != "vscode" ]; then
  if [ -n "$SSH_CLIENT" ]; then
    client_id=$(echo $SSH_CLIENT | awk '{print $1}' | tr '.' '_')
    session_name="ssh_${client_id}"
  else
    session_name="$USER"
  fi
  tmux has-session -t "$session_name" 2>/dev/null \
  && tmux attach-session -t "$session_name" \
  || tmux new-session -s "$session_name"
fi

