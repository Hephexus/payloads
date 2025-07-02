# Example WebApp Firewall Script
# Version 1.0

# Drops all inbound connection attempts that aren't already established
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT

# Drops all Packets that don't have Port 22 and 80 as their destination
iptables -A INPUT -p tcp -m tcp --dport 22 -m conntrack --cstate NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 80 -m conntrack --cstate NEW,ESTABLISHED -j ACCEPT

# Drops all outbound connection attempts that aren't already established
iptables -A OUTPUT -m conntrack --cstate ESTABLISHED -j ACCEPT

# ???
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

# ???
iptables -6 -P INPUT DROP
iptables -6 -P OUTPUT DROP
iptables -6 -P FORWARD DROP

# Persists the Firewall settings in the Netfilter
netfilter-persistent save