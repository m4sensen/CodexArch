



logAttempt "install LVM2 package inside chroot ..."
pacman -Syy lvm2

logAttempt "edit initramfs hooks — required: encrypt lvm2 btrfs resume."
sleep 10
nano /etc/mkinitcpio.conf

logAttempt "regenerate initramfs with mkinitcpio -P ..."
mkinitcpio -P