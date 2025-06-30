install() {
  local packages=("$@")
  local status=1

  if [[ ${#packages[@]} -eq 0 ]]; then
    logError "No packages specified to install."
    return 1
  fi

  logAttempt "Installing packages: ${packages[*]}"

  while (( status != 0 )); do
    if pacman -Sy --noconfirm "${packages[@]}"; then
      logSuccess "Successfully installed: ${packages[*]}"
      status=0
    else
      logError "Failed to install: ${packages[*]}"
      echo -e "${QUESTION_EMOJI} Press Enter to retry or Ctrl+C to cancel."
      read -r
    fi
  done
}