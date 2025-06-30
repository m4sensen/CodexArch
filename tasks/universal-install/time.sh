separator "="
logHeading "Step 02: Time"
separator "="

# Sync time from the internet
timedatectl
timedatectl set-ntp true
timedatectl status
# timedatectl list-timezones

ln -sf "/usr/share/zoneinfo/($TIMEZONE:-America/New_York)" /etc/localtime
logSuccess "Timezone set to $TIMEZONE"

# Generate hardware clock: set the hardware clock (RTC) to the current system time (sys).
hwclock --systohc