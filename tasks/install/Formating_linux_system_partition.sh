hr "_"
logTitle "Formating_linux_system_partition"
hr "_"

logSecure "format ${DISK}2 partition with LUKS"
cryptsetup luksFormat ${DISK}2
# logSuccess "Partition ${DISK}2 successfully encrypted with LUKS"

logRequest "Enter the LUKS passphrase to unlock ${DISK}2 (mapping as 'cryptroot')"
cryptsetup open ${DISK}2 cryptroot
# logSuccess "LUKS container ${DISK}2 opened as /dev/mapper/cryptroot"

logAttempt "create physical volume on /dev/mapper/cryptroot"
pvcreate /dev/mapper/cryptroot
# logSuccess "Physical volume created on /dev/mapper/cryptroot"

logAttempt "create volume group 'vg0'"
vgcreate vg0 /dev/mapper/cryptroot
# logSuccess "Volume group 'vg0' created successfully"

logCalculate "Calculating swap size for hibernation..."
HIBERNATION_SWAP_SIZE=$(get_hibernation_swap_size)
logAttempt "create logical volume 'swap' with size ${HIBERNATION_SWAP_SIZE}..."
lvcreate -L "$HIBERNATION_SWAP_SIZE" vg0 -n swap
# logSuccess "Logical volume 'swap' (${HIBERNATION_SWAP_SIZE}) created successfully."

logAttempt "create logical volume 'root' (remaining space)"
lvcreate -l 100%FREE vg0 -n root
# logSuccess "Logical volume 'root' created"

hr "*"
lsblk
hr "*"