# Simple Docker Web Server

Проект по созданию и развертыванию веб-сервера в Docker контейнерах. Включает кастомный FastCGI сервер, Nginx прокси и безопасную конфигурацию. Подробнее: report.md.

## 🎯 Цели проекта
- Освоить основы работы с Docker и Docker Compose
- Написать и запустить кастомный веб-сервер на C/FastCGI
- Настроить Nginx в качестве reverse proxy
- Обеспечить безопасность контейнеров с помощью Dockle

## 📋 Компоненты проекта

### Part 1: Работа с готовыми Docker образами

**Изучение официального образа nginx:**
```bash
# Скачивание образа
docker pull nginx:latest

# Запуск контейнера
docker run -d --name nginx-container nginx

# Проверка запущенных контейнеров
docker ps

# Инспекция контейнера
docker inspect nginx-container

# Маппинг портов
docker run -d -p 80:80 -p 443:443 --name nginx-ports nginx
```

### Part 2: Операции с контейнерами
Настройка Nginx статуса:
- Модификация nginx.conf для добавления страницы /status
- Копирование конфигурации в контейнер
- Экспорт/импорт контейнера

### Part 3: Кастомный веб-сервер
- Мини-сервер на C с FastCGI
- Запуск сервера

### Part 4: Сборка собственного Docker образа
- Dockerfile
- Сборка и запуск

### Part 5: Проверка безопасности с Dockle
- Сканирование образа
- Устранение проблем безопасности:
- Использование non-root пользователя
- Удаление ненужных пакетов
- Настройка правильных прав доступа

### Part 6: Развертывание с Docker Compose
docker-compose.yml

## 🛠️ Быстрый старт
Предварительные требования:
- Docker и Docker Compose
- GCC (для компиляции C кода)
- FastCGI development libraries

Запуск проекта:
```bash
# Клонирование репозитория
git clone <repository-url>
cd simple-docker

# Сборка и запуск
docker-compose up --build

# Проверка работы
curl http://localhost:80
```