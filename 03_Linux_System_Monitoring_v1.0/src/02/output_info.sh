#!/bin/bash

source vars.sh

output_info() {
  echo "HOSTNAME = $HOSTNAME"
  echo "TIMEZONE = $TIMEZONE UTC ${TIMEZONE_OFFSET:0:3}"
  echo "OS = $OS $OS_VERSION"
  echo "DATE = $DATE"
  echo "UPTIME = $UPTIME"
  echo "UPTIME_SEC = $UPTIME_SEC"
  echo "IP = $IP"
  echo "MASK = $MASK"
  echo "GATEWAY = $GATEWAY"
  echo "RAM_TOTAL = $RAM_TOTAL ГБ"
  echo "RAM_USED = $RAM_USED ГБ"
  echo "RAM_FREE = $RAM_FREE ГБ"
  echo "SPACE_ROOT = $SPACE_ROOT МБ"
  echo "SPACE_ROOT_USED = $SPACE_ROOT_USED МБ"
  echo "SPACE_ROOT_FREE = $SPACE_ROOT_FREE МБ"
}