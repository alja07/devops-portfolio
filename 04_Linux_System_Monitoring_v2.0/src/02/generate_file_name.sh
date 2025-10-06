#!/bin/bash

generate_file_name() {
  name=""
  
  # Генерация имени (используем все символы хотя бы раз)
  for (( i=0; i<${#file_name_part}; i++ )); do
    name+="${file_name_part:$i:1}"
  done
  
  # Дополнение до 5 символов
  while [ ${#name} -lt 5 ]; do
    random_char="${file_name_part:$(( RANDOM % ${#file_name_part} )):1}"
    name+="${random_char}"
  done
  
  # Генерация расширения
  ext=""
  for (( i=0; i<${#file_ext_part}; i++ )); do
    ext+="${file_ext_part:$i:1}"
  done
  
  # Итоговое имя
  echo "${name}_$(date +'%d%m%y').${ext}"
}