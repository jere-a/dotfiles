if status is-interactive
    set -U fish_color_command green
    set -U fish_color_error red
    set -U fish_color_param white
    set -U fish_color_comment brblack
    set -U fish_color_quote yellow

    starship init fish | source
end
