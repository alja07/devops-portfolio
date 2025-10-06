#!/bin/bash

clean_by_date() {
    echo "=== Параметр 2: Удаление по дате создания ==="
    
    read -p "Введите начальную дату и время (ГГГГ-ММ-ДД ЧЧ:ММ): " start_datetime
    read -p "Введите конечную дату и время (ГГГГ-ММ-ДД ЧЧ:ММ): " end_datetime
    
    # Добавляем секунды :00 к введённым данным
    start_datetime="${start_datetime}:00"
    end_datetime="${end_datetime}:00"
    
    # Преобразование в UNIX timestamp
    start_ts=$(date -d "$start_datetime" +%s 2>/dev/null)
    end_ts=$(date -d "$end_datetime" +%s 2>/dev/null)
    
    if [ -z "$start_ts" ] || [ -z "$end_ts" ]; then
        echo "Неверный формат даты/времени. Используйте формат: ГГГГ-ММ-ДД ЧЧ:ММ" >&2
        exit 1
    fi
    
    echo "Поиск файлов созданных между $(date -d "@$start_ts") и $(date -d "@$end_ts")"
    
    # Ищем файлы по дате создания во всех лог-файлах
    for log_file in $(ls -t $LOG_PATTERN 2>/dev/null); do
        echo "Анализ лог-файла: $log_file"
        
        # Пропускаем заголовочные строки (первые 4 строки)
        tail -n +5 "$log_file" | while IFS= read -r line; do
            # Извлекаем дату и время из строки лога [2025-09-16 15:48:49]
            log_datetime=$(echo "$line" | grep -oP '\[\K\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}(?=\])')
            
            if [ -n "$log_datetime" ]; then
                # Преобразуем дату из лога в timestamp
                log_ts=$(date -d "$log_datetime" +%s 2>/dev/null)
                
                if [ "$log_ts" -ge "$start_ts" ] && [ "$log_ts" -le "$end_ts" ]; then
                    # Извлекаем путь (для строк "Создана папка:" и "Создан файл:")
                    path=$(echo "$line" | grep -oP '(Создана папка:|Создан файл:) \K[^ ]+')
                    
                    if [ -n "$path" ]; then
                        echo "$path" >> "$TEMP_FILE"
                    fi
                fi
            fi
        done
    done
    
    # Получаем уникальные пути
    items_to_delete=($(sort -u "$TEMP_FILE"))
    > "$TEMP_FILE"  # Очищаем временный файл
    
    if [ ${#items_to_delete[@]} -eq 0 ]; then
        echo "Не найдено файлов/папок для удаления в указанный период." >&2
        exit 0
    fi
    
    echo "Найдено для удаления (${#items_to_delete[@]} объектов):"
    printf '%s\n' "${items_to_delete[@]}"
    
    if confirm_deletion; then
        deleted_count=0
        error_count=0
        for item in "${items_to_delete[@]}"; do
            if [ -e "$item" ]; then
                if rm -rf "$item"; then
                    echo "Удалено: $item"
                    ((deleted_count++))
                else
                    echo "Ошибка удаления: $item" >&2
                    ((error_count++))
                fi
            fi
        done
        echo "Удаление завершено. Удалено: $deleted_count, ошибок: $error_count"
    else
        echo "Удаление отменено."
    fi
}
