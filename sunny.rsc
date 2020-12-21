# dec/21/2020 11:11:06 by RouterOS 6.47.8
# software id = S3R7-Q979
#
# model = CCR1009-7G-1C-1S+
# serial number = 915508C55DA7
/interface bridge
add name=bridge1
/interface ethernet
set [ find default-name=sfp-sfpplus1 ] auto-negotiation=no speed=1Gbps
/caps-man datapath
add bridge=bridge1 name=datapath1
/caps-man security
add authentication-types=wpa2-psk name=security1
/caps-man configuration
add datapath=datapath1 name=cfg1 security=security1 ssid=e888-homelab
/interface list
add name=WAN
add name=LAN
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip pool
add name=dhcp ranges=192.168.1.10-192.168.1.254
add name=vpn ranges=192.168.89.2-192.168.89.255
/ip dhcp-server
add address-pool=dhcp disabled=no interface=bridge1 name=dhcp1
/ppp profile
set *FFFFFFFE local-address=192.168.89.1 remote-address=vpn
/user group
set full policy="local,telnet,ssh,ftp,reboot,read,write,policy,test,winbox,pas\
    sword,web,sniff,sensitive,api,romon,dude,tikapp"
add name=prometheus policy="read,winbox,api,!local,!telnet,!ssh,!ftp,!reboot,!\
    write,!policy,!test,!password,!web,!sniff,!sensitive,!romon,!dude,!tikapp"
/caps-man manager
set enabled=yes upgrade-policy=suggest-same-version
/caps-man provisioning
add action=create-dynamic-enabled master-configuration=cfg1 name-format=\
    prefix-identity
/interface bridge port
add bridge=bridge1 interface=ether1
add bridge=bridge1 interface=ether2
add bridge=bridge1 interface=ether3
add bridge=bridge1 interface=ether4
add bridge=bridge1 interface=ether5
add bridge=bridge1 interface=ether6
add bridge=bridge1 interface=ether7
add bridge=bridge1 interface=combo1
add bridge=bridge1 interface=*E
/interface detect-internet
set detect-interface-list=all
/interface l2tp-server server
set enabled=yes use-ipsec=yes
/interface list member
add interface=sfp-sfpplus1 list=WAN
add interface=bridge1 list=LAN
/interface pptp-server server
set enabled=yes
/interface sstp-server server
set default-profile=default-encryption enabled=yes
/ip address
add address=192.168.1.1/24 comment=defconf interface=ether1 network=\
    192.168.1.0
/ip cloud
set ddns-enabled=yes
/ip dhcp-client
add disabled=no interface=sfp-sfpplus1
/ip dhcp-server lease
add address=192.168.1.12 always-broadcast=yes client-id=1:b0:19:c6:c5:c8:4b \
    mac-address=B0:19:C6:C5:C8:4B server=dhcp1
add address=192.168.1.31 client-id=\
    ff:dd:f1:40:4f:0:2:0:0:ab:11:73:da:ea:49:87:6b:2:ac mac-address=\
    E0:4F:43:5C:AF:E7 server=dhcp1
add address=192.168.1.25 client-id=\
    ff:fb:a7:2:2f:0:2:0:0:ab:11:73:da:ea:49:87:6b:2:ac mac-address=\
    E0:9D:31:DB:27:25 server=dhcp1
add address=192.168.1.36 client-id=1:b8:27:eb:a8:a7:af mac-address=\
    B8:27:EB:A8:A7:AF server=dhcp1
/ip dhcp-server network
add address=192.168.1.0/24 dns-server=8.8.4.4,210.23.6.60,1.1.1.1 gateway=\
    192.168.1.1
/ip dns
set allow-remote-requests=yes servers=1.1.1.1,8.8.4.4
/ip firewall filter
add action=accept chain=input comment=\
    "defconf: accept established,related,untracked" connection-state=\
    established,related,untracked
add action=accept chain=input comment="allow IPsec NAT" dst-port=4500 \
    protocol=udp
add action=accept chain=input comment="allow IKE" dst-port=500 protocol=udp
add action=accept chain=input comment="allow l2tp" dst-port=1701 protocol=udp
add action=accept chain=input comment="allow pptp" dst-port=1723 protocol=tcp
add action=accept chain=input comment="allow sstp" dst-port=443 protocol=tcp
add action=drop chain=input comment="defconf: drop invalid" connection-state=\
    invalid
add action=accept chain=input comment="defconf: accept ICMP" protocol=icmp
add action=drop chain=input comment="defconf: drop all not coming from LAN" \
    in-interface-list=!LAN
add action=fasttrack-connection chain=forward comment="defconf: fasttrack" \
    connection-state=established,related
add action=accept chain=forward comment=\
    "defconf: accept established,related, untracked" connection-state=\
    established,related,untracked
add action=drop chain=forward comment="defconf: drop invalid" \
    connection-state=invalid
add action=drop chain=forward comment=\
    "defconf:  drop all from WAN not DSTNATed" connection-nat-state=!dstnat \
    connection-state=new in-interface-list=WAN
/ip firewall nat
add action=masquerade chain=srcnat out-interface-list=WAN
add action=dst-nat chain=dstnat disabled=yes dst-port=22 in-interface-list=\
    WAN protocol=tcp to-addresses=192.168.1.4 to-ports=22
add action=dst-nat chain=dstnat disabled=yes dst-port=6799 in-interface-list=\
    WAN protocol=tcp to-addresses=192.168.1.3 to-ports=6799
add action=dst-nat chain=dstnat disabled=yes dst-port=443 in-interface-list=\
    WAN protocol=tcp to-addresses=192.168.1.4 to-ports=443
add action=dst-nat chain=dstnat disabled=yes dst-port=9115 in-interface-list=\
    WAN protocol=tcp to-addresses=192.168.1.4 to-ports=9115
add action=dst-nat chain=dstnat disabled=yes dst-port=80 in-interface-list=\
    WAN protocol=tcp to-addresses=192.168.1.4 to-ports=80
add action=dst-nat chain=dstnat disabled=yes dst-port=8333 in-interface-list=\
    WAN protocol=tcp to-addresses=192.168.1.5 to-ports=8333
add action=dst-nat chain=dstnat dst-address=!192.168.1.1 dst-address-type=\
    local dst-port=23 protocol=tcp to-addresses=192.168.1.5 to-ports=23
add action=masquerade chain=srcnat comment="Hairpin NAT" dst-address=\
    192.168.1.0/24 src-address=192.168.1.0/24
add action=dst-nat chain=dstnat comment=FreeNAS disabled=yes dst-address=\
    !192.168.1.1 dst-address-type=local dst-port=24 protocol=tcp \
    to-addresses=192.168.1.2 to-ports=22
add action=dst-nat chain=dstnat comment="Caddy http" dst-address=!192.168.1.1 \
    dst-address-type=local dst-port=80 protocol=tcp to-addresses=192.168.1.5 \
    to-ports=80
add action=dst-nat chain=dstnat comment="Caddy https" dst-address=\
    !192.168.1.1 dst-address-type=local dst-port=443 protocol=tcp \
    to-addresses=192.168.1.5 to-ports=443
add action=dst-nat chain=dstnat disabled=yes dst-address=!192.168.1.1 \
    dst-address-type=local dst-port=9436 protocol=tcp src-address=\
    188.166.218.168 to-addresses=192.168.1.4 to-ports=9436
add action=dst-nat chain=dstnat dst-address=!192.168.1.1 dst-address-type=\
    local dst-port=22 protocol=tcp to-addresses=192.168.1.4 to-ports=22
add action=dst-nat chain=dstnat disabled=yes dst-address=!192.168.1.1 \
    dst-address-type=local dst-port=873 protocol=tcp to-addresses=192.168.1.2 \
    to-ports=873
add action=dst-nat chain=dstnat dst-address=!192.168.1.1 dst-address-type=\
    local dst-port=51820 protocol=udp to-addresses=192.168.1.3 to-ports=51820
add action=dst-nat chain=dstnat dst-address=!192.168.1.1 dst-address-type=\
    local dst-port=51821 protocol=udp to-addresses=192.168.1.4 to-ports=51821
add action=dst-nat chain=dstnat dst-address=!192.168.1.1 dst-address-type=\
    local dst-port=51822 protocol=udp to-addresses=192.168.1.5 to-ports=51822
add action=dst-nat chain=dstnat dst-address=!192.168.1.1 dst-address-type=\
    local dst-port=5201 protocol=tcp to-addresses=192.168.1.5 to-ports=5201
add action=masquerade chain=srcnat comment="masq. vpn traffic" src-address=\
    192.168.89.0/24
/ip route
add disabled=yes distance=1 gateway=210.23.25.245
/ip service
set telnet disabled=yes
/ip ssh
set allow-none-crypto=yes forwarding-enabled=remote
/ip traffic-flow
set interfaces=sfp-sfpplus1
/lcd
set color-scheme=dark time-interval=hour
/ppp secret
add name=vpn
/system clock
set time-zone-name=Asia/Singapore
/system identity
set name=10G
/system routerboard settings
# Firmware upgraded successfully, please reboot for changes to take effect!
set auto-upgrade=yes
/system scheduler
add interval=1d name=Auto-Upgrade on-event="/system package update\
    \ncheck-for-updates once\
    \n:delay 3s;\
    \n:if ( [get status] = \"New version is available\") do={ install }" \
    policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=jan/01/2017 start-time=03:00:20
/tool graphing interface
add interface=sfp-sfpplus1
