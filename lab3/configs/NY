/interface bridge
add name=lobridge
add name=vpn
/interface vpls
add disabled=no l2mtu=1500 mac-address=02:BD:27:52:DB:8E name=EoMPLS remote-peer=9.9.9.5 vpls-id=100:100
/routing ospf instance
set [ find default=yes ] router-id=9.9.9.2
/interface bridge port
add bridge=vpn interface=ether5
add bridge=vpn interface=EoMPLS
/ip address
add address=9.9.9.2 interface=lobridge network=9.9.9.2
add address=192.168.3.101/30 interface=ether3 network=192.168.3.100
add address=192.168.4.101/30 interface=ether4 network=192.168.4.100
add address=10.10.59.1/29 interface=vpn network=10.10.59.0
add address=192.168.5.101/30 interface=ether5 network=192.168.5.100
/mpls ldp
set enabled=yes lsr-id=9.9.9.2 transport-address=9.9.9.2
/mpls ldp interface
add interface=ether3
add interface=ether4
add interface=ether5
/routing ospf network
add area=backbone network=9.9.9.2/32
add area=backbone network=192.168.3.100/30
add area=backbone network=192.168.4.100/30