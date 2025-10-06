#!/bin/bash

path="$1" #Путь
dir_count="$2" #Количество папок
dir_chars="$3"  # Символы для генерации имен папок
file_count="$4" # Количество файлов
file_template="$5"  # Шаблон имени файла (name.ext)
file_size_kb="${6/kb/}"  # Размер файлов
