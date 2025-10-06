#!/bin/bash

# Функция генерации имени файла
generate_file_name() {
  name_part=$(echo "$file_template" | cut -d. -f1)
  ext_part=$(echo "$file_template" | cut -d. -f2)
  name=""
  
  # Добавляем все символы шаблона
  for (( i=0; i<${#name_part}; i++ )); do
    name="${name}${name_part:$i:1}"
  done
  
  # Дополняем до 4 символов обязательно
  while [ ${#name} -lt 4 ]; do
    random_char="${name_part:$(( RANDOM % ${#name_part} )):1}"
    name="${name}${random_char}"
  done
  
  # С 50% вероятностью добавляем еще символы (до 7)
  while [ ${#name} -lt 7 ] && [ $(( RANDOM % 2 )) -eq 1 ]; do
    random_char="${name_part:$(( RANDOM % ${#name_part} )):1}"
    name="${name}${random_char}"
  done
  
  # Генерация расширения
  ext=""
  for (( i=0; i<${#ext_part}; i++ )); do
    ext="${ext}${ext_part:$i:1}"
  done
  
  echo "${name}_$(date +'%d%m%y').${ext}"
}