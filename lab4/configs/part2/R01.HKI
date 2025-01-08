/interface bridge
add name=loopback
/routing bgp instance
set default as=65500 router-id=9.9.9.3
/routing ospf instance
set [ find default=yes ] router-id=9.9.9.3
/ip address
add address=9.9.9.3 interface=loopback network=9.9.9.3
add address=192.168.3.102/30 interface=ether3 network=192.168.3.100
add address=192.168.5.101/30 interface=ether4 network=192.168.5.100
add address=192.168.8.101/30 interface=ether5 network=192.168.8.101
/mpls ldp
set enabled=yes lsr-id=9.9.9.3 transport-address=9.9.9.3
/mpls ldp interface
add interface=ether3
add interface=ether4
add interface=ether5
/routing bgp peer
add address-families=vpnv4 name=peer1 remote-address=9.9.9.6 remote-as=65500 update-source=loopback
add address-families=vpnv4 name=peer2 remote-address=9.9.9.2 remote-as=65500 route-reflect=yes update-source=loopback
add address-families=vpnv4 name=peer3 remote-address=9.9.9.4 remote-as=65500 route-reflect=yes update-source=loopback
/routing ospf network
add area=backbone network=192.168.3.100/30
add area=backbone network=192.168.5.100/30
add area=backbone network=192.168.8.100/30
add area=backbone network=9.9.9.3/32