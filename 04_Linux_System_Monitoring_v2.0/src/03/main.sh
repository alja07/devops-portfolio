#!/bin/bash

# Общие настройки
LOG_PATTERN="../02/creation_log_*.txt"
TEMP_FILE=$(mktemp)

# Функция подтверждения удаления
confirm_deletion() {
    read -p "Вы действительно хотите удалить эти файлы/папки? [y/N]: " answer
    [[ "$answer" =~ [yY] ]] && return 0 || return 1
}

source clean_by_log_param_1.sh
source clean_by_date_param_2.sh
source clean_by_mask_param_3.sh

# Основной код скрипта
if [ $# -ne 1 ]; then
    echo "Использование: $0 <Параметр>"
    echo "Параметры:"
    echo "  1 - Удаление по лог-файлу"
    echo "  2 - Удаление по дате создания"
    echo "  3 - Удаление по маске имени"
    exit 1
fi

# Проверяем root-права
if [ "$(id -u)" -ne 0 ]; then
    echo "Этот скрипт требует root-прав для полного доступа к системе" >&2
    exit 1
fi

# Выбираем Параметр очистки
case $1 in
    1) clean_by_log ;;
    2) clean_by_date ;;
    3) clean_by_mask ;;
    *)
        echo "Неверный Параметр. Допустимые значения: 1, 2, 3" >&2
        exit 1
        ;;
esac

# Удаляем временный файл
rm -f "$TEMP_FILE"