center_text() {
  local text="$1"
  local term_width=$(tput cols)
  local text_length=${#text}

  if (( text_length >= term_width )); then
    # Text too long to center, just print it as is
    echo "$text"
  else
    local padding=$(( (term_width - text_length) / 2 ))
    printf "%*s%s\n" "$padding" "" "$text"
  fi
}

center_multiline_text() {
  local term_width=$(tput cols)
  while IFS= read -r line || [[ -n $line ]]; do
    local line_length=${#line}
    if (( line_length >= term_width )); then
      echo "$line"
    else
      local padding=$(( (term_width - line_length) / 2 ))
      printf "%*s%s\n" "$padding" "" "$line"
    fi
  done
}