#!/bin/bash

# Bluetooth monitor: ensures the adapter stays unblocked and powered on.
# Paired with bluetooth-monitor.service and bluetooth-monitor.timer
# (sibling files in this directory).
#
# Install:
#   sudo install -m 755 bluetooth_monitor.sh       /usr/local/bin/bluetooth_monitor.sh
#   sudo install -m 644 bluetooth-monitor.service  /etc/systemd/system/bluetooth-monitor.service
#   sudo install -m 644 bluetooth-monitor.timer    /etc/systemd/system/bluetooth-monitor.timer
#   sudo systemctl daemon-reload
#   sudo systemctl enable --now bluetooth-monitor.timer
#
# Verify:
#   systemctl status bluetooth-monitor.timer
#   journalctl -u bluetooth-monitor.service -n 20

# Unblock rfkill in case it's soft-blocked, then ensure the adapter is powered.
# Both commands are idempotent, so running every minute is harmless.
rfkill unblock bluetooth
bluetoothctl show | grep -q "Powered: yes" || bluetoothctl power on
