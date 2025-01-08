/interface bridge
add name=loopback
add name=vpls protocol-mode=none
/routing bgp instance
set default as=65500 router-id=9.9.9.6
/routing ospf instance
set [ find default=yes ] router-id=9.9.9.6
/interface bridge port
add bridge=vpls interface=ether4
/interface vpls bgp-vpls
add bridge=vpls export-route-targets=1:2 import-route-targets=1:2 name=vpls \
    route-distinguisher=1:2
/ip address
add address=9.9.9.6 interface=loopback network=9.9.9.6
add address=10.10.0.2/24 interface=vpls network=10.10.0.0
add address=192.168.8.102/30 interface=ether3 network=192.168.8.100
add address=192.168.9.101/30 interface=ether4 network=192.168.9.100
/mpls ldp
set enabled=yes lsr-id=9.9.9.6 transport-address=9.9.9.6
/mpls ldp interface
add interface=ether3
add interface=ether4
/routing bgp instance vrf
add redistribute-connected=yes redistribute-ospf=yes routing-mark=vrf1
/routing bgp peer
add address-families=vpnv4 name=peer1 remote-address=9.9.9.3 remote-as=65500 update-source=loopback
/routing ospf network
add area=backbone network=192.168.8.100/30
add area=backbone network=192.168.9.100/30
add area=backbone network=9.9.9.6/32