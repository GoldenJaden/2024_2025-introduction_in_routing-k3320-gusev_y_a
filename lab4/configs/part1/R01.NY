/interface bridge
add name=lobridge
/routing bgp instance
set default as=65500 router-id=9.9.9.1
/routing ospf instance
set [ find default=yes ] router-id=9.9.9.1
/ip address
add address=9.9.9.1 interface=lobridge network=9.9.9.1
add address=192.168.1.102/30 interface=ether3 network=192.168.1.100
add address=192.168.2.101/30 interface=ether4 network=192.168.2.100
/ip route vrf
add export-route-targets=65500:100 import-route-targets=65500:100 \
    interfaces=ether3 route-distinguisher=65500:100 routing-mark=vrf1
/mpls ldp
set enabled=yes lsr-id=9.9.9.1 transport-address=9.9.9.1
/mpls ldp interface
add interface=ether3
add interface=ether4
/routing bgp instance vrf
add redistribute-connected=yes redistribute-ospf=yes routing-mark=vrf1
/routing bgp peer
add address-families=vpnv4 name=peer1 remote-address=9.9.9.2 remote-as=\
    65500 update-source=lobridge
/routing ospf network
add area=backbone network=192.168.1.100/30
add area=backbone network=192.168.2.100/30
add area=backbone network=9.9.9.1/32
/system identity
set name=R01.NY