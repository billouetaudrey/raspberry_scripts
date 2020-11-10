
echo "Afficher service"
echo "Affichage services bannis"
sudo fail2ban-client status phpmyadmin-syslog
sudo fail2ban-client status apache-fakegooglebot
sudo fail2ban-client status apache-noscript
sudo fail2ban-client status apache-overflows
sudo fail2ban-client status apache-auth
sudo fail2ban-client status  apache-badbots
sudo fail2ban-client status  mysqld-auth
sudo fail2ban-client status  proftpd
sudo fail2ban-client status  sshd
echo "Choisir service"
read service
echo "Status du service choisi"
sudo fail2ban-client status $service
echo "Entrer ip a debannir"
read ip
sudo fail2ban-client set $service unbanip $ip
echo "Status du service apres unban"
sudo fail2ban-client status $service
