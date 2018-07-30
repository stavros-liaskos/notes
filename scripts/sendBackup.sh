#!/bin/bash
# redirect stdout/stderr to a file
exec &> sendBackUp.log

VCS2_ROOT="root@192.119.163.102"
BACKUP_PATH="/var/opt/gitlab/backups/"

echo "#############################################"
echo "#   Today is $(date)   #"
echo "#############################################"


echo "Sending backup to vcs2..."
rsync -vuar "$BACKUP_PATH"*_gitlab_backup.tar "$VCS2_ROOT":"$BACKUP_PATH"