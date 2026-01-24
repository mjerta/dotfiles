#!/bin/bash

echo "Linux File System Hierarchy Quick Guide"
echo "======================================"

declare -A dirs=(
  ["/"]="Root directory, top of the file system"
  ["/bin"]="Essential user command binaries (e.g., ls, cp)"
  ["/sbin"]="System administration binaries (e.g., reboot, fdisk)"
  ["/etc"]="System-wide configuration files"
  ["/home"]="User home directories"
  ["/root"]="Home directory for root user"
  ["/var"]="Variable data (logs, caches, databases)"
  ["/tmp"]="Temporary files (cleared on reboot)"
  ["/usr"]="User programs and applications"
  ["/boot"]="Boot loader and kernel files"
  ["/dev"]="Device files (e.g., hard drives, terminals)"
  ["/proc"]="Virtual filesystem with process/kernel info"
  ["/sys"]="Runtime device and driver information"
  ["/lib"]="Shared libraries for /bin and /sbin"
  ["/opt"]="Optional third-party software"
  ["/mnt"]="Temporary mount point for filesystems"
  ["/media"]="Mount point for removable media (USB, CD)"
  ["/srv"]="Data for services (e.g., web or FTP servers)"
  ["/run"]="Runtime data since last boot (PID files, sockets)"
)

for dir in "${!dirs[@]}"; do
  printf "%-15s %s\n" "$dir:" "${dirs[$dir]}"
done
