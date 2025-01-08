/interface bridge
add name=lobridge
/routing ospf instance
set [ find default=yes ] router-id=9.9.9.3
/ip address
add address=9.9.9.3 interface=lobridge network=9.9.9.3
add address=192.168.4.102/30 interface=ether3 network=192.168.4.100
add address=192.168.8.101/30 interface=ether4 network=192.168.8.100
/mpls ldp
set enabled=yes lsr-id=9.9.9.3 transport-address=9.9.9.3
/mpls ldp interface
add interface=ether3
add interface=ether4
/routing ospf network
add area=backbone network=9.9.9.3/32
add area=backbone network=192.168.4.100/30
add area=backbone network=192.168.8.100/30