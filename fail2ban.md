```bash
sudo service fail2ban restart   # to apply changes
sudo fail2ban-client status     # list jails
sudo iptables -S                # list configured firewall rules
sudo fail2ban-client status ssh # status for particular jail
```