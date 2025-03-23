# 2025-03-23 16:04:06 by RouterOS 7.18.2
# software id = 5FN3-HYNE
#
# model = RBwAPG-5HacD2HnD
# serial number = HD7083WGBY9
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
add bridge=bridge interface=wlan1
add bridge=bridge interface=wlan2
/ip dhcp-client
add interface=bridge
/system clock
set time-zone-name=Europe/London
/system identity
set name=outside
/system note
set show-at-login=no
/system routerboard settings
# Firmware upgraded successfully, please reboot for changes to take effect!
set auto-upgrade=yes
