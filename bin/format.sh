# Full Zero-wipe

logWarning "This command ${BOLD}completely erases${BOLD} all data on the disk. Make sure to **back up** any important data before proceeding."

logQuestion "Do you wanna continue ?"

read -p "Enter you're choice: (y, n)" choice




    case "$choice" in
        y|Y)
       dd if=/dev/zero of=${DISK} bs=1M status=progress
       ;;
        *)
           exit 1
            ;;
    esac
done






