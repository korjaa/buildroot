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
