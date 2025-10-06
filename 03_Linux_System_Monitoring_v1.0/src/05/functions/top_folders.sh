#!/bin/bash

#Топ-5 папок с наибольшим размером в порядке убывания (путь и размер)
  # получаем список путей папок и их размер
folders_list=$(find "$directory" -type d)

top_folders=""
for folder in $folders_list; do
  folder_size=$(du -sb "$folder" | awk '{ print $1 }')
  top_folders+="$folder:$folder_size\n"
done

  # сортируем
sort_top_folders=$(echo -e "$top_folders" | sort -t: -nk2 -r | head -n 5)

echo "TOP 5 folders of maximum size arranged in descending order (path and size):"
counter=1
while IFS=: read path size; do
  if [ -z "$path" ]; then
    echo "---Folders NOT FIND---"
  else
    echo "$counter - $path, $(numfmt --from=auto --to=iec $size)"
  fi

  ((counter++))
done <<<"$sort_top_folders"
echo "etc up to 5"

