separator "="
logTitle "Step 04: Host setup"
separator "="

logAttempt "open /etc/hostname for editing..."
logRequest "enter your desired hostname (e.g., computerHost)"
read -p "Press Enter to continue..."
nano /etc/hostname

logAttempt "open /etc/hosts for editing..."
logHint "Add your hosts (e.g., 127.0.1.1    computerHost)"
read -p "Press Enter to continue..."
nano /etc/hosts