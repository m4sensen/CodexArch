hr "_"
logTitle "Base system setup"
hr "_"

logAttempt "modify ParallelDownloads in /etc/pacman.conf ..."
# set_parallel_downloads
nano "/etc/pacman.conf"

logAttempt "install base system packages ..."
install_base_packages

logAttempt "generate fstab for mounted system ..."
genfstab -U /mnt >> /mnt/etc/fstab

logAttempt "enter chroot environment to configure system ..."
arch-chroot /mnt

logAttempt "install LVM2 package inside chroot ..."
pacman -Syy lvm2

logAttempt "edit initramfs hooks — required: encrypt lvm2 btrfs resume."
sleep 10
nano /etc/mkinitcpio.conf

logAttempt "regenerate initramfs with mkinitcpio -P ..."
mkinitcpio -P