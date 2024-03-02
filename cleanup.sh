#!/bin/bash

echo "Current disk usage:"
sudo du -sh /

# Update and Clean APT Cache
echo "Cleaning APT cache..."
sudo apt-get update
sudo apt-get clean
sudo apt-get autoremove -y

echo "Update and Clean APT Cache completed."

echo "Largest files in /var/log:"
sudo find /var/log -type f -exec ls -lhS {} + | head -n 10

# Clean up archived logs older than 7 days
echo "Deleting archived logs older than 7 days..."
sudo find /var/log -name "*.gz" -o -name "*.1" -mtime +7 -exec rm {} \;

# Placeholder for kernel cleanup - Manual action recommended
# echo "Cleaning old kernels..."
# sudo apt-get purge linux-image-OLD-VERSION

# Find large files but don't delete them automatically
#echo "Finding large files (larger than 100MB)..."
#sudo find / -type f -size +100M

# Optionally, clear specific large log files carefully
# sudo truncate -s 0 /var/log/specific-large-file.log

# Clean up journal logs to keep the last 100MB
echo "Cleaning up journal logs to keep the last 100MB..."
sudo journalctl --vacuum-size=100M

# Truncating syslog and kern.log
echo "Truncating syslog and kern.log..."
sudo truncate -s 0 /var/log/syslog
sudo truncate -s 0 /var/log/kern.log

echo "Disk usage after cleanup:"
sudo du -sh /var/log

echo "Cleanup of /var/log completed."

# Clear user cache
echo "Clearing user cache..."
rm -rf ~/.cache/*

echo "Disk usage after cleanup:"
sudo du -sh /