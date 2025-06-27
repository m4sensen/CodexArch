# 1. Initialize the keyring
pacman-key --init

# 2. Populate it with Arch's trusted keys
pacman-key --populate archlinux

# 3. Refresh keys
pacman-key --refresh-keys

pacman -Syy