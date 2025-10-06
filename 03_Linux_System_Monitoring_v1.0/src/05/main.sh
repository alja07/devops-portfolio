#!/bin/bash

start_time=$SECONDS
directory=$1

#Проверяем наличие каталога
source check_directory.sh

#Подсчет общего количества папок (включая вложенные)
source functions/total_folders.sh

#Топ-5 папок с наибольшим размером в порядке убывания (путь и размер)
source functions/top_folders.sh

#Считаем общее количество файлов
source functions/total_files.sh

#Количество файлов конфигурации (с расширением .conf), текстовых файлов, исполняемых файлов, файлов журналов (файлов с расширением .log), архивов, символических ссылок
source functions/conf_count.sh

#10 самых больших файлов в порядке убывания (путь, размер и тип)
source functions/top_files.sh

#10 самых больших исполняемых файлов в порядке убывания (путь, размер и хэш)
source functions/top_exe_files.sh

#Время выполнения скрипта
total_time=$((SECONDS - start_time))
echo "Script execution time (in seconds) = $total_time"