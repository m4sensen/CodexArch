Exit() {
    local delay="${1:-0}"
    local exit_code="${2:-1}"

    sleep "$delay"
    exit "$exit_code"
}
