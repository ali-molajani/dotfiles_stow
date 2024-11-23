#!/usr/bin/bash
# add-config.sh - Add new configuration to dotfiles

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

STOW_DIR="$HOME/.dotfiles"

print_message() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

# Check if correct number of arguments
if [ "$#" -ne 2 ]; then
    print_message "$RED" "Usage: $0 <package_name> <config_path>"
    print_message "$YELLOW" "Example: $0 nvim ~/.config/nvim"
    exit 1
fi

PACKAGE_NAME="$1"
CONFIG_PATH="$2"

# Ensure config path exists
if [ ! -e "$CONFIG_PATH" ]; then
    print_message "$RED" "Config path does not exist: $CONFIG_PATH"
    exit 1
fi

# Create package directory in stow dir
PACKAGE_DIR="$STOW_DIR/$PACKAGE_NAME"
mkdir -p "$PACKAGE_DIR"

# Get the relative path from home directory
RELATIVE_PATH=$(realpath --relative-to="$HOME" "$CONFIG_PATH")

# Create target directory structure
TARGET_DIR="$PACKAGE_DIR/$(dirname "$RELATIVE_PATH")"
mkdir -p "$TARGET_DIR"

# Move config to stow directory
print_message "$YELLOW" "Moving $CONFIG_PATH to $TARGET_DIR"
mv "$CONFIG_PATH" "$TARGET_DIR/"

# Create symbolic link back to original location
ln -s "$PACKAGE_DIR/$(dirname "$RELATIVE_PATH")/$(basename "$CONFIG_PATH")" "$CONFIG_PATH"

print_message "$GREEN" "Successfully added $PACKAGE_NAME to dotfiles"

