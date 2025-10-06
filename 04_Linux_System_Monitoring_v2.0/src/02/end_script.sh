#!/bin/bash

# Завершение скрипта
end_script() {
  end_time=$(date +%s)
  total_time=$((end_time - start_time))
  
  echo "----------------------------------" >> "$log_file"
  echo "Время начала: $(date -d "@$start_time" '+%Y-%m-%d %H:%M:%S')" >> "$log_file"
  echo "Время окончания: $(date '+%Y-%m-%d %H:%M:%S')" >> "$log_file"
  echo "Общее время выполнения: ${total_time} секунд" >> "$log_file"
  
  echo "Скрипт завершен. Общее время выполнения: ${total_time} секунд"
}