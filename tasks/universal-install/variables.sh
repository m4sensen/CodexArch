separator "="
logHeading "Step 01: Variable configuration"
separator "*"
lsblk   # List block devices so the user can see available disks
separator "*"

# Set timezone
while true; do
    read -rp "Enter your timezone (e.g., America/New_York): " TIMEZONE

    if [ -f "/usr/share/zoneinfo/$TIMEZONE" ]; then
    echo "TIMEZONE=$TIMEZONE" >> "$PROJECT_DIR/config/codexArch.cfg"
    break
    else
    logError "Timezone '$TIMEZONE' does not exist."
    logChoiceLabel "Options:"
        logChoice "[1] Try again"
        logChoice "[2] Exit"
        read -rp "Select an option [1/2]: " choice

        case "$choice" in
            1) continue ;;
            2) echo "Exiting."; exit 1 ;;
            *) echo "Invalid choice." ;;
        esac
    fi
done












# Ask the user to select a disk, loop until valid or exit
while true; do
    read -rp "Enter disk device (e.g., /dev/sda): " DISK

    if [ -b "$DISK" ]; then
        mkdir -p "$PROJECT_DIR/config"
        echo "DISK=$DISK" >> "$PROJECT_DIR/config/codexArch.cfg"
        logSuccess "Disk path saved to config."
        break
    else
        logError "$DISK is not a valid block device."
        logChoiceLabel "Options:"
        logChoice "  [1] Try again"
        logChoice "  [2] Exit"
        read -rp "Select an option [1/2]: " choice

        case "$choice" in
            1) continue ;;
            2) echo "Exiting."; exit 1 ;;
            *) echo "Invalid choice." ;;
        esac
    fi
done

# Get total disk size
DISK_SIZE_BYTES=$(blockdev --getsize64 "$DISK")
DISK_SIZE_GiB=$((DISK_SIZE_BYTES / 1024 / 1024 / 1024))

logInfo "Disk size: $DISK_SIZE_GiB"
echo "DISK_SIZE_GiB=$DISK_SIZE_GiB" >> "$PROJECT_DIR/config/codexArch.cfg"
logSuccess "Disk size saved to config."

# Prompt for EFI size
read -rp "Enter EFI partition size: " EFI_PART_SIZE_GiB
EFI_PART_SIZE_GiB=${EFI_PART_SIZE_GiB:-1}
echo "EFI_PART_SIZE_GiB=$EFI_PART_SIZE_GiB" >> "$PROJECT_DIR/config/codexArch.cfg"
logSuccess "EFI size saved to config."

# Prompt for ROOT size with % support
read -rp "Enter ROOT partition size (e.g., 40G or 60%): " ROOT_PART_INPUT

if [[ "$ROOT_PART_INPUT" =~ ^([0-9]{1,3})%$ ]]; then
    PERCENT=${BASH_REMATCH[1]}
    ROOT_PART_SIZE_GiB=$(echo "($DISK_SIZE_GiB * $PERCENT + 99) / 100")
else
    ROOT_PART_SIZE="$ROOT_PART_INPUT"
fi

echo "ROOT_PART_SIZE=$ROOT_PART_SIZE" >> "$PROJECT_DIR/config/codexArch.cfg"
logSuccess "EFI size saved to config."


cat "$PROJECT_DIR/config/codexArch.cfg"

read -p "Press enter to continue :"