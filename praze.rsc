# jun/09/2021 10:17:48 by RouterOS 6.48.3
# software id = D555-50G3
#
# model = RBD53iG-5HacD2HnD
# serial number = E7290D45E8BC
/interface bridge
add name=aa
/interface wireless
# managed by CAPsMAN
# channel: 2452/20-Ce/gn(20dBm), SSID: praze, CAPsMAN forwarding
set [ find default-name=wlan1 ] antenna-gain=0 country=no_country_set \
    frequency-mode=manual-txpower ssid=MikroTik station-roaming=enabled
# managed by CAPsMAN
# channel: 5180/20-Ceee/ac/P(20dBm), SSID: praze, CAPsMAN forwarding
set [ find default-name=wlan2 ] antenna-gain=0 country=no_country_set \
    frequency-mode=manual-txpower ssid=MikroTik station-roaming=enabled
/interface ethernet
set [ find default-name=ether1 ] l2mtu=1526 mtu=1520 name=ether1-wan
/interface pppoe-client
add add-default-route=yes disabled=no interface=ether1-wan name=AAISP user=\
    khw@a.1
/caps-man datapath
add bridge=aa client-to-client-forwarding=yes local-forwarding=no name=aaout
/caps-man configuration
add country="united kingdom" datapath=aaout installation=indoor \
    keepalive-frames=disabled name=Praze ssid=praze
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip pool
add name=dhcp_pool0 ranges=81.187.180.130-81.187.180.190
/ip dhcp-server
add address-pool=dhcp_pool0 disabled=no interface=aa name=dhcp1
/queue type
add kind=pcq name=wan pcq-classifier=src-address
/snmp community
set [ find default=yes ] addresses=0.0.0.0/0
/user group
set full policy="local,telnet,ssh,ftp,reboot,read,write,policy,test,winbox,pas\
    sword,web,sniff,sensitive,api,romon,dude,tikapp"
/caps-man manager
set enabled=yes upgrade-policy=suggest-same-version
/caps-man provisioning
add action=create-dynamic-enabled master-configuration=Praze name-format=\
    prefix-identity name-prefix=P
/interface bridge port
add bridge=aa hw=no interface=ether2
add bridge=aa hw=no interface=ether3
add bridge=aa hw=no interface=ether4
add bridge=aa hw=no interface=ether5
/ip neighbor discovery-settings
set discover-interface-list=!dynamic
/interface wireless cap
# 
set caps-man-addresses=127.0.0.1 discovery-interfaces=aa enabled=yes \
    interfaces=wlan1,wlan2
/ip address
add address=81.187.180.129/26 interface=ether2 network=81.187.180.128
/ip dhcp-server lease
add address=81.187.180.146 client-id=1:b8:27:eb:e9:f:f2 mac-address=\
    B8:27:EB:E9:0F:F2 server=dhcp1
add address=81.187.180.135 client-id=1:9c:8e:cd:1d:bd:e6 mac-address=\
    9C:8E:CD:1D:BD:E6 server=dhcp1
add address=81.187.180.131 mac-address=7C:2F:80:49:90:DA server=dhcp1
/ip dhcp-server network
add address=81.187.180.128/26 dns-server=217.169.20.20,217.169.20.21 gateway=\
    81.187.180.129 netmask=26
/ip dns
set allow-remote-requests=yes servers=217.169.20.20,217.169.20.21
/ip firewall address-list
add address=888.dabase.com list=admin
add address=pj.dabase.com list=admin
/ip firewall filter
add action=accept chain=forward comment="Established and related traffic" \
    connection-state=established,related
add action=accept chain=forward comment="LAN traffic can go anywhere" \
    in-interface=aa
add action=accept chain=forward comment=ICMP protocol=icmp
add action=accept chain=forward comment=management dst-port=22,80 protocol=\
    tcp src-address-list=admin
add action=drop chain=forward comment="Drop the rest"
add action=accept chain=output
add action=accept chain=input comment="LAN traffic can go anywhere" \
    in-interface=aa
add action=accept chain=input comment="Established traffic" connection-state=\
    established
add action=accept chain=input comment="Related traffic" connection-state=\
    related
add action=accept chain=input dst-port=22,80 protocol=tcp src-address-list=\
    admin
add action=accept chain=input comment=ICMP protocol=icmp
add action=accept chain=input comment="CAPs to CAPsMAN" dst-port=5246,5247 \
    protocol=udp src-address=127.0.0.1
add action=drop chain=input comment="Drop the rest"
/ip firewall service-port
set ftp disabled=yes
set tftp disabled=yes
set irc disabled=yes
set h323 disabled=yes
set sip disabled=yes
set pptp disabled=yes
/ip ssh
set allow-none-crypto=yes forwarding-enabled=remote
/system clock
set time-zone-name=Europe/London
/system identity
set name=momsbedroom
/system routerboard settings
set auto-upgrade=yes
/tool graphing interface
add interface=AAISP
