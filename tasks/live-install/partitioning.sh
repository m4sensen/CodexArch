separator "_"
logTitle "Partitioning"
separator "_"

# Ask the user to select a disk, loop until valid or exit
while true; do
    read -rp "Enter disk device (e.g., /dev/sda): " DISK

    if [ -b "$DISK" ]; then
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

logInfo "Disk size: $DISK_SIZE_GiB GiB"
echo "DISK_SIZE_GiB=$DISK_SIZE_GiB" >> "$PROJECT_DIR/config/codexArch.cfg"
logSuccess "Disk size saved to config."

# Prompt for EFI size
read -rp "Enter EFI partition size in GiB (default: 1): " EFI_PART_SIZE_GiB
EFI_PART_SIZE_GiB=${EFI_PART_SIZE_GiB:-1}
# Ensure EFI_PART_SIZE_GiB is an integer
EFI_PART_SIZE_GiB=$(printf "%.0f" "$EFI_PART_SIZE_GiB")
echo "EFI_PART_SIZE_GiB=$EFI_PART_SIZE_GiB" >> "$PROJECT_DIR/config/codexArch.cfg"
logSuccess "EFI size saved to config."

# Prompt for ROOT size with % support
read -rp "Enter ROOT partition size (e.g., 40G or 60%): " ROOT_PART_INPUT

if [[ "$ROOT_PART_INPUT" =~ ^([0-9]{1,3})%$ ]]; then
    PERCENT=${BASH_REMATCH[1]}
    # Use bc for floating point and then printf to round to nearest integer
    ROOT_PART_SIZE_GiB=$(printf "%.0f" "$(echo "scale=2; ($DISK_SIZE_GiB * $PERCENT) / 100" | bc)")
    logInfo "Calculated ROOT size from percentage: $ROOT_PART_SIZE_GiB GiB"
else
    # Remove any 'G' or 'g' suffix if present and ensure it's an integer
    ROOT_PART_SIZE_GiB=$(echo "$ROOT_PART_INPUT" | sed 's/[Gg]$//')
    ROOT_PART_SIZE_GiB=$(printf "%.0f" "$ROOT_PART_SIZE_GiB")
fi

echo "ROOT_PART_SIZE_GiB=$ROOT_PART_SIZE_GiB" >> "$PROJECT_DIR/config/codexArch.cfg"
logSuccess "ROOT size saved to config." # Corrected log message

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
# mp stand for mount point
# findmnt -nr -o TARGET "$mp" is more robust than parsing lsblk output for mountpoints
for mp in $(lsblk -ln "$DISK" | awk '/disk|part/{print $1}' | grep -E "^$(basename $DISK)[0-9]*" | sed "s|^|/dev/|" | tac); do
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
logAttempt "create EFI partition with ${EFI_PART_SIZE_MiB}MiB"
# parted uses 1MiB as start by default, so explicit 1MiB is fine.
parted -s "$DISK" mkpart ESP fat32 1MiB "${EFI_PART_SIZE_MiB}MiB" || { logError "Failed to create EFI partition."; exit 1; }
parted -s "$DISK" set 1 esp on || { logError "Failed to set EFI flag."; exit 1; }

# Create root partition
# ROOT_START_MiB should be 1MiB *after* EFI_PART_SIZE_MiB
ROOT_START_MiB=$((EFI_PART_SIZE_MiB + 1))
ROOT_END_MiB=$((ROOT_START_MiB + ROOT_PART_SIZE_MiB - 1)) # -1 because mkpart end is inclusive
logAttempt "create ROOT partition from ${ROOT_START_MiB}MiB to ${ROOT_END_MiB}MiB"
parted -s "$DISK" mkpart primary "${ROOT_START_MiB}MiB" "${ROOT_END_MiB}MiB" || { logError "Failed to create ROOT partition."; exit 1; }
# parted -s "$DISK" set 2 root on || { logWarn "Could not set root flag for partition 2 (optional for Linux root)."; }

# Create remaining partition (e.g., for /home or /var)
PART3_START_MiB=$((ROOT_END_MiB + 1))
logAttempt "create remaining partition from ${PART3_START_MiB}MiB to 100%"
parted -s "$DISK" mkpart primary "${PART3_START_MiB}MiB" 100% || { logError "Failed to create remaining partition."; exit 1; }

# Show partition table
separator "*"
parted "$DISK" print
separator "*"

logSuccess "Partitioning is completed successfully"

read -p "Press enter to continue"
