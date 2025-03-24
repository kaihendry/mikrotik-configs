# 2025-03-24 14:13:48 by RouterOS 7.18.2
# software id = D555-50G3
#
# model = RBD53iG-5HacD2HnD
# serial number = E7290D45E8BC
/interface bridge
add name=bridge
/interface wifi
set [ find default-name=wifi1 ] configuration.country="United Kingdom" .mode=ap .ssid=praze disabled=no security.authentication-types=""
set [ find default-name=wifi2 ] configuration.country="United Kingdom" .mode=ap .ssid=praze disabled=no security.authentication-types=""
/interface bridge port
add bridge=bridge interface=ether1
add bridge=bridge interface=ether2
add bridge=bridge interface=ether3
add bridge=bridge interface=ether4
add bridge=bridge interface=ether5
add bridge=bridge interface=wifi1
add bridge=bridge interface=wifi2
/ip dhcp-client
add interface=bridge
/system clock
set time-zone-name=Europe/London
/system identity
set name=tvroom
/system leds settings
set all-leds-off=immediate
/system note
set show-at-login=no
/system routerboard settings
set auto-upgrade=yes
