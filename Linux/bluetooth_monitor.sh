#!/bin/bash

# Placed in /usr/local/bin/bluetooth_monitor.sh

# Associated File /etc/systemd/system/bluetooth-monitor.service
# [Unit]
# Description=Bluetooth Monitor Service

# [Service]
# Type=oneshot
# ExecStart=/usr/local/bin/bluetooth_monitor.sh

# Associated File /etc/systemd/system/bluetooth-monitor.timer

# [Unit]
# Description=Run Bluetooth Monitor Script Every Minute

# [Timer]
# OnBootSec=1min
# OnUnitActiveSec=1min
# Unit=bluetooth-monitor.service

# [Install]
# WantedBy=timers.target


# Check if Bluetooth is powered off
status=$(bluetoothctl show | grep "Powered" | awk '{print $2}')
echo $status

# If Bluetooth is off, turn it on
if [ "$status" == "no" ]; then
    rfkill toggle bluetooth
fi