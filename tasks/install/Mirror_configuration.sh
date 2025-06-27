# Manual methode
nano /etc/pacman.d/mirrorlist

# automatique methode : 

# reflector --country US,NY --latest 20 --sort rate --save /etc/pacman.d/mirrorlist

# reflector --latest 20 --sort rate --save /etc/pacman.d/mirrorlist

# reflector --country "YourCountry" --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

# reflector --country "United States" --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

