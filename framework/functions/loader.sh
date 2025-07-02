load_functions() {

  local importable_dirs=("$@")
  local loaded_importable_count=0

  for importable_dir in "${importable_dirs[@]}"; do
    if [[ -d "$importable_dir" ]]; then
      echo "[SEARCH] $DATE Searching for importable files in: $importable_dir"
     
      for importable_file in "$importable_dir"/*.sh; do
        if [[ -f "$importable_file" ]]; then
          echo "[SOURCE] $DATE Sourcing: $importable_file"
          source "$importable_file" || {
            echo "[ERROR] $DATE Failed to source $importable_file. Aborting." >&2
            exit 1
          }
          ((loaded_importable_count++))
        else
          echo "[SKIP] $DATE Skipping non-existent or non-regular importable_file: $importable_file"
        fi
      done
    else
      echo "[ERROR] $DATE Required directory not found: $importable_dir" >&2
      exit 1
    fi
  done

  if [[ "$loaded_importable_count" -eq 0 ]]; then
    echo "[ERROR] $DATE No library or function files were loaded." >&2
    exit 1
  else
    echo "[SUCCESS] $DATE Successfully loaded $loaded_importable_count library and function files."
  fi
}
