
# Ensure the script is copied into the chroot system:
mkdir -p /mnt/root/codexArch
cp -r ~/codexArch/* /mnt/root/codexArch/

# Apply chmod *on the correct path inside the chroot*
chmod +x /mnt/root/codexArch/bin/universal_install.sh
chmod +x /mnt/root/codexArch/bin/core_install.sh

# Now run from outside using arch-chroot:
arch-chroot /mnt /bin/bash -c "bash /root/codexArch/bin/universal_install.sh && bash /root/codexArch/bin/core_install.sh"
