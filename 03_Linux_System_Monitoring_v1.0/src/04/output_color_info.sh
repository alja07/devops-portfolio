#!/bin/bash

keys=(
  HOSTNAME
  TIMEZONE
  USER
  OS
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
  "$TIMEZONE UTC ${TIMEZONE_OFFSET:0:3}"
  "$USER"
  "$OS $OS_VERSION"
  "$DATE"
  "$UPTIME"
  "$UPTIME_SEC сек"
  "$IP"
  "$MASK"
  "$GATEWAY"
  "$RAM_TOTAL ГБ"
  "$RAM_USED ГБ"
  "$RAM_FREE ГБ"
  "$SPACE_ROOT МБ"
  "$SPACE_ROOT_USED МБ"
  "$SPACE_ROOT_FREE МБ"
)

for i in "${!keys[@]}"; do
  echo -e "${col1_color_font}${col1_color_bg}${keys[i]}${reset_color} = ${col2_color_font}${col2_color_bg}${values[i]}${reset_color}"
done

output_colors() {
  echo ""
  echo "Цветовая схема:"
  echo "Column 1 background color = $color1 (${colors[$color1]:-"default"})"
  echo "Column 1 font color = $color2 (${colors[$color2]:-"default"})"
  echo "Column 2 background color = $color3 (${colors[$color3]:-"default"})"
  echo "Column 2 font color = $color4 (${colors[$color4]:-"default"})"
}
