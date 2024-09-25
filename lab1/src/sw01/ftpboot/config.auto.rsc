/interface bridge
add name=bridge1
add name=bridge2
/interface ethernet
set [ find default-name=ether1 ] disable-running-check=no
set [ find default-name=ether2 ] disable-running-check=no
set [ find default-name=ether3 ] disable-running-check=no
set [ find default-name=ether4 ] disable-running-check=no
set [ find default-name=ether5 ] disable-running-check=no
/interface vlan
add interface=ether3 name=vlan10 vlan-id=10
add interface=ether3 name=vlan20 vlan-id=20
add interface=ether4 name=vlan102 vlan-id=10
add interface=ether5 name=vlan202 vlan-id=20
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/interface bridge port
add bridge=bridge1 interface=vlan10
add bridge=bridge1 interface=vlan102
add bridge=bridge2 interface=vlan20
add bridge=bridge2 interface=vlan202
/ip address
add address=172.31.255.30/30 interface=ether1 network=172.31.255.28
/ip dhcp-client
add disabled=no interface=ether1
add disabled=no interface=bridge2
add disabled=no interface=bridge1
/system identity
set name=sw01