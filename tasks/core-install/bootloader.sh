separator "_"
logTitle "Bootloader"
separator "_"

logAttempt "install grub and efibootmgr."
safe_install grub efibootmgr

logAttempt "install GRUB."
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB

logRequest "uncomment GRUB_ENABLE_CRYPTODISK=y."
logAdvice "In nano : 
CTRL + K => cut
CTRL + U => paste
"
sleep 10

logAttempt "modify /etc/default/grub"
# === #
echo 'GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet"' >> /etc/default/grub
echo 'GRUB_CMDLINE_LINUX="cryptdevice=UUID=[YOUR_SDA2_UUID]:cryptroot:allow-discards root=/dev/mapper/vg0-root rootfstype=btrfs rootflags=subvol=@ resume=/dev/mapper/vg0-swap"' >> /etc/default/grub
blkid -s UUID -o value ${DISK}2 >> /etc/default/grub
# === #

nano /etc/default/grub

logAttempt "regenerate grub.cfg"
grub-mkconfig -o /boot/grub/grub.cfg