#!/bin/bash
# Metrics Collect for Linux Monitoring


    # Получаем расширенные метрики
    # CPU
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{printf "%.1f", 100 - $8}' | tr ',' '.')
    CPU_CORES=$(nproc)
    CPU_LOAD=$(awk '{printf "%.1f", $1}' /proc/loadavg)
    
    # RAM
    RAM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
    RAM_USED=$(free -m | awk '/Mem:/ {print $3}')
    RAM_FREE=$(free -m | awk '/Mem:/ {print $4}')
    RAM_PERCENT=$(awk "BEGIN {printf \"%.1f\", ($RAM_USED / $RAM_TOTAL) * 100}")
    SWAP_USED=$(free -m | awk '/Swap:/ {print $3}')
    SWAP_TOTAL=$(free -m | awk '/Swap:/ {print $2}')
    
    # Disk
    DISK_TOTAL=$(df -BM / | awk 'NR==2 {print $2}' | tr -d 'M')
    DISK_USED=$(df -BM / | awk 'NR==2 {print $3}' | tr -d 'M')
    DISK_FREE=$(df -BM / | awk 'NR==2 {print $4}' | tr -d 'M')
    DISK_PERCENT=$(awk "BEGIN {printf \"%.1f\", ($DISK_USED / $DISK_TOTAL) * 100}")
    INODES_USED=$(df -i / | awk 'NR==2 {print $3}')
    INODES_FREE=$(df -i / | awk 'NR==2 {print $4}')
    
    # Network
    # Получаем сетевые метрики
    NET_IFACE=$(ip -o -4 route show to default | awk '{print $5}' | head -1)
    RX_BYTES=$(cat /proc/net/dev | awk -v iface="$NET_IFACE" '$0 ~ iface {print $2}')
    TX_BYTES=$(cat /proc/net/dev | awk -v iface="$NET_IFACE" '$0 ~ iface {print $10}')

    # Конвертируем в человеко-читаемый формат
    RX_READABLE=$(numfmt --to=iec --suffix=B $RX_BYTES)
    TX_READABLE=$(numfmt --to=iec --suffix=B $TX_BYTES)    
    
    # System
    UPTIME=$(uptime -p)
    CURRENT_TIME=$(date +"%H:%M:%S")
    HOSTNAME=$(hostname)

    # Обновляем историю
    CPU_HISTORY+=("$CPU_USAGE")
    RAM_HISTORY+=("$RAM_PERCENT")
    DISK_HISTORY+=("$DISK_PERCENT")
    TIMESTAMPS+=("$CURRENT_TIME")
    
    if [ ${#CPU_HISTORY[@]} -gt $MAX_HISTORY ]; then
        CPU_HISTORY=("${CPU_HISTORY[@]:1}")
        RAM_HISTORY=("${RAM_HISTORY[@]:1}")
        DISK_HISTORY=("${DISK_HISTORY[@]:1}")
        TIMESTAMPS=("${TIMESTAMPS[@]:1}")
    fi

    # Генерируем API-ответ
    cat > "$API_FILE" <<EOF
{
    "system": {
        "hostname": "$HOSTNAME",
        "uptime": "$UPTIME",
        "time": "$CURRENT_TIME"
    },
    "cpu": {
        "usage": $CPU_USAGE,
        "cores": $CPU_CORES,
        "load": $CPU_LOAD,
        "history": [$(IFS=,; echo "${CPU_HISTORY[*]}")]
    },
    "ram": {
        "used": $RAM_USED,
        "free": $RAM_FREE,
        "total": $RAM_TOTAL,
        "percent": $RAM_PERCENT,
        "swap_used": $SWAP_USED,
        "swap_total": $SWAP_TOTAL,
        "history": [$(IFS=,; echo "${RAM_HISTORY[*]}")]
    },
    "disk": {
        "used": $DISK_USED,
        "free": $DISK_FREE,
        "total": $DISK_TOTAL,
        "percent": $DISK_PERCENT,
        "inodes_used": $INODES_USED,
        "inodes_free": $INODES_FREE
    },
    "network": {
        "rx": "$RX_BYTES",
        "tx": "$TX_BYTES"
    },
    "timestamps": [$(printf "\"%s\"," "${TIMESTAMPS[@]}" | sed 's/,$//')]
}
EOF