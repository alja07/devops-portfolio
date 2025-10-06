#!/bin/bash

# Функция генерации имени папки
generate_dir_name() {
  chars="$1"
  name=""
  
  # Добавляем все символы хотя бы по одному разу
  for (( i=0; i<${#chars}; i++ )); do
    name="${name}${chars:$i:1}"
  done
  
  # Дополняем случайными символами до длины 4 (если нужно)
  while [ ${#name} -lt 4 ]; do
    random_char="${chars:$(( RANDOM % ${#chars} )):1}"
    name="${name}${random_char}"
  done
  
  # Добавляем дополнительные символы до длины 7 (случайное количество)
  remaining_chars=$(( RANDOM % 4 ))  # 0-3 дополнительных символов
  for (( i=0; i<remaining_chars; i++ )); do
    random_char="${chars:$(( RANDOM % ${#chars} )):1}"
    name="${name}${random_char}"
  done
  
  # Добавляем дату
  echo "${name}_$(date +'%d%m%y')"
}
