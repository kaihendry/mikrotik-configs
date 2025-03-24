# 2025-03-24 14:16:35 by RouterOS 7.18.2
# software id = KQWQ-JVBP
#
# model = L009UiGS-2HaxD
# serial number = HF309260XJZ
/interface bridge
add name=bridge
/interface wifi
set [ find default-name=wifi1 ] configuration.country="United Kingdom" .mode=ap .ssid=praze disabled=no
/port
set 0 name=serial0
/interface bridge port
add bridge=bridge interface=ether1
add bridge=bridge interface=ether2
add bridge=bridge interface=ether3
add bridge=bridge interface=ether4
add bridge=bridge interface=ether5
add bridge=bridge interface=ether6
add bridge=bridge interface=ether7
add bridge=bridge interface=ether8
add bridge=bridge interface=wifi1
/ip dhcp-client
add interface=bridge
/ip smb shares
set [ find default=yes ] directory=flash/pub
/system clock
set time-zone-name=Europe/London
/system identity
set name=redagain
/system note
set show-at-login=no
/system routerboard settings
# Firmware upgraded successfully, please reboot for changes to take effect!
set auto-upgrade=yes enter-setup-on=delete-key
