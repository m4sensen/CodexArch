logLogo "
 ██████╗ ██████╗ ██████╗ ███████╗██╗  ██╗     █████╗ ██████╗  ██████╗██╗  ██╗
██╔════╝██╔═══██╗██╔══██╗██╔════╝╚██╗██╔╝    ██╔══██╗██╔══██╗██╔════╝██║  ██║
██║     ██║   ██║██║  ██║█████╗   ╚███╔╝     ███████║██████╔╝██║     ███████║
██║     ██║   ██║██║  ██║██╔══╝   ██╔██╗     ██╔══██║██╔══██╗██║     ██╔══██║
╚██████╗╚██████╔╝██████╔╝███████╗██╔╝ ██╗    ██║  ██║██║  ██║╚██████╗██║  ██║
 ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝    ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝
"
separator "="
logCopyright "CodexArch © Masensen"
separator "="
logTitle "CodexArch menu:"

echo "Choose an action to continue:"
menu_options=("Install" "Live install" "Core install" "Troubleshooting" "Format" "Exit")

select menu_option in "${menu_options[@]}"; do
    case $menu_option in
        "Install")
            logChoice "Install"
            require_file "$PROJECT_DIR/bin/install.sh"
            ;;
        "Live install")
            logChoice "Live install"
            require_file "$PROJECT_DIR/bin/live_install.sh"
            ;;
        "Core install")
            logChoice "Core install"
            require_file "$PROJECT_DIR/bin/core_install.sh"
            ;;
        "Troubleshooting")
            logChoice "You chose Troubleshooting."
            require_file "$PROJECT_DIR/bin/troubleshoot.sh"
            ;;
        "Format")
            logChoice "You chose to Format."
            require_file "$PROJECT_DIR/bin/format.sh"
            ;;
        "Exit")
            logChoice "You chose to exit"
            require_file "$PROJECT_DIR/bin/exit.sh"
            ;;
        *)
            logError "Invalid option. Try again."
            ;;
    esac
done
