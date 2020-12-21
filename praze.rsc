# dec/21/2020 03:13:12 by RouterOS 6.47.8
# software id = 3TFL-GZ17
#
# model = RouterBOARD 952Ui-5ac2nD
# serial number = 71B207784E85
/interface bridge
add name=aa
/interface ethernet
set [ find default-name=ether1 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full l2mtu=1526 \
    mtu=1520 name=ether1-wan
set [ find default-name=ether2 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full
set [ find default-name=ether3 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full
set [ find default-name=ether4 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full
set [ find default-name=ether5 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full
/interface pppoe-client
add add-default-route=yes default-route-distance=0 disabled=no interface=\
    ether1-wan name=AAISP user=khw@a.1
/interface wireless
# managed by CAPsMAN
# channel: 2412/20-Ce/gn(20dBm), SSID: praze, CAPsMAN forwarding
set [ find default-name=wlan1 ] antenna-gain=0 country=no_country_set \
    frequency-mode=manual-txpower ssid=MikroTik station-roaming=enabled
# managed by CAPsMAN
# channel: 5180/20-Ceee/ac/P(20dBm), SSID: praze, CAPsMAN forwarding
set [ find default-name=wlan2 ] antenna-gain=0 country=no_country_set \
    frequency-mode=manual-txpower ssid=MikroTik station-roaming=enabled
/caps-man datapath
add bridge=aa client-to-client-forwarding=yes local-forwarding=no name=aaout
/caps-man configuration
add country="united kingdom" datapath=aaout installation=indoor \
    keepalive-frames=disabled name=Praze ssid=praze
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip hotspot profile
set [ find default=yes ] html-directory=flash/hotspot
/ip pool
add name=dhcp_pool0 ranges=81.187.180.130-81.187.180.190
/ip dhcp-server
add address-pool=dhcp_pool0 disabled=no interface=aa name=dhcp1
/queue type
add kind=pcq name=wan pcq-classifier=src-address
/queue tree
add disabled=yes max-limit=920k name=Upload parent=AAISP queue=default
add disabled=yes limit-at=800k max-limit=800k name=Upload-UDP packet-mark=UDP \
    parent=Upload
add disabled=yes name=Upload-Else packet-mark=Else parent=Upload queue=\
    default
/snmp community
set [ find default=yes ] addresses=0.0.0.0/0
/user group
set full policy="local,telnet,ssh,ftp,reboot,read,write,policy,test,winbox,pas\
    sword,web,sniff,sensitive,api,romon,dude,tikapp"
/caps-man access-list
add action=accept disabled=yes interface=any signal-range=-80..120
add action=reject disabled=yes interface=any signal-range=-120..-81
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
/ip dhcp-server network
add address=81.187.180.128/26 dns-server=81.187.180.146,81.187.180.129 \
    gateway=81.187.180.129 netmask=26
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
/ip firewall mangle
add action=set-priority chain=postrouting disabled=yes new-priority=\
    from-dscp-high-3-bits passthrough=yes
add action=mark-packet chain=prerouting disabled=yes new-packet-mark=UDP \
    passthrough=no protocol=udp
add action=mark-packet chain=prerouting disabled=yes new-packet-mark=Else \
    passthrough=no
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
set name=bedroom
/system routerboard settings
# Firmware upgraded successfully, please reboot for changes to take effect!
set auto-upgrade=yes
/tool graphing interface
add interface=AAISP
