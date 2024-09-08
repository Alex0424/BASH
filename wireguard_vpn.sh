#!/bin/bash
# You need to have WireGuard Config file in same directory and between 200 to 300 bytes for this script to work

install_wireguard() {
    dnf update -y
    dnf install wireguard-tools -y
    if command -v wg > /dev/null 2>&1; then
        echo "WireGuard installaed successfully. Version:"
        wg --version
    else
        echo "Failed to install WireGuard."
        exit 1
    fi
}


if command -v wg > /dev/null 2>&1; then
    echo "WireGuars is already installed. Version:"
    wg --version
    read -p "Connect to VPN? (Y/n): " response
    response=$(echo "$response" | tr '[:upper:]' '[:lower:]')

    if [[ "$response" == "yes" || "$response" == "y" ]]; then
        CONFIG_FILE=$(find ./ -type f -name "*.conf" -size +200c -size -300c | head -n 1)

        if [[ -z "$CONFIG_FILE" ]]; then
            echo "No .conf file found with size between 200 and 300 bytes."
            exit 1
        fi

        CONFIG_NAME=$(basename "$CONFIG_FILE")
        echo "Starting VPN with configuration: $CONFIG_NAME"
        wg-quick up "$CONFIG_NAME"
        echo "to stop WireGuard VPN connection do: wg-quick down $CONFIG_NAME"
    else
        echo "Action abort."
    fi

else
    echo "WireGuard is not installed. Installing now..."
    install_wireguard
fi
