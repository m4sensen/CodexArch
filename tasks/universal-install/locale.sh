separator "="
logHeading "Step 03: Locale"
separator "="

logAttempt "open /etc/locale.gen for editing"
logRequest "uncomment the locale(s) you need, e.g., en_US.UTF-8 UTF-8"
logHint "To uncomment, remove the '#' at the beginning of the relevant line"
read -p "Press Enter to continue..."

nano /etc/locale.gen
logAttempt "generate locales"
locale-gen

