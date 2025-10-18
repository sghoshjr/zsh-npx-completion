#compdef npx
###-begin-npx-completions-###
#
# npx autocompletion script
#
# Installation: add 'source ~/npx_completion.zsh' in ~/.zshrc
#
#
_npx_custom_completion() {
  # Enable null_glob locally to handle empty directories
  setopt localoptions null_glob

  # Use unique array to automatically deduplicate
  typeset -aU binaries
  local file bin_dir

  # Scan local node_modules/.bin first (priority)
  if [[ -d "./node_modules/.bin" ]]; then
    for file in ./node_modules/.bin/[^.]*; do
      [[ -f "$file" ]] && binaries+=(${file:t})
    done
  fi

  # Scan npx cache directories (~/.npm/_npx/<hash>/node_modules/.bin)
  local npx_cache_dir="$HOME/.npm/_npx"
  if [[ -d "$npx_cache_dir" ]]; then
    for bin_dir in "$npx_cache_dir"/*/node_modules/.bin(N); do
      if [[ -d "$bin_dir" ]]; then
        for file in "$bin_dir"/[^.]*; do
          [[ -f "$file" ]] && binaries+=(${file:t})
        done
      fi
    done
  fi

  if (( ${#binaries} > 0 )); then
    _describe 'npx packages' binaries
  else
    _message 'no npx packages found'
  fi
}

compdef _npx_custom_completion npx
###-end-npx-completions-###
