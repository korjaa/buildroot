#!/bin/sh

set -u
set -e

# Mount /boot/ from sdcard
if [ ! -d ${TARGET_DIR}/boot ]; then
    mkdir ${TARGET_DIR}/boot
fi
if ! grep -qE '^/dev/mmcblk0p1' ${TARGET_DIR}/etc/fstab; then
    #     # <file system> <mount pt>      <type>  <options>       <dump>  <pass>
    echo "/dev/mmcblk0p1  /boot           vfat    defaults        0       2" \
    >> ${TARGET_DIR}/etc/fstab
fi

# WiFi configuration
cp package/busybox/S10mdev ${TARGET_DIR}/etc/init.d/S10mdev
chmod 755 ${TARGET_DIR}/etc/init.d/S10mdev
cp package/busybox/mdev.conf ${TARGET_DIR}/etc/mdev.conf
