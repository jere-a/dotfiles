# FZF keybind options
set -gx FZF_CTRL_T_OPTS "
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

set -gx FZF_CTRL_R_OPTS "
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

set -gx FZF_ALT_C_OPTS "
  --walker-skip .git,node_modules,target
  --preview 'tree -C {}'"

# Append to existing FZF_DEFAULT_OPTS safely
set -gx FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS
  --color=fg:#d0d0d0,fg+:#d0d0d0,bg:#121212,bg+:#262626
  --color=hl:#5f87af,hl+:#5fd7ff,info:#afaf87,marker:#87ff00
  --color=prompt:#d7005f,spinner:#af5fff,pointer:#af5fff,header:#87afaf
  --color=border:#262626,label:#aeaeae,query:#d9d9d9
  --border=rounded --border-label='' --preview-window=border-rounded --prompt='> '
  --marker='>' --pointer='◆' --separator='─' --scrollbar='│'"

# fd-based completion generators
function _fzf_compgen_path
    fd --hidden --follow --exclude ".git" . $argv[1]
end

function _fzf_compgen_dir
    fd --type d --hidden --follow --exclude ".git" . $argv[1]
end

# Custom fzf behavior per command
function _fzf_comprun
    set command $argv[1]
    set -e argv[1]

    switch $command
        case cd
            fzf --preview 'tree -C {} | head -200' $argv
        case export unset
            fzf --preview "eval 'echo \$'{}" $argv
        case ssh
            fzf --preview 'dig {}' $argv
        case '*'
            fzf --preview 'bat -n --color=always {}' $argv
    end
end
