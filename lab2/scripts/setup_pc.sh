apk add dhcpcd traceroute
dhcpcd eth2
sleep 10
ip route del default via 192.168.100.1

ifconfig | grep 192.168.*.50