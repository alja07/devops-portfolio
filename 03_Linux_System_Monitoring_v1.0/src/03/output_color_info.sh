#!/bin/bash

keys=(
  HOSTNAME
  TIMEZONE
  TIMEZONE_OFFSET
  USER
  OS
  OS_VERSION
  DATE
  UPTIME
  UPTIME_SEC
  IP
  MASK
  GATEWAY
  RAM_TOTAL
  RAM_USED
  RAM_FREE
  SPACE_ROOT
  SPACE_ROOT_USED
  SPACE_ROOT_FREE
)

values=(
  "$HOSTNAME"
  "$TIMEZONE"
  "$TIMEZONE_OFFSET"
  "$USER"
  "$OS"
  "$OS_VERSION"
  "$DATE"
  "$UPTIME"
  "$UPTIME_SEC"
  "$IP"
  "$MASK"
  "$GATEWAY"
  "$RAM_TOTAL"
  "$RAM_USED"
  "$RAM_FREE"
  "$SPACE_ROOT"
  "$SPACE_ROOT_USED"
  "$SPACE_ROOT_FREE"
)

for i in "${!keys[@]}"; do
  echo -e "${col1_color_font}${col1_color_bg}${keys[i]}${reset_color} = ${col2_color_font}${col2_color_bg}${values[i]}${reset_color}"
done