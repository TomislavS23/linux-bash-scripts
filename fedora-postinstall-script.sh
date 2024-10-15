# VARIABLES
basic_commands=(
	# Basic
    "sudo dnf upgrade"
    "sudo dnf remove firefox gnome-contacts gnome-weather gnome-maps"
    "flatpak install flathub org.mozilla.firefox"
    "sudo dnf install @virtualization"
)

vscode=(
    # VSCode
    "sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc"
    'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null'
    "sudo dnf upgrade"
    "sudo dnf install code"
)

docker_commands=(
    # Docker
    "sudo dnf -y install dnf-plugins-core"
    "sudo dnf-3 config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo"
    "sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin"
    "sudo systemctl start docker"
    "sudo systemctl enable docker"
    "sudo docker run hello-world"
)

fix_permissions=(
    # Permissions
    "sudo usermod -a -G docker $USER"
    "grep docker /etc/group"
)

# SCRIPT
execute_commands() {
    local commands=("$@")
    for cmd in "${commands[@]}"; do
        if ! eval "$cmd"; then
            echo "Command failed: $cmd"
            echo "Press any key to quit..."
            read -n 1 -s
            exit 1
        fi

        sleep 3

        echo "------------------------- END OF PREVIOUS COMMAND ------------------------"
        echo "--------------------------------------------------------------------------"
        echo "--------------------------- NEXT COMMAND ---------------------------------"
    done
}

# SCRIPT EXECUTION
execute_commands "${basic_commands[@]}"
execute_commands "${vscode[@]}"
execute_commands "${docker_commands[@]}"
execute_commands "${fix_permissions[@]}"

# EXIT
echo "All commands executed."
echo "Press any key to quit..."
read -n 1 -s
