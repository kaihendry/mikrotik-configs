# jan/02/1970 00:22:34 by RouterOS 6.47.8
# software id = D555-50G3
#
# model = RBD53iG-5HacD2HnD
# serial number = E7290D45E8BC
/interface bridge
add admin-mac=08:55:31:FB:23:8C auto-mac=no comment=defconf name=bridge
/interface list
add comment=defconf name=WAN
add comment=defconf name=LAN
/ip pool
add name=dhcp_pool0 ranges=81.187.180.130-81.187.180.190
/ip dhcp-server
add address-pool=dhcp_pool0 disabled=no interface=bridge name=dhcp1
/interface bridge port
add bridge=bridge comment=defconf interface=ether2
add bridge=bridge comment=defconf interface=ether3
add bridge=bridge comment=defconf interface=ether4
add bridge=bridge comment=defconf interface=ether5
add bridge=bridge comment=defconf interface=wlan1
add bridge=bridge comment=defconf interface=wlan2
/ip neighbor discovery-settings
set discover-interface-list=LAN
/interface pppoe-client
add add-default-route=yes disabled=no interface=ether1 name=AAISP password=XXXXX user=khw@a.1
/interface list member add list=WAN interface=AAISP
/interface list member
add comment=defconf interface=bridge list=LAN
/ip address
add address=192.168.88.1/24 comment=defconf interface=bridge network=\
    192.168.88.0
/ip dhcp-client
add comment=defconf disabled=no interface=ether1
/ip dhcp-server network
add address=192.168.88.0/24 comment=defconf gateway=192.168.88.1
/ip dns
set allow-remote-requests=yes servers=217.169.20.20,217.169.20.21
/ip firewall address-list
add address=888.dabase.com list=admin
add address=pj.dabase.com list=admin
/ip firewall filter
add action=accept chain=input comment=\
    "defconf: accept established,related,untracked" connection-state=\
    established,related,untracked
add action=drop chain=input comment="defconf: drop invalid" connection-state=\
    invalid
add action=accept chain=input comment="defconf: accept ICMP" protocol=icmp
add action=accept chain=forward comment=management dst-port=22,80 protocol=tcp src-address-list=admin
add action=accept chain=input comment=\
    "defconf: accept to local loopback (for CAPsMAN)" dst-address=127.0.0.1
add action=accept chain=input dst-port=22,80 protocol=tcp src-address-list=admin
add action=drop chain=input comment="defconf: drop all not coming from LAN" \
    in-interface-list=!LAN
add action=accept chain=forward comment="defconf: accept in ipsec policy" \
    ipsec-policy=in,ipsec
add action=accept chain=forward comment="defconf: accept out ipsec policy" \
    ipsec-policy=out,ipsec
add action=fasttrack-connection chain=forward comment="defconf: fasttrack" \
    connection-state=established,related
add action=accept chain=forward comment=\
    "defconf: accept established,related, untracked" connection-state=\
    established,related,untracked
add action=drop chain=forward comment="defconf: drop invalid" \
    connection-state=invalid
add action=drop chain=forward comment=\
    "defconf: drop all from WAN not DSTNATed" connection-nat-state=!dstnat \
    connection-state=new in-interface-list=WAN
/ip firewall nat
add action=masquerade chain=srcnat comment="defconf: masquerade" \
    ipsec-policy=out,none out-interface-list=WAN
/tool mac-server
set allowed-interface-list=LAN
/tool mac-server mac-winbox
set allowed-interface-list=LAN
/ip address
add address=81.187.180.129/26 interface=ether2 network=81.187.180.128
/caps-man datapath add bridge=bridge client-to-client-forwarding=yes local-forwarding=no name=aaout
/caps-man configuration add country="united kingdom" datapath=aaout installation=indoor name=Praze ssid=praze
/caps-man manager set enabled=yes upgrade-policy=suggest-same-version
/caps-man provisioning
add action=create-dynamic-enabled master-configuration=Praze name-format=\
    prefix-identity name-prefix=P
/system clock set time-zone-name=Europe/London
/system identity set name=momsbedroom2
