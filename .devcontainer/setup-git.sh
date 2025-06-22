#!/usr/bin/env bash

# Dev Containers Template - Git Setup Script
# Source: https://github.com/robertsinfosec/dev-containers-template
# For latest updates and documentation, visit the repository above
#
# Script: setup-git.sh
# Description: Configure Git in dev container using host Git configuration
# Usage: Called automatically by devcontainer.json postCreateCommand

set -euo pipefail

# --- Colors ---
CYAN='\033[36m'
GREEN='\033[32m'
RED='\033[31m'
YELLOW='\033[33m'
GRAY='\033[90m'
RESET='\033[0m'

echo -e "${CYAN}[*] Setting up Git configuration from host${RESET}"

# Fix SSH permissions and verify SSH config from host mount
if [[ -d "$HOME/.ssh" ]]; then
    chmod 700 "$HOME/.ssh"
    chmod 600 "$HOME/.ssh"/* 2>/dev/null || true
    echo -e "${GREEN}[+] SSH permissions configured${RESET}"
    
    # Verify SSH config is available from host mount
    if [[ -f "$HOME/.ssh/config" ]]; then
        echo -e "${GREEN}[+] SSH config available from host mount${RESET}"
        chmod 600 "$HOME/.ssh/config"
    else
        echo -e "${YELLOW}[!] No SSH config found on host - SSH connections may use defaults${RESET}"
        echo -e "${GRAY}    Consider creating ~/.ssh/config on your host machine for GitHub SSH-over-HTTPS${RESET}"
    fi
fi

# Check for host Git config
HOST_CONFIG="/tmp/host-gitconfig"
if [[ ! -f "$HOST_CONFIG" ]]; then
    echo -e "${YELLOW}[!] Host .gitconfig not found - skipping Git configuration${RESET}"
    exit 0
fi

echo -e "${CYAN}[*] Reading Git configuration from host${RESET}"

# Apply each config entry from the host
config_count=0
while IFS= read -r config_line; do
    # Skip empty lines
    [[ -z "$config_line" ]] && continue
    
    # Parse key=value pairs
    if [[ "$config_line" =~ ^([^=]+)=(.*)$ ]]; then
        key="${BASH_REMATCH[1]}"
        value="${BASH_REMATCH[2]}"
        
        config_count=$((config_count + 1))
        
        # Handle signing key path translation
        if [[ "$key" == "user.signingkey" ]]; then
            # Convert host paths to container paths using $HOME
            # Handles /home/user (Linux), /Users/user (macOS), and ~/ paths
            translated_value=$(echo "$value" | sed "s|/home/[^/]*/|$HOME/|" | sed "s|/Users/[^/]*/|$HOME/|" | sed "s|^~/|$HOME/|")
            
            echo -e "${GRAY}[%] Translating signing key path:${RESET}"
            echo -e "${GRAY}    Host: $value${RESET}"
            echo -e "${GRAY}    Container: $translated_value${RESET}"
            
            # Only set if the translated key exists
            if [[ -f "$translated_value" ]]; then
                git config --global "$key" "$translated_value"
                echo -e "${GREEN}[+] Set $key to $translated_value${RESET}"
            else
                echo -e "${YELLOW}[!] Signing key not found at $translated_value - skipping${RESET}"
                echo -e "${GRAY}[%] Available SSH keys:${RESET}"
                ls -la "$HOME"/.ssh/*.pub 2>/dev/null || echo -e "${YELLOW}[!] No SSH public keys found${RESET}"
            fi
        else
            # Copy all other Git settings as-is
            git config --global "$key" "$value"
            echo -e "${GREEN}[+] Set $key to $value${RESET}"
        fi
    fi
    
done < <(git config --file "$HOST_CONFIG" --list)

echo -e "${CYAN}[*] Processed $config_count configuration entries${RESET}"

# Show final configuration
echo -e "${CYAN}[*] Final Git configuration in container:${RESET}"
if git config --global --list | grep -E "(user\.|gpg\.|commit\.gpgsign)"; then
    echo -e "${GREEN}[+] Git configuration applied successfully${RESET}"
else
    echo -e "${YELLOW}[!] No user/signing config found after processing${RESET}"
    echo -e "${GRAY}[%] All global config:${RESET}"
    git config --global --list || echo "No global config at all"
fi

echo -e "${GREEN}[+] Git configuration complete${RESET}"