#!/bin/bash
while true; do
  echo on | sudo tee /sys/bus/usb/devices/1-2/power/control > /dev/null
  sleep 1
done

