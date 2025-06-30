color() {
    local ground=$1  # 38 = foreground, 48 = background
    local r=$2
    local g=$3
    local b=$4
    printf "\033[%s;2;%s;%s;%sm" "$ground" "$r" "$g" "$b"
}
