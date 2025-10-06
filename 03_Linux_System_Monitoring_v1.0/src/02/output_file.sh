#!/bin/bash

read -p "Хотите сохранить информацию в файл? (Y/N)" answer

output_file() {
  if [[ "$answer" =~ [Yy] ]]; then
  filename=$(date +"%d_%m_%y_%H_%M_%S").status

  if touch "$filename"; then 
    output_info > "$filename"
    echo "Информация сохранена в файл: $filename"
  else
    echo "Ошибка: невозможно создать файл $filename" >&2
    exit 1
  fi
else
  echo "Сохранение отменено."
fi
}