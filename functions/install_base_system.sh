install_base_system() {
  local packages=(
    base
    base-devel
    linux
    linux-firmware
    btrfs-progs
    nano
  )

  while true; do
    echo "Installing base packages with pacstrap..."

    if sudo pacstrap /mnt "${packages[@]}"; then
      echo "All packages installed successfully."
      break
    else
      echo "Package installation failed."
      read -rp "Press Enter to try again..."
    fi
  done
}