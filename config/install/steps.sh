require_file "$project_dir/tasks/install/Time_configuration.sh"
require_file "$project_dir/tasks/install/Language_configuration.sh"
require_file "$project_dir/tasks/install/Hostname_configuration.sh"
require_file "$project_dir/tasks/install/Keys_configuration.sh"
require_file "$project_dir/tasks/install/Mirror_configuration.sh"

require_file "$project_dir/tasks/install/Partitioning_the_disk.sh"

require_file "$project_dir/tasks/install/Formating_boot_partition.sh"

require_file "$project_dir/tasks/install/Formating_linux_system_partition.sh"
require_file "$project_dir/tasks/install/Formating_root.sh"
require_file "$project_dir/tasks/install/Making_swap.sh"

require_file "$project_dir/tasks/install/Base_system_setup.sh"

# === ==== #
require_file "$project_dir/tasks/install/Time_configuration.sh"
require_file "$project_dir/tasks/install/Language_configuration.sh"
require_file "$project_dir/tasks/install/Hostname_configuration.sh"
require_file "$project_dir/tasks/install/Keys_configuration.sh"
require_file "$project_dir/tasks/install/Mirror_configuration.sh"
# === === #

require_file "$project_dir/tasks/install/Configure_bootloader.sh"

require_file "$project_dir/tasks/install/Root_password_setup.sh"
require_file "$project_dir/tasks/install/Setup_users.sh"

require_file "$project_dir/tasks/install/Setup_network.sh"

require_file "$project_dir/tasks/Microcode.sh"
require_file "$project_dir/tasks/Graphics_drivers.sh"


require_file "$project_dir/tasks/install/Setup_window_managers.sh"

require_file "$project_dir/tasks/install/Required_packages.sh"
require_file "$project_dir/tasks/install/Stores_setup.sh"

require_file "$project_dir/tasks/install/reboot.sh"








