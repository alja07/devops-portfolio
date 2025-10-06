#!/bin/bash

source params.sh
source checks.sh
source generate_dir_name.sh
source generate_file_name.sh
source create_log.sh

# Основной цикл создания
created_dirs=0
while [ $created_dirs -lt $dir_count ]; do
  check_disk_space
  
  # Генерация имени папки
  generated_dir_name=$(generate_dir_name "$dir_chars")
  dir_path="${path}/${generated_dir_name}"
  
  # Создание папки
  mkdir -p "$dir_path"
  echo "[$(date +'%Y-%m-%d %H:%M:%S')] Создана папка: $dir_path" >> "$LOG_FILE"
  ((created_dirs++))
    
  # Создание файлов в папке 
  created_files=0
  while [ $created_files -lt $file_count ]; do
    check_disk_space
    generated_file_name=$(generate_file_name)
    file_path="${dir_path}/${generated_file_name}"
    if [ ! -e "$file_path" ]; then
      dd if=/dev/zero of="$file_path" bs=1K count="$file_size_kb" 2>/dev/null
      file_size=$(du -b "$file_path" | cut -f1)
      echo "[$(date +'%Y-%m-%d %H:%M:%S')] Создан файл: $file_path | Размер: $file_size байт" >> "$LOG_FILE"
      ((created_files++))
    fi
  done
done

echo "Создано: $dir_count папок и $(( dir_count * file_count )) файлов"
echo "Лог: $LOG_FILE"