#!/bin/bash



if which endpointosc &>/dev/null; then
    echo "INFO: Tool is installed, so update will be start..."
    sleep 2s
    endpointosc_path=$(which endpointosc)
else
    echo "ERROR: Tool is not found on server. Please run ./install.sh first..."
    exit 1
fi

if [ -f "./usr/bin/endpointosc" ]; then
    echo "INFO: New binary found under ./usr/bin/"
    sleep 2s
else
    echo "ERROR: Binary file doesn't exist on ./usr/bin folder"
    exit 1
fi


backup_config() {

    echo "INFO: Default configuration file found..."
    sleep 2s
    echo "INFO: Backup is starting..."
    sleep 2s
    mv /etc/endpointosc/endpointosc.yml /etc/endpointosc/endpointosc.yml.backup
    if [ $? -eq 0 ]; then
        echo "SUCCESS: Config backup finished successfully"
        echo "INFO: Old configuration file: /etc/endpointosc/endpointosc.yml.backup"
    else
        echo "ERROR: Backup process failed."
        exit 1
    fi
}


backup_binary(){

    mv $endpointosc_path /root/endpointosc.old
    if [ $? -eq 0 ]; then
        echo "SUCCESS: Binary backup finished successfully"
        echo "INFO: Old binary file: /root/endpointosc.old"
    else
        echo "ERROR: Backup process failed."
        exit 1
    fi
}

update() {
    cp ./usr/bin/endpointosc $endpointosc_path
    if [ $? -eq 0 ]; then
        echo "SUCCESS: Update finished successfully"
        sleep 2s
        echo "INFO: You can check the update by running:"
        echo "INFO: endpointosc --version"
    else
        echo "ERROR: Update process failed."
        exit 1
    fi


}




if [ -f "/etc/endpointosc/endpointosc.yml" ]; then
    backup_config
    sleep 2s
fi


backup_binary
sleep 2s
update
