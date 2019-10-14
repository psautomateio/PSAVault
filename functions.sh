#!/bin/bash
#
# Title:      PSAutomate
# Based On:   PGBlitz (Reference Title File)
# Original Author(s):  Admin9705 - Deiteq
# PSAutomate Auther: fattylewis
# URL:        https://psautomate.io - http://github.psautomate.io
# GNU:        General Public License v3.0
################################################################################

# BAD INPUT
badinput() {
  echo
  read -p '⛔️ ERROR - Bad Input! | Press [ENTER] ' typed </dev/tty
}

badinput1() {
  echo
  read -p '⛔️ ERROR - Bad Input! | Press [ENTER] ' typed </dev/tty
  question1
}

variable() {
  file="$1"
  if [ ! -e "$file" ]; then echo "$2" >$1; fi
}

removemounts() {
  ansible-playbook /opt/psautomate/menu/remove/mounts.yml
}

readrcloneconfig() {
  touch /opt/appdata/psautomate/rclone.conf
  mkdir -p /var/psautomate/rclone/

  gdcheck=$(cat /opt/appdata/psautomate/rclone.conf | grep gdrive)
  if [ "$gdcheck" != "" ]; then
    echo "good" >/var/psautomate/rclone/gdrive.status && gdstatus="good"
  else echo "bad" >/var/psautomate/rclone/gdrive.status && gdstatus="bad"; fi

  gccheck=$(cat /opt/appdata/psautomate/rclone.conf | grep "remote = gdrive:/encrypt")
  if [ "$gccheck" != "" ]; then
    echo "good" >/var/psautomate/rclone/gcrypt.status && gcstatus="good"
  else echo "bad" >/var/psautomate/rclone/gcrypt.status && gcstatus="bad"; fi

  tdcheck=$(cat /opt/appdata/psautomate/rclone.conf | grep tdrive)
  if [ "$tdcheck" != "" ]; then
    echo "good" >/var/psautomate/rclone/tdrive.status && tdstatus="good"
  else echo "bad" >/var/psautomate/rclone/tdrive.status && tdstatus="bad"; fi

}

rcloneconfig() {
  rclone config --config /opt/appdata/psautomate/rclone.conf
}

keysprocessed() {
  mkdir -p /opt/appdata/psautomate/keys/processed
  ls -1 /opt/appdata/psautomate/keys/processed | wc -l >/var/psautomate/project.keycount
}
