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
