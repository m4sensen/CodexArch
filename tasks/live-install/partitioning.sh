separator "_"
logHeading "Partitioning"
separator "_"

logAttempt "check if the variables exist"

: "${DISK:?Error: DISK variable not set. Please set it (e.g., /dev/sda)}"
: "${ROOT_PART_SIZE_GiB:?Error: ROOT_PART_SIZE_GiB not set (in GB)}"
: "${EFI_PART_SIZE_GiB:=1}"  # default to 1GB if not set

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
logAttempt "create EFI partition"
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