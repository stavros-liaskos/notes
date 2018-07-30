#!/bin/bash
# redirect stdout/stderr to a file
exec &> mirror.log

BACKUP="/var/opt/gitlab/backups/"
VCADMIN_PATH="/home/vcadmin/"
REPOS="/var/opt/gitlab/git-data/"

# TODO: check gitlab:backup for return value
# TODO: can this script be called right after vcs1 backup is sent?

echo "#############################################"
echo "#   Today is $(date)   #"
echo "#############################################"


echo "Stopping processes..."
sudo gitlab-ctl stop unicorn
sudo gitlab-ctl stop sidekiq

echo "Processes status..."
# Verify
sudo gitlab-ctl status

echo "Parsing filename..."
FILENAME="$(cd /var/opt/gitlab/backups/ && echo *_gitlab_backup.tar)"
HASHED_NAME=${FILENAME::-18}
echo $HASHED_NAME

echo "Starting backup..."
sudo gitlab-rake gitlab:backup:restore BACKUP=$HASHED_NAME force=yes

echo "Starting Gitlab..."
sudo gitlab-ctl restart

echo "Sanitizing..."
sudo gitlab-rake gitlab:check SANITIZE=true

echo "Deleting backup file..."
rm -rf /var/opt/gitlab/backups/*

echo "Cleaning old repos..."
rm -rf "$REPOS"/repositories.old.*
