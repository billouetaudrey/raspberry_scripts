#Send message on TG
python3 /home/billou/serverbackupstart.py

#Create new log
date > /home/billou/Logs/HDDCloneLinux.log

#Starting update
sudo apt update >> /home/billou/Logs/HDDCloneLinux.log
echo "Starting upgrade" >> /home/billou/Logs/HDDCloneLinux.log
sudo apt upgrade -y >> /home/billou/Logs/HDDCloneLinux.log

#Shutdown services
systemctl stop docker.service
systemctl stop plexmediaserver.service

#Delete previous backup
rm /mnt/NAS/backup.img

#Starting backup
echo "Backup Started" >> /home/billou/Logs/HDDCloneLinux.log
dd if=/dev/sda2 of=/mnt/NAS/backup.img bs=1k conv=noerror status=progress >> /home/billou/Logs/HDDCloneLinux.log
echo "Backup done" >> /home/billou/Logs/HDDCloneLinux.log

#Restart Service
systemctl start docker.service
systemctl start plexmediaserver.service
echo "Service started" >> /home/billou/Logs/HDDCloneLinux.log

#Send email
mutt -s "Log Clone Linux IMG" -c xxx@gmail.com < /home/billou/Logs/HDDCloneLinux.log

#Send message done on TG
python3 /home/billou/serverbackupdone.py
