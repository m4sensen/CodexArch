timedatectl list-timezones
ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime

timedatectl set-ntp true
timedatectl status

# Generate hardware clock: set the hardware clock (RTC) to the current system time (sys).
hwclock --systohc