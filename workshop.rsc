# 2025-03-23 16:09:12 by RouterOS 7.18.2
# software id = GFNT-B5IJ
#
# model = RB952Ui-5ac2nD
# serial number = 7C3107576F4B
/interface bridge
add name=bridge
/interface wireless
set [ find default-name=wlan1 ] disabled=no mode=ap-bridge ssid=praze
set [ find default-name=wlan2 ] disabled=no mode=ap-bridge ssid=praze
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/interface bridge port
add bridge=bridge interface=ether1
add bridge=bridge interface=ether2
add bridge=bridge interface=ether3
add bridge=bridge interface=ether4
add bridge=bridge interface=ether5
add bridge=bridge interface=wlan1
add bridge=bridge interface=wlan2
/ip dhcp-client
add interface=bridge
/system clock
set time-zone-name=Europe/London
/system identity
set name=workshop
/system note
set show-at-login=no
/system routerboard settings
set auto-upgrade=yes
