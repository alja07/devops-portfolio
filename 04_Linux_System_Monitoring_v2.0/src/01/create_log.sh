#!/bin/bash

# Создание лог-файла
LOG_FILE="${path}/creation_log_$(date +'%d%m%y').txt"
echo "Лог создания файлов и папок" > "$LOG_FILE"
echo "Дата: $(date)" >> "$LOG_FILE"
echo "Параметры: $@" >> "$LOG_FILE"
echo "----------------------------------" >> "$LOG_FILE"
