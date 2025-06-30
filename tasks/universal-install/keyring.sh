separator "="
logTitle "Keyring"
separator "="

logHint "This step is optional if you're using the official Arch ISO."
logHint "Only run it if you're using a custom ISO, an old image, or having keyring issues."

read -p "Do you want to run keyring initialization? (y/N): " do_keyring


case "$do_keyring" in
    [Yy]*)
        logAttempt "initialize the pacman keyring"
        pacman-key --init

        logAttempt "populate the keyring with Arch Linux trusted keys"
        pacman-key --populate archlinux

        logAttempt "refresh the keyring"
        pacman-key --refresh-keys
        ;;
    *)
        logSkip "keyring initialization"
        ;;
esac


logAttempt "check if 'archlinux-keyring' package is installed..."
pacman -Q archlinux-keyring

logAttempt "force syncing package databases..."
pacman -Syy