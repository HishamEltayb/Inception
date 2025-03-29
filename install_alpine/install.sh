#!/bin/sh

# Change the permission for this file before running:
# chmod +x install.sh
# Then run it with:
# doas sh install.sh

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if the script is being run as root
if [ "$(id -u)" -ne 0 ]; then
    printf "${RED}This script must be run as root. Please run it with 'doas'.${NC}\n"
    exit 1
fi

# Ask for username
printf "${YELLOW}Please enter your device username: (This user will have doas privileges)${NC}\n"
read -r username

# Update system
printf "${BLUE}Updating system...${NC}\n"
apk update && apk upgrade

# Install necessary packages
printf "${BLUE}Installing required packages...${NC}\n"
apk add doas git make curl openssh docker sudo 
chmod 664 /etc/sudoers
sudo addgroup sudo
sudo adduser "$username" sudo
sudo adduser root sudo

# Configure doas for the user
printf "${BLUE}Configuring doas for $username...${NC}\n"
echo "$username ALL=(ALL) ALL" >> /etc/sudoers

# Configure SSH
printf "${BLUE}Configuring SSH on port 42...${NC}\n"
if ! grep -q "Port 42" /etc/ssh/sshd_config; then
    echo "Port 42" >> /etc/ssh/sshd_config
    rc-service sshd restart
fi

# Configure Docker
printf "${BLUE}Configuring Docker...${NC}\n"
rc-update add docker boot
addgroup "$username" docker
service docker start

# Final Message
printf "${GREEN}Setup completed successfully for user $username!${NC}\n"
printf "${YELLOW}Please configure your VM to enable port forwarding (guest 42 <-> host 42) in your MAC.${NC}\n"
printf "${YELLOW}After the reboot, you can start using Docker without doas.${NC}\n"

sleep 3

reboot
