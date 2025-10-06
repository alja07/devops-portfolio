check_input() {
  input="$1"

  if [ "$#" -ne 1 ]; then
    echo "Ошибка: введите один параметр." >&2
    exit 1
  fi

  if [[ "$input" =~ [0-9] ]]; then
    echo "Ошибка: введите текстовый параметр." >&2
    exit 1
  else
    echo "Введенный параметр: $input"
    exit 0
  fi
}



 


