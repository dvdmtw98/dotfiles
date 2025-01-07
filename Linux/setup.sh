#!/bin/bash

# Define dotfiles directory
DOTFILES_DIR="./Linux"

# List of files/folders to symlink
declare -A FILES_TO_SYMLINK=(
    ["fastfetch/config.jsonc"]="$HOME/.config/fastfetch/config.jsonc"
    ["imwheel/.imwheelrc"]="$HOME/.imwheelrc",
    ["xinput/.xprofile"]="$HOME/.xprofile"
)

# Create symlinks
echo "Creating symlinks for Linux..."
for SOURCE in "${!FILES_TO_SYMLINK[@]}"; do
    TARGET="${FILES_TO_SYMLINK[$SOURCE]}"
    
    # Remove existing files or directories
    if [ -e "$TARGET" ] || [ -L "$TARGET" ]; then
        echo "Removing existing: $TARGET"
        rm -rf "$TARGET"
    fi

    # Create the symlink
    echo "Linking $DOTFILES_DIR/$SOURCE -> $TARGET"
    ln -s "$DOTFILES_DIR/$SOURCE" "$TARGET"
done

echo "Linux setup complete!"
