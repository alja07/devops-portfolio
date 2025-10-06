#!/bin/bash

# Функция генерации имени папки
generate_dir_name() {
  chars="$1"
  name=""
  
  # Добавляем все символы хотя бы по одному разу
  for (( i=0; i<${#chars}; i++ )); do
    name+="${chars:$i:1}"
  done
  
  # Дополняем случайными символами до длины 5
  while [ ${#name} -lt 5 ]; do
    random_char="${chars:$(( RANDOM % ${#chars} )):1}"
    name+="${random_char}"
  done
  
  # Добавляем дату
  echo "${name}_$(date +'%d%m%y')"
}
