set_parallel_downloads() {
  local conf="/etc/pacman.conf"
  local value="$1"

  # If no value is provided, prompt the user
  if [[ -z "$value" ]]; then
    read -rp "Enter desired ParallelDownloads value (1-20): " value
  fi

  # Validate input is a number between 1 and 20
  if [[ ! "$value" =~ ^[0-9]+$ || "$value" -lt 1 || "$value" -gt 20 ]]; then
    echo "❌ Invalid input. Please enter a number between 1 and 20."
    return 1
  fi

  # Modify or add the setting
  if grep -q '^\s*#\?\s*ParallelDownloads\s*=' "$conf"; then
    sudo sed -i "s/^#\?\s*ParallelDownloads\s*=.*/ParallelDownloads = $value/" "$conf"
  else
    echo "ParallelDownloads = $value" | sudo tee -a "$conf" > /dev/null
  fi

  echo "✅ ParallelDownloads set to $value in $conf"
}


: <<'END_COMMENT'

# set_parallel_downloads_prompte() {
  local conf="/etc/pacman.conf"
  local value

  # Prompt user
  read -rp "Enter desired ParallelDownloads value (1-20) [5]: " value
  value="${value:-5}"


  # Validate input is a number between 1 and 20
  if [[ ! "$value" =~ ^[0-9]+$ || "$value" -lt 1 || "$value" -gt 20 ]]; then
    echo "Invalid input. Please enter a number between 1 and 20."
    return 1
  fi

  # Modify or add the setting
  if grep -q '^\s*#\?\s*ParallelDownloads\s*=' "$conf"; then
    sudo sed -i "s/^#\?\s*ParallelDownloads\s*=.*/ParallelDownloads = $value/" "$conf"
  else
    echo "ParallelDownloads = $value" | sudo tee -a "$conf" > /dev/null
  fi

  echo "✅ ParallelDownloads set to $value in $conf"
}

set_parallel_downloads() {
  local value="${1:-5}"
  local conf="/etc/pacman.conf"

  if ! grep -q '^\s*#\?\s*ParallelDownloads' "$conf"; then
    echo "ParallelDownloads = $value" | sudo tee -a "$conf" > /dev/null
  else
    sudo sed -i "s/^#\?\s*ParallelDownloads\s*=.*/ParallelDownloads = $value/" "$conf"
  fi
}

END_COMMENT