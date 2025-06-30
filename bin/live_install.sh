require_file "$project_dir/bin/universal_install.sh"

require_file "$project_dir/tasks/live-install/partitioning.sh"
require_file "$project_dir/tasks/live-install/boot_partitioning.sh"
require_file "$project_dir/tasks/live-install/luks_partitioning.sh"

require_file "$project_dir/tasks/live-install/root_partitioning.sh"
require_file "$project_dir/tasks/live-install/swap_partitioning.sh"

require_file "$project_dir/tasks/live-install/base_system.sh"