# Provisioning Scripts

This repository contains useful scripts for setting up and configuring various system components.

## Netplan Configuration Script

The `netplan.sh` script allows you to configure a static IP address for your system interactively.

### Usage

#### Update netplan

```bash
curl -sLO https://raw.githubusercontent.com/quangvinh2080/provisioning-scripts/main/netplan.sh
sudo chmod +x ./netplan.sh
sudo ./netplan.sh 
```

#### Install docker

```bash
curl -o- https://raw.githubusercontent.com/quangvinh2080/provisioning-scripts/main/docker.sh|bash
```

#### Install k3s with helm

```bash
curl -o- https://raw.githubusercontent.com/quangvinh2080/provisioning-scripts/main/k3s-with-helm.sh|bash
```

### Features
- Prompts for user input (IP, gateway, DNS servers)
- Modifies Netplan configuration
- Applies changes automatically

### Disclaimer
Use these scripts with caution. Always review the code before execution, especially when running scripts from external sources.


