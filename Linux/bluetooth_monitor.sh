#!/bin/bash

# Placed in /usr/local/bin/bluetooth_monitor.sh
# Paired with bluetooth-monitor.service and bluetooth-monitor.timer
# (see sibling files in this directory).

# Unblock rfkill in case it's soft-blocked, then ensure the adapter is powered.
# Both commands are idempotent, so running every minute is harmless.
rfkill unblock bluetooth
bluetoothctl show | grep -q "Powered: yes" || bluetoothctl power on
