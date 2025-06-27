# 1. Create the default user :
useradd -m -G wheel,storage,power,audio,video -s /bin/bash codex

# 2. Set password
passwd codex

sleep 10
 echo "Uncomment this : %wheel ALL=(ALL:ALL) ALL"

# 3. Enable sudo privileges
EDITOR=nano visudo
