PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Ensure the script is copied into the chroot system:
mkdir -p /mnt/root/codexArch
cp -r ~/codexArch/* /mnt/root/codexArch/

# Now run from outside using arch-chroot:
arch-chroot /mnt /bin/bash -c "bash root/codexArch/switch.sh"