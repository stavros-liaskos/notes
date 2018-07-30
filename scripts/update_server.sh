#!/bin/bash
# redirect stdout/stderr to a file
exec &> update.log

echo "Stopping processes for updating..."
sudo gitlab-ctl stop unicorn
sudo gitlab-ctl stop sidekiq
sudo gitlab-ctl stop nginx

echo "Updating..."
sudo apt-get update && sudo apt-get upgrade -y

echo "Starting Gitlab..."
sudo gitlab-ctl restart