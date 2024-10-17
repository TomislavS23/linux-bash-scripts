#!/usr/bin/env bash
set -e
trap "echo 'An error occurred. Exiting...'; exit 1" ERR

# Complete set of commands needed to install and configure Docker.
# This set also adds user to docker group (needed to run docker commands in terminal).
readonly docker=(
    "sudo dnf -y install dnf-plugins-core"
    "sudo dnf-3 config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo"
    "sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin"
    "sudo systemctl start docker"
    "sudo systemctl enable docker"
    "sudo docker run hello-world"
    "sudo usermod -a -G docker $USER"
    "grep docker /etc/group"
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