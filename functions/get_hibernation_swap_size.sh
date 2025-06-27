# --- Get hibernation swap size in GiB, rounded up ---
get_hibernation_swap_size() {
  local ram_kib ram_mib raw_swap_gib rounded_swap_gib

  # Get total system RAM in KiB and convert to MiB
  ram_kib=$(grep MemTotal /proc/meminfo | awk '{print $2}')
  ram_mib=$(( (ram_kib + 1023) / 1024 ))

  # Calculate RAM * 1.2 in GiB (floating point)
  raw_swap_gib=$(awk "BEGIN { printf \"%.2f\", (${ram_mib} * 1.2) / 1024 }")

  # Round up to nearest whole number
  rounded_swap_gib=$(awk "BEGIN { printf \"%d\", int($raw_swap_gib + 0.999) }")

  echo "${rounded_swap_gib}G"
}


