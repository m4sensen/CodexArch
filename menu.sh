hr "="
logLogo "
 ██████╗ ██████╗ ██████╗ ███████╗██╗  ██╗     █████╗ ██████╗  ██████╗██╗  ██╗
██╔════╝██╔═══██╗██╔══██╗██╔════╝╚██╗██╔╝    ██╔══██╗██╔══██╗██╔════╝██║  ██║
██║     ██║   ██║██║  ██║█████╗   ╚███╔╝     ███████║██████╔╝██║     ███████║
██║     ██║   ██║██║  ██║██╔══╝   ██╔██╗     ██╔══██║██╔══██╗██║     ██╔══██║
╚██████╗╚██████╔╝██████╔╝███████╗██╔╝ ██╗    ██║  ██║██║  ██║╚██████╗██║  ██║
 ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝    ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝
"
hr "="
logCopyright "CodexArch © Masensen"
hr "="
logTitle "CodexArch menu:"

echo "Choose an action to continue:"
menu_options=("Install" "Troubleshooting" "Format" "Exit")

select menu_option in "${menu_options[@]}"; do
    case $menu_option in
        "Install")
            logChoice "You chose to Install."
            require_file "$project_dir/bin/install.sh"
            ;;
        "Troubleshooting")
            logChoice "You chose Troubleshooting."
            require_file "$project_dir/bin/troubleshoot.sh"
            ;;
        "Format")
            logChoice "You chose to Format."
            require_file "$project_dir/bin/Format.sh"
            ;;
        "Exit")
            logChoice "You chose to exit"
            require_file "$project_dir/bin/exit.sh"
            ;;
        *)
            logError "Invalid option. Try again."
            ;;
    esac
done
