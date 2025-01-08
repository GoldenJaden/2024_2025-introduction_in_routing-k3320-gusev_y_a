/interface bridge
add name=loopback
add name=vpls protocol-mode=none
/routing bgp instance
set default as=65500 router-id=9.9.9.5
/routing ospf instance
set [ find default=yes ] router-id=9.9.9.5
/interface bridge port
add bridge=vpls interface=ether4
/interface vpls bgp-vpls
add bridge=vpls export-route-targets=1:2 import-route-targets=1:2 name=vpls \
    route-distinguisher=1:2 site-id=4
/ip address
add address=9.9.9.5 interface=loopback network=9.9.9.5
add address=192.168.6.102/30 interface=ether3 network=192.168.6.100
add address=192.168.7.101/30 interface=ether4 network=192.168.7.100
add address=10.10.0.20/24 interface=vpls network=10.10.0.0
/mpls ldp
set enabled=yes lsr-id=9.9.9.5 transport-address=9.9.9.5
/mpls ldp interface
add interface=ether3
add interface=ether4
/routing bgp instance vrf
add redistribute-connected=yes redistribute-ospf=yes routing-mark=vrf1
/routing bgp peer
add address-families=vpnv4 name=peer1 remote-address=9.9.9.4 remote-as=\
    65500 update-source=loopback
/routing ospf network
add area=backbone network=192.168.6.100/30
add area=backbone network=192.168.7.100/30
add area=backbone network=9.9.9.5/32