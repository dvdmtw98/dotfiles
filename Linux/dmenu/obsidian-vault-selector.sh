#!/usr/bin/env bash

# Preserve your desired display order
labels=("Note Vault" "Blog Vault" "Tracker Vault")

# Associative Arrays are Unordered
declare -A vaults=(
    ["Note Vault"]="notes-vault"
    ["Blog Vault"]="blog-vault"
    ["Tracker Vault"]="tracker-vault"
)

choice=$(printf '%s\n' "${labels[@]}" | dmenu -c -l 10 -i -p "Select Obsidian Vault:")

# The +_ checks if the key exists
if [[ -n "$choice" && "${vaults[$choice]+_}" ]]; then
    xdg-open "obsidian://open?vault=${vaults[$choice]}" &
fi
