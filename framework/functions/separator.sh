separator() {
  local pattern="${1:--}"
  local cols
  cols=$(tput cols)
  local line=""
  while ((${#line} < cols)); do
    line+="$pattern"
  done
  logSeparator "${line:0:cols}"
}
