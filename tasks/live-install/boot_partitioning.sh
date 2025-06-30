separator "_"
logTitle "Boot partitioning"
separator "_"

logAttempt "format ${DISK}1 EFI partition to FAT32"
mkfs.fat -F32 ${DISK}1
# logSuccess "EFI partition ${DISK}1 successfully formatted to FAT32"