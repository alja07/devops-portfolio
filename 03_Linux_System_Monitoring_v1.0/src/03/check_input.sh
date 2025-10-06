#!/bin/bash

check_input() {
  if [ "$#" -ne 4 ]; then
    echo "Ошибка: введите четыре параметра" >&2
    exit 1
  fi

  for param in "$@"; do
    if [[ !("$param" =~ ^[1-6]$) ]]; then
      echo "Ошибка: каждый параметр должен быть числом от 1 до 6." >&2
      exit 1
    fi
  done
}

check_input_color() {
  if [[ "$col1_color_bg" == "$col1_color_font" || "$col2_color_bg" == "$col2_color_font" ]]; then
    echo "Ошибка: шрифт и фон одного столбца не должны совпадать. Введите другие числа." >&2
    exit 1
  fi
}