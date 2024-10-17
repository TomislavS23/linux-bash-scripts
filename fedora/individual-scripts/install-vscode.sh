#!/usr/bin/env bash
set -e
trap "echo 'An error occurred. Exiting...'; exit 1" ERR

# Complete set of commands needed to install VSCode on Fedora.
readonly vscode=(
    "sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc"
    'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null'
    "sudo dnf upgrade"
    "sudo dnf install code"
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