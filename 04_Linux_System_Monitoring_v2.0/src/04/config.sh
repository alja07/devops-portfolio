#!/bin/bash

# Конфигурация генератора логов

# Коды HTTP ответов и их значения:
# 200 - OK (Успешный запрос)
# 201 - Created (Ресурс создан)
# 400 - Bad Request (Неверный запрос)
# 401 - Unauthorized (Требуется аутентификация)
# 403 - Forbidden (Доступ запрещён)
# 404 - Not Found (Ресурс не найден)
# 500 - Internal Server Error (Ошибка сервера)
# 501 - Not Implemented (Не реализовано)
# 502 - Bad Gateway (Ошибка шлюза)
# 503 - Service Unavailable (Сервис недоступен)

# Методы HTTP
methods=("GET" "POST" "PUT" "PATCH" "DELETE")

# Коды ответов
response_codes=("200" "201" "400" "401" "403" "404" "500" "501" "502" "503")

# User Agents
user_agents=(
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0"
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.1.1 Safari/605.1.15"
    "Mozilla/5.0 (Windows NT 10.0; Trident/7.0; rv:11.0) like Gecko"
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36 Edg/91.0.864.59"
    "Opera/9.80 (Windows NT 6.1; U; en) Presto/2.7.62 Version/11.01"
    "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"
    "Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)"
    "curl/7.68.0"
    "Wget/1.20.3 (linux-gnu)"
)

# URL-адреса
urls=(
    "/"
    "/index.html"
    "/about"
    "/contact"
    "/products"
    "/services"
    "/blog"
    "/images/logo.png"
    "/static/css/style.css"
    "/api/v1/users"
    "/admin"
    "/login"
    "/search?q=test"
    "/document.pdf"
    "/favicon.ico"
)

# Количество дней для генерации логов
DAYS_TO_GENERATE=5
MIN_RECORDS=100
MAX_RECORDS=1000