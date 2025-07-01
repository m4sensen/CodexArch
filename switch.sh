FRAMEWORK_NAME="codexBash"
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DATE="$(date +'%Y-%m-%d %H:%M:%S')"

require_Loader() {
  local file="$PROJECT_DIR/framework/loader/loader.sh"

  if [ -f "$file" ]; then
    source "$file"
  else
    echo "[ERROR] $DATE Required file not found: $file" >&2
    echo "[EXIT] $DATE Exiting CodexBox..."
    exit 1
  fi
}

require_Loader
loader
require_file "$PROJECT_DIR/codexBash.cfg"

separator "="

logSuccess "${RESET}${BOLD}${GREEN_500}${ITALIC}${FRAMEWORK_NAME} framework © Masensen${RESET},${GREEN_500}${BOLD} has been started successfully."

separator "="

logStart "[START] Starting CodexArch ..."

separator "="

log "$PROJECT_DIR"

read -p "Press Enter to continue..."
log "$PROJECT_DIR/bin/universal_install.sh"
log "$PROJECT_DIR/bin/core_install.sh"

logChoice "Universal install"
require_file "$PROJECT_DIR/bin/universal_install.sh"
logChoice "Core install"
require_file "$PROJECT_DIR/bin/core_install.sh"