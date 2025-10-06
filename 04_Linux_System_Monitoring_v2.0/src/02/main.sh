#!/bin/bash

# Запоминаем время начала
start_time=$(date +%s)

source params.sh
source checks.sh

# Разделение шаблона файла
file_name_part=$(echo "$file_name" | cut -d. -f1)
file_ext_part=$(echo "$file_name" | cut -d. -f2)

source create_log.sh
source generate_dir_name.sh
source generate_file_name.sh
source create_random_dir.sh

# Основной цикл создания папок и файлов
for (( i=1; i<=100; i++ )); do
  check_disk_space
  
  # Создаем папку
  dir_path=$(create_random_dir)
  if [ -z "$dir_path" ]; then
    continue
  fi
  
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] Создана папка: $dir_path" >> "$log_file"
  
  # Случайное количество файлов (1-5)
  file_count=$((RANDOM % 5 + 1))

  # Создаем файлы
  for (( j=1; j<=file_count; j++ )); do
    check_disk_space
    
    file_name=$(generate_file_name)
    file_path="${dir_path}/${file_name}"
    
    # Создаем файл заданного размера
    dd if=/dev/zero of="$file_path" bs=1M count="$file_size_mb" 2>/dev/null
    file_size=$(du -b "$file_path" | cut -f1)
    
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Создан файл: $file_path | Размер: $file_size байт" >> "$log_file"
  done
done

source end_script.sh
end_script