#!/bin/bash

if [ ! -e /config/device-tree/overlays/fpga ]; then mkdir /config/device-tree/overlays/fpga; fi
sudo cp design_top_wrapper.bit.bin /lib/firmware
sudo cp overlay.dtb /config/device-tree/overlays/fpga/dtbo
sudo chmod 0666 /dev/udmabuf0
sudo chmod 0666 /dev/uio1
