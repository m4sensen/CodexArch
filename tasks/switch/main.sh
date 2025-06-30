set -e

CHROOT_PATH="/mnt"
PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "[*] Copying script folder to chroot..."
mkdir -p "$CHROOT_PATH/root/"
cp -a "$PROJECT_DIR" "$CHROOT_PATH/root/"

echo "[*] Binding essential filesystems..."
for dir in dev proc sys; do
    mount --bind /$dir "$CHROOT_PATH/$dir"
done

echo "[*] Entering chroot and starting installation..."
chroot "$CHROOT_PATH" /bin/bash -c "
    cd /root/codexArch/bin
    echo '[*] Running universal-install...'
    bash universal-install

    echo '[*] Running core-install.sh...'
    bash core-install.sh
"


# arch-chroot /mnt