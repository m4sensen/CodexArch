mkdir -p /mnt/root/codexArch
cp -r ~/codexArch/* /mnt/root/codexArch/

arch-chroot /mnt /bin/bash -c "/root/codexArch/bin/universal_install.sh && /root/codexArch/bin/core_install.sh"
