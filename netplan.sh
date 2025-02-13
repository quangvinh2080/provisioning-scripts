#!/bin/bash

# Detect the active network interface (ignores loopback and virtual interfaces)
INTERFACE=$(ip -4 route | grep default | awk '{print $5}')

# Get current DHCP IP and Gateway
CURRENT_IP=$(ip -4 addr show "$INTERFACE" | grep -oP '(?<=inet\s)\d+(\.\d+){3}/\d+')
CURRENT_GATEWAY=$(ip route | grep default | awk '{print $3}')

# Prompt user with defaults
echo "Detected active network interface: $INTERFACE"
echo "Detected current DHCP settings:"
echo "IP Address: $CURRENT_IP"
echo "Gateway: $CURRENT_GATEWAY"

read -p "Enter the static IP address (default: $CURRENT_IP): " STATIC_IP
STATIC_IP=${STATIC_IP:-$CURRENT_IP}

read -p "Enter the gateway IP address (default: $CURRENT_GATEWAY): " GATEWAY
GATEWAY=${GATEWAY:-$CURRENT_GATEWAY}

read -p "Enter the primary DNS server (default: 8.8.8.8): " DNS1
DNS1=${DNS1:-8.8.8.8}

read -p "Enter the secondary DNS server (default: 8.8.4.4): " DNS2
DNS2=${DNS2:-8.8.4.4}

# Backup the existing Netplan configuration
sudo cp /etc/netplan/00-installer-config.yaml /etc/netplan/00-installer-config.yaml.bak

# Write the new Netplan configuration
sudo tee /etc/netplan/00-installer-config.yaml > /dev/null <<EOL
network:
  version: 2
  ethernets:
    $INTERFACE:
      addresses:
      - $STATIC_IP
      nameservers:
        addresses:
        - $DNS1
        - $DNS2
        search: []
      routes:
      - to: default
        via: $GATEWAY
EOL

# Apply the configuration
sudo netplan apply

# Output a success message
echo "Netplan updated successfully with:"
echo "Interface: $INTERFACE"
echo "Static IP: $STATIC_IP"
echo "Gateway: $GATEWAY"
echo "DNS: $DNS1, $DNS2"
