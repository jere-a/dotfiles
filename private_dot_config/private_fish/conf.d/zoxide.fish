function __load_zoxide --on-event fish_prompt
    functions -e __load_zoxide
    zoxide init fish | source
end
