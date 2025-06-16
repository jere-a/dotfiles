function compile_then_source() {
  local method=$1       # '.' or 'source'
  local file=$2         # file to source

  # Zsh: check if .zwc is missing or outdated
  if [[ ! -f $file.zwc && ! $file.zwc -nt $file ]]; then
    if [[ -r $file && -w ${file:h} ]]; then
      zcompile "${file:P}"
    fi
  fi

  # Source the file with any args
  builtin "$method" "$file"
}
