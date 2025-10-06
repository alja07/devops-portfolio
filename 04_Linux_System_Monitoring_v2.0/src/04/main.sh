#!/bin/bash

# Основной скрипт генерации лог-файлов

source config.sh
source functions.sh

# Функция генерации одного лог-файла
generate_log_file() {
    local day_offset=$1
    local log_date=$(date -d "-$day_offset days" "+%Y-%m-%d")
    local log_file="nginx_access_$log_date.log"
    local records=$((RANDOM%(MAX_RECORDS - MIN_RECORDS + 1) + MIN_RECORDS))
    
    echo "Генерация лога за $log_date ($records записей) в файл $log_file"
    
    # Запись заголовка
    echo "# Nginx access log for $log_date" > "$log_file"
    echo "# Generated records: $records" >> "$log_file"
    
    # Генерация временных меток в пределах дня
    local timestamps=()
    for ((i=0; i<records; i++)); do
        local seconds=$(( (86400 * i) / records ))
        timestamps+=("$(date -d "$log_date + $seconds seconds" "+%d/%b/%Y:%H:%M:%S %z")")
    done
    
    # Генерация записей лога
    for ((i=0; i<records; i++)); do
        local ip=$(generate_ip)
        local timestamp="${timestamps[$i]}"
        local method=$(generate_method)
        local url=$(generate_url)
        local code=$(generate_status_code)
        local agent=$(generate_user_agent)
        local size=$(generate_response_size)
        
        # Combined Log Format
        echo "$ip - - [$timestamp] \"$method $url HTTP/1.1\" $code $size \"-\" \"$agent\"" >> "$log_file"
    done
    
    echo "Файл $log_file успешно создан"
}

# Главная функция
main() {
    echo "=== Генератор лог-файлов nginx ==="
    echo "Генерация $DAYS_TO_GENERATE файлов..."
    
    for day in $(seq 0 $((DAYS_TO_GENERATE - 1))); do
        generate_log_file $day
    done
    
    echo "Генерация логов завершена"
    echo "Создано файлов: $DAYS_TO_GENERATE"
}

# Запуск
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi