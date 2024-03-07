#!/bin/bash



dependencies() {

python_version=$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[:3])))')

if [ "$EUID" -ne 0 ]; then
    echo "ERROR: This script must be run as root or with sudo."
    exit 1
fi

if which endpointosc &>/dev/null; then
    echo "ERROR: Tool is already installed"
    exit 1
fi

if [ -f "./usr/bin/endpointosc" ]; then
    echo "INFO: Binary found under ./usr/bin/"
    sleep 2s
else
    echo "ERROR: Binary file doesn't exist on ./usr/bin folder"
    exit 1
fi

if [[ "$(printf '%s\n' "3.9" "$python_version" | sort -V | head -n1)" == "3.9" ]]; then
    cat /dev/null
else
    echo "ERROR: Python version does not support...$python_version"
    echo "Expected: >= 3.9"
    echo "Current: $pyhon_version"
    exit 1
fi


}



configuration_check(){

    if [ -f "/etc/endpointosc/endpointosc.yml" ]; then
        echo "INFO: Default configuration found under /etc/endpointosc/endpointosc.yml"
        sleep 2s
        echo "WARNING: It will overwritten by new version"
        read -p "Do you want to backup it? (y/n): " choice

        # Convert input to lowercase for case-insensitive comparison
        choice=${choice,,}

        # Check the input
        if [ "$choice" = "y" ]; then
            mv /etc/endpointosc/endpointosc.yml /etc/endpointosc/endpointosc.yml.backup
            if [ $? -eq 0 ]; then
                echo "SUCCESS: Config backup finished successfully"
                echo "INFO: Old configuration file: /etc/endpointosc/endpointosc.yml.backup"
            else
                echo "ERROR: Backup process failed."
                exit 1
            fi
            # Add your actions here if the user chooses "y"
        elif [ "$choice" = "n" ]; then
            echo "You chose not to proceed."
            sleep 2
            rm -rf /etc/endpointosc/endpointosc.yml
        else
            echo "Invalid choice. Please enter 'y' or 'n'."
        fi
    else
        echo "ERROR: Unknown error occured!"
        exit 1
    fi




}



install(){

        cp ./usr/bin/endpointosc /usr/bin/endpointosc
        if [ $? -eq 0 ]; then
            echo "SUCCESS: Endpointosc installed successfully"
            endpointosc_path=$(which endpointosc)
            endpointosc_version=$(endpointosc --version)

            echo "INFO: Installed path: $endpointosc_path"
            echo "INFO: Installed $endpointosc_version"
        else
            echo "ERROR: Installation failed"
            exit 1
        fi


}


dependencies
sleep 1s
configuration_check
sleep 1s
install

