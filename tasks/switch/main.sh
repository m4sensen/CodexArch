

# Exit immediately if a command exits with a non-zero status.
set -e

# Define the path to the new root filesystem
CHROOT_PATH="/mnt"

# --- Pre-chroot Steps ---

echo "[*] Copying script folder to chroot..."
# Ensure the destination directory exists inside the new root
mkdir -p "$CHROOT_PATH/root/codexArch" || { echo "Error: Failed to create target directory in chroot."; exit 1; }
# Copy the entire project directory (e.g., 'codexArch') to /root/ inside the new system
cp -a "$PROJECT_DIR" "$CHROOT_PATH/root/" || { echo "Error: Failed to copy project directory to chroot."; exit 1; }
echo "[+] Script folder copied to $CHROOT_PATH/root/$(basename "$PROJECT_DIR")"

# --- Enter Chroot and Run Installation Scripts ---

echo "[*] Entering chroot environment and starting installation scripts..."
# arch-chroot automatically handles binding /dev, /proc, /sys
# The -c option allows you to execute a command string directly.
arch-chroot "$CHROOT_PATH" /bin/bash -c "
    # Navigate to the directory where your scripts are located inside the chroot
    cd /root/$(basename "$PROJECT_DIR")/bin || { echo 'Error: Failed to navigate to script directory inside chroot.'; exit 1; }

    echo '[*] Running universal-install.sh...'
    # Use bash explicitly to ensure script execution
    bash universal_install.sh || { echo 'Error: universal-install.sh failed.'; exit 1; }

    echo '[*] Running core-install.sh...'
    bash core_install.sh || { echo 'Error: core-install.sh failed.'; exit 1; }

    echo '[+] Installation scripts inside chroot completed successfully.'
" || { echo "Error: Chroot command or scripts inside chroot failed."; exit 1; }

echo "[+] Exited chroot environment."

# --- Post-chroot Steps (e.g., unmounting, if not handled by a later reboot) ---
# It's good practice to unmount when you're done, especially if you're not immediately rebooting.
# However, usually, after the chroot phase, you'd configure bootloader, generate fstab, and then reboot.
# If you need to unmount here, uncomment and adapt these lines:
# echo "[*] Unmounting filesystems..."
# umount -R "$CHROOT_PATH" || { echo "Warning: Failed to unmount all filesystems. Manual unmount might be needed."; }
# echo "[+] Filesystems unmounted."

echo "[+] Chroot process completed successfully. You can now proceed with bootloader installation, fstab generation, and final configurations."
