logStart "Starting CodexArch ..."
logLogo "
 ██████╗ ██████╗ ██████╗ ███████╗██╗  ██╗     █████╗ ██████╗  ██████╗██╗  ██╗
██╔════╝██╔═══██╗██╔══██╗██╔════╝╚██╗██╔╝    ██╔══██╗██╔══██╗██╔════╝██║  ██║
██║     ██║   ██║██║  ██║█████╗   ╚███╔╝     ███████║██████╔╝██║     ███████║
██║     ██║   ██║██║  ██║██╔══╝   ██╔██╗     ██╔══██║██╔══██╗██║     ██╔══██║
╚██████╗╚██████╔╝██████╔╝███████╗██╔╝ ██╗    ██║  ██║██║  ██║╚██████╗██║  ██║
 ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝    ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝
"
logTitle "CodexArch menu :"

echo "Choose an option:"
options=("Install" "Troubleshooting" "Format" "Exit")

select opt in "${options[@]}"; do
    case $opt in
        "Install")
            echo "You chose to Install."
            # Add your install logic here
            break
            ;;
        "Backup")
            echo "You chose to Backup."
            # Add your backup logic here
            break
            ;;
        "Restore")
            echo "You chose to Restore."
            # Add your restore logic here
            break
            ;;
        "Exit")
            echo "Exiting."
            break
            ;;
        *)
            echo "❌ Invalid option. Try again."
            ;;
    esac
done
