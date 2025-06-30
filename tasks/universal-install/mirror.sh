separator "="
logHeading "Step 05: Mirrorlist setup"
separator "="

logChoiceLabel "Choose how you want to configure your Arch mirrors:"
logChoice "  1) Use mirrors based on your timezone (auto-detected)"
logChoice "  2) Use fixed mirrors from United States, France, and Switzerland"
logChoice "  3) Enter your own custom list of countries"
read -p "Your choice (1/2): " mirror_choice

case "$mirror_choice" in
    1)
        logAttempt "Use predefined mirrors: United States, France, Switzerland"
        reflector --country "United States,France,Switzerland" \
                  --latest 50 \
                  --sort rate \
                  --protocol https \
                  --save /etc/pacman.d/mirrorlist
        ;;
    2)
        

read -p "Enter comma-separated country names (e.g. Germany,Netherlands,Canada): " custom_countries

# Get valid country list from reflector
valid_countries=$(reflector --list-countries | sed -n 's/^[[:space:]]\{2,\}\([A-Za-z][A-Za-z ]*\).*/\1/p' | tr '\n' ',' | sed 's/,$//')

# Validate each entered country
IFS=',' read -ra user_countries <<< "$custom_countries"
is_valid=true

for country in "${user_countries[@]}"; do
    if ! [[ ",$valid_countries," == *",$country,"* ]]; then
        echo "Invalid country: $country"
        is_valid=false
    fi
done

if [ "$is_valid" = true ]; then
    logAttempt "Use custom countries: $custom_countries"
    reflector --country "$custom_countries" \
              --latest 50 \
              --sort rate \
              --protocol https \
              --save /etc/pacman.d/mirrorlist
else
    echo "Please enter valid country names as listed by 'reflector --list-countries'"
fi
        ;;
    *)
        logSkip "Invalid choice or skipped mirrorlist generation"
        ;;
esac














