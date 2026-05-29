function __load_atuin --on-event fish_prompt
    functions -e __load_atuin
    atuin init fish | source
    atuin pty-proxy init fish | source
end
