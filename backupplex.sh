
#!/bin/bash

# Backup a Plex database.
# Author Scott Smereka
# Version 1.0

# Script Tested on:
# Ubuntu 12.04 on 2/2/2014      [ OK ]


# Plex Database Location.  The trailing slash is
# needed and important for rsync.
plexDatabase="/var/lib/plexmediaserver/Library/Application Support/Plex Media Server/"

# Location to backup the directory to.
backupDirectory="/mnt/Maxtor/BackupRasp/Plex/"

# Log file for script's output named with
# the script's name, date, and time of execution.
scriptName=$(basename ${0})
log="/var/log/${scriptName}_`date +%m%d%y%H%M%S`.log"
echo "Log Started" > $log

#Create backup directory
if [ -d "$backupDirectory" ]; then
    echo "\033[0;32m Backup Directory is there. \033[m"
else
mkdir $backupDirectory
fi

# Create Log
echo "Staring Backup of Plex Database."
echo "------------------------------------------------------------\n"

# Stop Plex
echo "\n\nStopping Plex Media Server."
echo "------------------------------------------------------------\n"
sudo service plexmediaserver stop

# Backup database
echo "\n\nStarting Backup."
echo "------------------------------------------------------------\n"
sudo rsync -a --info=progress2 --delete --exclude "Cache" "$plexDatabase" "$backupDirectory" --log-file=$log

# Restart Plex
echo "\n\nStarting Plex Media Server."
echo "------------------------------------------------------------\n"
sudo service plexmediaserver start

# Done
echo "\n\nBackup Complete."

#Source : https://gist.github.com/ssmereka/8773626
