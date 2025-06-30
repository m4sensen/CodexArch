separator "="
logTitle "Step 02: Time"
separator "="

# Sync time from the internet
timedatectl
timedatectl set-ntp true
timedatectl status
# timedatectl list-timezones

# Set timezone
while true; do
    read -rp "Enter your timezone (e.g., America/New_York): " TIMEZONE

    if [ -f "/usr/share/zoneinfo/$TIMEZONE" ]; then
    echo "TIMEZONE=$TIMEZONE" > "$PROJECT_DIR/config/codexArch.cfg"
    ln -sf "/usr/share/zoneinfo/($TIMEZONE:-America/New_York)" /etc/localtime
    logSuccess "Timezone set to $TIMEZONE"
    break
    else
    logError "Timezone '$TIMEZONE' does not exist."
    logChoiceLabel "Options:"
        logChoice "[1] Try again"
        logChoice "[2] Exit"
        read -rp "Select an option : " choice

        case "$choice" in
            1) continue ;;
            2) echo "Exiting."; exit 1 ;;
            *) echo "Invalid choice." ;;
        esac
    fi
done


# Generate hardware clock: set the hardware clock (RTC) to the current system time (sys).
hwclock --systohc