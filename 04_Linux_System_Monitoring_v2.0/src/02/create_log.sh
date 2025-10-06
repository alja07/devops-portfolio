#!/bin/bash

# Создаем лог-файл
log_file="creation_log_$(date +'%d%m%y_%H%M%S').txt"
echo "Лог создания файлов и папок" > "$log_file"
echo "Дата начала: $(date '+%Y-%m-%d %H:%M:%S')" >> "$log_file"
echo "Параметры: $@" >> "$log_file"
echo "----------------------------------" >> "$log_file"
