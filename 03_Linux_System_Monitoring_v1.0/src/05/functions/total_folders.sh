#!/bin/bash

#Подсчет общего количества папок (включая вложенные)
total_folders=$(find "$directory" -type d | wc -l)

echo "Total number of folders (including all nested ones) = $total_folders"
