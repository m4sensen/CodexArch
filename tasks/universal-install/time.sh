separator "="
logTitle "Step 02: Time"
separator "="

# Sync time from the internet
timedatectl
timedatectl set-ntp true
timedatectl status
# timedatectl list-timezones

# Set timezone

ln -sf "/usr/share/zoneinfo/America/New_York" /etc/localtime
echo "TIMEZONE=$TIMEZONE" > "$PROJECT_DIR/config/codexArch.cfg"
logSuccess "Timezone set to $TIMEZONE"

# Generate hardware clock: set the hardware clock (RTC) to the current system time (sys).
hwclock --systohc