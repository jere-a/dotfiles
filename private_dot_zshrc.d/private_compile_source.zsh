function compile_then_source() {
  local method=$1
  local file=$2

  # Validate inputs
  if [[ $# -ne 2 ]]; then
    print -u2 "Usage: compile_then_source <method> <file>"
    return 1
  fi

  if [[ ! -f "$file" ]]; then
    print -u2 "File not found: $file"
    return 1
  fi

  # Create cache directory if needed
  local cache_dir="${file:h}/.zsh_cache"
  if [[ ! -d "$cache_dir" ]]; then
    mkdir -p "$cache_dir" || return 1
  fi

  # Compile if .zwc is missing or outdated
  local zwc_file="${file:r}.zwc"
  if [[ ! -f "$zwc_file" || "$zwc_file" -ot "$file" ]]; then
    if [[ -r "$file" && -w "${file:h}" ]]; then
      zcompile "$file" || {
        print -u2 "Failed to compile: $file"
        return 1
      }
    fi
  fi

  # Source the file
  builtin "$method" "$file" || return 1
}
