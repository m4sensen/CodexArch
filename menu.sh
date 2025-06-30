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
menu_options=("Install" "Live install" "Core install" "Troubleshooting" "Format" "Exit")

select menu_option in "${menu_options[@]}"; do
    case $menu_option in
        "Install")
            logChoice "Install"
            require_file "$project_dir/bin/install.sh"
            ;;
        "Live install")
            logChoice "Live install"
            require_file "$project_dir/bin/live_install.sh"
            ;;
        "Core install")
            logChoice "Core install"
            require_file "$project_dir/bin/core_install.sh"
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
