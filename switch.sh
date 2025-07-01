
FRAMEWORK_NAME="codexBash"
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/codexArch/.." && pwd)"
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

require_Loader &&
loader &&
require_file "$PROJECT_DIR/codexBash.cfg" ||

exit 1

separator "="
logSuccess "${RESET}${BOLD}${GREEN_500}${ITALIC}${FRAMEWORK_NAME} framework © Masensen${RESET},${GREEN_500}${BOLD} has been started successfully."
separator "="
logStart "[START] Starting CodexArch ..."
separator "="


bash root/codexArch/bin/universal_install.sh && bash root/codexArch/bin/core_install.sh