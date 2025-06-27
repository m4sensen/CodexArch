logAttempt "create swap on /dev/mapper/vg0-swap..."
if mkswap /dev/mapper/vg0-swap; then
  logSuccess "Swap created successfully."
else
  logError "Failed to create swap on /dev/mapper/vg0-swap."
  exit 1
fi

logAttempt "Enabling swap on /dev/mapper/vg0-swap..."
if swapon /dev/mapper/vg0-swap; then
  logSuccess "Swap enabled successfully."
else
  logError "Failed to enable swap on /dev/mapper/vg0-swap."
  exit 1
fi

log "Displaying block devices:"
lsblk -f
