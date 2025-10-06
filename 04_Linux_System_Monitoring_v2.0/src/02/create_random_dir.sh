#!/bin/bash

create_random_dir() {
  base_dirs=("/home" "/home/$USER" "/tmp" "/var" "/opt" "/usr/local" "/data")
  valid_dirs=()
  
  # Ищем допустимые директории
  for dir in "${base_dirs[@]}"; do
    if [[ ! "$dir" =~ /(bin|sbin)(/|$) ]] && [ -d "$dir" ]; then
      valid_dirs+=("$dir")
    fi
  done
  
  if [ ${#valid_dirs[@]} -eq 0 ]; then
    echo "Нет подходящих директорий для создания папок" >> "$log_file"
    exit 1
  fi
  
  # Выбираем случайную директорию
  random_dir="${valid_dirs[$((RANDOM % ${#valid_dirs[@]}))]}"
  dir_name=$(generate_dir_name "$dir_name")
  full_path="${random_dir}/${dir_name}"
  
  mkdir -p "$full_path"
  echo "$full_path"
}
