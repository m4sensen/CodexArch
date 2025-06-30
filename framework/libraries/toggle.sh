toggle_emojis() {
  local name
  name="${1^^}_EMOJI" # Convert to uppercase: success → EMOJI_SUCCESS

  if [[ "${USE_EMOJI:-false}" == "true" ]]; then
    printf "%s" "${!name:-}"
  fi
  return 0
}

toggle_colors() {
  local name
  name="${1}"
  
  if [[ "${USE_COLORS:-false}" == "true" ]]; then
    printf "%s" "${!name:-}"
  fi
  return 0

}