# Format root logical volume as Btrfs
logAttempt "format /dev/mapper/vg0-root with Btrfs..."
mkfs.btrfs /dev/mapper/vg0-root
# logSuccess "Filesystem formatted: Btrfs on /dev/mapper/vg0-root"

# Temporary mount to create subvolumes
logAttempt "Mounting root volume to /mnt for subvolume creation..."
mount /dev/mapper/vg0-root /mnt
# logSuccess "Mounted /dev/mapper/vg0-root to /mnt"

# Create Btrfs subvolumes
logAttempt "create Btrfs subvolumes..."
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@snapshots
btrfs subvolume create /mnt/@vms
btrfs subvolume create /mnt/@var
btrfs subvolume create /mnt/@log
btrfs subvolume create /mnt/@cache
btrfs subvolume create /mnt/@pkg
btrfs subvolume create /mnt/@tmp
# logSuccess "Subvolumes created successfully."

hr "="
logInfo "Listing created subvolumes:"
btrfs subvolume list /mnt
hr "="

# Unmount before remounting with options
logAttempt "unmount /mnt to remount subvolumes with options..."
umount /mnt
# logSuccess "Unmounted /mnt"

# Mount root subvolume
logAttempt "mount subvolume @ as /mnt with Btrfs options..."
mount -o subvol=@,rw,noatime,autodefrag,ssd,compress=zstd /dev/mapper/vg0-root /mnt
# logSuccess "Mounted root subvolume @ to /mnt"

# Create mount points
logAttempt "create mount points under /mnt..."
mkdir -p /mnt/{home,.snapshots,vms,var,tmp,boot}
# logSuccess "Mount points created"

# Mount subvolumes
logAttempt "mount subvolumes..."
mount -o subvol=@home,rw,noatime,autodefrag,ssd,compress=zstd /dev/mapper/vg0-root /mnt/home
mount -o subvol=@snapshots,rw,noatime,autodefrag,ssd,compress=zstd /dev/mapper/vg0-root /mnt/.snapshots
mount -o subvol=@tmp,rw,noatime,autodefrag,ssd,compress=zstd /dev/mapper/vg0-root /mnt/tmp
mount -o subvol=@vms,noatime,nodatacow,ssd /dev/mapper/vg0-root /mnt/vms
mount -o subvol=@var,rw,noatime,autodefrag,ssd,compress=zstd /dev/mapper/vg0-root /mnt/var
# logSuccess "Subvolumes mounted"

# Create nested mount directories
logAttempt "create nested /var directories..."
mkdir -p /mnt/var/{log,cache,lib/pacman}
# logSuccess "Nested /var mount points created"

# Mount nested var subvolumes
logAttempt "mount /var subvolume targets..."
mount -o subvol=@log,rw,noatime,autodefrag,ssd,compress=zstd /dev/mapper/vg0-root /mnt/var/log
mount -o subvol=@cache,rw,noatime,autodefrag,ssd,compress=zstd /dev/mapper/vg0-root /mnt/var/cache
mount -o subvol=@pkg,rw,noatime,autodefrag,ssd,compress=zstd /dev/mapper/vg0-root /mnt/var/lib/pacman
# logSuccess "Mounted all /var-related subvolumes"

# Mount EFI boot partition
logAttempt "mount EFI system partition to /mnt/boot..."
mount "${DISK}1" /mnt/boot
# logSuccess "EFI partition ${DISK}1 mounted to /mnt/boot"