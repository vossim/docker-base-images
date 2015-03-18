#!/bin/bash

LOG_FILE="build.log"
TMP_DIR="jessie-chroot"
TAR_FILE="rootfs.tar.xz"

write_message() {
  echo "=====================================================" | tee -a $LOG_FILE
  echo "$1 $(date)" | tee -a $LOG_FILE
  echo "=====================================================" | tee -a $LOG_FILE
}

rm $LOG_FILE
write_message "Building chroot"
debootstrap --arch=amd64 --components=main --variant=minbase jessie "./$TMP_DIR" http://http.debian.net/debian/ | tee -a $LOG_FILE
write_message "Building archive"
XZ_OPTS=-9e tar cfvJ "$TAR_FILE" -C "$TMP_DIR" . | tee -a $LOG_FILE
write_message "Removing $TMP_DIR"
rm -rf "$TMP_DIR"
write_message "Done"
