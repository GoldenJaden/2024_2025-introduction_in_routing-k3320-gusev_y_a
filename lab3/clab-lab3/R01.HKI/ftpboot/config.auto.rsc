/interface bridge
add name=lobridge
/routing ospf instance
set [ find default=yes ] router-id=9.9.9.4
/ip address
add address=9.9.9.4 interface=lobridge network=9.9.9.4
add address=192.168.8.102/30 interface=ether3 network=192.168.8.100
add address=192.168.9.101/30 interface=ether5 network=192.168.9.100
add address=192.168.6.102/30 interface=ether4 network=192.168.6.100
/mpls ldp
set enabled=yes lsr-id=9.9.9.4 transport-address=9.9.9.4
/mpls ldp interface
add interface=ether3
add interface=ether4
add interface=ether5
/routing ospf network
add area=backbone network=9.9.9.4/32
add area=backbone network=192.168.8.100/30
add area=backbone network=192.168.9.100/30
add area=backbone network=192.168.6.100/30