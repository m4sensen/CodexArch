hr "_"
logTitle "Base system"
hr "_"

logAttempt "modify ParallelDownloads in /etc/pacman.conf ..."
# set_parallel_downloads
nano "/etc/pacman.conf"

logAttempt "install base system packages ..."
install base base-devel linux linux-firmware btrfs-progs nano

logAttempt "generate fstab for mounted system ..."
genfstab -U /mnt >> /mnt/etc/fstab

logAttempt "enter chroot environment to configure system ..."