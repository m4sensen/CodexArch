require_file() {
  local file="$1"

  if [ -f "$file" ]; then
    logAttempt "load $file"
    source "$file" || {
    logError "Failed to load required file $file."
    Exit
    }
    logSuccess "Required file $file, loaded successfully."
  else
    logError "Required file $file not found "
    Exit
  fi
}