#!/usr/bin/bash
# deploy-configs.sh - Deploy all configurations using stow

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

STOW_DIR="$HOME/dotfiles_stow"
BACKUP_DIR="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"

print_message() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

# Check if stow is installed
if ! command -v stow &> /dev/null; then
    print_message "$RED" "GNU Stow is not installed. Please install it first."
    exit 1
fi

# Check if dotfiles directory exists
if [ ! -d "$STOW_DIR" ]; then
    print_message "$RED" "Dotfiles directory not found at $STOW_DIR"
    exit 1
fi

# Get all packages from the stow directory
packages=($(ls -1 "$STOW_DIR"))

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Force restow all packages
for package in "${packages[@]}"; do
    if [ -d "$STOW_DIR/$package" ]; then
        print_message "$YELLOW" "Restowing $package..."
        
        # Use --restow to force update
        stow -d "$STOW_DIR" -t "$HOME" --restow "$package"
        
        if [ $? -eq 0 ]; then
            print_message "$GREEN" "✔ Successfully stowed $package"
        else
            print_message "$RED" "✘ Failed to stow $package"
        fi
    fi
done

print_message "$GREEN" "All configurations deployed!"
