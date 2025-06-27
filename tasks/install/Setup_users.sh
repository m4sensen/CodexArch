useradd -m -G wheel,audio,video,storage -s /bin/bash codex
# 1. Create the user
useradd -m -G wheel,audio,video,storage -s /bin/bash codex

# 2. Set password
passwd codex

sleep 10
 echo "Uncomment this : %wheel ALL=(ALL:ALL) ALL"

# 3. Enable sudo privileges
EDITOR=nano visudo
