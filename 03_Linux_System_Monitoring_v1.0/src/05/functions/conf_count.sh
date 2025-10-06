#!/bin/bash

#Количество файлов конфигурации (с расширением .conf), текстовых файлов, исполняемых файлов, файлов журналов (файлов с расширением .log), архивов, символических ссылок

conf_count=$(find "$directory" -type f -name "*.conf" | wc -l)
txt_count=$(find "$directory" -type f -exec file {} \; | grep -E 'ASCII text|UTF-8 Unicode' | grep -v ': *.binary\|compiled\|compressed' | wc -l)
exe_count=$(find "$directory" -type f -exec file {} \; | grep 'executable' | wc -l)
log_count=$(find "$directory" -type f -name "*.log" | wc -l)
archive_count=$(find "$directory" -type f -name "*.zip" -o -name "*.tar" -o -name "*.gz" -o -name "*.rar" | wc -l)
symbolic_link_count=$(find "$directory" -type l | wc -l)

echo "Number of: "
echo "Configuration files (with the .conf extension) = $conf_count"
echo "Text files = $txt_count"
echo "Executable files = $exe_count"
echo "Log files (with the extension .log) = $log_count"
echo "Archive files = $archive_count"
echo "Symbolic links = $symbolic_link_count"
