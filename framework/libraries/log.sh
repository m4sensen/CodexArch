log() {
  echo -e "$(color $FG $DEFAULT_COLOR)[LOG] $(date +'%Y-%m-%d %H:%M:%S')  $*'.'${RESET}"
}

logSuccess() {
  echo -e "${SUCCESS_COLOR}${BOLD}$(emoji_toggle success)[SUCCESS] $(date +'%Y-%m-%d %H:%M:%S') $*'.'${RESET}"
}

logError() {
  echo -e "${ERROR_COLOR}${BOLD}$(emoji_toggle error)[ERROR] $(date +'%Y-%m-%d %H:%M:%S') $*'.'${RESET}" >&2
}

logWarn() {
  echo -e "${WARN_COLOR}${BOLD}$(emoji_toggle warn)[WARN] $(date +'%Y-%m-%d %H:%M:%S') $*'.'${RESET}" >&2
}

logQuestion() {
  echo -e "${QUESTION_COLOR}${BOLD}$(emoji_toggle question)[QUESTION] $(date +'%Y-%m-%d %H:%M:%S') $*'?'${RESET}"
}

logCheck() {
  echo -e "${CHECK_COLOR}${BOLD}$(emoji_toggle check)[CHECK] $(date +'%Y-%m-%d %H:%M:%S') Checking for $*'.'${RESET}"
}

logUpload() {
  echo -e "${UPLOAD_COLOR}${BOLD}$(emoji_toggle upload)[UPLOAD] $(date +'%Y-%m-%d %H:%M:%S') Uploading $*'.'${RESET}"
}

logDownload() {
  echo -e "${DOWNLOAD_COLOR}${BOLD}$(emoji_toggle download)[DOWNLOAD] $(date +'%Y-%m-%d %H:%M:%S') Downloading $*'.'${RESET}"
}

logStart() {
  echo -e "${START_COLOR}${BOLD}$(emoji_toggle start)[START] $(date +'%Y-%m-%d %H:%M:%S') Starting $*'.'${RESET}"
}

logChoice() {
  echo -e "${CHOISE_COLOR}${BOLD}$(emoji_toggle target)[CHOISE] $(date +'%Y-%m-%d %H:%M:%S') You chose to $*'.'${RESET}"
}

logChoiceLabel() {
  echo -e "${CHOISE_COLOR}${BOLD}$(emoji_toggle select)   $*${RESET}"
}

logRequest() {
  echo -e "${REQUEST_COLOR}${BOLD}$(emoji_toggle request)[REQUEST] $(date +'%Y-%m-%d %H:%M:%S') Please $*'.'${RESET}"
}

logAttempt() {
  echo -e "${ATTEMPT_COLOR}${BOLD}$(emoji_toggle tool)[ATTEMPT] $(date +'%Y-%m-%d %H:%M:%S') Attempt to $*'...'${RESET}"
}

logHint() {
  echo -e "${HINT_COLOR}${BOLD}$(emoji_toggle hint)[HINT] $(date +'%Y-%m-%d %H:%M:%S') $*'.'${RESET}"
}

logSkip() {
  echo -e "${SKIP_COLOR}${BOLD}$(emoji_toggle skip)[SKIP] $(date +'%Y-%m-%d %H:%M:%S') Skipping $*'...'${RESET}"
}

logUnmount(){
echo -e "${UNMOUNT_COLOR}${BOLD}$(emoji_toggle pin)[UNMOUNT] $(date +'%Y-%m-%d %H:%M:%S') Unmounting $*'...'${RESET}"
}

logMount() {
echo -e "${MOUNT_COLOR}${BOLD}$(emoji_toggle pin)[MOUNT] $(date +'%Y-%m-%d %H:%M:%S') Mounting $*'...'${RESET}"
}

logInfo() {
  echo -e "${INFO_COLOR}${BOLD}$(emoji_toggle info)[INFO] $(date +'%Y-%m-%d %H:%M:%S') $*'.'${RESET}"
}

logBreak() {
  echo
}

logLogo() {
  echo -e "${LOGO_COLOR}"
  center_multiline_text <<< "$*"
  echo -e "${RESET}"
}

logCopyright() {
  echo -e "${COPYRIGHT_COLOR}${ITALIC}$(center_text "$*")${RESET}"
}

logTitle() {
  echo -e "${TITLE_COLOR}${BOLD}${UNDERLINE}# $*${RESET}"
}

headingColor() {
  echo -e "${HEADING_COLOR}${BOLD}${UNDERLINE}## $*${RESET}"
}

logSeparator() {
  echo -e "${SEPARATOR_COLOR}$*${RESET}"
}