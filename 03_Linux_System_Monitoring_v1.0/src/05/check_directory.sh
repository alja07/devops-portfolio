#!/bin/bash

if [ ! -d "$directory" ]; then
  echo "Каталог не найден!" 
  exit 1
fi