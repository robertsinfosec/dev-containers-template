#!/usr/bin/env bash

# Dev Container Post-Setup Script
# Description: Configure aliases and developer experience enhancements

set -euo pipefail

# --- Colors ---
CYAN='\033[36m'
GREEN='\033[32m'
BLUE='\033[34m'
RESET='\033[0m'

echo -e "${CYAN}[*] Setting up development environment${RESET}"

# --- Start Docker Daemon (DinD setup) ---
# echo -e "${GREEN}[+] Starting Docker daemon${RESET}"
# if ! pgrep dockerd > /dev/null; then
#   sudo nohup dockerd > /tmp/dockerd.log 2>&1 &
#   sleep 5
#   echo -e "${BLUE}[i] Docker started successfully${RESET}"
# else
#   echo -e "${BLUE}[i] Docker already running${RESET}"
# fi

# --- Add useful aliases ---
echo -e "${GREEN}[+] Adding development aliases${RESET}"
cat >> "$HOME/.bashrc" << 'EOF'

# === Development Aliases ===
alias ll="ls -la"

# === Jekyll Aliases ===
alias jstart="bundle exec jekyll serve --host 0.0.0.0 --livereload"
alias jbuild="bundle exec jekyll build"
alias jclean="bundle exec jekyll clean"
alias jserve="bundle exec jekyll serve --host 0.0.0.0"
alias jdraft="bundle exec jekyll serve --host 0.0.0.0 --drafts --livereload"

show_help() {
  echo -e "\033[36m"
  echo    "╔══════════════════════════════════════════════════════════════════════════════╗"
  echo -e "║                          Dev Container Commands                              ║"
  echo    "╠══════════════════════════════════════════════════════════════════════════════╣"
  echo -e "║  ll                   Directory listing: ls -la                              ║"
  echo    "║                                                                              ║"
  echo -e "║  Jekyll Commands:                                                            ║"
  echo -e "║  jstart               Start Jekyll with live reload (host 0.0.0.0)           ║"
  echo -e "║  jbuild               Build Jekyll site                                      ║"
  echo -e "║  jclean               Clean Jekyll build files                               ║"
  echo -e "║  jserve               Start Jekyll without live reload                       ║"
  echo -e "║  jdraft               Start Jekyll with drafts and live reload               ║"
  echo    "║                                                                              ║"
  echo -e "║  Tip: Use dc-help to show this message again                                 ║"
  echo    "╚══════════════════════════════════════════════════════════════════════════════╝"
  echo -e "\033[0m"
}

alias dc-help="show_help"

# === Colorful Prompt ===
PS1='\[\033[38;5;39m\]\u\[\033[0m\]@\[\033[38;5;42m\]\h\[\033[0m\] \[\033[38;5;244m\]\w\[\033[0m\]\n\$ '


# Show help on interactive terminals
if [[ $- == *i* ]]; then
    show_help
fi
EOF
