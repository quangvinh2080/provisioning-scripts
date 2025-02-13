#!/bin/bash

# Prompt user for input
read -p "Enter the static IP address (with CIDR, e.g., 192.168.1.100/24): " STATIC_IP
read -p "Enter the gateway IP address: " GATEWAY
read -p "Enter the primary DNS server: " DNS1
read -p "Enter the secondary DNS server: " DNS2

# Update the Netplan configuration
sudo sed -i.bak \
    -e 's/dhcp4: true/dhcp4: false/' \
    -e "/dhcp4: false/a\        addresses:\n          - $STATIC_IP\n        gateway4: $GATEWAY\n        nameservers:\n          addresses:\n            - $DNS1\n            - $DNS2" \
    /etc/netplan/*.yaml

# Apply the configuration
sudo netplan apply

# Output a success message
echo "Netplan updated to use static IP: $STATIC_IP, Gateway: $GATEWAY, DNS: $DNS1, $DNS2"

