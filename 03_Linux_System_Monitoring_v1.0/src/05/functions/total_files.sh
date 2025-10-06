#!/bin/bash

#Считаем общее количество файлов
total_files=$(find "$directory" -type f | wc -l)
echo "Total number of files = $total_files"
