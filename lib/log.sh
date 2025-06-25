log() {
  echo -e "${SLATE_500}${BOLD}[LOG] $(date +'%Y-%m-%d %H:%M:%S')  $*${RESET}"
}

logSuccess() {
  echo -e "${GREEN_500}${BOLD}$(emoji_toggle success)[SUCCESS] $(date +'%Y-%m-%d %H:%M:%S') $*${RESET}"
}

logWarn() {
  echo -e "${YELLOW_500}${BOLD}$(emoji_toggle warn)[WARN] $(date +'%Y-%m-%d %H:%M:%S') $*${RESET}"
}

logError() {
  echo -e "${RED_500}${BOLD}$(emoji_toggle error)[ERROR] $(date +'%Y-%m-%d %H:%M:%S') $*${RESET}"
}

logDebug() {
  echo -e "${GRAY_500}${BOLD}$(emoji_toggle debug)[DEBUG] $(date +'%Y-%m-%d %H:%M:%S') $*${RESET}"
}

logQuestion() {
  echo -e "${PURPLE_500}${BOLD}$(emoji_toggle question)[QUESTION] $(date +'%Y-%m-%d %H:%M:%S') $*${RESET}"
}

logWait() {
  echo -e "${BLUE_500}${BOLD}$(emoji_toggle wait)[WAIT] $(date +'%Y-%m-%d %H:%M:%S') $*${RESET}"
}

logClean() {
  echo -e "${TEAL_500}${BOLD}$(emoji_toggle clean)[CLEAN] $(date +'%Y-%m-%d %H:%M:%S') $*${RESET}"
}

logSecure() {
  echo -e "${EMERALD_500}${BOLD}$(emoji_toggle secure)[SECURE] $(date +'%Y-%m-%d %H:%M:%S') $*${RESET}"
}

logSave() {
  echo -e "${ORANGE_500}${BOLD}$(emoji_toggle save)[SAVE] $(date +'%Y-%m-%d %H:%M:%S') $*${RESET}"
}

logCheck() {
  echo -e "${LIME_500}${BOLD}$(emoji_toggle search)[CHECK] $(date +'%Y-%m-%d %H:%M:%S') $*${RESET}"
}

logUpload() {
  echo -e "${SKY_500}${BOLD}$(emoji_toggle upload)[UPLOAD] $(date +'%Y-%m-%d %H:%M:%S') $*${RESET}"
}

logDownload() {
  echo -e "${PINK_500}${BOLD}$(emoji_toggle download)[DOWNLOAD] $(date +'%Y-%m-%d %H:%M:%S') $*${RESET}"
}

logStart() {
  echo -e "${ROSE_500}${BOLD}$(emoji_toggle start)[START] $(date +'%Y-%m-%d %H:%M:%S') $*${RESET}"
}

logActive() {
  echo -e "${GREEN_500}${BOLD}$(emoji_toggle hint)[active] $(date +'%Y-%m-%d %H:%M:%S') $*${RESET}"
}

logLogo() {
  echo -e "${NEUTRAL_500}$*${RESET}"
}

logTitle() {
  echo -e "${INDIGO_500}${BOLD}$*${RESET}"
}