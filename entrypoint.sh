#!/bin/sh

# Generate new ssh key
ssh-keygen -f /root/.ssh/id_rsa -q -P ""

# Show public key
echo "Add the following public key to GitHub:"
echo -e "\033[0;34m$(cat /root/.ssh/id_rsa.pub)\033[0m"

# Add cron job that will reset the repository every minute
echo "*       *       *       *       *       cd /var/www && git fetch origin && git reset --hard origin/master" >> /etc/crontabs/root

exec "$@"
