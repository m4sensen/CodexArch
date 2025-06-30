separator "="
logTitle "Step 05: Mirrorlist setup"
separator "="

logChoiceLabel "Choose how you want to configure your Arch mirrors:"
logChoice "  1) Use mirrors based on your timezone (auto-detected)"
logChoice "  2) Use fixed mirrors from United States, France, and Switzerland"
logChoice "  3) Enter your own custom list of countries"
read -p "Your choice (1/2): " mirror_choice

logAttempt "Use predefined mirrors: United States, France, Switzerland"
reflector --country "United States,France,Switzerland" --latest 50 --sort rate --protocol https --save /etc/pacman.d/mirrorlist

  









