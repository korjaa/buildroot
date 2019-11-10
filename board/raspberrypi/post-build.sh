#!/bin/sh

set -u
set -e

# Add a console on tty1
if [ -e ${TARGET_DIR}/etc/inittab ]; then
    grep -qE '^tty1::' ${TARGET_DIR}/etc/inittab || \
	sed -i '/GENERIC_SERIAL/a\
tty1::respawn:/sbin/getty -L  tty1 0 vt100 # HDMI console' ${TARGET_DIR}/etc/inittab
fi

# Mount /boot/ from sdcard
if [ ! -d ${TARGET_DIR}/boot ]; then
    mkdir ${TARGET_DIR}/boot
fi
if ! grep -qE '^/dev/mmcblk0p1' ${TARGET_DIR}/etc/fstab; then
    #     # <file system> <mount pt>      <type>  <options>       <dump>  <pass>
    echo "/dev/mmcblk0p1  /boot           vfat    defaults        0       2" \
    >> ${TARGET_DIR}/etc/fstab
fi
