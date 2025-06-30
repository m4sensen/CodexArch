log() {
  echo -e "$(color $FG $DEFAULT_COLOR)[LOG] $(date +'%Y-%m-%d %H:%M:%S')  $*'.'${RESET}"
}

logSuccess() {
  echo -e "${SUCCESS_COLOR}${BOLD}$(toggle_emojis success)[SUCCESS] $(date +'%Y-%m-%d %H:%M:%S') $*'.'${RESET}"
}

logError() {
  echo -e "${ERROR_COLOR}${BOLD}$(toggle_emojis error)[ERROR] $(date +'%Y-%m-%d %H:%M:%S') $*'.'${RESET}" >&2
}

logWarn() {
  echo -e "${WARN_COLOR}${BOLD}$(toggle_emojis warn)[WARN] $(date +'%Y-%m-%d %H:%M:%S') $*'.'${RESET}" >&2
}

logQuestion() {
  echo -e "${QUESTION_COLOR}${BOLD}$(toggle_emojis question)[QUESTION] $(date +'%Y-%m-%d %H:%M:%S') $*'?'${RESET}"
}

logCheck() {
  echo -e "${CHECK_COLOR}${BOLD}$(toggle_emojis check)[CHECK] $(date +'%Y-%m-%d %H:%M:%S') Checking for $*'.'${RESET}"
}

logUpload() {
  echo -e "${UPLOAD_COLOR}${BOLD}$(toggle_emojis upload)[UPLOAD] $(date +'%Y-%m-%d %H:%M:%S') Uploading $*'.'${RESET}"
}

logDownload() {
  echo -e "${DOWNLOAD_COLOR}${BOLD}$(toggle_emojis download)[DOWNLOAD] $(date +'%Y-%m-%d %H:%M:%S') Downloading $*'.'${RESET}"
}

logStart() {
  echo -e "${START_COLOR}${BOLD}$(toggle_emojis start)[START] $(date +'%Y-%m-%d %H:%M:%S') Starting $*'.'${RESET}"
}

logChoice() {
  echo -e "${CHOISE_COLOR}${BOLD}$(toggle_emojis target)[CHOISE] $(date +'%Y-%m-%d %H:%M:%S') You chose to $*'.'${RESET}"
}

logChoiceLabel() {
  echo -e "${CHOISE_COLOR}${BOLD}$(toggle_emojis select)   $*${RESET}"
}

logRequest() {
  echo -e "${REQUEST_COLOR}${BOLD}$(toggle_emojis request)[REQUEST] $(date +'%Y-%m-%d %H:%M:%S') Please $*'.'${RESET}"
}

logAttempt() {
  echo -e "${ATTEMPT_COLOR}${BOLD}$(toggle_emojis tool)[ATTEMPT] $(date +'%Y-%m-%d %H:%M:%S') Attempt to $*'...'${RESET}"
}

logHint() {
  echo -e "${HINT_COLOR}${BOLD}$(toggle_emojis hint)[HINT] $(date +'%Y-%m-%d %H:%M:%S') $*'.'${RESET}"
}

logSkip() {
  echo -e "${SKIP_COLOR}${BOLD}$(toggle_emojis skip)[SKIP] $(date +'%Y-%m-%d %H:%M:%S') Skipping $*'...'${RESET}"
}

logUnmount(){
echo -e "${UNMOUNT_COLOR}${BOLD}$(toggle_emojis pin)[UNMOUNT] $(date +'%Y-%m-%d %H:%M:%S') Unmounting $*'...'${RESET}"
}

logMount() {
echo -e "${MOUNT_COLOR}${BOLD}$(toggle_emojis pin)[MOUNT] $(date +'%Y-%m-%d %H:%M:%S') Mounting $*'...'${RESET}"
}

logInfo() {
  echo -e "${INFO_COLOR}${BOLD}$(toggle_emojis info)[INFO] $(date +'%Y-%m-%d %H:%M:%S') $*'.'${RESET}"
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