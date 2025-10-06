#!/bin/bash

#10 самых больших файлов в порядке убывания (путь, размер и тип)
files_list=$(find "$directory" -type f)

top_files=""
for file in $files_list; do
  file_type=$(file "$file" | awk '{print $2}')

  file_size=$(du -sb "$file" | awk '{ print $1 }')
  top_files+="$file:$file_size:$file_type\n"
done

sort_top_files=$(echo -e "$top_files" | sort -t: -nk2 -r | head -n 10)

echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
counter=1
while IFS=: read path size file_type; do
  if [ -z "$path" ]; then
    echo "---Files NOT FIND---"
  else
    echo "$counter - $path, $(numfmt --from=auto --to=iec $size), $file_type"
  fi
  ((counter++))
done <<<"$sort_top_files"

echo "etc up to 10"
