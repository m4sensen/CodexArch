FRAMEWORK_NAME="codexBash"
project_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

import_utils() {

  local utils_dirs=("$project_dir/libraries" "$project_dir/functions")
  local loaded_utils_count=0

  for utils_dir in "${utils_dirs[@]}"; do
    if [[ -d "$utils_dir" ]]; then
      echo "Searching for functions and libraries in: $utils_dir"
      # Use a for loop with globbing and check for existence before sourcing
      for file in "$utils_dir"/*.sh; do
        if [[ -f "$file" ]]; then
          echo "Sourcing: $file"
          # Using 'source' can be risky if files are untrusted.
          # Ensure these directories only contain trusted scripts.
          source "$file" || {
            echo "ERROR: Failed to source $file. Aborting." >&2
            return 1 # Return a non-zero status to indicate failure
          }
          ((loaded_utils_count++))
        else
          echo "Skipping non-existent or non-regular file: $file"
        fi
      done
    else
      echo "ERROR: Required directory not found: $utils_dir" >&2
      return 1 # Indicate failure if a utils directory is missing
    fi
  done

  if [[ "$loaded_utils_count" -eq 0 ]]; then
    echo "Warning: No library or function files were loaded."
  else
    echo "Successfully loaded $loaded_utils_count library and function files."
  fi
  return 0 # Indicate success
}

# --- Function to Toggle Emoji Display ---
emoji_toggle() {
  local name
  name="${1^^}_EMOJI" # Convert to uppercase: success → EMOJI_SUCCESS

  # Ensure USE_EMOJI is set and explicitly check for 'true'
  if [[ "${USE_EMOJI:-false}" == "true" ]]; then
    # Use parameter expansion with a default empty string
    # This prevents 'unbound variable' errors if ${!name} is not set
    printf "%s" "${!name:-}"
  fi
  return 0
}


# --- Function to Import CodexBash Configuration ---
import_codexBash_cfg() {
  local config_file
  # Using $0 is generally safe here as it refers to the script itself
  config_file="$project_dir/codexBash.cfg"

  if [[ -f "$config_file" ]]; then
    echo "Loading configuration from: $config_file"
    # Sourcing configuration files is generally safe if you trust the file.
    # Validate content if the file can be modified by untrusted sources.
    source "$config_file" || {
      logError "Failed to load configuration from $config_file. Aborting."
      return 1 # Indicate failure
    }
    echo "Configuration loaded successfully."
  else
    logError "Required configuration file not found: $config_file"
    echo "FATAL: Exiting $FRAMEWORK_NAME in 5s..." >&2
    return 1 # Indicate failure
  fi
  return 0
}

# --- Main Execution Flow ---

# Check if logError and logExit are defined after sourcing them or define them here.
# For this example, we've included them at the top.

# Attempt to import functions. Exit if it fails.
import_utils || { echo "Failed to initialize framework functions."; sleep 10; exit 1; }

# Attempt to import configuration. Exit if it fails.
import_codexBash_cfg || logExit "Failed to load framework configuration."

# Display framework information
hr "="
logSuccess "${RESET}${BOLD}${GREEN_500}${ITALIC}${FRAMEWORK_NAME} framework © Masensen${RESET},${GREEN_500}${BOLD} has been started successfully."
hr "="
logStart "Starting CodexArch ..."
require_file "$project_dir/menu.sh"
