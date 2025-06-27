
echo "modifying ParallelDownloads :"

set_parallel_downloads

nano "/etc/pacman.conf"

## ============================ ###
install_base_packages


genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt
pacman -Syy lvm2

echo "add encrypt lvm2 btrfs resume"

sleep 10

nano /etc/mkinitcpio.conf

mkinitcpio -P