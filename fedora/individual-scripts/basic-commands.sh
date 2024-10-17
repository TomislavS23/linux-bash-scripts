#!/usr/bin/env bash
set -e
trap "echo 'An error occurred. Exiting...'; exit 1" ERR

# Complete set of basic commands that can be executed post-installation on Fedora.
readonly basic_commands=(
    "sudo dnf upgrade"
    "sudo dnf remove firefox gnome-contacts gnome-weather gnome-maps"
    "flatpak install flathub org.mozilla.firefox"
    "sudo dnf install @virtualization"
)

# Function recieves one of the specified arrays and loops through it, executing commands.
execute_commands() {
    local commands=("$@")
    for cmd in "${commands[@]}"; do
        if ! eval "$cmd"; then
            echo
            echo "Command failed: $cmd"
            echo "Press any key to quit..."
            read -n 1 -s
            exit 1
        fi

        sleep 1

        echo ""
        echo "[------------------------- END OF PREVIOUS COMMAND -----------------------]"
        echo "[-------------------------------------------------------------------------]"
        echo "[------------------------------ NEXT COMMAND -----------------------------]"
        echo ""
    done
}


execute_commands "${basic_commands[@]}"

echo
echo "Press any key to exit..."
read -n 1 -s