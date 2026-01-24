# AGENTS.md

## Build/Lint/Test Commands
- No build system configured (personal zsh config)
- No linting tools configured
- No test framework configured
- Use `source ~/.zshrc` to reload configuration
- Use `nvim` as default editor for editing files

## Code Style Guidelines

### Shell Scripts (.zsh, .sh)
- Use 2-space indentation (preferred) or tabs (existing files may use either)
- Use `#!/bin/zsh` or `#!/bin/bash` shebangs
- Quote variables: `"$VAR"` not `$VAR`
- Use `[[ ]]` for conditionals instead of `[ ]`
- Functions: `function_name() { ... }` (with or without `function` keyword)
- Error handling: Use `if [[ $? -ne 0 ]]; then` pattern, not `set -e`
- Comments: `# brief description` on same line or above

### Naming Conventions
- Functions: `lowercase_with_underscores` (e.g., `compile_then_source`)
- Variables: `lowercase_with_underscores` for locals, `UPPER_CASE` for globals
- Files: `descriptive_name.zsh` or `descriptive_name.sh`

### Imports/Dependencies
- Source files with: `source /path/to/file.zsh` or `source_file /path/to/file.zsh`
- Use `compile_then_source` for performance optimization on large files
- Use `local` variables within functions to avoid global pollution

### Performance Patterns
- Use `compile_then_source` function for large configuration files
- Cache compiled versions in `~/.zsh_cache/`
- Check file modification times before recompiling

### Formatting
- Max line length: 100 characters
- One command per line
- Group related functions together
- Use consistent indentation within each file