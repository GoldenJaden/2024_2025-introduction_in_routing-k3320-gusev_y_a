/interface bridge
add name=lobridge
/routing ospf instance
set [ find default=yes ] router-id=9.9.9.7
/ip address
add address=9.9.9.7 interface=lobridge network=9.9.9.7
add address=192.168.3.102/30 interface=ether3 network=192.168.3.100
add address=192.168.6.101/30 interface=ether4 network=192.168.6.100
add address=192.168.7.101/30 interface=ether5 network=192.168.7.100
/mpls ldp
set enabled=yes lsr-id=9.9.9.7 transport-address=9.9.9.7
/mpls ldp interface
add interface=ether3
add interface=ether4
add interface=ether5
/routing ospf network
add area=backbone network=9.9.9.7/32
add area=backbone network=192.168.3.100/30
add area=backbone network=192.168.6.100/30
add area=backbone network=192.168.7.100/30