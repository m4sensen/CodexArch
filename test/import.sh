import() {
  
  local module="$1"
  local from_key="$2"
  shift 2
  local paths=("$@")

if [[ -z "$module" || "$from_key" != "from" || -z "$path" ]]; then
  logError "Invalid or missing arguments"
  logHint "Usage: import <module> from <path>"
  return 1
fi



if [[ "$module" == "all"]]; then
  local imported_modules_count=0
  for path_dir in "${path_dirs[@]}"; do
    if [[ -d "$path_dir" ]]; then
      logSearch "modules in: $path_dir"
      for importable_file in "$path_dir"/*.cdx; do
        if [[ -f "$importable_file" ]]; then
          logAttempt "source: $importable_file"
          source "$importable_file" || {
            logError "Failed to source $importable_file. Aborting." >&2
            exit 1
          }
          ((imported_modules_count++))
        else
          logSkip "non-existent or non-regular importable_file: $importable_file"
        fi
      done
    else
      logError "Required directory not found: $path_dir" >&2
      exit 1
    fi
  done

  if [[ "$imported_modules_count" -eq 0 ]]; then
    logError "No library or function files were loaded." >&2
    exit 1
  else
    logSuccess "Successfully loaded $imported_modules_count library and function files."
  fi








}