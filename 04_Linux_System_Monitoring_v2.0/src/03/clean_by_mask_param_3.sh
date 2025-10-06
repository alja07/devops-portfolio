#!/bin/bash

clean_by_mask() {
    echo "=== Параметр 3: Удаление по маске имени ==="
    
    read -p "Введите маску имени (например, 'azazz_080825'): " name_mask
    
    if [ -z "$name_mask" ]; then
        echo "Маска не может быть пустой" >&2
        exit 1
    fi
    
    # Проверяем наличие лог-файлов
    log_files=($(ls -t $LOG_PATTERN 2>/dev/null))
    if [ ${#log_files[@]} -eq 0 ]; then
        echo "Лог-файлы не найдены по шаблону: $LOG_PATTERN" >&2
        exit 1
    fi
    
    echo "Поиск по маске '$name_mask' во всех лог-файлах..."
    
    # Ищем во всех лог-файлах
    for log_file in "${log_files[@]}"; do
        echo "Анализ лог-файла: $log_file"
        # Пропускаем заголовки логов (первые 4 строки)
        tail -n +5 "$log_file" | grep -E "Создана папка:|Создан файл:" | grep "$name_mask" | \
        awk -F': ' '{print $2}' | awk '{print $1}' >> "$TEMP_FILE"
    done
    
    # Получаем уникальные пути
    items_to_delete=($(sort -u "$TEMP_FILE"))
    > "$TEMP_FILE"  # Очищаем временный файл
    
    if [ ${#items_to_delete[@]} -eq 0 ]; then
        echo "Не найдено файлов/папок с маской '$name_mask'" >&2
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
        echo "Удаление завершено. Удалено: $deleted_count"
    else
        echo "Удаление отменено"
    fi
}
