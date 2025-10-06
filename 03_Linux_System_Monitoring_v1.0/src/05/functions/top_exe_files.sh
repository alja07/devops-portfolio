#!/bin/bash

exe_file_path_list=$(find "$directory" -type f -exec file {} \; | grep 'executable'| cut -d: -f1)

top_exe_files=""
for exe_file in $exe_file_path_list; do
  exe_file_hash=$(md5sum $exe_file_path_list | awk '{ print $1 }')
  exe_file_size=$(du -sb "$file" | awk '{ print $1}')
  top_exe_files+="$exe_file:$exe_file_size:$exe_file_hash\n"
done

sort_top_exe_files=$(echo -e "$top_exe_files" | sort -t: -nk2 -r | head -n 10)

echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):"

counter=1
while IFS=: read exe_file_path_list exe_file_size exe_file_hash; do
  if [ -z "$exe_file_path_list" ]; then
    echo "---Executable files NOT FIND---"
  else
    echo "$counter - $exe_file_path_list, $(numfmt --from=auto --to=iec  $exe_file_size), $exe_file_hash"
  fi
  ((counter++))
done <<<"$sort_top_exe_files"
echo "etc up to 10"
