separator "_"
logTitle "Partitioning"
separator "_"




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
    ROOT_PART_SIZE_GiB="$ROOT_PART_INPUT"
fi

echo "ROOT_PART_SIZE_GiB=$ROOT_PART_SIZE_GiB" >> "$PROJECT_DIR/config/codexArch.cfg"
logSuccess "EFI size saved to config."


cat "$PROJECT_DIR/config/codexArch.cfg"

read -p "Press enter to continue :"









logAttempt "check if the variables exist"


# Convert to MiB
EFI_PART_SIZE_MiB=$((EFI_PART_SIZE_GiB * 1024))
ROOT_PART_SIZE_MiB=$((ROOT_PART_SIZE_GiB * 1024))

separator "*"
logWarn "WARNING: This will ERASE all data on $DISK!"
logHint "Press Ctrl+C to cancel, or press enter to continue."
separator "*"

read -p "press enter to continue."

logAttempt "check if disk exists"
if [ ! -b "$DISK" ]; then
    logError "Disk $DISK not found!"
    exit 1
fi

logAttempt "unmount any mounted partitions on $DISK..."
# mp stand for moint point
for mp in $(lsblk -ln "$DISK" | awk '{print $1}' | grep -E "^$(basename $DISK)[0-9]+" | sed "s|^|/dev/|" | tac); do
    mountpoint=$(findmnt -nr -o TARGET "$mp")
    if [ -n "$mountpoint" ]; then
        logUnmount "$mountpoint"
        umount "$mp" || logWarn "Could not unmount $mp"
    fi
done

# Create GPT partition table
logAttempt "create GPT partition table"
parted -s "$DISK" mklabel gpt || { logError "Failed to create GPT label."; exit 1; }

# Create EFI partition
logAttempt "create EFI partition with ${EFI_PART_SIZE_MIB}MiB / ${EFI_PART_SIZE_MIB}GiB"
parted -s "$DISK" mkpart ESP fat32 1MiB "${EFI_PART_SIZE_MIB}MiB" || exit 1
parted -s "$DISK" set 1 esp on || exit 1

# Create root partition
ROOT_START_MIB=$((EFI_PART_SIZE_MIB + 1))
ROOT_END_MIB=$((ROOT_START_MIB + ROOT_PART_SIZE_MIB))
logAttempt "create ROOT partition"
parted -s "$DISK" mkpart primary "${ROOT_START_MIB}MiB" "${ROOT_END_MIB}MiB" || exit 1
parted -s "$DISK" set 2 root on || exit 1

# Create EXT4 partition in remaining space
PART3_START_MIB=$((ROOT_END_MIB + 1))
logAttempt "create EXT4 partition..."
parted -s "$DISK" mkpart primary ext4 "${PART3_START_MIB}MiB" 100% || exit 1

# Show partition table

separated "*"
parted "$DISK" print
separator "*"

logSuccess "partitioning is completed successfuly"

read -p "Press enter to continue"