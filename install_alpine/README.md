# Inception Installation Guide for Alpine Linux

# https://wiki.alpinelinux.org/wiki/Alpine_setup_scripts#setup-xorg-base

## Prerequisites
Before running the installation script, ensure that you have the following setup:

- A virtual machine (VM) running **Alpine Linux**.
- Network ports configured:
  - **443:443** for Nginx
  - **42:42** for SSH between the host and the guest
- `curl` must be installed on your system.

## Installing Curl
If `curl` is not installed, you can install it using the following command:
```sh
su -c "apk add curl"
```

## Downloading the Installation Script
To download the installation script, run the following command:
```sh
curl -O https://raw.githubusercontent.com/HishamEltayb/Inception/refs/heads/master/install_alpine/install.sh
```

## Setting Up Execution Permissions
Once downloaded, modify the file permissions to make it executable:
```sh
chmod +x install.sh
```

## Running the Installation Script
Execute the script with superuser privileges:
```sh
su  -c 'sh install.sh'
```

## Notes
- Alpine Linux uses `doas` instead of `sudo` by default for privilege escalation
- Ensure you have the necessary permissions to execute the script
- Double-check that your VM's network settings are correctly configured before running the script
- If you encounter any issues, verify that `curl` is properly installed and your VM network ports are correctly mapped

Happy coding! 🚀
