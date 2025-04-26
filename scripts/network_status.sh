#!/bin/bash

check_ethernet() {
    local eth_device=$(networkctl list --no-legend | grep -P 'eth[0-9]|enp[0-9]s[0-9]' | awk '{print $2}')
    [ -z "$eth_device" ] && return 1
    
    if ip link show "$eth_device" | grep -q "state UP"; then
        echo "󰈀 Ethernet"
        return 0
    fi
    return 1
}

check_wifi() {
    local wifi_device=$(iwctl device list | awk '/wlan[0-9]+\s+.*station/ {print $2}' | head -n 1)
    [ -z "$wifi_device" ] && return 1
    
    local wifi_network=$(iwctl station "$wifi_device" show 2>/dev/null | grep "Connected network" | sed -E 's/.*Connected network[[:space:]]+//; s/[[:space:]]+$//')
    [ -n "$wifi_network" ] && echo "  $wifi_network" && return 0
    
    return 1
}

main() {
    check_ethernet || check_wifi || echo "󰖪 Offline"
}

main
