# 2023-11-19 13:15:42 by RouterOS 7.11.2
# software id = GFNT-B5IJ
#
# model = RB952Ui-5ac2nD
# serial number = 7C3107576F4B
/interface bridge
add admin-mac=64:D1:54:B5:8D:76 auto-mac=no comment=defconf name=bridgeLocal
/interface wireless
# managed by CAPsMAN
# channel: 2412/20-Ce/gn(20dBm), SSID: praze, local forwarding
set [ find default-name=wlan1 ] antenna-gain=0 country=no_country_set \
    disabled=no frequency-mode=manual-txpower ssid=MikroTik station-roaming=\
    enabled
# managed by CAPsMAN
# channel: 5180/20-Ceee/ac/P(20dBm), SSID: praze, local forwarding
set [ find default-name=wlan2 ] antenna-gain=0 country=no_country_set \
    disabled=no frequency-mode=manual-txpower ssid=MikroTik station-roaming=\
    enabled
/caps-man datapath
add bridge=bridgeLocal name=datapath1
/caps-man security
add name=security1
/caps-man configuration
add country="united kingdom" datapath=datapath1 datapath.bridge=bridgeLocal \
    .local-forwarding=yes mode=ap name=cfg1 security=security1 ssid=praze
/interface lte apn
set [ find default=yes ] ip-type=ipv4 use-network-apn=no
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/routing bgp template
set default disabled=no output.network=bgp-networks
/routing ospf instance
add disabled=no name=default-v2
/routing ospf area
add disabled=yes instance=default-v2 name=backbone-v2
/caps-man manager
set enabled=yes
/caps-man provisioning
add action=create-dynamic-enabled master-configuration=cfg1 name-format=\
    prefix-identity name-prefix=work
/interface bridge port
add bridge=bridgeLocal comment=defconf ingress-filtering=no interface=ether1
add bridge=bridgeLocal comment=defconf ingress-filtering=no interface=ether2
add bridge=bridgeLocal comment=defconf ingress-filtering=no interface=ether3
add bridge=bridgeLocal comment=defconf ingress-filtering=no interface=ether4
add bridge=bridgeLocal comment=defconf ingress-filtering=no interface=ether5
/ip neighbor discovery-settings
set discover-interface-list=!dynamic
/ip settings
set max-neighbor-entries=8192
/ipv6 settings
set disable-ipv6=yes max-neighbor-entries=8192
/interface ovpn-server server
set auth=sha1,md5
/interface wireless cap
# 
set bridge=bridgeLocal discovery-interfaces=bridgeLocal enabled=yes \
    interfaces=wlan1,wlan2
/ip dhcp-client
add comment=defconf interface=bridgeLocal
/ip ssh
set forwarding-enabled=remote
/routing bfd configuration
add disabled=no
/system clock
set time-zone-name=Europe/London
/system identity
set name=workshop
/system note
set show-at-login=no
/system routerboard settings
set auto-upgrade=yes
