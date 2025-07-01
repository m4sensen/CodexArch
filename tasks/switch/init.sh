
# Ensure the script is copied into the chroot system:
mkdir -p /mnt/root/codexArch
cp -r ~/codexArch/* /mnt/root/codexArch/












# Now run from outside using arch-chroot:
arch-chroot /mnt /bin/bash -c "root/codexArch/tasks/switch/init.sh"
