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

        echo ""
        echo "[------------------------- END OF PREVIOUS COMMAND -----------------------]"
        echo "[-------------------------------------------------------------------------]"
        echo "[------------------------------ NEXT COMMAND -----------------------------]"
        echo ""
    done
}

printMenu(){
    clear

    echo "Please choose one of the available options in this script:"
    echo "---------------------------------------------------------------------"
    echo "|     [1] Execute basic commands post-install commands.             |"
    echo "|     [2] Install VSCode (microsoft).                               |"
    echo "|     [3] Install docker and fix user permissions.                  |"
    echo "|     [4] Exit.                                                     |"
    echo "---------------------------------------------------------------------"
}



while true; do
    printMenu

    read option
    clear

    case $option in
    1) execute_commands "${basic_commands[@]}";;
    2) execute_commands "${vscode[@]}";;
    3) execute_commands "${docker_commands[@]}";;
    4) exit 0;;
    *) echo "Wrong number, please try again."
    esac

    echo "Press any key to continue..."
    read -n 1 -s
done