#!/bin/bash

# Вспомогательные функции для генерации логов

# Функция генерации случайного IP
generate_ip() {
    echo "$((RANDOM%256)).$((RANDOM%256)).$((RANDOM%256)).$((RANDOM%256))"
}

# Функция генерации случайного кода ответа
generate_status_code() {
    local codes=("${response_codes[@]}")
    echo "${codes[$((RANDOM % ${#codes[@]}))]}"
}

# Функция генерации случайного метода
generate_method() {
    local methods=("${methods[@]}")
    echo "${methods[$((RANDOM % ${#methods[@]}))]}"
}

# Функция генерации случайного URL
generate_url() {
    local urls=("${urls[@]}")
    echo "${urls[$((RANDOM % ${#urls[@]}))]}"
}

# Функция генерации случайного User-Agent
generate_user_agent() {
    local agents=("${user_agents[@]}")
    echo "${agents[$((RANDOM % ${#agents[@]}))]}"
}

# Функция генерации размера ответа
generate_response_size() {
    echo $((RANDOM%5000 + 100))
}